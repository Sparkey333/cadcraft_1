#!/bin/sh
# Functional smoke test for CADCraft on Linux and macOS.
#
# Runs the headless CLI through its real workflows (sample drawing, info, DXF -> DWG -> SVG -> PNG
# -> PDF, a scripted drawing saved and exported, the JSON command form, a DWG round trip, the
# command catalogue, a short benchmark) and then starts the desktop app with the JSON control
# channel, draws through it, checks the drawing changed, asks for a screenshot and a headless
# render, and quits. Every step prints PASS or FAIL; the exit code is the number of failed steps
# (capped at 125). Entity checks read `cadcraft-cli info` (model-space counts), never raw DXF text.
#
# Usage:
#   packaging/smoke-test.sh                 # uses target/release binaries (builds them if missing)
#   packaging/smoke-test.sh --no-build      # fail instead of building when binaries are missing
#   packaging/smoke-test.sh --no-gui        # CLI only (no window, no virtual display)
#   CADCRAFT_BIN=... CADCRAFT_CLI=... SMOKE_OUT=... SMOKE_PORT=... packaging/smoke-test.sh
#
# On Linux without a display the GUI step starts its own Xvfb (software Vulkan via mesa,
# WGPU_BACKEND=vulkan); the app needs libxkbcommon-x11 at runtime on X11. On macOS the app opens
# a native window; no display setup is needed. The GUI step needs `nc` (any common variant).

set -u
ROOT=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
CLI=${CADCRAFT_CLI:-"$ROOT/target/release/cadcraft-cli"}
BIN=${CADCRAFT_BIN:-"$ROOT/target/release/cadcraft"}
OUT=${SMOKE_OUT:-"$ROOT/target/smoke"}
PORT=${SMOKE_PORT:-7733}
BUILD=1
GUI=1
for a in "$@"; do
  case "$a" in
    --no-build) BUILD=0 ;;
    --no-gui) GUI=0 ;;
    -h|--help) sed -n '2,/^$/{/^#/s/^# \{0,1\}//p;}' "$0"; exit 0 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done

