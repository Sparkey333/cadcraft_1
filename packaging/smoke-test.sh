#!/bin/sh
# Functional smoke test for CADCraft on Linux and macOS.
#
# Runs the headless CLI through its real workflows (sample drawing, info, DXF -> DWG -> SVG -> PNG,
# a scripted drawing saved and exported, the command catalogue, a short benchmark) and then starts
# the desktop app with the JSON control channel, draws through it, asks for a screenshot and quits.
# Every step prints PASS or FAIL; the exit code is the number of failed steps.
#
# Usage:
#   packaging/smoke-test.sh                 # uses target/release binaries (builds them if missing)
#   packaging/smoke-test.sh --no-build      # fail instead of building when binaries are missing
#   packaging/smoke-test.sh --no-gui        # CLI only (no window, no virtual display)
#   CADCRAFT_BIN=/path/to/cadcraft CADCRAFT_CLI=/path/to/cadcraft-cli packaging/smoke-test.sh
#
# On Linux without a display the GUI step starts its own Xvfb (display :97) when it is installed; the software
# Vulkan driver (mesa) is used when no GPU is present (WGPU_BACKEND=vulkan). The app needs
# libxkbcommon-x11 at runtime on X11.

set -u
ROOT=$(cd "$(dirname "$0")/.." && pwd)
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
    -h|--help) sed -n 2,16p "$0"; exit 0 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done

PASS=0
FAIL=0
step() {
  # step NAME COMMAND...  — runs the command, prints PASS/FAIL, keeps the log in $OUT/NAME.log
  name=$1; shift
  if "$@" >"$OUT/$name.log" 2>&1; then
    PASS=$((PASS + 1)); printf 'PASS  %s\n' "$name"
  else
    FAIL=$((FAIL + 1)); printf 'FAIL  %s  (see %s)\n' "$name" "$OUT/$name.log"
  fi
}
ok() { PASS=$((PASS + 1)); printf 'PASS  %s\n' "$1"; }
bad() { FAIL=$((FAIL + 1)); printf 'FAIL  %s  (%s)\n' "$1" "$2"; }
check_grep() {
  # check_grep NAME PATTERN FILE  — the file contains a line matching PATTERN (grep basic regex)
  if grep -q -- "$2" "$3" 2>/dev/null; then ok "$1"; else bad "$1" "no match for $2 in $3"; fi
}
check_not_grep() {
  # check_not_grep NAME PATTERN FILE  — no line of the file matches PATTERN
  if grep -q -- "$2" "$3" 2>/dev/null; then bad "$1" "unexpected match for $2 in $3"; else ok "$1"; fi
}
check_count() {
  # check_count NAME PATTERN FILE MIN  — at least MIN lines match PATTERN
  n=$(grep -c -- "$2" "$3" 2>/dev/null || echo 0)
  if [ "$n" -ge "$4" ]; then ok "$1"; else bad "$1" "$n matches for $2 in $3, wanted $4"; fi
}
check_nonempty() {
  # check_nonempty NAME FILE
  if [ -s "$2" ]; then ok "$1"; else bad "$1" "$2 missing or empty"; fi
}
check_head() {
  # check_head NAME FILE STRING  — the file starts with STRING
  if [ -f "$2" ] && head -c "${#3}" "$2" | grep -q -- "$3"; then ok "$1"; else bad "$1" "$2 does not start with $3"; fi
}

rm -rf "$OUT"; mkdir -p "$OUT"
echo "CADCraft smoke test · $(date -u +%Y-%m-%dT%H:%M:%SZ) · out: $OUT"

# 0. binaries
if [ ! -x "$CLI" ] || [ ! -x "$BIN" ]; then
  if [ "$BUILD" = 1 ]; then
    echo "building release binaries (first time: several minutes)"
    (cd "$ROOT" && cargo build --release -p cadcraft-cli -p cadcraft) || { echo "build failed"; exit 1; }
  else
    echo "binaries missing: $CLI / $BIN"; exit 1
  fi
fi

# 1. CLI version and command catalogue
step cli-version "$CLI" --version
check_grep cli-version-string "cadcraft" "$OUT/cli-version.log"
step cli-commands "$CLI" commands
check_count cli-commands-count . "$OUT/cli-commands.log" 300

# 2. sample drawing, info, conversion chain
step sample-floorplan "$CLI" sample floorplan "$OUT/floorplan.dxf"
step info-dxf "$CLI" info "$OUT/floorplan.dxf"
check_grep info-entities "[Ee]ntit" "$OUT/info-dxf.log"
step convert-dwg "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.dwg"
step info-dwg "$CLI" info "$OUT/floorplan.dwg"
step convert-svg "$CLI" convert "$OUT/floorplan.dwg" "$OUT/floorplan.svg"
check_grep svg-has-root "<svg" "$OUT/floorplan.svg"
step convert-png "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.png"
check_nonempty png-nonempty "$OUT/floorplan.png"
step convert-pdf "$CLI" convert "$OUT/floorplan.dxf" "$OUT/floorplan.pdf"
check_head pdf-header "$OUT/floorplan.pdf" "%PDF-"

