# CADCraft: measured facts and feature status

Source: research worker notes `cadcraft-inventory.md` and the JSON summary, 2026-10-21. Status: full = shipping/mature, partial = with named limits, none = absent, unknown = unverified.

## Summary

CADCraft v0.10.0 (released 2026-10-19/21) is a pre-alpha, pure-Rust, MIT/Apache-2.0 2D CAD app targeting AutoCAD 2027 parity. Measured on 2026-10-21 from the clone at /home/user/cadcraft_1 without building: 193,684 lines of Rust in 618 files across 12 library crates + 3 apps + xtask; 413 registered engine command ids (240 with interactive prompt machines) plus 56 UI-only commands; 2,184 #[test] attributes; 16 interface languages. The repo's own weighted self-assessment: menu breadth 245/491 = 50% (ROADMAP, 2026-10-10; the regenerated checklist of 2026-10-16 says 283/491 = 58%), ready for real work ≈ 38%, mainstream 2D drafter ≈ 28%, essentials user ≈ 46%; DXF ≈ 50% read / 30% write, DWG ≈ 30% read / 15% write; 3D 2%; stability 35%. Strong: 2D draw/modify/dimension/layer/hatch/block basics, parametric constraints, DXF foreign-data round trip, vector PDF with real text and layers, cross-platform signed builds incl. Linux/FreeBSD/web, agent-first automation (MCP, JSON control channel, CLI), AutoLISP core, and a credible never-crash architecture (unsafe forbidden, panic lints, catch_unwind guards that restore the drawing, 100 hostile-named test functions (39 in the engine crate; recounted 2026-10-21), caps everywhere, autosave with recovery, AUDIT/RECOVER). Weak: 4 of 5 daily workflows fail its own alpha gate; DWG save is lossy via the acadrust bridge and never systematically verified by the project and there is no real-file corpus in the repository; community reports exist: issue #604 (an AutoCAD 2027 round trip gained 6 AUDIT errors and came back as AC1018) and the #1041 corpus test (BricsCAD V26 refused 14 of 23 CADCraft-saved DWGs) (reconciled after the fact-check and critique, 2026-10-21); no 3D, no civil/land features whatsoever (zero hits for TIN/contour/alignment/COGO/GIS/geolocation/survey in the code); no PDF/raster underlays, SHX fonts, binary CTB/PC3, printers, sheet sets, eTransmit, fields, dynamic-block authoring, XCLIP, plug-in API; no CI test gate on PRs; absolute geometry tolerances and a 2D kernel untested at survey-scale coordinates; several parity docs contradict each other.

## Measured numbers

