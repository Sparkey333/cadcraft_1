# CADCraft feature inventory (honest, evidence-based)

Compiled 2026-10-21 from the repository clone at `/home/user/cadcraft_1` (branch `claude/sweet-pasteur-e6o9dg`, HEAD `0cf3bde` = merge of upstream PR #1398, 2026-10-21). Read-only: nothing was built or run. Upstream: https://github.com/storytold/cadcraft (MIT OR Apache-2.0). Every status below cites a file or a doc row. Status scale: **full** (works as AutoCAD users expect, per the repo's own audit), **partial** (exists but with stubs, caps or missing options the docs name), **none**.

Caveat on the repo's own numbers: the parity docs are self-assessments written by the agents that built the app (`docs/target-app-parity.md` "How it was measured"), re-measured on 2026-10-10 against AutoCAD 2027 for Mac and only partly refreshed since. Several docs disagree with each other (see "Doc inconsistencies" at the end). I report both values where they differ.

---

## 1. Measured numbers

| Metric | Value | Evidence |
|---|---|---|
| Version | **0.10.0** | `Cargo.toml` `[workspace.package] version = "0.10.0"`; commit `e86eacf` "Release 0.10.0" dated 2026-10-19; GitHub release `v0.10.0` page shows 21 Oct, 30 assets (WebFetch of https://github.com/storytold/cadcraft/releases/latest, 2026-10-21) |
| Stage | **pre-alpha** (4 of 5 core workflows fail the alpha gate) | `ROADMAP.md` banner; `docs/roadmap.md#alpha-gate` |
| Target | Autodesk AutoCAD 2027 (for Mac 26.0 as menu oracle; Windows docs where they differ) | `docs/target-app-parity.md` |
| Lines of Rust | **193,684** lines in **618** `.rs` files (crates + apps + xtask, tests included; ~11,838 lines are in files named `*test*.rs`, inline `#[cfg(test)]` modules not separated) | `find … -name '*.rs' \| xargs cat \| wc -l` (2026-10-21). `docs/architecture.md` says "about 57,000 lines" as of 2026-10-10: stale by ~3.4× |
| Lines per crate | engine 97,341 · ui-egui 29,979 · io 23,106 · doc 10,689 · render 9,514 · geom 5,031 · fonts 4,754 · constraints 4,283 · dxf 1,171 · mcp 1,075 · dwg 791 · color 276 · app cadcraft 2,792 · cadcraft-cli 1,236 · cadcraft-web 549 · xtask 1,097 | same count, per directory |
| Crates | **12 library crates** (`geom, dxf, color, doc, constraints, fonts, render, io, dwg, engine, ui-egui, mcp`) + **3 apps** (`cadcraft`, `cadcraft-cli`, `cadcraft-web`) + `xtask` | `ls crates apps`; `docs/architecture.md` |
| Engine command ids | **413** registered ids (harness file `command-ids.txt`); 415 `CommandSpec::new(` call sites in `crates/engine/src/cmd`; **240** `.interactive(` prompt machines; 32 transparent commands | grep counts 2026-10-21. `docs/parity-checklist.md` (generated 2026-10-16) says "427 registered commands"; `docs/architecture.md` (2026-10-10) said 295 |
| UI-only commands | **56** entries in `UI_COMMANDS` (`ui.dock`, `ui.theme.*`, `ui.saveversion.*`, `ui.spacemouse*`, dialogs…) | `crates/ui-egui/src/menus.rs:17` |
| Menu-breadth parity | **245 / 491 = 50%** (ROADMAP headline, reviewed 2026-10-10; 233 engine + 12 UI-only) · **283 / 491 = 58%** per the regenerated checklist of 2026-10-16 (Dimension 28/28 = 100%, Format 93%, Edit 85%, Tools 71%, Draw 63%, File 59%, Modify 46%, Insert 45%, View 41%, Window 14%, Help 0%) · 2D menus only ≈ 65% | `ROADMAP.md`; `docs/parity-checklist.md` |
| Ready for real work | **≈ 38%** (weighted 37.7%) | `docs/target-app-parity.md` "By dimension" |
| Mainstream 2D drafter | ≈ 28% (45.3% depth × 0.90 interaction × 0.85 stability × 0.80 file exchange) | same doc |
| Essentials user | ≈ 46% | same doc |
| Feature depth (weighted) | ≈ 41% | same doc |
| Per-dimension | UI/UX 43% (ROADMAP) / 48% (`docs/ui-parity.md`, updated 2026-10-11) · File formats 30% · Stability 35% · Performance 60% · Platforms 75% · Localization 5% (stale) · Ecosystem/automation 10% · AI 20% · Hardware 45% | `ROADMAP.md` "By dimension" |
| Per-area features | Draw 60% · Modify 50% · Geometry precision 40% · Layers 70% · Dimensions 45% · Text/MTEXT 35% · Leaders/tables/fields 25% · Hatch 35% · Blocks/xrefs 25% · Layouts/plot 35% · Inquiry 30% · Constraints 50% · 3D 2% · Collaboration 5% | `ROADMAP.md` "Features" |
| Hours remaining (self-estimate, "Opus 5.5 agent-hours") | alpha 125–190 h · beta 600–930 h · full parity 1,300–2,100 h | `ROADMAP.md` |
| DXF / DWG fidelity | DXF ≈ 50% read / 30% write; DWG ≈ 30% read / 15% write | `docs/file-format-parity.md` |
| Tests | **2,184** `#[test]` attributes; ~40 test fns named `hostile_*…never_panic` etc.; 36 io round-trip tests, all synthetic | grep 2026-10-21; `docs/file-format-parity.md#tests` |
| `catch_unwind` sites | **19** in non-test code (engine `lib.rs` execute/input/open, `guard.rs` ×8, `dwg/lib.rs` ×4, `lisp/mod.rs` ×2, `cmd/file.rs`, `ui-egui canvas/rebuild.rs`) | grep |
| Crate roots with `deny(clippy::unwrap_used …)` | 15 | grep; `unsafe_code = "forbid"` in `Cargo.toml` |
| Interface languages | **16**: English + 15 TSV catalogs (ar, cs, de, el, es, fr, hu, it, ko, pt-BR, ru, sv, tr, uk, zh), 1,010–1,360 rows each (18,385 rows total) | `crates/ui-egui/src/i18n/*.tsv`; `docs/localization.md`. `ROADMAP.md` Languages table is stale (lists most as "none") |
| System variables | ~125 entries in `crates/engine/src/sysvars/table.rs`; docs say "about 150 of ~1,000" | grep; `docs/gaps.md` U10 |
| Command aliases | 144 built-in; user `.pgp` files via ALIASEDIT | `docs/ui-parity.md` |
| Hatch patterns / linetypes | 23 own patterns (AutoCAD ~85); 19 linetypes (~45) | `docs/gaps.md` F13; `docs/target-app-parity.md` |
| DIMSTYLE variables | 43 of ~80 | `docs/roadmap.md` alpha gate |
| AutoLISP interpreter | 5,620 lines (`crates/engine/src/lisp/`) | wc |
| Menu oracle | `xtask/data/menu-catalog.txt` 560 lines / 491 leaf items | file |
| Performance (internal) | 200k entities: pick 0.001 ms, ~4 ms after edit (incremental R-tree), ~4 ms GPU frame; 12k-entity hatched DWG (~340k primitives): zoom stall 2–4.5 s → 26–64 ms after background rebuild (2026-10-13), edits still 1.8 s on UI thread; 10 MB DWG failed after ~2 min (#57); 83 MB DGN-bloated site plan with 888,483 orphan line-style components now opens (#1482) | `docs/hardware-parity.md`; `docs/file-format-parity.md` rev 2026-10-17 |
| GitHub (fetched page, **unverified**) | 6.3k stars, 2.8k forks, 57 watching, 392 open issues, 404 open PRs (WebFetch of https://github.com/storytold/cadcraft on 2026-10-21; API access was blocked in this session). Docs' own count on 2026-10-10: 97 issues (37 open), 127 PRs from 19 outside authors, 2 praise comments, 0 "switched from AutoCAD" reports | `docs/target-app-parity.md` "User evidence" |
| Development history | first version (51k lines, 290 commands) built in ≈ 11.5 agent-hours on 2026-10-07; PR numbers reached #1727 by 2026-10-21 | `ROADMAP.md` progress log; `git log` |
| Licence | MIT OR Apache-2.0; DWG bridge uses `acadrust` 0.6.4 (MPL-2.0, unmodified); ArtCraft brand in `docs/brand/` is trademarked, not open | `Cargo.toml`, `crates/dwg/Cargo.toml`, `README.md` |
| Toolchain | Rust 1.95+ for desktop/web UI builds, workspace MSRV 1.90; edition 2024; egui/eframe 0.36, wgpu | `README.md` Quick start; `Cargo.toml` |

---

## 2. Feature inventory by category

### 2.1 Drawing & modify

| Feature | Status | Evidence / notes |
|---|---|---|
| LINE, PLINE (arcs, widths, Length), CIRCLE (6/6 methods incl. TTR/TTT), ARC (11/11), RECTANG (fillet/chamfer/all options), POLYGON, ELLIPSE (+arcs, Isocircle), SPLINE (fit/CV, Knots/Tangency/toLerance/Object), POINT, XLINE, RAY, DONUT, REVCLOUD (rect/poly/freehand), WIPEOUT, BOUNDARY, CENTERLINE/CENTERMARK | **full** | `cmd/draw.rs`, `cmd/draw2.rs`; `docs/target-app-parity.md` Draw row "ARC 11/11, CIRCLE 6/6, RECTANG all options" |
| MLINE (+MLSTYLE, MLEDIT), REGION (UNION/SUBTRACT/INTERSECT), HELIX | **partial** | objects since #510; MLEDIT tees trim square, booleans only on non-touching boundaries, regions saved as polylines (no ACIS) (`docs/gaps.md` F21) |
| Isometric drafting (ISODRAFT, ISOPLANE/F5) | **full** | #556; `engine/src/snap/iso.rs`, `cmd/settings/iso.rs` |
| ERASE, MOVE, COPY, ROTATE (Reference), SCALE, MIRROR, STRETCH (CP/WP/fence), OFFSET (Through/Erase/Layer/Multiple), TRIM/EXTEND (quick + standard), FILLET/CHAMFER (Polyline, Trim, Multiple), BREAK, BREAKATPOINT, JOIN, EXPLODE, LENGTHEN, BLEND, ALIGN, REVERSE, PEDIT (vertex editing), SPLINEDIT, OVERKILL, DRAWORDER, MATCHPROP, FLATTEN, CHSPACE, MOCORO/NCOPY/BURST/BREAKLINE/TXT2MTXT (Express-tool equivalents) | **full** for lines/arcs/circles/polylines; **partial** for ellipse/spline inputs | `docs/geometry-parity.md`: TRIM on ellipse/spline is sampled (1e-4 refinement); BREAK only line/arc/circle/polyline; OFFSET of ellipse yields a polyline, spline offset lossy, polyline offset doesn't recompute bulges; `docs/gaps.md` F1 says the most-used options are done, leftovers in -ATTEDIT/-RENAME |
| ARRAY rect/polar/path, associative arrays, ARRAYEDIT/ARRAYCLOSE | **partial** | #448; no array grips, ARRAYPATH not associative, no item deletion (`docs/gaps.md` F5) |
| Grips (stretch/move/rotate/scale/mirror, hot-grip options, multi-grip, polyline vertex menus) | **partial** | #425 landed options and multiple hot grips; no hover multifunctional menus, no grip dimensional input (`docs/ui-parity.md` Grips ≈ 40%; `docs/gaps.md` U5) |
| Undo/redo (U, UNDO count, MREDO, UNDOCTL) | **partial** | whole-document copy-on-write snapshots capped at 2,000; no Mark/Back/BEgin/End groups (`docs/ui-parity.md` command line table; `engine/src/undoctl.rs`) |
| Geometry precision | **partial** | exact for lines/arcs/circles; ellipse/spline intersections tessellated; absolute tolerance `EPS = 1e-9`; 2D kernel (`Vec2`, Z dropped); property tests hold known answers at 1e6–1e7 coordinates to 1e-9 relative (`docs/geometry-parity.md`) |

### 2.2 Precision input

| Feature | Status | Evidence |
|---|---|---|
| Coordinate syntax `x,y`, `@dx,dy`, `@d<a`, `#`, `*`, direct distance entry, angle forms (`45d30'`, surveyor `N45dE`, grads, radians), architectural `5'6-1/2"` | **full** | `engine/src/prompt.rs`, `units.rs` (`docs/ui-parity.md` Point entry) |
| FROM, M2P/MTP, point filters `.x .y .xy`, angle override `<a`, typed osnap overrides (END/MID/…/NON) | **full** | `engine/src/pointmod.rs` (#393, #441) |
| TK (tracking point modifier), `'CAL` typed calculator | **none** | `docs/ui-parity.md` Point entry rows |
| Running object snaps (END, MID, CEN, GCE, NOD, QUA, INT, EXT, INS, PER, TAN, NEA, APP, PAR) | **partial** | all modes exist; MID none on circles/ellipses/splines, TAN not on ellipse/spline, GCE closed LWPOLYLINE only, INS not on ATTDEF/MLEADER (`docs/ui-parity.md` Object snaps ≈ 45%) |
| Object snap tracking, polar tracking, ortho, Shift-override, additional polar angles | **full** | #379; `engine/src/snap/tracking.rs` (Tracking ≈ 70%) |
| PolarSnap, polar relative to last segment | **none** | `docs/ui-parity.md` |
| Grid/snap rectangular + isometric, SNAPBASE/SNAPANG | **full** | same |
| Dynamic input (pointer boxes, Tab/`,`/`<` locks, relative default) | **partial** | #60; no grip dimensional input, lock icons, DYNPROMPT menu, DYNDIM (`docs/ui-parity.md` Dynamic input ≈ 45%) |
| Selection: pick, window/crossing, W/C/F/WP/CP/BOX/AU/SI/M/G/Add/Remove/Undo, press-drag (PICKDRAG 0/2), selection cycling, QSELECT, SELECTSIMILAR, ISOLATEOBJECTS/HIDEOBJECTS | **partial** | #226, #428, #1143; no lasso, no CLass keyword, no FILTER dialog, isolation not saved (`docs/gaps.md` U6) |
| Right-click/context menus | **partial** | command menu, selection menu, palette menus (#512); no layout-tab rename/move/copy dialog |
| Drafting Settings dialog, Options dialog (Display, Open/Save, Drafting, Selection, User Prefs, Profiles) | **full** | #23 (`docs/gaps.md` F20 leftovers: right-click customization, named profile import/export) |

### 2.3 Layers & properties

| Feature | Status | Evidence |
|---|---|---|
| Layers palette + Layer Properties Manager (on/off/freeze/lock/plot/colour/linetype/lineweight/transparency/description/plot style), filters, layer states (LAYERSTATE save/restore/rename/delete), VP overrides | **full** | `crates/ui-egui/src/layers.rs`, `cmd/layer.rs`; `docs/target-app-parity.md` Layers 70% |
| Layer tools: LAYISO/LAYUNISO, LAYFRZ/LAYTHW, LAYOFF/LAYON, LAYLCK/LAYULK, LAYMCH, LAYMCUR, LAYCUR, LAYDEL, LAYMRG, LAYERP, VPLAYER | **full** | command ids list |
| Properties palette (per-object editing), Quick Properties, QSELECT | **full** | #182; block references show read-only insertion X/Y/Z, coordinate editing still missing (`docs/ui-parity.md` Chrome) |
| Linetypes (19 of ~45), LTSCALE, user `.lin` files; lineweights (LWDISPLAY, LWEIGHT); colour index + true colour; transparency (TRANSPARENCYDISPLAY) | **partial** | linetype manager thin; linetype SHX shape elements skipped (`docs/gaps.md` FF9) |
| RENAME, PURGE | **partial** | -RENAME of materials/plot styles/viewport configs prints "not available yet"; PURGE skips multiline styles (`docs/gaps.md` F1, F21) |

### 2.4 Annotation

| Feature | Status | Evidence |
|---|---|---|
| Dimensions: DIMLINEAR/ALIGNED/ANGULAR/ARC/RADIUS/DIAMETER/ORDINATE/JOGGED/JOGLINE/BASELINE/CONTINUE/BREAK/SPACE/EDIT/TEDIT/INSPECT/OVERRIDE/REASSOCIATE/DISASSOCIATE, QDIM modes, DIM (smart DIM: **none**), associativity following geometry, all arrowheads, 43/~80 DIMSTYLE variables, DIMSTYLE command (current/delete/rename/override/update/list) | **partial** (core **full**) | Dimension menu 28/28 covered (`docs/parity-checklist.md`); no DIMSTYLE Manager dialog, no smart DIM, DIMTFILL/DIMALTTD/DIMUPT/DIMTXTDIRECTION not modelled, DIMBREAK doesn't follow moved objects (`docs/gaps.md` F7) |
| TEXT, MTEXT (TrueType/OpenType/`.ttc`, formatting codes, stacked fractions, indents/tabs/bullets/numbering/columns, on-canvas editor with toolbar and ruler) | **partial** | #532, #547; editor doesn't lay out by indents/tabs/columns while typing, existing MTEXT can't be edited (no DDEDIT/MTEDIT), no FIELD/UPDATEFIELD, no SPELL (PR #551 open), no SHX fonts (`docs/gaps.md` F9, FF8) |
| Bidi/Arabic shaping in drawing text, CJK fallback, FONTALT/FONTFALLBACK | **full** | #287, #173; `README.md` Fonts section |
| MLEADER, MLEADERSTYLE (5 fields), MLEADEREDIT add/remove, MLEADERALIGN, MLEADERCOLLECT, LEADER, native MULTILEADER DXF | **partial** | #459, #408; one landing per multileader, block content lacks attributes (`docs/gaps.md` F10, FF2) |
| TABLE, TABLESTYLE (cell styles), TABLEDIT, formulas, table.break, TABLEEXPORT, CSV DATALINK/DATALINKUPDATE | **partial** | #534; formulas not stored as AutoCAD FIELDs, cell text doesn't wrap, custom styles/breaks/links travel only as CADCraft xdata (not through DWG), data links CSV/TSV only, 8 MiB cap, no Excel, no write-back, not on web (`docs/gaps.md` F11; `cmd/table/breaks.rs`) |
| Fields (FIELD, UPDATEFIELD) | **none** | `docs/gaps.md` F9 |
| TOLERANCE (feature control frames) | **partial** | #420; no dialog, no leader attachment, no in-place edit (F8) |
| Annotative scaling (CANNOSCALE, OBJECTSCALE, SCALELISTEDIT, ANNOALLVISIBLE/ANNOAUTOSCALE) | **partial** | #468; ANNORESET no-op, no per-scale positions, AutoCAD per-object scale contexts read as non-annotative (F12) |
| TEXTTOFRONT, HATCHTOBACK | **partial** | current space only (F19) |

### 2.5 Hatch

| Feature | Status | Evidence |
|---|---|---|
| HATCH pick-point/select-object with islands, pattern/solid/gradient, Hatch and Gradient dialog (HPDLGMODE), HATCHEDIT dialog and command (add/remove boundaries), associative hatches (also inside blocks), origin, gap tolerance, separate hatches, island styles | **partial** | `cmd/hatch.rs`, `cmd/hatch/edit.rs`, `ui-egui/src/hatchdlg.rs`; 23 own patterns of ~85, gradients render flat, no Preview/Inherit Properties, no MPolygon, copied hatch not linked to copied boundary, HPGAPTOL between curve ends only (`docs/gaps.md` F13) |
| Boundary tracing | **partial** | curves polygonised; caps 60,000 segments / 4,096 islands; boundaries come out tessellated (`geom/src/region.rs`; `docs/geometry-parity.md` Hatch ≈ 45%) |
| User `.pat` files, SUPERHATCH | user `.pat`: **full** (#552); SUPERHATCH: **none** | `docs/gaps.md` E3 |

### 2.6 Blocks, attributes, dynamic blocks, xrefs, groups

| Feature | Status | Evidence |
|---|---|---|
| BLOCK/-BLOCK, INSERT (file insert), WBLOCK, BASE, nested blocks, Blocks palette, EXPLODE | **full** | `cmd/blocks.rs`, `cmd/blocks/insert_file.rs` |
| Block Editor (BEDIT/BSAVE/BSAVEAS/BCLOSE, Edit Block Definition dialog) for static blocks | **full** for static blocks | 2026-10-12 rows in `docs/gaps.md` F3 |
| REFEDIT/REFSET/REFCLOSE (in-place edit of a block reference) | **partial** | #813; works for blocks; xref in place not written back, no nested pick, no banner (`docs/gaps.md` F2) |
| Attributes: ATTDEF, ATTEDIT/-ATTEDIT, ATTSYNC, BATTMAN, ATTDISP, multiline attributes, DATAEXTRACTION/EATTEXT (CSV or table) | **partial** | #433; no verify/preset/lock-position modes, BATTMAN can't create multiline attributes, extraction has no wizard/nested blocks/`.dxe` (F17) |
| Dynamic blocks | **partial (read/use), none (author)** | parameters, visibility states, value sets, stretch/lookup read into a model (`blocks.dynamic`), references edited by grips and Properties ▸ Custom, saved as AutoCAD saves them (checked with an AutoCAD dynamic block per `docs/file-format-parity.md`); no authoring of parameters/actions (F3, alpha blocker at beta) |
| Xrefs: XATTACH, -XREF (?/Bind/Detach/Path/Unload/Reload/Overlay/Attach/Type), XBIND, XOPEN, External References palette, overlays, relative paths, nested loading, load at open | **partial** | #525; `cmd/blocks/xref.rs`, `xref/load.rs`, `xref/bind.rs`, `ui-egui/src/xrefs.rs`; XCLIP **none**; unloaded state and xref-layer overrides last only for the session (F2) |
| Groups: GROUP/-GROUP/GROUPEDIT/UNGROUP, PICKSTYLE, DXF/DWG round trip | **partial** | #417; no group bounding box/single grip, copying a group doesn't make a new group, no Object Grouping dialog (F16) |
| DesignCenter, tool palettes, Smart Blocks | **none** | `docs/target-app-parity.md` Blocks row; `docs/gaps.md` A1 |

### 2.7 Layouts, viewports, plotting

| Feature | Status | Evidence |
|---|---|---|
| Layouts (new/copy/delete/rename/set), layout tabs, MSPACE/PSPACE via viewports, MVIEW (ON/OFF/Lock/2/3/4, polygonal, object), VPCLIP, per-viewport layer freeze and overrides, viewport scale list, VPORTS (tiled model viewports with saved configurations), named views (VIEW) | **partial** | #453, #463; MVIEW Restore prints "not available yet"; clipped viewport and its boundary move separately (F15, U11) |
| PAGESETUP (device, paper, margins, plot style table, plot transparency), PLOT, EXPORTPDF, PREVIEW, PUBLISH (≤256 sheets), PLOTWINDOW, PDFBOOK (sheet books from frame polylines), Plot dialog | **partial** | #160, #186; model-space PDF plots keep default margins; no system printers (H3); "Plot transparency" not saved in DXF/DWG (F14) |
| Plot styles CTB/STB (own JSON format, built-in default/monochrome/grayscale tables, end/join/fill styles, STYLESMANAGER dialog, kept in drawing) | **partial** | `docs/plot-styles.md`; binary `.ctb`/`.stb` not read (no public spec) |
| Plotter devices (CADCraft PDF/PNG/SVG, ISO/ANSI/ARCH papers, user `.plotter.json`, PLOTTERMANAGER) | **partial** | `docs/plotters.md`; binary `.pc3`/`.pmp` not read; no physical printers |
| PDF output: vector, lineweights, real text as embedded TrueType subsets, OCG layers, several sheets per file, hyperlinks, transparency as alpha | **full** | #567, #571; `crates/io/src/pdf/` |
| Annotative scale per viewport | **partial** | F12 |

### 2.8 Files & exchange

| Format | Status | Evidence |
|---|---|---|
| DXF read: R12 ASCII through 2018, ASCII + binary (R13+), code pages pre-2007 (#505), `\U+`/`\M+` escapes | **full** (R12 binary: **none**) | `docs/file-format-parity.md` DXF table |
| DXF write: 2000–2018 ASCII and binary (SAVEAS version/binary), round-trips unknown entities/objects with CLASS records, foreign xdata, extension dictionaries, reactors, XRECORDs, layer states, colour books (#528) | **partial** | R12/R14 output **none**; 36 header variables written vs ~280 in AutoCAD; other programs' table/object handles renumbered on first save (FF7); UCS elevation and MTEXT background colour lost (FF1) |
| DWG read/write 2000–2018 via `acadrust` 0.6.4 DXF bridge (native only, not web) | **partial** | R13/R14 read "claims support, untested"; R14/pre-R13 write **none**; acadrust drops custom-class entities/objects, xdata on table records/blocks, colour books, reactors; 10 MB DWG failed after ~2 min (#57); never verified in AutoCAD; no real-file corpus (alpha blockers 1, 2, FF5, FF6) |
| DWT templates (NEW/QNEW, SAVEAS .dwt) | **full** | #552 |
| PDF export | **full** (see 2.7) | |
| PDF import / PDF underlay (PDFIMPORT, PDFATTACH) | **none** | FF10 (20–35 h est.) |
| Raster images (IMAGEATTACH, display) | **none** (IMAGE entity round-trips in DXF but is never shown; ATTACH command is a stub that returns "not available yet") | `cmd/exchange.rs:57`; `docs/file-format-parity.md` |
| SVG export, PNG export (2400×1600 default), `--window` framing | **full** | `README.md` CLI section; AutoCAD has no SVG export |
| SVG/SVGZ import (shapes, paths, groups, Inkscape layers) | **partial** | #636; no CSS classes, `use`, fills/gradients, text, images; losses listed on open (#627) |
| IMPORT (merge another DXF/DWG's model space with its layers/styles/blocks at a point and scale), EXPORT (dxf/dwg/svg/png/pdf) | **full** | `cmd/exchange.rs` `EXPORT_FORMATS`, `run_import` |
| DWF/DWFx, DGN, WMF, EPS, ACIS SAT, STL, FBX, IGES/STEP, 3DS, DWS standards | **none** | `docs/file-format-parity.md` Other formats |
| SHX fonts (shapes, big fonts) | **none** (stroke font or FONTALT stands in; text metrics differ) | FF8 |
| `.lin`/`.pat`/`.pgp` user files | **full** | #552 |
| `.lsp` load | **full** (core language) | #758 |
| JSON data formats: plot styles, plotters, workspace layout | **full** (own formats) | `docs/plot-styles.md`, `docs/plotters.md`, `docs/control-protocol.md` |
| Multiple open drawings, file tabs, `document.switch`, drag-and-drop open | **full** | `cmd/file.rs:174`; `README.md` |
| Web build file I/O | **partial** | no DWG, plot shows raw PDF bytes (#134); open/save downloads fixed (#55, #133) |

### 2.9 Parametric constraints

| Feature | Status | Evidence |
|---|---|---|
| 12 geometric constraints (incl. G2 Smooth), dimensional constraints (distance/angular/radius/diameter), PARAMETERS with expressions, AUTOCONSTRAIN, CONSTRAINTINFER, DOF report, over-constraint detection, constraint bars, re-solve after every edit, DXF persistence | **full** for 2D lines/arcs/circles/polylines/points; **partial** on ellipse/spline/block | own damped Gauss–Newton/LM solver (`crates/constraints/src/lm.rs`), MAX_ITER 200, MAX_ROWS 800 (`docs/geometry-parity.md` Constraint solver ≈ 50%; #546); no annotational vs dynamic constraint distinction noted |

### 2.10 3D

| Feature | Status | Evidence |
|---|---|---|
| UCS, 3D views, 3DORBIT, visual styles, solids, surfaces, meshes, sections, materials, lights, rendering, 3D osnaps (150 of 491 menu items) | **none** | `3dorbit` is a registered stub returning "CADCraft draws in 2D (plan view) only" (`cmd/exchange.rs:67`); `docs/gaps.md` F24 (300–450 h) |
| 3DPOLY, HELIX, Z on entity points, 3DFACE/SOLID/TRACE entities | **partial** (stored/drawn in plan, no 3D operations) | `docs/geometry-parity.md` Curves; `docs/architecture.md` Data model: "no UCS yet", 2D kernel |
| 3D exchange formats | **none** | FF11 |

### 2.11 Inquiry & utilities

| Feature | Status | Evidence |
|---|---|---|
| DIST, AREA, ID, LIST, MEASUREGEOM, angle/radius measure, CAL, QuickCalc palette, FIND, COUNT/COUNTLIST/COUNTTABLE, TIME, STATUS, UNITS dialog, LIMITS, SETVAR/GETVAR, SYSVARS, DIVIDE/MEASURE/DDPTYPE | **full** | command ids; `cmd/inquiry.rs`, `cmd/utility/calc.rs` |
| MASSPROP | **partial** | regions only (#510); shoelace over tessellated boundaries (`docs/geometry-parity.md` Measurement) |
| AREA on bulge polylines | **partial** | tessellated at 1e-4; ellipse perimeter exact since #1471 |
| COMPARE/COMPARECLOSE (drawing compare with overlay, next/previous) | **partial** | #563; 200,000-object cap, compares the shown tab only, no COMPAREEXPORT report (`cmd/file/compare.rs`; F22) |
| AUDIT (with AUDITCTL `.adt` log), RECOVER, DRAWINGRECOVERY | **full** | `engine/src/audit.rs`; #406 |
| OPTIONS dialog | **full** | #23 (F20 leftovers) |
| SPELL, ETRANSMIT | **none** | `docs/target-app-parity.md` Inquiry row |

### 2.12 Automation & APIs

| Feature | Status | Evidence |
|---|---|---|
| Command line: prompts with clickable keywords, AutoComplete, history (F2), aliases, transparent commands, scripts | **full** | `docs/ui-parity.md` Command line ≈ 60% (no sysvar/mid-string AutoComplete) |
| SCRIPT (`.scr` files), `cadcraft-cli run --script/--script-file`, script over MCP/control | **full** | #693 |
| AutoLISP: APPLOAD, `(load)`, `defun c:`, `command`, entity lists (entget/entmake/entmod), `ssget` with filters, `get…` input, `tblsearch`, `acad.lsp`/`acaddoc.lsp` startup, `autoload`, `*error*`, `vl-catch-all-*`, conformance corpus test | **partial** | #758; `docs/autolisp.md`; no Visual LISP ActiveX (`vlax-`/`vla-`), DCL dialogs, reactors; `trans` has no UCS; `.fas`/`.vlx` **none** (E1) |
| MCP server (`cadcraft-cli mcp`, headless or `--connect` to app, `--lazy`, `--launch`): tools `command_line`, `script`, `execute`, `list_commands`, `inspect_drawing`, `query_entities` (incl. `selected:true`), `shapes`, `render`, `find_text`, `new_drawing/open/save/cancel`, `screenshot`, `ui_inspect`, `ui_click`; resources `cadcraft://drawing`, `cadcraft://commands`; schema-validated args | **full** (ahead of AutoCAD) | `docs/mcp.md`; `crates/mcp` |
| JSON control channel (`--control PORT`, JSON lines): `cmdline.*`, `engine.execute`, `engine.commands`, `drawing.inspect`, `ui.inspect/elements/menu/pointer/click/drag/key/text/set/resize/screenshot/render/dock`, `app.open/save/quit`; bounded (16 connections, 256 MiB/line, 64 queued, 60 s timeout with `not-run`/`may-have-run` state) | **full** | `docs/control-protocol.md`; `crates/ui-egui/src/control.rs` |
| `cadcraft-cli` (`info`, `convert`, `run`, `commands`, `sample`, `perf`, `mcp`), headless PNG/SVG/PDF export, stdout-closed safety | **full** | `apps/cadcraft-cli/src/main.rs` |
| "Everything is a command": JSON form never opens dialogs; menus/toolbar/Tool Sets/scripts/CLI/MCP reach the same registry | **full** | `AGENTS.md`/`CLAUDE.md`; `cmd/mod.rs` `CommandSpec` |
| Plug-in API (ObjectARX/.NET/JS) | **none** (planned Rust→WASM plug-ins, owner decision E4) | `docs/customization.md` |
| CUI customisation, workspaces, tool palettes, action recorder | **none** (ALIASEDIT dialog only, session-scoped edits) | `docs/gaps.md` U12, E5 |
| Express Tools equivalents | **partial** | NCOPY, BREAKLINE, TXT2MTXT, BURST, MOCORO exist; no SUPERHATCH etc. (E3) |
| In-app AI assistant, Smart Blocks, Markup Assist | **none** | `docs/gaps.md` A1–A3 |

### 2.13 Collaboration

| Feature | Status | Evidence |
|---|---|---|
| Sheet Set Manager, eTransmit, Share (cloud), Traces, Markup Import/Assist, Activity Insights, DWS standards/CHECKSTANDARDS | **none** | `share` is a stub returning "no online service to share through" (`cmd/exchange.rs:62`); `docs/gaps.md` F23 |
| DWG Compare | **partial** | see 2.11 |
| Clipboard between drawings (COPYCLIP/CUTCLIP/COPYBASE/PASTECLIP/PASTEORIG/PASTEBLOCK) carrying layers, linetypes, styles and nested blocks; DXF text on the system clipboard to paste into another CADCraft window | **full** | `cmd/clipboard.rs` (50,000-object cap) |
| PUBLISH, PDFBOOK (multi-sheet PDF) | **partial** | 2.7 |
| Hyperlinks | **partial** | foreign hyperlink xdata kept and written to PDF; no HYPERLINK command in the id list |

### 2.14 Civil / land-development capabilities

**All none.** A case-sensitive, word-boundary scan of `crates/engine/src/cmd`, `crates/doc/src` and `crates/io/src` (2026-10-21) found zero matches for `TIN`, `contour`, `GIS`, `UTM`, `geodetic|latitude|longitude`, `northing|easting`, `slope`, `survey`, `parcel`, `grading`, `station`, `COGO`, `LandXML`, `shapefile`, `KML|GeoJSON`, `point cloud`, `GEOGRAPHICLOCATION`. The hits for `elevation` are the LWPOLYLINE elevation field (`doc/src/entity.rs:185`), for `alignment` text/table cell alignment, for `profile` user profiles and templates, for `surface` hatch library/GD&T symbols.

| Capability | Status | Notes |
|---|---|---|
| COGO points (number, elevation, description, point groups, styles) | **none** | only plain POINT/DIVIDE/MEASURE/DDPTYPE |
| Surfaces / TIN, contours, volumes | **none** | no 3D kernel; `Vec2` geometry (`docs/geometry-parity.md` Numbers) |
| Alignments, profiles, corridors, cross sections, grading, parcels, pipe networks | **none** | |
| Coordinate systems, geolocation (GEOGRAPHICLOCATION), map/aerial underlays | **none** | |
| GIS import (SHP/GeoJSON/KML), LandXML, survey (field book, ASCII point import) | **none** | |
| Survey units | **partial** | surveyor bearing angles `N45dE`, architectural/engineering distance formats and all AutoCAD unit/angle formats parse and display (`engine/src/units.rs`) |
| Large (state-plane/UTM) coordinates | **partial / risk** | `docs/geometry-parity.md`: "Large coordinates (UTM, 1e6–1e7): untested; absolute tolerances will misjudge tangency and coincidence"; property tests show closed-form known answers hold at 1e6–1e7 to 1e-9 relative, but tessellation steps are absolute world units (1e-3/1e-4) |
| Point clouds, DGN, DWF underlays | **none** | FF10/FF11 |

### 2.15 Stability & crash safety

| Item | Status | Evidence |
|---|---|---|
| Never-crash policy: no `unwrap/expect/panic!/todo!/unreachable!` in production code, `unsafe_code = "forbid"`, 15 crate roots with `#![deny(clippy::unwrap_used …)]` | **full** (policy + lints) | `CLAUDE.md`, `Cargo.toml` `[workspace.lints]`, grep |
| `catch_unwind` last-resort guards: `Session::execute` restores the drawing and selection on an escaped panic (`engine/src/lib.rs:896-910`); interactive input (`lib.rs:1231`); `guard.rs` wraps factory, `begin`, `input`, `prompt`, `preview`, `preview_objects`, `drag`, `editing_mtext`; file open (`lib.rs:784`); DWG bridge read and write (`dwg/lib.rs:75,98,499,515`) because `acadrust` is third-party; LISP tick (`lisp/mod.rs:272,313`); UI canvas rebuild thread (`ui-egui/src/canvas/rebuild.rs:142`); desktop logger (`apps/cadcraft/src/logging.rs:560`) | **full** | grep 2026-10-21 (19 sites) |
| Hostile-input tests: ~40 functions (`hostile_params_never_panic`, `hostile_lisp_never_panics`, `hostile_xref_input_never_panics`, `hostile_dxf…`, `hostile_linetype_files_never_panic_and_stay_capped`, geometry property suite with NaN/inf/subnormal/1e300 inputs) | **full** | grep; `crates/geom/src/property_tests.rs`; `docs/geometry-parity.md` Tests |
| Input caps: DXF tag counts (`crates/dxf`), DWG size limits (#175), hatch 60,000 segments / 4,096 islands, `MAX_BLOCK_DEPTH = 16` (`doc/src/extents.rs:10`), xref 4,000,000 objects / 1,000 files / 512 MiB per file / 1 GiB total, clipboard 50,000 objects, COMPARE 200,000 objects, data link 8 MiB, plot style file 4 MB, plotter file 1 MB, control channel 256 MiB/line, LISP "internal stack limit reached" | **full** | source constants cited |
| Autosave: SAVETIME (default 10 min, max 600) writes `<drawing>_<instance>_<uid>.sv$` as DXF to SAVEFILEPATH; per-instance lock file refreshed every 60 s, stale after 5 min; Drawing Recovery on next start | **partial** | `engine/src/autosave.rs`; **none on web**, files are DXF not DWG, no separate RECOVER mode in readers (`docs/gaps.md` F4) |
| AUDIT/RECOVER (missing layers/blocks recreated, dangling references reassigned, undrawable geometry removed, block cycles broken, duplicate handles fixed, `.adt` log) | **full** | `engine/src/audit.rs` |
| Logging that survives a crash (`cadcraft.log` rotated to `.1/.2`, 16 MiB cap, `RUST_LOG`) | **full** | `README.md` Logs |
| Undo as copy-on-write whole-document snapshots (cheap restore) | **full** | `docs/architecture.md` Data model |
| CI test gate on pull requests | **none** | workflows: `freebsd.yml`, `nix.yml` (flake **evaluation only**, "no build, about a minute"), `packaging-lint.yml`, `release.yml`, `windows-arm64.yml`; `docs/gaps.md` S1 "No CI runs `cargo xtask ci` on pull requests" |
| Known stability record | **partial** | self-rated 35%; startup crash on Intel UHD (#33, fixed 0.4.0); AMD `atio6axx.dll` GL crash avoided by DirectX-12-only default on Windows (`README.md`); "lines not visible mid-command" (#44); 27 of 37 open issues on the core path (2026-10-10); ~60 correctness fixes merged in one day (2026-10-10); 404 open PRs on 2026-10-21 (unverified page fetch) |

### 2.16 Performance

| Item | Status | Evidence |
|---|---|---|
| GPU canvas (wgpu: Metal / DX12 / Vulkan / WebGPU+WebGL2), CPU `tiny-skia` fallback, display lists rebuilt per change, R-tree spatial index patched per chunk | **full** | `docs/architecture.md` Rendering; `docs/hardware-parity.md` |
| Internal numbers: 200k entities pick 0.001 ms, 4 ms re-index after edit, ~4 ms frame; zoom/pan rebuilt on a worker thread (stalls 26–64 ms on a 340k-primitive DWG, M-series Mac); edits still ~1.8 s on that drawing | **partial** (self-rated 60%) | `docs/hardware-parity.md` |
| Large files: 1M entities untested; 10 MB DWG failed after ~2 min (#57); 83 MB DGN-bloated DWG opens after dropping 888k orphan line-style components (#1482); DWG via DXF bridge means a 1.2 GB intermediate DXF for that file | **partial / weak** | `docs/file-format-parity.md`, `docs/gaps.md` FF6 |
| No benchmark against AutoCAD or BricsCAD on the same machine | — | `docs/hardware-parity.md` |

### 2.17 Platforms & packaging

| Item | Status | Evidence |
|---|---|---|
| Windows x64 / arm64 / x86: MSI (WiX `packaging/windows/cadcraft.wxs`) + portable zip, code-signed, silent install flag | **full** | `README.md` Downloads; `packaging/windows/` |
| macOS universal DMG, signed and notarized; CLI zip | **full** | `packaging/macos/` |
| Linux x86_64 + aarch64: AppImage (self-updating via zsync), Flatpak, deb, rpm, tarball; riscv64 tarball | **full** | `packaging/linux/` |
| FreeBSD x86_64 tarball (aarch64 dropped in 0.10.0: CI 5-hour limit) | **partial** | release notes (WebFetch) |
| Web (WASM static site via trunk): no DWG, no autosave, plot shows raw PDF bytes, Korean needs a font, no installed fonts | **partial** | `docs/gaps.md` P1, F4; `docs/localization.md` |
| Nix flake | **partial** | `nix.yml` evaluates the flake only |
| Hardware: HiDPI yes; trackpad/pinch (macOS); 3D mouse: `ui-egui/src/spacemouse.rs` holds host-independent SpaceMouse preferences and 2D pan/zoom navigation (device I/O in the desktop app) while `docs/hardware-parity.md` (2026-10-13) still says "no"; pen tablet **none**; system printers **none**; multi-monitor not deliberate | **partial** | files cited |
| Windows/Linux get little runtime testing (main platform macOS) | — | `docs/gaps.md` P2; `docs/roadmap.md` "Main platform: macOS" |
| Accessibility: AccessKit via eframe (untested with screen readers), system-cursor option for magnifiers, reduced-motion support | **partial** | `README.md` Accessibility |

### 2.18 Localization

| Item | Status | Evidence |
|---|---|---|
| 16 interface languages (en + ar, cs, de, el, es, fr, hu, it, ko, pt-BR, ru, sv, tr, uk, zh), live switching, Auto from OS locale, `CADCRAFT_LOCALE`, plural rules, coverage tests | **full** for UI chrome | `crates/ui-egui/src/i18n/`; `docs/localization.md` (most catalogs AI-assisted, native proofreading pending) |
| Engine diagnostics, command-line output, CLI/MCP replies, command history | **English only** | `docs/gaps.md` L1 |
| Drawing text: TrueType/OpenType/TTC, CJK fallback, Arabic/Hebrew bidi + shaping; Devanagari/Indic shaping **none**; vertical text **none**; SHX **none** | **partial** | `docs/localization-parity.md` |
| IME on every platform | **partial** (upstream egui fixes queued, PRs #110–#119) | same |
| Japanese, Hindi, Indonesian, Vietnamese, Traditional Chinese | **none** | `ROADMAP.md` Languages (table is stale for the languages that do exist) |

### 2.19 Licence & cost

| Item | Value |
|---|---|
| Licence | MIT OR Apache-2.0 (`LICENSE-MIT`, `LICENSE-APACHE`, `NOTICE`); contributors' translations and assets under the same; `acadrust` MPL-2.0 unmodified; craft-ui/craft-docpath from `storytold/craft-libs` (git deps) |
| Cost | free; no account, no subscription, no telemetry mentioned; downloads from GitHub Releases |
| Trademark | ArtCraft name/logos in `docs/brand/` are not open; forks must remove them (`README.md`) |
| Clean-room | file formats from public DXF Reference / ODA DWG spec; no Autodesk assets, fonts, patterns, linetypes; GPL CAD sources never read (`CLAUDE.md`, `ATTRIBUTION.md`) |
| Fonts | none in repo; optional `craft-fonts` build input (`CRAFT_FONTS_DIR`) |

---

## 3. Genesis-relevant findings (referencing, data links, paths, copying, crash safety)

1. **Path containment is a library policy, not ad hoc.** `crates/engine/src/doc_path.rs`: every path *stored in a drawing* (xref paths, table data links) reaches the file system only through `resolve()`, which takes a relative path from the drawing's own folder and refuses network paths to any host other than the share the drawing is on (`craft_docpath::Refused::Network`), and refuses relative paths when the drawing has no file. Paths the user types in a command are used as given. A refused path is treated like a missing file with the reason in the xref's status. *Keep this; Genesis should extend it into a declared "project container" so every link is relative to the project root and portable.*
2. **Xref resolution order and bounds.** `cmd/blocks/xref/load.rs`: a path is tried as given, then by file name beside the host; nested attached xrefs load with their parent (overlays don't) to at most `MAX_BLOCK_DEPTH = 16`; circular references are detected and skipped; caps of 4,000,000 objects, 1,000 files, 512 MiB per file and 1 GiB total; *every failure leaves the xref block empty with a status and never stops the host drawing from opening*. Symbols arrive renamed `xref|name`; layer 0 and ByLayer/ByBlock/Continuous stay the host's. *Keep: graceful degradation and resource caps are what "zero crashes" means on real project folders.*
3. **Xref state that doesn't persist.** Unloaded state and per-xref layer overrides last only for the session; XCLIP doesn't exist; editing an xref in place isn't written back (`docs/gaps.md` F2). *Fix in Genesis: xref state must be part of the saved document and clip boundaries first-class.*
4. **Data links are thin and private.** DATALINK reads CSV/TSV only (8 MiB cap), no Excel, no write-back, not on the web; links, cell styles and table breaks travel only as CADCraft-private xdata and are lost through DWG (F11). Formulas aren't AutoCAD FIELDs, so other programs see values only. *Genesis lesson: anything stored as app-private xdata is invisible to every other tool; a data-link model should be an open, documented sidecar or a native format object, and both directions (read/write-back) should be designed in from the start.*
5. **Copying between drawings carries its dependencies and has an explicit collision policy.** `cmd/clipboard.rs`: the clipboard holds objects plus the layers, linetypes, text/dim/mleader/table styles and nested blocks they reference; pasting adds what the target lacks, a name the target already has keeps the target's definition, anonymous `*` blocks get fresh names, pasted objects get new handles; it can travel as DXF text on the system clipboard between CADCraft windows; 50,000-object cap on the system path. IMPORT does the same for a whole file's model space at a point and scale. *Keep the explicit, documented collision rule; Genesis should surface it to the user (what was renamed/kept) rather than silently choosing.*
6. **Handles are not stable across tools.** Other programs' table-record and object handles are renumbered on CADCraft's first save (FF7); entity handles are kept. *Genesis: stable, never-renumbered IDs are a prerequisite for "better referencing".*
7. **Lossy save is the #1 gap and was retrofitted.** The top row of `docs/gaps.md` is "Saving DWG drops what we don't model". DXF now round-trips unknown entities/objects, foreign xdata, extension dictionaries and reactors (#528) but the DWG path through `acadrust` still drops custom-class objects, xdata on table records/blocks, colour books and reactors, and nothing has ever been checked in AutoCAD. *Genesis: an "unknown data is sacred" document model (opaque pass-through of everything not understood) must be a day-one design, with a real-file corpus and an external-validator test (ezdxf audit was run by hand once).*
8. **COMPARE exists but is bounded and partial.** 200,000-object cap, active tab only, no report export (F22). *Keep the geometry-then-handle matching idea; Genesis needs per-layout, exportable diffs.*
9. **Crash-safety architecture worth copying wholesale:** Rust with `unsafe` forbidden and panicking calls denied by lint; `Result` everywhere; `catch_unwind` at every boundary where a panic could still escape (command execute, each interactive step, file open, third-party DWG bridge, LISP, render thread) with *restore-the-drawing* semantics; copy-on-write undo snapshots that make restore trivial; ~40 hostile-input tests and a property-based numeric suite; caps on every input-sized allocation; autosave with instance lock files so a crashed instance's `.sv$` is offered and a running one's isn't; AUDIT/RECOVER that never guess at content; crash-surviving rotated logs. Evidence: `engine/src/guard.rs`, `lib.rs:896`, `dwg/src/lib.rs`, `autosave.rs`, `audit.rs`.
10. **Where crash safety still leaks:** no CI runs the test suite on PRs (S1; the new `nix.yml` only evaluates the flake), stability self-rated 35%, web build has no autosave, autosave writes DXF not DWG, GPU-driver crashes are avoided by backend choice rather than handled, and the DWG path is a third-party crate whose panics are caught but whose data loss is not. *Genesis: make the PR test gate and a real-file corpus non-negotiable from commit one.*
11. **Geometry tolerance model is wrong for land development.** One absolute `EPS = 1e-9` plus absolute tessellation steps (1e-3/1e-4 world units) and a 2D `Vec2` kernel; large (UTM/state-plane 1e6–1e7) coordinates untested in commands (`docs/geometry-parity.md`). *Genesis: 3D points, a tolerance context relative to drawing extents, and known-answer tests at survey coordinates from the start.*
12. **Everything-is-a-command + JSON-never-opens-dialogs** (`cmd/mod.rs` `CommandSpec`, `CLAUDE.md`) gives scriptability, MCP control and testability for free, and a `cargo xtask layers` gate keeps the UI swappable. *Keep.*
13. **Honest, measured parity docs** (`docs/target-app-parity.md`, `gaps.md`, with weights, discounts and revision histories) are themselves a practice worth keeping, though they drift (see below).

---

## 4. Unique strengths (vs AutoCAD/BricsCAD class apps)

- Pure Rust, `unsafe` forbidden, panic-denying lints, panic guards with drawing restore, hostile-input and property tests: a credible "never crash" engineering story even at pre-alpha.
- Agent-first automation: MCP server (headless or bridged), JSON control channel with UI introspection (`ui.elements`, `ui.screenshot`), CLI batch runs; AutoCAD has none of these natively.
- Runs on macOS, Windows (x64/arm64/x86), Linux (x86_64/aarch64/riscv64), FreeBSD and the browser; signed installers for all desktop platforms.
- Free (MIT/Apache-2.0), no account; clean-room with an enforced asset-attribution gate.
- Own parametric solver with DOF reporting and constraint inference; DXF round trip of foreign data; vector PDF with real text, layers and hyperlinks; SVG import/export; 16 interface languages with live switching.
- Swappable UI (layering enforced by `cargo xtask layers`); copy-on-write document with cheap undo; R-tree picking at 200k entities.
- Extreme development velocity (0 → 194k lines and ~1,700 PRs in two weeks, largely agent-written) with written, weighted self-assessment.

## 5. Notable weaknesses

- Pre-alpha: 4 of 5 daily workflows fail the repo's own alpha gate; ready-for-real-work ≈ 38%, 2D drafter ≈ 28%.
- DWG save is lossy through `acadrust`, never verified in AutoCAD, no real-file corpus; 10 MB DWG took ~2 min to fail; DWG goes through an in-memory DXF (1.2 GB for an 83 MB file).
- No 3D at all (2D `Vec2` kernel, no UCS); no civil/land features of any kind.
- No PDF/raster/DWF/DGN underlays or image display (ATTACH is a stub); no SHX fonts (text metrics differ); binary CTB/STB/PC3 unreadable; no physical printers.
- Dynamic-block authoring, XCLIP, sheet sets, eTransmit, fields, SPELL, Visual LISP/DCL, plug-in API, CUI: none.
- Stability self-rated 35%; no CI test gate on PRs; 404 open PRs (page fetch, unverified); Windows/Linux lightly tested; web build can't do DWG or autosave.
- Geometry on ellipses/splines is tessellated; absolute tolerances; polyline offsets don't recompute bulges.
- Docs drift: `ROADMAP.md` Languages table says Spanish/French/Chinese/Korean are "none" while catalogs exist; `docs/architecture.md` says 57k lines vs 194k now; menu breadth 245 (ROADMAP) vs 283 (checklist); `docs/ui-parity.md` 48% vs ROADMAP 43%; `docs/hardware-parity.md` says no 3D mouse while `spacemouse.rs` exists.

## 6. Doc inconsistencies found (so the comparison doesn't repeat them)

| Topic | Doc A | Doc B |
|---|---|---|
| Lines of Rust | `docs/architecture.md`: ~57,000 (2026-10-10) | measured 193,684 (2026-10-21) |
| Registered commands | `docs/architecture.md`: 295 | `command-ids.txt`: 413; `docs/parity-checklist.md`: 427 |
| Menu breadth | `ROADMAP.md`: 245/491 (50%) | `docs/parity-checklist.md` 2026-10-16: 283/491 (58%) |
| UI/UX fidelity | `ROADMAP.md`: 43% | `docs/ui-parity.md`: 48% |
| Languages | `ROADMAP.md` table: most "none", "ships English plus partial Ukrainian and German" | 15 catalogs in `crates/ui-egui/src/i18n/`, 16 languages in `docs/localization.md` |
| 3D mouse | `docs/hardware-parity.md`: none | `crates/ui-egui/src/spacemouse.rs` + `ui.spacemouse*` commands |
| Named views / VPORTS | `docs/ui-parity.md` Navigation: "no" | `docs/gaps.md` U11: landed in #463 |
| SCRIPT `.scr` | `docs/ui-parity.md` / `docs/file-format-parity.md`: no SCRIPT command | `docs/gaps.md` rev 2026-10-12: SCRIPT landed (#693) |
| Options dialog | `docs/ui-parity.md` Chrome: "no (issue #23)" | `docs/gaps.md` F20: done (#23) |

## 7. Sources

- Repository files cited inline: `README.md`, `ROADMAP.md`, `CLAUDE.md`, `AGENTS.md`, `ATTRIBUTION.md`, `Cargo.toml`, `docs/target-app-parity.md`, `docs/gaps.md`, `docs/roadmap.md`, `docs/file-format-parity.md`, `docs/ui-parity.md`, `docs/geometry-parity.md`, `docs/architecture.md`, `docs/mcp.md`, `docs/customization.md`, `docs/autolisp.md`, `docs/localization.md`, `docs/localization-parity.md`, `docs/hardware-parity.md`, `docs/plot-styles.md`, `docs/plotters.md`, `docs/control-protocol.md`, `docs/parity-checklist.md`, `crates/engine/src/cmd/mod.rs` and the files under `crates/engine/src/cmd/`, `crates/engine/src/{guard,autosave,audit,doc_path,lib}.rs`, `crates/dwg/src/lib.rs`, `.github/workflows/*.yml`, `packaging/`.
- Upstream: https://github.com/storytold/cadcraft (page fetched 2026-10-21; star/fork/issue/PR counts unverified by API), https://github.com/storytold/cadcraft/releases/latest (v0.10.0, 30 assets).
- No GPL/LGPL CAD project source was read.