# 3. scripted drawing: command-line script exactly as a user would type it
printf 'LINE 0,0 100,0\n\nCIRCLE 50,50 25\nDIMLINEAR 0,0 100,0 50,-20\n' >"$OUT/draw.scr"
step run-script "$CLI" run --metric --script-file "$OUT/draw.scr" --save "$OUT/draw.dxf" --export "$OUT/draw.png"
check_grep draw-dxf-has-line "^LINE" "$OUT/draw.dxf"
check_grep draw-dxf-has-circle "^CIRCLE" "$OUT/draw.dxf"
check_grep draw-dxf-has-dimension "^DIMENSION" "$OUT/draw.dxf"
check_nonempty draw-png-nonempty "$OUT/draw.png"
step run-json "$CLI" run --metric --cmd 'line {"points":[[0,0],[10,10]]}' --cmd 'circle {"center":[5,5],"radius":2}' --save "$OUT/json.dxf"
check_count json-dxf-entities "^LINE\|^CIRCLE" "$OUT/json.dxf" 2
step info-draw "$CLI" info "$OUT/draw.dxf"

# 4. round trip of the scripted drawing through DWG
step draw-to-dwg "$CLI" convert "$OUT/draw.dxf" "$OUT/draw.dwg"
step draw-dwg-back "$CLI" convert "$OUT/draw.dwg" "$OUT/draw-back.dxf"
check_grep roundtrip-keeps-circle "^CIRCLE" "$OUT/draw-back.dxf"

# 5. short benchmark (synthetic drawing, 20,000 entities)
step perf-20k "$CLI" perf 20000

# 6. desktop app over the control channel
XVFB=""
if [ "$GUI" = 1 ]; then
  if [ -z "${DISPLAY:-}" ] && [ -z "${WAYLAND_DISPLAY:-}" ]; then
    if command -v Xvfb >/dev/null 2>&1; then
      # a private virtual X display; the software Vulkan driver (mesa lavapipe) renders the window
      Xvfb :97 -screen 0 1600x1000x24 -nolisten tcp >"$OUT/xvfb.log" 2>&1 &
      XVFB=$!
      export DISPLAY=:97
      export WGPU_BACKEND="${WGPU_BACKEND:-vulkan}"
      sleep 2
    else
      echo "SKIP  gui (no display and no Xvfb)"; GUI=0
    fi
  fi
fi
if [ "$GUI" = 1 ]; then
  rm -f "$OUT/shot.png"
  "$BIN" --sample --control "$PORT" >"$OUT/gui.log" 2>&1 &
  APP=$!
  # wait for the port (up to 60 s)
  i=0
  while [ $i -lt 60 ]; do
    if nc -z 127.0.0.1 "$PORT" 2>/dev/null; then break; fi
    sleep 1; i=$((i + 1))
  done
  if nc -z 127.0.0.1 "$PORT" 2>/dev/null; then
    ok "gui-control-port (after ${i}s)"
    # one connection, several JSON lines; replies are one JSON object per line
    {
      printf '%s\n' '{"id":1,"method":"ping","params":{}}'
      printf '%s\n' '{"id":2,"method":"cmdline.input","params":{"text":"circle 0,0 5"}}'
      printf '%s\n' '{"id":3,"method":"engine.execute","params":{"command":"line","params":{"points":[[0,0],[10,0],[10,10]]}}}'
      printf '%s\n' '{"id":4,"method":"cmdline.input","params":{"text":"zoom e"}}'
      printf '%s\n' '{"id":5,"method":"drawing.inspect","params":{}}'
      printf '%s\n' "{\"id\":6,\"method\":\"ui.screenshot\",\"params\":{\"path\":\"$OUT/shot.png\"}}"
      printf '%s\n' "{\"id\":7,\"method\":\"ui.render\",\"params\":{\"path\":\"$OUT/render.png\",\"width\":800,\"height\":500}}"
      sleep 3
      printf '%s\n' '{"id":8,"method":"app.quit","params":{}}'
      sleep 1
    } | nc 127.0.0.1 "$PORT" >"$OUT/control.log" 2>&1
    check_grep gui-ping '"result":"pong"' "$OUT/control.log"
    check_grep gui-cmdline-circle '"id":2,"ok":true' "$OUT/control.log"
    check_grep gui-execute-line '"id":3,"ok":true' "$OUT/control.log"
    check_not_grep gui-no-errors '"ok":false' "$OUT/control.log"
    check_grep gui-inspect-counts '"id":5,"ok":true,"result":{.*"counts"' "$OUT/control.log"
    check_nonempty gui-render-png "$OUT/render.png"
    if [ -s "$OUT/shot.png" ]; then
      ok "gui-screenshot ($(wc -c <"$OUT/shot.png") bytes)"
    else
      echo "WARN  gui-screenshot (no presented frame; ui.render passed instead)"
    fi
  else
    bad gui-control-port "see $OUT/gui.log"
  fi
  # the app quits on app.quit; make sure it is gone, then the virtual display
  sleep 2
  kill "$APP" 2>/dev/null; wait "$APP" 2>/dev/null
  [ -n "$XVFB" ] && kill "$XVFB" 2>/dev/null
fi

echo "----"
echo "passed $PASS, failed $FAIL · logs in $OUT"
exit $FAIL
