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

## 2026-10-22 · Third iteration: re-verify, track, and measure the pack across models

### Readability re-verification (12 findings, 12 verified against the rebuilt page)
- Six were already fixed by the second iteration; six had a residue the first fix missed, every one
  a second copy of the same text elsewhere (a worker's version string, a complaint row shown in two
  tables, a backlog counter-design cell, the table of contents). Lesson: when a fix changes a phrase,
  grep the generated page for the old phrase before declaring it done; data rows reach the page
  through more than one table.
- Verifying against the current page rather than the original finding is the right check: it
  separates "fixed", "half fixed" and "open" and yields an exact remaining edit.

### Progress tracker
- `docs/genesis/parity-tracker.md` is generated with the page from the same lists (matrix rows,
  roadmap phases, critique follow-ups) plus a hand-maintained progress table, so the tracker cannot
  drift from the page. CADCraft's own parity documents stay untouched.

### Cross-model evaluation of the pack (36 questions, 4 models, 2 conditions, blind judge)
- Closed-book scores: haiku 31 %, sonnet 51 %, opus 58 %, session model 58 %; refusals carried most
  of the gap (21, 11, 10, 10 of 36) and no model hallucinated when told to say "unsure".
- Open-book (the model reads the knowledge card) scored 100 % for every model with 97–100 % correct
  citations. That is a ceiling, not a result: `qa.jsonl` was derived from the same cards, so open-book
  measures whether the cards are complete and the model can find the row, which they are and it can.
  The product lesson stands: the pack turns a 31–58 % assistant into a cited one; retrieval of the
  right card is the whole problem for the in-app assistant, not model choice.
- Closed-book citation rates were 0–8 %: without the pack the models cannot name a source even when
  the answer is right. Any onboard assistant must ship with retrieval or it will answer unsourced.
- Next evaluation must use held-out questions that are not paraphrases of the cards (the review
  findings, the fact-check verdicts, and questions written by a design partner), two judges instead
  of one, and at least one non-Anthropic provider through BYOK so "between AIs" means more than one
  vendor.
- The judge (opus) also graded its own answers; the opus rows carry that bias. Cost and token counts
  were not metered by the harness; record them when the BYOK path runs through a provider that
  returns usage.

### Model continuity
- From this iteration every delegated run is pinned to the Opus 5.5 alias, so the work continues
  when the session model reaches its limit; the session model itself is switched by the owner. Every
  record names the model that produced it.

## 2026-11-06 · Fourth iteration: build, check and test for real

### Functional smoke tests (new: `packaging/smoke-test.sh`, `packaging/windows/smoke-test.ps1`)
- 49 steps, all passing in the Linux container on the 0.10.0 release binaries: CLI version and
  catalogue (431 command objects), sample floor plan with 16 entities as DXF and as DWG, DXF → DWG →
  SVG → PNG → PDF with element counts and file signatures, a scripted drawing (LINE, CIRCLE,
  DIMLINEAR) whose model-space counts come from `info`, the JSON command form, a DWG round trip that
  keeps all three entities, `perf 20000`, and the desktop app under a private Xvfb: baseline
  `drawing.inspect`, `ping`, `cmdline.input` and `engine.execute` that must raise the entity count by
  exactly three, `ui.screenshot` (1600×1000, 250 KB) and `ui.render`, `app.quit` acknowledged, a
  clean exit and no panic in the log.
- The first version of the scripts (35 steps) was reviewed by three Opus lenses (PowerShell runtime,
  POSIX portability, correctness against the CLI and control channel): 50 findings, 50 verified, 46
  real. The pattern behind most of them: an assertion that cannot fail. `^LINE` matched the
  dimension's anonymous block, `entit` matched the key `entityCount` even at zero, a line count of
  pretty-printed JSON stood in for a command count, `cmdline.input` always replies ok:true with the
  error inside the result, and a TCP connect proved only that something listens on the port. Every
  assertion now reads a number the product computed and compares it with the expected value.
- On Windows, PowerShell 5.1 and 7.0–7.2 pass native arguments without escaping embedded quotes,
  so JSON given to `--cmd` arrives without its quotes; the script escapes them when legacy passing
  is in effect. The POSIX script starts Xvfb on a free display with `-displayfd` and probes
  readiness with a `ping` over the channel instead of `nc -z`, which some `nc` variants lack.
- Two lessons from writing it: `xvfb-run -s` takes one quoted argument, which a POSIX variable
  cannot carry, so the script starts its own Xvfb instead; and the control channel answers one JSON
  object per request on the same connection, so a single `nc` session with a sleep before
  `app.quit` is enough, no client library needed, as long as a watchdog guards against a hung app.
- The PowerShell twin mirrors every step with .NET's TcpClient for the control channel; it has
  not run on Windows yet (no PowerShell in the container, no PC folder shared with the session).

### Repository gate (`cargo xtask ci`)
- First run (`cargo xtask ci`, 2026-11-06 22:44 UTC): `fmt --check` passed, `clippy --workspace --all-targets -D warnings` passed (2 min 35 s), then the workspace test build stopped with "No space left on device": the dev profile is optimized with debug info and the test binaries of the ui crate alone pushed `target/debug` to 25 GB, past the container's writable allowance. Not a code failure.
- Second run with lean settings (`CARGO_INCREMENTAL=0 CARGO_PROFILE_DEV_DEBUG=0 CARGO_PROFILE_TEST_DEBUG=0`, 2026-11-06 22:55–23:08 UTC): `cargo test --workspace` passed, 2204 tests passed, 0 failed, 0 ignored across 327 test binaries (`target/debug` 7.3 GB with debug info off); `cargo xtask assets` passed (28 asset files attributed); `cargo xtask layers` passed (ok: 16 crates, no layering violations.); `cargo xtask wasm` passed (11 crates checked for wasm32-unknown-unknown). With fmt and clippy from the first run, every step of the gate is green on this branch at commit b013ca8.
- Lesson: in a container with a 20–25 GB allowance, run the gate with debug info off and remove `target/debug` before the wasm check; keep `target/release` for the smoke test. The tests alone need about 12 minutes on 4 vCPU.

### Running on the owner's PC
- A cloud session can build and test on the owner's own machine only through a Remote Control
  folder; none was shared (the folder list was empty), so the PC run stays blocked until the
  clone's folder is added in the Claude desktop app (Settings → Claude Code → Remote Control).

### Model continuity
- The session was still served by the Fable 5.1 model on 2026-11-06 (session record); delegated
  runs stay pinned to Opus 5.5.
