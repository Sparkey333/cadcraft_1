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

## 2026-10-21 · Second iteration: review the page, fix it, reconcile the numbers

### What the review found (four lenses, 90 findings, 69 verified: 68 real, 1 not)
- Counts drift between a worker's text and the repository: the inventory worker reported 19
  `catch_unwind` guards and about 40 hostile tests; a grep on the same day finds 21 call sites
  (two restore the drawing, the rest turn a panic into an error) and 100 test functions with
  "hostile" in the name (39 in the engine crate). Record the counting method next to every count;
  reconcile with a single replacement table at merge time rather than editing each worker's notes.
- Section numbering must be assigned once, in the table of contents, and every cross-reference
  must point at an anchor, not a number; the first draft said "section 7" for a section numbered 6
  and "ten releases" where the fact-check had already established eight.
- A command count must be the same number everywhere it appears (goals, principles, identity card,
  feature heading). Compute it from the command table at build time instead of typing it.
- Keyword mapping of complaint themes to designs needs two passes (every theme pattern before any
  detail fallback) and word boundaries: "mitigated" matched "gated", "point clouds" matched
  "cloud", "AUDIT/RECOVER habits" matched an input-model pattern. Print the mapping and read it
  before trusting it; the review caught three mis-mapped rows the first time.
- Readers need the product-by-product "new versus missing" lists and a theme × product matrix,
  not only a long verbatim table; keep the verbatim rows in a collapsed block with their sources.
- Genesis is a plan: write its claims in the conditional, keep an identity card labelled
  "targets, not measurements", and list where every target number comes from (appendix A.4).

### Facts added or corrected in this iteration
- BricsCAD V27 launched on 20 October 2026 from Octave, the name Bricsys took in 2026 as a Hexagon
  spin-off; the inventory stays on V26 and marks V27 additions. AutoLISP runs in every BricsCAD
  edition; Pro adds 3D, the civil tools, point clouds and the BRX/.NET/COM APIs.
- CADCraft's plot style tables are its own JSON format behind the `.ctb`/`.stb` names; vendor
  binaries are not read. DXF is read R12–2018 in ASCII and binary.
- Civil 3D referencing and crash safety are partial, not missing, in the summary table: data
  shortcuts and xrefs exist and break; the crash-reporting pipeline exists and the fixed-issue
  lists carry 12–17 crash fixes per release.

### Open follow-ups for the next iteration (from the completeness critic)
- Add Carlson Civil/Survey and Trimble Business Center snapshots; capture Civil Site Design for
  BricsCAD; count BricsCAD crash fixes from its release notes; settle BricsCAD and Autodesk list
  prices on the live store pages; record live G2 review counts.
- Assess the `acadrust` DWG bridge (maintainers, corpus, native write) before Genesis depends on it.
- Run a benchmark on a large public DWG/DXF (open, xattach, save) with memory measured, so the
  Genesis targets in appendix A.4 rest on numbers from this container rather than issue reports.
- Reproduce upstream #540 (two instances saving the same file) on 0.10.0 and file the result.
- Retrieve Reddit, Hacker News and YouTube sentiment through a reachable route; these were blocked.
- Run `qa.jsonl` through a second provider from `byok.md` and add the first cross-model row.