| Metric | Value | Evidence |
|---|---|---|
| Version | 0.10.0 | Cargo.toml [workspace.package]; commit e86eacf 'Release 0.10.0' 2026-10-19; GitHub release v0.10.0 (30 assets) page shows 21 Oct |
| Stage | pre-alpha (4 of 5 core workflows fail the alpha gate) | ROADMAP.md banner; docs/roadmap.md#alpha-gate |
| Lines of Rust | 193,684 lines in 618 .rs files (tests included; ~11,838 in *test*.rs files) | find crates apps xtask -name '*.rs' \| xargs cat \| wc -l on 2026-10-21; docs/architecture.md's '57,000' (2026-10-10) is stale |
| Lines per crate | engine 97,341; ui-egui 29,979; io 23,106; doc 10,689; render 9,514; geom 5,031; fonts 4,754; constraints 4,283; dxf 1,171; mcp 1,075; dwg 791; color 276; apps 4,577; xtask 1,097 | same count per directory |
| Crates | 12 library crates + 3 apps (cadcraft, cadcraft-cli, cadcraft-web) + xtask; layering L0 geom/dxf → L5 ui-egui/mcp enforced by cargo xtask layers | ls crates apps; docs/architecture.md |
| Engine command specs | 413 registered ids; 415 CommandSpec::new call sites; 240 interactive prompt machines; 32 transparent; 56 UI-only commands | scratchpad/command-ids.txt; grep of crates/engine/src/cmd; crates/ui-egui/src/menus.rs UI_COMMANDS. docs/parity-checklist.md (2026-10-16) says 427 registered |
| Menu-breadth parity | 245/491 = 50% (ROADMAP headline, 2026-10-10); 283/491 = 58% in docs/parity-checklist.md generated 2026-10-16 (Dimension 28/28, Format 93%, Modify 46%, View 41%, Window 14%, Help 0%); 2D menus only ≈ 65% | ROADMAP.md Headline numbers; docs/parity-checklist.md |
| Ready for real work | ≈ 38% (weighted 37.7%); mainstream 2D drafter ≈ 28%; essentials user ≈ 46%; feature depth ≈ 41% | docs/target-app-parity.md By dimension / audiences |
| Dimension parity | UI/UX 43% (ROADMAP) or 48% (docs/ui-parity.md); file formats 30%; stability 35%; performance 60%; platforms 75%; localization 5% (stale); ecosystem 10%; AI 20%; hardware 45%; 3D 2% | ROADMAP.md By dimension; docs/ui-parity.md |
| Feature-area parity | Draw 60, Modify 50, Geometry precision 40, Layers 70, Dimensions 45, Text 35, Leaders/tables/fields 25, Hatch 35, Blocks/xrefs 25, Layouts/plot 35, Inquiry 30, Constraints 50, 3D 2, Collaboration 5 (%) | ROADMAP.md Features |
| File fidelity | DXF ≈ 50% read / 30% write; DWG ≈ 30% read / 15% write; 36 header vars written vs ~280 | docs/file-format-parity.md |
| Remaining effort (self-estimate) | alpha 125–190 h; beta 600–930 h; full parity 1,300–2,100 'Opus 5.5 agent-hours' | ROADMAP.md |
| Tests | 2,184 #[test] attributes; 100 hostile-named never-panic test functions (recounted 2026-10-21); 36 io round-trip tests, all synthetic | grep; docs/file-format-parity.md#tests |
| catch_unwind guard sites | 19 in non-test code; 15 crate roots deny unwrap/expect/panic; unsafe_code = forbid | grep; crates/engine/src/guard.rs, lib.rs:896; crates/dwg/src/lib.rs; Cargo.toml |
| Interface languages | 16 (English + ar, cs, de, el, es, fr, hu, it, ko, pt-BR, ru, sv, tr, uk, zh; 1,010–1,360 catalog rows each) | crates/ui-egui/src/i18n/*.tsv; docs/localization.md |
| Libraries | 23 hatch patterns (AutoCAD ~85); 19 linetypes (~45); 43/~80 DIMSTYLE vars; ~125–150 of ~1,000 sysvars; 144 aliases | docs/gaps.md F13, U10; docs/roadmap.md; docs/ui-parity.md |
| Performance (internal, unbenchmarked vs AutoCAD) | 200k entities: pick 0.001 ms, 4 ms re-index, ~4 ms frame; zoom stall 2–4.5 s → 26–64 ms on 340k-primitive DWG; edits 1.8 s; 10 MB DWG failed after ~2 min (#57); 83 MB DGN-bloated DWG now opens (#1482) | docs/hardware-parity.md; docs/file-format-parity.md rev 2026-10-17 |
| GitHub (unverified page fetch 2026-10-21) | 6.3k stars, 2.8k forks, 57 watching, 392 open issues, 404 open PRs; docs' own 2026-10-10 count: 97 issues, 127 PRs from 19 outside authors, 0 'switched from AutoCAD' reports | WebFetch https://github.com/storytold/cadcraft (API blocked in session); docs/target-app-parity.md User evidence |
| Velocity | first version (51k lines, 290 commands) in ≈ 11.5 agent-hours on 2026-10-07; PR numbers reached #1727 by 2026-10-21 | ROADMAP.md progress log; git log |
| Licence / cost | MIT OR Apache-2.0, free, no account; acadrust MPL-2.0; ArtCraft brand trademarked | Cargo.toml; README.md License |
| Platforms | Windows x64/arm64/x86 MSI+portable (signed); macOS universal DMG (notarized); Linux x86_64/aarch64 AppImage/Flatpak/deb/rpm/tar + riscv64 tar; FreeBSD x86_64; web WASM | README.md Downloads; packaging/; v0.10.0 release notes (FreeBSD aarch64 dropped) |

## Drawing & modify

| Feature | Status | Notes | Source |
|---|---|---|---|
| 2D draw commands (LINE, PLINE, CIRCLE 6/6, ARC 11/11, RECTANG, POLYGON, ELLIPSE, SPLINE, XLINE/RAY, DONUT, REVCLOUD, WIPEOUT, BOUNDARY, centerlines, isometric) | full | all methods and options per the repo audit | cmd/draw.rs, cmd/draw2.rs; docs/target-app-parity.md Draw row |
| MLINE, REGION booleans, HELIX | partial | objects exist; MLEDIT tees square, booleans only on non-touching regions, regions saved as polylines | docs/gaps.md F21 |
| Modify set (MOVE/COPY/ROTATE/SCALE/MIRROR/STRETCH/OFFSET/TRIM/EXTEND/FILLET/CHAMFER/BREAK/JOIN/LENGTHEN/BLEND/ALIGN/PEDIT/SPLINEDIT/OVERKILL/MATCHPROP/DRAWORDER + Express-tool equivalents) | partial | full and exact for lines/arcs/circles/polylines; ellipse/spline cases tessellated; OFFSET of ellipse yields a polyline; BREAK not on ellipse/spline | docs/geometry-parity.md Offsets/Trim tables; docs/gaps.md F1 |
| Arrays (rect/polar/path, associative, ARRAYEDIT) | partial | no array grips, path arrays not associative | docs/gaps.md F5 |
| Grips | partial | hot-grip options and multi-grip landed; no hover multifunctional menus or grip dimensional input | docs/ui-parity.md Grips ≈ 40% |
| Undo/redo | partial | copy-on-write snapshots capped at 2,000; count only, no Mark/Back groups | docs/ui-parity.md command line table; engine/src/undoctl.rs |

## Precision input

| Feature | Status | Notes | Source |
|---|---|---|---|
| Coordinate syntax, direct distance, angle/unit formats incl. surveyor bearings | full | x,y @dx,dy @d<a # * ; N45dE; 5'6-1/2" | engine/src/prompt.rs, units.rs; docs/ui-parity.md Point entry |
| FROM, M2P, point filters, angle override, typed osnap overrides | full | TK and 'CAL typed calculator are none | engine/src/pointmod.rs; docs/ui-parity.md |
| Running object snaps (14 modes) | partial | MID none on circles/ellipses/splines; TAN not on ellipse/spline; GCE closed LWPOLYLINE only | docs/ui-parity.md Object snaps ≈ 45% |
| Object snap tracking, polar, ortho, grid/snap (rect + isometric) | full | PolarSnap and polar-relative-to-last-segment none | engine/src/snap/tracking.rs (#379); docs/ui-parity.md ≈ 70% |
| Dynamic input | partial | pointer boxes with Tab/locks; no grip dimensional input, DYNPROMPT menu, DYNDIM | ui-egui/src/dyninput.rs (#60); docs/ui-parity.md ≈ 45% |
| Selection (W/C/F/WP/CP/BOX/…, press-drag, cycling, QSELECT, SELECTSIMILAR, isolate) | partial | no lasso, CLass, FILTER dialog; isolation not saved | docs/gaps.md U6 |
| Options and Drafting Settings dialogs, context menus | partial | OPTIONS dialog with profiles done; right-click customization and some layout-tab menus missing | docs/gaps.md F20, U7 |

## Layers & properties

| Feature | Status | Notes | Source |
|---|---|---|---|
| Layer Properties Manager, filters, layer states, VP overrides, layer tools (LAYISO/LAYFRZ/LAYMRG/VPLAYER…) | full | self-rated 70% | ui-egui/src/layers.rs; cmd/layer.rs; ROADMAP Layers 70% |
| Properties palette, Quick Properties, QSELECT | full | block insertion X/Y/Z read-only | docs/ui-parity.md Chrome (#182) |
| Linetypes, lineweights, true colour, transparency, user .lin/.pat | partial | 19 of ~45 linetypes; SHX shape elements skipped; linetype manager thin | docs/gaps.md FF9; docs/target-app-parity.md Layers row |
| RENAME, PURGE | partial | -RENAME of materials/plot styles stubbed; PURGE skips mlstyles | docs/gaps.md F1, F21 |

## Annotation

| Feature | Status | Notes | Source |
|---|---|---|---|
| Dimensions (all DIM* types, associativity, QDIM, DIMBREAK/SPACE/JOG/INSPECT/EDIT, 43/~80 style vars) | partial | core is full (Dimension menu 28/28); no DIMSTYLE Manager dialog, no smart DIM, some vars unmodelled | docs/parity-checklist.md; docs/gaps.md F7 |
| TEXT/MTEXT (TrueType/OTF/TTC, formatting codes, in-canvas editor, bidi/Arabic shaping, CJK fallback) | partial | existing MTEXT not editable (no DDEDIT), editor layout while typing incomplete, no SHX | docs/gaps.md F9; README Fonts |
| Fields (FIELD/UPDATEFIELD), SPELL | none | SPELL open PR #551 | docs/gaps.md F9 |
| MLEADER family (style, edit, align, collect, native MULTILEADER DXF) | partial | one landing per multileader; thin style | docs/gaps.md F10, FF2 |
| Tables (styles, formulas, TABLEDIT, breaks, export, CSV data links) | partial | formulas not FIELDs; links/styles only as CADCraft xdata, lost via DWG; CSV only | docs/gaps.md F11; cmd/table/breaks.rs |
| TOLERANCE frames, annotative scaling | partial | no dialog; ANNORESET no-op | docs/gaps.md F8, F12 |

## Hatch

| Feature | Status | Notes | Source |
|---|---|---|---|
| HATCH/GRADIENT with pick points, islands, dialogs, HATCHEDIT boundary add/remove, associativity, user .pat | partial | 23 own patterns of ~85; gradients render flat; no Preview/Inherit; boundaries tessellated; caps 60k segments/4,096 islands | docs/gaps.md F13; geom/src/region.rs; docs/geometry-parity.md Hatch ≈ 45% |
| SUPERHATCH, MPolygon | none |  | docs/gaps.md E3, F13 |

## Blocks, attributes, dynamic blocks, xrefs, groups

| Feature | Status | Notes | Source |
|---|---|---|---|
| BLOCK/INSERT/WBLOCK/BASE, Blocks palette, Block Editor for static blocks, REFEDIT | full | REFEDIT works for blocks; not for xrefs | cmd/blocks.rs, blocks/bedit.rs, blocks/refedit.rs (#813) |
| Attributes (ATTDEF/ATTEDIT/ATTSYNC/BATTMAN/DATAEXTRACTION) | partial | no verify/preset/lock modes; extraction has no wizard or nested blocks | docs/gaps.md F17 |
| Dynamic blocks | partial | read, grips and visibility states editable and saved as AutoCAD saves them; no authoring of parameters/actions | docs/gaps.md F3; docs/file-format-parity.md dynamic block row |
| Xrefs (XATTACH, -XREF bind/detach/path/unload/reload/overlay, XBIND, XOPEN, palette, nested, relative paths) | partial | XCLIP none; unload state and layer overrides session-only; in-place xref edits not written back | cmd/blocks/xref.rs, xref/load.rs; docs/gaps.md F2 |
| Groups | partial | no group grip/bbox, no dialog | docs/gaps.md F16 |
| DesignCenter, tool palettes, Smart Blocks | none |  | docs/target-app-parity.md Blocks row |

## Layouts, viewports, plotting

| Feature | Status | Notes | Source |
|---|---|---|---|
| Layouts, viewports (polygonal/object/clipped, lock, VP layers), VPORTS, named views | partial | MVIEW Restore stubbed | docs/gaps.md F15, U11 (#453, #463) |
| PAGESETUP, PLOT dialog, PREVIEW, PUBLISH, EXPORTPDF, PDFBOOK | partial | model-space PDF keeps default margins; no system printers | docs/gaps.md F14 (#160, #186) |
| Plot styles CTB/STB and plotter devices (own JSON formats) | partial | binary .ctb/.stb/.pc3 not readable (no public spec) | docs/plot-styles.md; docs/plotters.md |
| PDF output (vector, embedded TrueType text, OCG layers, multi-sheet, hyperlinks, transparency) | full |  | crates/io/src/pdf/ (#567, #571) |

## Files & exchange

| Feature | Status | Notes | Source |
|---|---|---|---|
| DXF read R12–2018 ASCII/binary with code pages; write 2000–2018 ASCII/binary with foreign-data round trip | partial | no R12/R14 write, no R12 binary read; handles of other programs renumbered on first save | docs/file-format-parity.md DXF tables; FF7 |
| DWG 2000–2018 read/write via acadrust bridge | partial | drops custom-class objects, some xdata, colour books, reactors; never systematically verified in AutoCAD by the project (community issue #604 reports one round trip with 6 AUDIT errors); no real-file corpus; 10 MB file failed; not on web | docs/gaps.md top-10 rows 1–2, FF6; crates/dwg/src/lib.rs |
| DWT templates, IMPORT/EXPORT (dxf/dwg/svg/png/pdf), SVG/SVGZ import, PNG/SVG export | full | SVG import lacks CSS/use/fills/text/images | cmd/exchange.rs EXPORT_FORMATS; docs/gaps.md FF14 |
| PDF import/underlay, raster image attach/display, DWF, DGN, WMF/EPS/STL/STEP, DWS standards, eTransmit | none | ATTACH is a stub; IMAGE entity round-trips but is never shown | cmd/exchange.rs:57; docs/file-format-parity.md Other formats |
| SHX fonts | none | stroke font or FONTALT stands in; metrics differ | docs/gaps.md FF8 |

## Parametric constraints

| Feature | Status | Notes | Source |
|---|---|---|---|
| 12 geometric + dimensional constraints, parameters/expressions, AUTOCONSTRAIN, CONSTRAINTINFER, DOF report, over-constraint detection, DXF persistence | full | own Gauss–Newton/LM solver; ellipse/spline/block support partial; self-rated 50% | crates/constraints/src/lm.rs; docs/geometry-parity.md Constraint solver (#546) |

## 3D

| Feature | Status | Notes | Source |
|---|---|---|---|
| UCS, 3D views/orbit, solids, surfaces, meshes, sections, visual styles, materials, rendering (150 menu items) | none | 3DORBIT registered as a stub: 'CADCraft draws in 2D (plan view) only' | cmd/exchange.rs:67; docs/gaps.md F24 |
| 3DPOLY, HELIX, Z on entity points | partial | stored and drawn in plan only; 2D Vec2 kernel | docs/geometry-parity.md Curves; docs/architecture.md Data model |

## Inquiry & utilities

| Feature | Status | Notes | Source |
|---|---|---|---|
| DIST/AREA/ID/LIST/MEASUREGEOM/CAL/QuickCalc/FIND/COUNT/TIME/STATUS/UNITS/SETVAR | full | AREA on bulge polylines tessellated | cmd/inquiry.rs, cmd/utility/calc.rs; docs/geometry-parity.md Measurement |
| MASSPROP | partial | regions only, tessellated | docs/gaps.md F22 |
| COMPARE drawing compare | partial | 200k-object cap, active tab only, no report export | cmd/file/compare.rs; docs/gaps.md F22 |
| AUDIT/RECOVER/DRAWINGRECOVERY, OPTIONS | full |  | engine/src/audit.rs (#406); docs/gaps.md F20 |
| SPELL, ETRANSMIT | none |  | docs/target-app-parity.md Inquiry row |

## Automation & APIs

| Feature | Status | Notes | Source |
|---|---|---|---|
| Command line (keywords, AutoComplete, aliases, transparent commands), SCRIPT .scr, .pgp aliases | full | no sysvar AutoComplete | docs/ui-parity.md Command line; docs/customization.md |
| AutoLISP core (APPLOAD, command, entget/entmake, ssget, get*, startup files, corpus test) | partial | no Visual LISP ActiveX, DCL, reactors, .fas/.vlx | docs/autolisp.md; docs/gaps.md E1 (#758) |
| MCP server (headless or bridged; command_line, execute, query_entities, render, find_text, screenshot, ui_click) | full | ahead of AutoCAD | docs/mcp.md; crates/mcp |
| JSON control channel (cmdline.*, engine.execute, ui.* introspection/input, bounded and timeout-safe) and cadcraft-cli (info/convert/run/commands/perf/mcp) | full |  | docs/control-protocol.md; apps/cadcraft-cli/src/main.rs |
| Plug-in API, CUI, workspaces, tool palettes, action recorder, in-app AI | none | Rust→WASM plug-ins planned (owner decision) | docs/gaps.md E4, E5, U12, A1–A3 |

## Collaboration

| Feature | Status | Notes | Source |
|---|---|---|---|
| Sheet Set Manager, eTransmit, Share, Traces, Markup Import, Activity Insights, DWS standards | none | SHARE is a stub | cmd/exchange.rs:62; docs/gaps.md F23 |
| Clipboard between drawings with dependencies (layers/styles/blocks), system-clipboard DXF text, IMPORT of another file | full | 50k-object cap; target keeps its own definitions on name clash | cmd/clipboard.rs; cmd/exchange.rs run_import |
| COMPARE, PUBLISH, PDFBOOK | partial | see Inquiry/Plotting | docs/gaps.md F22, F14 |

## Civil / land-development capabilities

| Feature | Status | Notes | Source |
|---|---|---|---|
| COGO points, surfaces/TIN, contours, alignments, profiles, grading, parcels, corridors, pipe networks | none | zero source hits for TIN/contour/alignment(civil)/COGO/parcel/grading/station; only plain POINT/DIVIDE/MEASURE | word-boundary grep of crates/engine/src/cmd, crates/doc/src, crates/io/src on 2026-10-21 |
| Coordinate systems, geolocation, GIS import (SHP/GeoJSON/KML), LandXML, survey/field-book import, point clouds | none | no GEOGRAPHICLOCATION, EPSG, northing/easting anywhere | same grep; docs/file-format-parity.md Other formats |
| Survey angle/unit formats | partial | N45dE bearings and engineering/architectural units parse and display | engine/src/units.rs; docs/ui-parity.md Point entry |
| Large (UTM/state-plane) coordinates | partial | absolute tolerance EPS 1e-9 and absolute tessellation steps; 'untested' in commands though closed-form property tests hold at 1e6–1e7 | docs/geometry-parity.md Numbers and tolerances |

## Stability & crash safety

| Feature | Status | Notes | Source |
|---|---|---|---|
| Never-crash policy: unsafe forbidden, unwrap/expect/panic denied by lint, Result everywhere | full | 15 crate roots carry the deny attributes | CLAUDE.md; Cargo.toml lints; grep |
| catch_unwind guards with drawing restore at execute, every interactive step, file open, DWG bridge, LISP, render thread | full | 19 sites | engine/src/guard.rs; lib.rs:896-910; dwg/src/lib.rs; lisp/mod.rs; ui-egui canvas/rebuild.rs |
| Hostile-input tests and input caps | full | 100 hostile-named test functions; property suite with NaN/inf/1e300; caps on DXF tags, hatch, blocks (depth 16), xrefs, clipboard, compare, links, control channel | grep; geom/src/property_tests.rs; constants cited in notes |
| Autosave (SAVETIME .sv$ + instance lock) and Drawing Recovery | partial | none on web; DXF not DWG | engine/src/autosave.rs; docs/gaps.md F4 |
| AUDIT/RECOVER with .adt log | full | repairs never guess content | engine/src/audit.rs |
| CI test gate on pull requests | none | workflows are release/packaging-lint/freebsd/windows-arm64 and a Nix flake evaluation only | .github/workflows/nix.yml; docs/gaps.md S1 |
| Field stability record | partial | self-rated 35%; GPU driver crash avoided by DX12-only default; 27/37 open issues core-path (2026-10-10) | README Downloads; docs/target-app-parity.md discounts |

## Performance

| Feature | Status | Notes | Source |
|---|---|---|---|
| GPU canvas (wgpu), CPU fallback, display lists, R-tree picking, background zoom/pan rebuild | full | 200k entities fluent in internal numbers | docs/architecture.md Rendering; docs/hardware-parity.md |
| Large drawings and DWG throughput | partial | 1M entities untested; edits rebuild 1.8 s on 12k-entity hatched DWG; 10 MB DWG failed; DWG goes through in-memory DXF | docs/hardware-parity.md; docs/gaps.md FF6 |

## Platforms & packaging

| Feature | Status | Notes | Source |
|---|---|---|---|
| Signed Windows MSI/portable (x64/arm64/x86), notarized macOS universal, Linux AppImage/Flatpak/deb/rpm/tar (x86_64/aarch64/riscv64), FreeBSD x86_64, web WASM | full | FreeBSD aarch64 dropped in 0.10.0; Windows/Linux lightly tested (main platform macOS) | README Downloads; packaging/; docs/gaps.md P2 |
| Web build | partial | no DWG, no autosave, plot shows raw PDF bytes | docs/gaps.md P1, F4 |
| Hardware: 3D mouse, pen tablet, printers, multi-monitor | partial | spacemouse.rs exists for 2D pan/zoom though hardware doc says none; tablets/printers none | ui-egui/src/spacemouse.rs; docs/hardware-parity.md |

## Localization

| Feature | Status | Notes | Source |
|---|---|---|---|
| 16 UI languages with live switching, plural rules, coverage tests | full | mostly AI-assisted translations awaiting native proofreading; ROADMAP table stale | crates/ui-egui/src/i18n/; docs/localization.md |
| Engine diagnostics, CLI/MCP replies, command history | none | English only | docs/gaps.md L1 |
| Drawing text: bidi/Arabic shaping, CJK fallback | partial | no Indic shaping, no vertical text, no SHX | docs/localization-parity.md |

## Licence & cost

| Feature | Status | Notes | Source |
|---|---|---|---|
| MIT OR Apache-2.0, free, no account, clean-room, enforced asset attribution | full | acadrust MPL-2.0; ArtCraft brand trademarked | Cargo.toml; README License; ATTRIBUTION.md |

## Findings relevant to Genesis

- **Path containment**: Paths stored in a drawing (xrefs, data links) reach the file system only through one resolver: relative to the drawing's folder, refusing network hosts other than the drawing's own share, refusing relative paths when the drawing is unsaved; a refused path behaves like a missing file with the reason in the xref status. Keep and extend into a declared project container. (evidence: crates/engine/src/doc_path.rs; craft-docpath dependency in Cargo.toml)
- **Xref loading**: Resolution order (as given, then by file name beside the host), nested attach-only loading to depth 16, circular-reference guard, caps of 4M objects / 1,000 files / 512 MiB per file / 1 GiB total, symbols renamed xref|name, and the rule that an xref failure never stops the host from opening. Keep. (evidence: crates/engine/src/cmd/blocks/xref/load.rs header and constants)
- **Xref state persistence**: The Unloaded state lasts only for the session (host overrides on xref layers do persist, test #886); XCLIP doesn't exist; in-place xref edits aren't written back. Genesis must save xref state and clip boundaries in the document. (evidence: docs/gaps.md F2)
- **Data links**: DATALINK reads CSV/TSV only (8 MiB cap), no Excel, no write-back, not on web; links, cell styles and breaks travel as app-private xdata and vanish through DWG; formulas aren't FIELDs so other tools see values. Genesis needs an open, bidirectional link model stored in a documented sidecar or native object, never private xdata. (evidence: crates/engine/src/cmd/table/breaks.rs; docs/gaps.md F11)
- **Copying between drawings**: Clipboard carries referenced layers, linetypes, styles and nested blocks; target keeps its own definition on a name clash, anonymous blocks are renamed, pasted objects get new handles; DXF text on the system clipboard enables cross-window paste; 50k-object cap. IMPORT merges a whole file's model space. Keep the explicit collision rule but surface it to the user. (evidence: crates/engine/src/cmd/clipboard.rs; cmd/exchange.rs run_import)
- **Stable identifiers**: Other programs' table-record and object handles are renumbered on CADCraft's first save; only entity handles survive. 'Better referencing' requires IDs that are never renumbered. (evidence: docs/gaps.md FF7; docs/file-format-parity.md Handles row)
- **Lossless save as a day-one design**: The top-ranked gap is 'saving DWG drops what we don't model'; DXF pass-through of unknown data was retrofitted (#528) but the DWG bridge still drops custom-class objects, xdata on tables/blocks, colour books and reactors, and output was never checked in AutoCAD. Genesis should treat unknown data as opaque pass-through from the first commit and run an external validator plus a real-file corpus in CI. (evidence: docs/gaps.md top-10 rows 1–2; docs/file-format-parity.md Tests)
- **Drawing compare**: COMPARE matches by geometry/properties then handle, with a 200k-object cap, active layout only, no exportable report. Keep the matching idea; add per-layout, exportable diffs. (evidence: crates/engine/src/cmd/file/compare.rs; docs/gaps.md F22)
- **Crash-safety architecture to copy**: unsafe forbidden + panic lints; catch_unwind at command execute (restores drawing and selection), every interactive step (factory/begin/input/prompt/preview/drag), file open, the third-party DWG bridge, LISP and the render thread; copy-on-write undo makes restore trivial; hostile-input tests; input caps everywhere; autosave .sv$ with heartbeat lock files so only a crashed instance's files are offered; AUDIT/RECOVER that never guess. (evidence: crates/engine/src/guard.rs; lib.rs:896-910; crates/dwg/src/lib.rs:75-515; autosave.rs; audit.rs)
- **Crash-safety leaks to avoid**: No CI runs the tests on PRs (new nix.yml only evaluates the flake); stability self-rated 35%; web build has no autosave; autosave writes DXF not DWG; GPU-driver crashes are dodged by backend choice (DX12 only) rather than handled; DWG panics are caught but DWG data loss is not. (evidence: .github/workflows/nix.yml; docs/gaps.md S1, F4; README Downloads)
- **Tolerance model and 3D for land development**: One absolute EPS = 1e-9, absolute tessellation steps (1e-3/1e-4 world units) and a 2D Vec2 kernel that discards Z; large UTM/state-plane coordinates are untested in commands. Genesis needs 3D points, a tolerance context relative to extents, and known-answer tests at 1e6–1e7 coordinates from the start. (evidence: docs/geometry-parity.md Numbers and tolerances; docs/architecture.md Data model)
- **Everything is a command**: Every user action is a CommandSpec with a JSON form that never opens dialogs; menus, toolbar, scripts, CLI, control channel and MCP hit the same registry; layering is enforced by cargo xtask layers so the UI is swappable. This gives automation, testability and agent control for free. Keep. (evidence: crates/engine/src/cmd/mod.rs; CLAUDE.md Non-negotiables; docs/control-protocol.md)
- **File bloat handling**: An 83 MB DWG with 888,483 orphaned DGN line-style components (a common site-plan artefact) only opens because such components are dropped before the DXF bridge; DWG passes through a 1.2 GB DXF in memory. Genesis needs a native, streaming DWG/DXF path rather than a text bridge. (evidence: docs/file-format-parity.md rev 2026-10-17 (#1482))

## Unique strengths

- Credible never-crash engineering: pure Rust with unsafe forbidden, panic-denying lints on 15 crate roots, 21 catch_unwind call sites (Session::execute and the LISP runner restore the drawing, the rest turn an escaped panic into an error; recounted 2026-10-21), 100 hostile-named test functions (39 in the engine crate; recounted 2026-10-21) plus a property-based numeric suite, caps on every input-sized structure, autosave with instance lock files, AUDIT/RECOVER that never guess content, crash-surviving rotated logs.
- Agent-first automation no commercial CAD ships natively: MCP server (headless or bridged to the app), JSON control channel with UI introspection and screenshots, cadcraft-cli batch runs, and an 'everything is a command' registry whose JSON form never opens dialogs.
- Broadest platform reach of the three apps compared: signed Windows x64/arm64/x86, notarized macOS universal, Linux (AppImage/Flatpak/deb/rpm, aarch64, riscv64), FreeBSD, and a browser build.
- Free and open (MIT OR Apache-2.0), clean-room, no account; DXF foreign-data round trip (#528), vector PDF with real text/layers/hyperlinks, SVG import/export, own parametric solver with DOF reporting, 16 interface languages.
- Swappable UI enforced by a layering gate; copy-on-write document with cheap undo; R-tree picking at 200k entities; extreme development velocity with honest, weighted self-assessment docs.

## Notable weaknesses

- Pre-alpha: 4 of 5 daily AutoCAD workflows fail the repo's own alpha gate; ready-for-real-work ≈ 38%, mainstream 2D drafter ≈ 28%.
- DWG save is lossy through the third-party acadrust bridge, never systematically verified in AutoCAD by the project (community issue #604 reports one round trip with 6 AUDIT errors), no real-file corpus; a 10 MB DWG failed after ~2 minutes; DWG passes through an in-memory DXF (1.2 GB for an 83 MB file).
- No 3D at all (2D Vec2 kernel, no UCS) and no civil/land-development capability of any kind (points/surfaces/contours/alignments/grading/parcels/GIS/geolocation/survey all absent).
- No PDF/raster/DWF/DGN underlays or image display (ATTACH is a stub), no SHX fonts (text metrics differ), binary CTB/STB/PC3 unreadable, no physical printers, no sheet sets/eTransmit/fields/SPELL, no dynamic-block authoring or XCLIP, no plug-in API or CUI.
- Stability self-rated 35% with no CI test gate on pull requests; ~400 open PRs and ~390 open issues on the upstream page (unverified); Windows/Linux lightly tested; web build lacks DWG and autosave.
- Geometry on ellipses/splines is tessellated, tolerances are absolute, polyline offsets don't recompute bulges; untested at survey-scale coordinates.
- Documentation drifts internally (lines of code 57k vs 194k; menu breadth 245 vs 283; UI/UX 43% vs 48%; languages table lists existing catalogs as 'none'; hardware doc says no 3D mouse while code exists).
