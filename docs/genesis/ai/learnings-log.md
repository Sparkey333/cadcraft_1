# Learnings log (append-only)

> Append one block per iteration. Newest at the bottom. Each entry says what was tried, what was
> learned, and what to do differently. Keep facts with evidence; opinions marked as such.

## 2026-10-21 · First iteration: build, measure, compare, plan

### Repository and tooling
- The desktop app needs `libxkbcommon-x11` at runtime on Linux/X11; without it winit panics before
  the window exists (`xkbcommon-dl` `expect`). Under a virtual X display with Mesa's `llvmpipe`
  Vulkan driver the app runs, serves the control channel and writes screenshots; set
  `WGPU_BACKEND=vulkan`. A headless CI smoke test of the GUI is therefore possible.
- `cadcraft-cli run --script 'A\nB'` receives the two characters backslash and n in most shells;
  use real newlines (`$'...'`), `--script-file`, or `--cmd 'id {json}'`. The README example is
  misleading as written (suggested task filed in the session).
- Release builds in a 4-vCPU container: `cadcraft-cli` 3 min 08 s, `cadcraft` 6 min 18 s with a
  warm registry; `target/` grows to about 4 GB.
- `cargo xtask assets` passes with new documentation files; it only polices binary assets.
- The parity documents drift from the code: lines of Rust (57k in the architecture doc, 194k
  measured), registered commands (295 / 413 / 427), menu breadth (245 vs 283 of 491), the
  languages table. Re-measure before quoting them.

### Field evidence that changes the picture
- Upstream issues contradict the "never crashes" headline in the field: GPU and window-creation
  failures at startup (#1724, #1824, #1631), an xref re-path crash (#1636), an 8.4 GB freeze on a
  76.8 MB xref (#1625), 47.8 MB DWG in ~20 s and 4.5–5.1 GB (#1076), silent data loss on concurrent
  saves (#540), lost clicks while the mouse moves (#1001). The engine guards hold; the layers they
  do not cover (drivers, memory, file locking) are where the failures are.
- A corpus test (#1041) had BricsCAD V26 refuse 14 of 23 CADCraft-saved DWGs; an AutoCAD round trip
  went from 0 to 6 AUDIT errors and AC1032 became AC1018 (#604). "Lossless DWG" is the number-one
  gap for any user who exchanges files.

### Research method
- Each research worker had a limited web-search budget and the environment's proxy refused direct
  fetches of most vendor, review and forum hosts; evidence came from search summaries plus the
  Autodesk Product Help MCP and GitHub. Mark such items "as indexed" and date them.
- Independent fact-checkers told to refute claims were worth running: they confirmed most claims
  but added precisions (self-assessed numbers, pre-launch announcements, conflicting maintenance
  prices) that the page now carries.
- Keep pricing in the vendor's currency with the page it was read from; resellers disagree by
  10–20 percent and some list the Lite price under Ultimate.

### Design decisions recorded for Genesis
- Build Genesis as a separate product on CADCraft's lower crates (geom, dxf, color, doc,
  constraints, fonts, render, io, engine, mcp), not as a fork chasing AutoCAD menu parity.
- Project container with a manifest, typed references with health and GUID links, parsed-reference
  cache, command journal, CI gate, process isolation for the GPU path, streaming file I/O.
- Scope: sites (lots, pads, driveways, small streets, grading, drainage, utilities to the main),
  old-school and neo techniques as first-class objects, open public data feeds cached in the
  project.