APP=""
XVFB=""
WD=""
cleanup() {
  [ -n "$WD" ] && kill "$WD" 2>/dev/null
  [ -n "$APP" ] && kill "$APP" 2>/dev/null
  [ -n "$XVFB" ] && kill "$XVFB" 2>/dev/null
  return 0
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

PASS=0
FAIL=0
ok() { PASS=$((PASS + 1)); printf 'PASS  %s\n' "$1"; }
bad() { FAIL=$((FAIL + 1)); printf 'FAIL  %s  (%s)\n' "$1" "$2"; }
step() {
  # step NAME COMMAND...  - runs the command, PASS on exit 0, log in $OUT/NAME.log
  name=$1; shift
  if "$@" >"$OUT/$name.log" 2>&1; then ok "$name"; else bad "$name" "exit $?, see $OUT/$name.log"; fi
}
check_grep() {
  # check_grep NAME PATTERN FILE  - a line of FILE matches PATTERN (basic regex)
  if grep -q -- "$2" "$3" 2>/dev/null; then ok "$1"; else bad "$1" "no match for $2 in $3"; fi
}
check_not_grep() {
  # check_not_grep NAME PATTERN FILE
  if grep -q -- "$2" "$3" 2>/dev/null; then bad "$1" "unexpected match for $2 in $3"; else ok "$1"; fi
}
count_matches() {
  # count_matches FILE PATTERN...  - prints the number of lines matching any pattern (0 if none)
  f=$1; shift
  set -- "$@"
  n=0
  for pat in "$@"; do
    m=$(grep -c -- "$pat" "$f" 2>/dev/null)
    case $m in ''|*[!0-9]*) m=0 ;; esac
    n=$((n + m))
  done
  echo "$n"
}
check_count() {
  # check_count NAME FILE MIN PATTERN...  - at least MIN lines match any PATTERN
  name=$1; f=$2; min=$3; shift 3
  n=$(count_matches "$f" "$@")
  if [ "$n" -ge "$min" ]; then ok "$name"; else bad "$name" "$n matching lines in $f, wanted $min"; fi
}
json_num() {
  # json_num FILE KEY  - first value of "KEY": <integer> in a pretty-printed JSON file, or empty
  sed -n "s/^ *\"$2\": \([0-9][0-9]*\).*/\1/p" "$1" 2>/dev/null | head -n 1
}
check_json_num() {
  # check_json_num NAME FILE KEY EXPECTED  - the integer value of KEY equals EXPECTED
  v=$(json_num "$2" "$3")
  if [ "${v:-none}" = "$4" ]; then ok "$1"; else bad "$1" "$3 is ${v:-missing} in $2, expected $4"; fi
}
check_svg_geometry() {
  # check_svg_geometry NAME FILE MIN  - at least MIN drawn elements (polyline, path, line, circle)
  n=$(tr '<' '\n' <"$2" 2>/dev/null | grep -c -e '^polyline' -e '^path' -e '^line' -e '^circle')
  case $n in ''|*[!0-9]*) n=0 ;; esac
  if [ "$n" -ge "$3" ]; then ok "$1"; else bad "$1" "$n drawn elements in $2, wanted $3"; fi
}
check_head() {
  # check_head NAME FILE STRING  - the file starts with STRING
  if [ -f "$2" ] && [ "$(head -c "${#3}" "$2" 2>/dev/null)" = "$3" ]; then ok "$1"; else bad "$1" "$2 does not start with $3"; fi
}
check_png() {
  # check_png NAME FILE  - the file carries the PNG signature
  sig=$(head -c 8 "$2" 2>/dev/null | od -An -tx1 | tr -d ' \n')
  if [ "$sig" = "89504e470d0a1a0a" ]; then ok "$1"; else bad "$1" "$2 is not a PNG"; fi
}

rm -rf "$OUT"; mkdir -p "$OUT"
echo "CADCraft smoke test - $(date -u +%Y-%m-%dT%H:%M:%SZ) - out: $OUT"

# 0. binaries
need_bin=$GUI
if [ ! -x "$CLI" ] || { [ "$need_bin" = 1 ] && [ ! -x "$BIN" ]; }; then
  if [ "$BUILD" = 1 ]; then
    echo "building release binaries (first time: several minutes)"
    (cd "$ROOT" && cargo build --release -p cadcraft-cli -p cadcraft) || { echo "build failed"; exit 1; }
  fi
  if [ ! -x "$CLI" ] || { [ "$need_bin" = 1 ] && [ ! -x "$BIN" ]; }; then
    echo "binaries missing: $CLI / $BIN"; exit 1
  fi
fi

# 1. CLI version and command catalogue (one JSON object per command, at indent 2)
step cli-version "$CLI" --version
check_grep cli-version-string "cadcraft" "$OUT/cli-version.log"
step cli-commands "$CLI" commands
check_count cli-commands-count "$OUT/cli-commands.log" 300 '^  {'

# 2. sample drawing, info, conversion chain (the floor plan sample has 16 entities)
step sample-floorplan "$CLI" sample floorplan "$OUT/floorplan.dxf"
step info-dxf "$CLI" info "$OUT/floorplan.dxf"
check_json_num info-entities "$OUT/info-dxf.log" entityCount 16
step convert-dwg "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.dwg"
step info-dwg "$CLI" info "$OUT/floorplan.dwg"
check_json_num info-dwg-entities "$OUT/info-dwg.log" entityCount 16
step convert-svg "$CLI" convert "$OUT/floorplan.dwg" "$OUT/floorplan.svg"
check_grep svg-has-root "<svg" "$OUT/floorplan.svg"
check_svg_geometry svg-has-geometry "$OUT/floorplan.svg" 10
step convert-png "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.png"
check_png png-signature "$OUT/floorplan.png"
step convert-pdf "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.pdf"
check_head pdf-header "$OUT/floorplan.pdf" "%PDF-"

# 3. scripted drawing: a command-line script exactly as a user would type it
printf 'LINE 0,0 100,0\n\nCIRCLE 50,50 25\nDIMLINEAR 0,0 100,0 50,-20\n' >"$OUT/draw.scr"
step run-script "$CLI" run --metric --script-file "$OUT/draw.scr" --save "$OUT/draw.dxf" --export "$OUT/draw.png"
step info-draw "$CLI" info "$OUT/draw.dxf"
check_json_num draw-entities "$OUT/info-draw.log" entityCount 3
check_json_num draw-line "$OUT/info-draw.log" Line 1
check_json_num draw-circle "$OUT/info-draw.log" Circle 1
check_json_num draw-dimension "$OUT/info-draw.log" Dimension 1
check_png draw-png-signature "$OUT/draw.png"
step run-json "$CLI" run --metric --cmd 'line {"points":[[0,0],[10,10]]}' --cmd 'circle {"center":[5,5],"radius":2}' --save "$OUT/json.dxf"
step info-json "$CLI" info "$OUT/json.dxf"
check_json_num json-line "$OUT/info-json.log" Line 1
check_json_num json-circle "$OUT/info-json.log" Circle 1

# 4. round trip of the scripted drawing through DWG keeps all three entities
step draw-to-dwg "$CLI" convert "$OUT/draw.dxf" "$OUT/draw.dwg"
step draw-dwg-back "$CLI" convert "$OUT/draw.dwg" "$OUT/draw-back.dxf"
step info-draw-back "$CLI" info "$OUT/draw-back.dxf"
check_json_num roundtrip-line "$OUT/info-draw-back.log" Line 1
check_json_num roundtrip-circle "$OUT/info-draw-back.log" Circle 1
check_json_num roundtrip-dimension "$OUT/info-draw-back.log" Dimension 1

# 5. short benchmark (synthetic drawing, 20,000 entities)
step perf-20k "$CLI" perf 20000

# 6. desktop app over the control channel
probe() {
  # probe  - prints the reply to a ping on $PORT (empty when nothing answers within 3 s)
  printf '{"id":0,"method":"ping","params":{}}\n' | nc -w 3 127.0.0.1 "$PORT" 2>/dev/null | head -n 1
}
if [ "$GUI" = 1 ] && ! command -v nc >/dev/null 2>&1; then
  echo "SKIP  gui (nc not installed)"; GUI=0
fi
if [ "$GUI" = 1 ] && [ "$(uname -s)" != Darwin ] && [ -z "${DISPLAY:-}" ] && [ -z "${WAYLAND_DISPLAY:-}" ]; then
  if command -v Xvfb >/dev/null 2>&1; then
    # a private virtual X display on a free number; Xvfb reports it through -displayfd
    : >"$OUT/xvfb.display"
    Xvfb -displayfd 3 -screen 0 1600x1000x24 -nolisten tcp 3>"$OUT/xvfb.display" >"$OUT/xvfb.log" 2>&1 &
    XVFB=$!
    i=0
    while [ $i -lt 20 ] && [ ! -s "$OUT/xvfb.display" ] && kill -0 "$XVFB" 2>/dev/null; do sleep 1; i=$((i + 1)); done
    if [ -s "$OUT/xvfb.display" ]; then
      DISPLAY=":$(tr -d '[:space:]' <"$OUT/xvfb.display")"
      export DISPLAY
      export WGPU_BACKEND="${WGPU_BACKEND:-vulkan}"
    else
      echo "SKIP  gui (Xvfb did not start, see $OUT/xvfb.log)"; GUI=0
    fi
  else
    echo "SKIP  gui (no display and no Xvfb)"; GUI=0
  fi
fi
if [ "$GUI" = 1 ]; then
  if [ -n "$(probe)" ] || nc -z -w 2 127.0.0.1 "$PORT" 2>/dev/null; then
    bad gui-control-port "port $PORT already in use; set SMOKE_PORT"; GUI=0
  fi
fi
if [ "$GUI" = 1 ]; then
  rm -f "$OUT/shot.png" "$OUT/render.png"
  "$BIN" --sample --control "$PORT" >"$OUT/gui.log" 2>&1 &
  APP=$!
  i=0
  ready=""
  while [ $i -lt 60 ]; do
    kill -0 "$APP" 2>/dev/null || break
    case $(probe) in *pong*) ready=1; break ;; esac
    sleep 1; i=$((i + 1))
  done
  if [ -n "$ready" ]; then
    ok "gui-control-port (after ${i}s)"
    # watchdog: if the app hangs, kill it so the nc session below cannot block forever
    ( sleep 180; kill "$APP" 2>/dev/null; echo fired >"$OUT/watchdog" ) &
    WD=$!
    rm -f "$OUT/watchdog"
    # one connection, one JSON request per line, one reply per line (ids match the requests)
    {
      printf '%s\n' '{"id":10,"method":"drawing.inspect","params":{"entities":false}}'
      printf '%s\n' '{"id":1,"method":"ping","params":{}}'
      printf '%s\n' '{"id":2,"method":"cmdline.input","params":{"text":"circle 0,0 5"}}'
      printf '%s\n' '{"id":3,"method":"engine.execute","params":{"command":"line","params":{"points":[[0,0],[10,0],[10,10]]}}}'
      printf '%s\n' '{"id":4,"method":"cmdline.input","params":{"text":"zoom e"}}'
      printf '%s\n' '{"id":5,"method":"drawing.inspect","params":{"entities":false}}'
      printf '%s\n' "{\"id\":6,\"method\":\"ui.screenshot\",\"params\":{\"path\":\"$OUT/shot.png\"}}"
      printf '%s\n' "{\"id\":7,\"method\":\"ui.render\",\"params\":{\"path\":\"$OUT/render.png\",\"width\":800,\"height\":500}}"
      sleep 10
      printf '%s\n' '{"id":8,"method":"app.quit","params":{}}'
      sleep 2
    } | nc -w 15 127.0.0.1 "$PORT" >"$OUT/control.log" 2>&1
    kill "$WD" 2>/dev/null; WD=""
    if [ -f "$OUT/watchdog" ]; then bad gui-responsive "watchdog killed the app after 180 s"; fi
    check_grep gui-ping '"id":1,"ok":true,"result":"pong"' "$OUT/control.log"
    check_grep gui-cmdline-circle '"id":2,"ok":true' "$OUT/control.log"
    check_not_grep gui-cmdline-circle-no-error '"id":2,.*"error"' "$OUT/control.log"
    check_grep gui-cmdline-circle-finished '"id":2,.*"running":null' "$OUT/control.log"
    check_grep gui-execute-line '"id":3,"ok":true' "$OUT/control.log"
    check_not_grep gui-cmdline-zoom-no-error '"id":4,.*"error"' "$OUT/control.log"
    n0=$(grep '"id":10,' "$OUT/control.log" | sed -n 's/.*"entityCount":\([0-9]*\).*/\1/p' | head -n 1)
    n5=$(grep '"id":5,' "$OUT/control.log" | sed -n 's/.*"entityCount":\([0-9]*\).*/\1/p' | head -n 1)
    if [ -n "$n0" ] && [ -n "$n5" ] && [ $((n5 - n0)) -eq 3 ]; then
      ok "gui-entities-added (circle + two lines: $n0 -> $n5)"
    else
      bad gui-entities-added "entityCount ${n0:-?} -> ${n5:-?}, expected +3"
    fi
    # every reply but the screenshot (which needs a presented frame) must be ok
    if grep -v '"id":6,' "$OUT/control.log" | grep -q '"ok":false'; then
      bad gui-no-errors "error reply in $OUT/control.log"
    else
      ok gui-no-errors
    fi
    check_png gui-render-png "$OUT/render.png"
    if [ -s "$OUT/shot.png" ]; then
      ok "gui-screenshot ($(wc -c <"$OUT/shot.png" | tr -d ' ') bytes)"
    else
      echo "WARN  gui-screenshot (no presented frame; the headless render stands in)"
    fi
    check_grep gui-quit-reply '"id":8,"ok":true' "$OUT/control.log"
    # the app must exit on app.quit, cleanly
    i=0
    while [ $i -lt 15 ] && kill -0 "$APP" 2>/dev/null; do sleep 1; i=$((i + 1)); done
    if kill -0 "$APP" 2>/dev/null; then
      bad gui-exit "app still running ${i}s after app.quit"
      kill "$APP" 2>/dev/null; wait "$APP" 2>/dev/null
    else
      wait "$APP"; rc=$?
      if [ "$rc" -eq 0 ]; then ok gui-exit; else bad gui-exit "exit status $rc"; fi
    fi
    APP=""
    check_not_grep gui-no-panic 'panicked' "$OUT/gui.log"
  else
    bad gui-control-port "app not answering after ${i}s, see $OUT/gui.log"
    kill "$APP" 2>/dev/null; wait "$APP" 2>/dev/null; APP=""
  fi
  if [ -n "$XVFB" ]; then kill "$XVFB" 2>/dev/null; XVFB=""; fi
fi

echo "----"
echo "passed $PASS, failed $FAIL - logs in $OUT"
[ "$FAIL" -gt 125 ] && exit 125
exit "$FAIL"
