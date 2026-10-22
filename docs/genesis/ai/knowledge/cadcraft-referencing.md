# CADCraft: referencing, data connections, file containment and crash safety (read from source)

Source: research worker notes `cadcraft-referencing.md` and the JSON summary, 2026-10-21. Status: full = shipping/mature, partial = with named limits, none = absent, unknown = unverified.

## Summary

CADCraft v0.10.0 (pre-alpha, pure Rust) has a solid, tested xref core (XATTACH/-XREF/XBIND/XOPEN/palette, overlays, relative paths, nested+circular bounds, host-side layer overrides persisted in DXF and DWG) and a deliberate stored-path security policy via the craft-docpath crate (only local files or the drawing's own network share are followed; other computers, devices and URLs are refused with a status, never an error). Data connections are thin: table data links read CSV only, carried as CADCraft xdata (invisible to AutoCAD), no fields/hyperlinks/Excel/DB. File containment is folder-shaped: no project container, eTransmit, sheet sets, .bak, or change notification; copy between drawings (clipboard, INSERT from file, IMPORT) uses one deterministic merge rule (existing target definitions win, anonymous blocks renamed, new handles, associativity dropped) but WBLOCK copies the whole symbol table and writes non-atomically. Crash safety is the strongest area: clippy deny of unwrap/expect/panic, forbid(unsafe), catch_unwind at every boundary with restore from a cheap Arc<Drawing> snapshot (made cheap by a copy-on-write chunked entity store), non-finite result refusal, 100 test functions named hostile across 2,110 tests (recounted 2026-10-21), caps on every input-sized loop, background autosave with lock files and immediate autosave on GPU faults, AUDIT/RECOVER. Weak spots the docs admit: no CI gate on PRs (stability scored 35%), no web autosave, DWG via acadrust->DXF-text bridge with a 6x inflation and the #57 10 MB DWG failure (throughput still open), DWG save drops unmodelled data, no XCLIP or in-place xref editing, Unloaded xref state lost on reopen.

## Measured numbers

| Metric | Value | Evidence |
|---|---|---|
| CADCraft version / HEAD | 0.10.0, commit 0cf3bde 2026-10-21 | Cargo.toml line 7; git log |
| MAX_BLOCK_DEPTH (block/xref nesting) | 16 | crates/doc/src/extents.rs:10 |
| Xref load caps | 4,000,000 objects; 1000 files; 512 MiB per file; 1 GiB total per load | crates/engine/src/cmd/blocks/xref/load.rs lines 22-30 |
| Data link file cap / format | 8 MiB, CSV/TSV only, read-only | crates/engine/src/cmd/table/breaks.rs:15; docs/gaps.md F11 |
| Clipboard caps | 50,000 objects mirrored to the OS clipboard; 5,000,000 nested-block walk; 256 MiB DXF text accepted | crates/engine/src/cmd/clipboard.rs lines 23-25, 165 |
| Autosave | SAVETIME default 10 min (max 600); lock heartbeat 60 s; stale after 5 min; DXF format; background thread; tmp+rename | crates/engine/src/autosave.rs lines 25-33, 390-410 |
| Undo depth | 2000 snapshots (each an O(1) Arc clone) | crates/engine/src/undoctl.rs:9 |
| Test functions in workspace | 2,110 #[test]; ~40 named hostile_* | grep -rc '#[test]' crates/; grep 'fn hostile_' |
| catch_unwind sites | Session::execute, interactive input, Guarded (factory/begin/prompt/preview/drag), finish_open, read_file, DWG reader+writer, LISP tick, canvas regen thread | crates/engine/src/lib.rs 784/896/1231; guard.rs; cmd/file.rs 267; crates/dwg/src/lib.rs 75/98/499/515; lisp/mod.rs 272/313; ui-egui/src/canvas/rebuild.rs 142 |
| DXF reader caps | 50M tags; 1M objects; 16,384 xdata groups/record; ownership depth 64; handles > 2^48 rejected | crates/dxf/src/lib.rs:167; crates/io/src/dxf_raw.rs 49-55 |
| DWG limits | 512 MiB DWG in, 1 GiB DXF rendition; DWG->DXF text is ~6x larger | crates/dwg/src/lib.rs Limits::DEFAULT and doc comment |
| Issue #57 DWG failure | 9.9 MB AC1024 DWG: ~1 min 50 s, ~1.1 GB RAM, then 'file too large', empty drawing (CADCraft 0.3.0, macOS); fix 61875b1/PR #175 stops runaway early; throughput still open (gaps FF6, 6-10 h) | https://github.com/storytold/cadcraft/issues/57; docs/gaps.md FF6; docs/file-format-parity.md line 55 |
| acadrust dependency | pinned 0.6.4 (MPL-2.0); crates.io latest 0.6.5 on 2026-10-18, 46,951 downloads | crates/dwg/Cargo.toml:13; https://crates.io/api/v1/crates/acadrust |
| Spatial index performance (internal) | 200,000 entities: pick 0.001 ms, ~4 ms re-index after an edit; frame ~4 ms; 1M untested | docs/hardware-parity.md lines 36-38 |
| Entity store chunking | chunks of 1024 Arc<Entity>, 64 index shards; clone = pointer copy; edit copies 1 chunk + 1 shard | crates/doc/src/store.rs lines 12-13 and module doc |
| Spatial index cache | 4 cached R-trees keyed by chunk identity; spaces < 256 entities scanned | crates/engine/src/spatial.rs lines 24-26 |
| Parity self-assessment | Stability 35%, Performance 60%, File formats 30%, Collaboration/cloud 5%, ready-for-real-work ~38% | ROADMAP.md By dimension; docs/target-app-parity.md line 162 |
| Gap estimates | F2 xref in-place edit/XCLIP 15-25 h; F23 Sheet Set/eTransmit 40-70 h; web autosave 3-5 h; CI gate 2-3 h | docs/gaps.md rows 5, 6, F2, F23 |

## External references (xrefs)

| Feature | Status | Notes | Source |
|---|---|---|---|
| XATTACH / -XREF attach, overlay, reload, unload, detach, path, type | full | All options implemented with JSON and command-line forms; attach failure changes nothing | crates/engine/src/cmd/blocks/xref.rs specs(); tests/xref.rs reload_unload_path_and_detach |
| Relative paths and relocation | full | Path saved as given; stored path resolved relative to host folder; bare file name tried beside host; both separators work; no Full/Relative/None path-type switch | xref/load.rs candidates(); tests paths_resolve_against_the_host_folder_then_by_name, missing_files_leave_the_host_intact |
| Missing or refused xref handling | full | NotFound/Unresolved status with reason, empty block, host opens, reference survives save; no file watcher or 'changed' notice | load.rs Missing::outcome; tests/xref.rs; grep notify/watch: none |
| Nested, circular and oversized references | full | Depth <= 16, cycle chain by canonical path, overlays not nested, file/byte/object caps | load.rs fetch(); test circular_and_deeply_nested_references_are_bounded |
| Host layer overrides persisted (VISRETAIN=1) | full | Xref-dependent LAYER records (flag 48) with their linetypes written to DXF and DWG; gaps.md F2 sentence on this is stale | crates/io/src/dxf_xref.rs; test xref_layer_overrides_survive_save_and_reopen_in_dxf_and_dwg (#886) |
| Unloaded state persisted | none | xref_status is #[serde(default)]; every xref reloads on reopen | crates/doc/src/tables.rs 677-679; load_all |
| Bind / XBIND | full | xref$0$name naming, Insert type merges, dependency-aware XBIND | xref/bind.rs; test bind_makes_the_xref_part_of_the_drawing |
| XOPEN | full | Opens the resolved file; refused paths give the reason | xref.rs run_xopen |
| External References palette | full | Status coloured, Reload All/Reload/Unload/Detach/Bind/Open; thin view over commands | crates/ui-egui/src/xrefs.rs |
| XCLIP, in-place xref edit (REFEDIT on xrefs), fading, demand loading | none | Listed as alpha-blocker leftovers | docs/gaps.md F2, row 4 |
| Underlays (PDF, image, DGN, point cloud) | none | No pdfattach/imageattach commands | docs/gaps.md FF10; grep crates/engine/src/cmd |

## Stored-path policy (craft-docpath)

| Feature | Status | Notes | Source |
|---|---|---|---|
| Local / own-share only resolution of stored paths | full | Refused::{Network, Device, Url, Invalid}; relative joins document folder; UNC only on the document's own share; file:// with host refused; lexical only (symlinks/mapped drives not checked) | crates/engine/src/doc_path.rs; https://raw.githubusercontent.com/storytold/craft-libs/82a24b006eefa036b43c09a67fb9a3fbd17ffe63/crates/docpath/src/lib.rs |
| User-chosen paths used as given | full | XATTACH, -XREF Path, DATALINK, INSERT from file bypass the policy by design | doc_path.rs module doc; insert_file.rs read_drawing |

## Data connections

| Feature | Status | Notes | Source |
|---|---|---|---|
| Table data links | partial | DATALINK/DATALINKUPDATE read CSV/TSV (8 MiB) into a table; stored as CADCraft xdata, not AutoCAD DATALINK objects; no Excel, no write-back, not on web, lost through DWG | crates/engine/src/cmd/table/breaks.rs; docs/gaps.md F11 |
| Fields, hyperlinks, dbConnect/OLE, DesignCenter, Excel links | none | No command specs found | grep crates/engine/src/cmd for field/hyperlink/adcenter |
| CSV exports (TABLEEXPORT, DATAEXTRACTION) | full | One-way exports | cmd/table/cells.rs; cmd/blocks/extract.rs |
| Agent/automation surface (MCP, control channel, CLI, LISP) | full | Every feature is a CommandSpec reachable from MCP tools, JSON control channel and cadcraft-cli | crates/mcp/src/tools.rs; docs/control-protocol.md |

## File containment and copying

| Feature | Status | Notes | Source |
|---|---|---|---|
| Clipboard between drawings (COPYCLIP/PASTECLIP/PASTEORIG/PASTEBLOCK) | full | Carries needed layers/linetypes/styles/nested blocks; deterministic merge (target definitions win, anonymous renamed); new handles; dimension associativity dropped; cross-window via DXF text on the OS clipboard | crates/engine/src/cmd/clipboard.rs; ui-egui/src/clipboard.rs |
| INSERT from file / IMPORT | full | Same merge rule; self-reference refused; .dwg then .dxf when no extension | cmd/blocks/insert_file.rs; cmd/exchange.rs |
| WBLOCK | partial | Copies the whole layer/linetype/style/block tables of the source (no pruning), plain fs::write (not atomic) | cmd/blocks.rs run_wblock lines 335-380 |
| Templates (.dwt/.dxf, QNEWTEMPLATE) | full | Untitled on open so the template is never overwritten; no templates shipped (clean-room) | cmd/file/template.rs |
| Foreign data round trip | partial | Unmodelled objects/xdata/xdict/reactors kept through DXF (#528); dropped by DWG save (acadrust) | crates/doc/src/foreign.rs; docs/gaps.md row 1 |
| Atomic save | full | tmp file + rename; no .bak kept | cmd/file.rs store() |
| Project container, eTransmit, Sheet Set Manager, Reference Manager, .bak | none | No project concept in engine or doc crates | docs/gaps.md F23; grep for project file/bundle |
| COMPARE (drawing diff) | full | Geometric diff vs file or open drawing, 200k objects cap, overlay navigation | cmd/file/compare.rs |

## Autosave, recovery, audit

| Feature | Status | Notes | Source |
|---|---|---|---|
| Autosave (desktop) | full | SAVETIME/SAVEFILEPATH, per-instance file names, lock-file heartbeat, background thread, tmp+rename, retry on failure, immediate save on GPU fault | crates/engine/src/autosave.rs; ui-egui/src/autosave.rs gpu_fault_tick; tests/autosave.rs |
| Drawing Recovery | full | Lists leftovers of dead instances, opens as unsaved copy, adopts file; only own-named files ever deleted | cmd/audit.rs run_drawingrecovery; autosave.rs recoverable()/discard() |
| AUDIT / RECOVER / AUDITCTL | full | Missing layers/blocks recreated, dangling refs reassigned/dropped, invalid geometry removed, block cycles cut, duplicate handles renumbered; .adt log; RECOVER = tolerant open + fix | crates/engine/src/audit.rs; cmd/audit.rs |
| Autosave in web build | none | Top-5 gap | docs/gaps.md row 5, F4 |

## Never-crash

| Feature | Status | Notes | Source |
|---|---|---|---|
| Lint wall and policy | full | deny(unwrap_used, expect_used, panic, unimplemented, todo, unreachable), forbid(unsafe_code), hostile-input rules, cargo xtask ci gate before commit | CLAUDE.md; crates/dwg/src/lib.rs lines 7-8 |
| catch_unwind guards with drawing restore | full | Session::execute, interactive input, Guarded wrapper (factory/begin/prompt/preview/drag), open, file read, DWG bridge, LISP, render thread | crates/engine/src/guard.rs and lib.rs; test panics_in_a_command_machine_end_the_command_not_the_app |
| Non-finite result refusal | full | Command reverted if any changed object gets NaN/inf or overflowing extents | crates/engine/src/finite.rs refuse_non_finite |
| Hostile-input tests | full | 100 hostile-named test functions incl. hostile_params_never_panic (recounted 2026-10-21) over every command and hostile_xref_input_never_panics | grep 'fn hostile_'; crates/engine/src/tests.rs:668; tests/xref.rs:397 |
| Input caps | full | Depth 16, DXF 50M tags / 1M objects, xref/clipboard/datalink/compare/DWG byte caps, undo 2000 | see numbers |
| CI running tests on pull requests | none | Only packaging lint and release builds; 40 open PRs | docs/gaps.md S1, S3 |

## Performance structures

| Feature | Status | Notes | Source |
|---|---|---|---|
| Copy-on-write entity store | full | Arc chunks of 1024 + sharded handle index; clones are pointer copies; makes undo/autosave/panic-restore O(1) | crates/doc/src/store.rs |
| R-tree spatial index | full | Per-space rstar tree, cache keyed by chunk identity (never stale), incremental rebuild, parity tests vs brute force | crates/engine/src/spatial.rs; docs/hardware-parity.md |
| Off-thread OPEN | partial | read_file runs on a worker; xref loading after open is synchronous and re-reads whole files on every reload (no parsed cache) | cmd/file.rs read_file/finish_open; xref.rs after_open |

## DWG path

| Feature | Status | Notes | Source |
|---|---|---|---|
| DWG read/write via acadrust DXF bridge | partial | Failsafe read with skipped-record notes, size limits, catch_unwind; ~6x DXF inflation; 10 MB DWG failed in ~2 min (#57); write drops custom objects, table/block xdata, colour books, reactors; pre-R13 unreadable; no real-file corpus | crates/dwg/src/lib.rs; https://github.com/storytold/cadcraft/issues/57; docs/gaps.md rows 1-2, FF6 |

## Findings relevant to Genesis

- **Project container**: Keep CADCraft's stored-path policy (craft-docpath: local or own-share only, refusals become statuses) and the bare-file-name-beside-host fallback - together they make a folder-shaped project relocatable. Change: add a project manifest beside the drawings listing every reference (xref, data link, underlay, font, template, plot style) with project-relative path, content hash, size, mtime and role; 'package/eTransmit' becomes copy-by-manifest instead of re-implementing eTransmit, which the project's gaps list (row F23) estimates at 40–70 hours. Persist xref status (CADCraft loses Unloaded) and the found-at path. Keep a .bak/previous version beside the atomic tmp+rename save, and make WBLOCK prune definitions like the clipboard does. (evidence: crates/engine/src/doc_path.rs; xref/load.rs candidates(); crates/doc/src/tables.rs xref_status serde(default); cmd/blocks.rs run_wblock; docs/gaps.md F23)
- **Link health checks**: Keep the per-reference status enum with a human reason (Loaded/Unloaded/Not Found/Unresolved(reason)/Unreferenced), computed at open and reload and coloured in the palette, and the rule that a bad reference never blocks opening. Change: add one linkcheck command that walks the manifest (xrefs, nested xrefs, data links, underlays) and reports found/missing/refused/changed-since-load using a hash or mtime+size recorded at load (CADCraft records neither); add a file watcher so a modified xref raises a reload notice (CADCraft has none); decide explicitly whether to canonicalise symlinks before the lexical docpath check. (evidence: xref/load.rs Outcome/Missing; ui-egui/src/xrefs.rs status colouring; grep notify/watch in engine and ui: none; craft-docpath docs caveat on symlinks)
- **Fast re-referencing**: Keep the copy-on-write EntityStore (Arc chunks of 1024, sharded handle index): snapshots, undo, autosave and spatial caches are pointer copies, and it is the natural substrate for sharing a loaded reference between host, palette and caches without copying. Change: CADCraft re-reads and re-imports the whole referenced file on every Reload and loads xrefs synchronously after OPEN; Genesis should keep a process-wide parsed-reference cache keyed by (canonical path, size, mtime, hash), load references on a worker like OPEN's read_file/finish_open split, give each reference its own R-tree so pick/snap through a reference is logarithmic, and consider viewport-extent demand loading for large site bases. Keep every cap (files, bytes, objects, depth 16, cycle chain). (evidence: crates/doc/src/store.rs; crates/engine/src/spatial.rs; cmd/file.rs read_file/finish_open; xref.rs after_open; load.rs caps)
- **Deterministic copy between drawings**: Keep the merge rules verbatim: existing named definitions in the target win, anonymous * blocks get fresh generated names, nested blocks and record-to-record dependencies (layer->linetype, dimstyle->textstyle) travel with the objects, new handles, source drawing uid tracked for Paste-to-original. CADCraft implements this three times (clipboard, insert-from-file, import); Genesis should have one merge_definitions used by paste, insert, import, bind and packaging. Change: add a stable per-object GUID so re-pasting the same source object is an idempotent update, return a merge report (kept/renamed/dropped) as the command result for users and agents, and remap handles to preserve dimension associativity when both ends were copied (CADCraft always drops it). Keep DXF text as the cross-process clipboard format. (evidence: cmd/clipboard.rs defs_for/merge/block_names/adopt; cmd/blocks/insert_file.rs; cmd/exchange.rs import_drawing)
- **Crash-proofing**: Keep everything: deny lints for unwrap/expect/panic plus forbid(unsafe), Result everywhere, catch_unwind at every boundary (command, interactive step, prompt/preview, open, file read, DWG bridge, LISP, render thread) with restore from the pre-command Arc<Drawing>, non-finite refusal, the hostile_* test convention plus a cross-command hostile_params_never_panic, caps on every input-sized loop, background autosave with lock files and tmp+rename, immediate autosave on GPU fault, GPU errors captured by callbacks. Add what CADCraft lacks: a CI gate running the full check on every PR (this missing CI gate, gaps list row S1, is why the project rates its own stability 35% despite the architecture), an append-only command journal per drawing so recovery replays to the last action rather than the last 10-minute autosave, web autosave (IndexedDB), a DWG path that does not inflate 6x into DXF text (#57 was the first crash-adjacent failure users reported; the upstream tracker now holds about 42 issues matching 'crash', including GPU startup failures and an xref re-path crash) (reconciled after the fact-check and critique, 2026-10-21), reader fuzzing, and opt-in crash/hang telemetry so 'zero crashes' is measurable. (evidence: CLAUDE.md Never crash; crates/engine/src/guard.rs, lib.rs, finite.rs, autosave.rs; crates/dwg/src/lib.rs; docs/gaps.md S1, row 5, FF6; https://github.com/storytold/cadcraft/issues/57)

## Unique strengths

- craft-docpath stored-path policy: xref and data-link paths saved in a drawing are followed only on this computer or the drawing's own network share; other computers, device paths and URLs become an 'Unresolved' status with a reason instead of being opened (AutoCAD has no equivalent)
- Every xref failure (missing, refused, unreadable, too big, circular, too deep) leaves an empty block with a status; the host always opens and the reference survives a save; bare file name beside the host is tried as a fallback for relocated projects
- Host-side xref layer overrides persist through both DXF and DWG save/reopen, verified by a test (#886)
- Copy-on-write chunked entity store makes every undo step, pre-command snapshot, autosave and clipboard definition set an O(1) pointer copy, which is what makes panic-restore and background autosave free
- Layered panic containment (execute, interactive step, prompt/preview, open, DWG bridge, LISP, render thread) plus non-finite-result refusal, enforced by clippy deny lints and 100 test functions named hostile (2,110 tests total; recounted 2026-10-21)
- Autosave design: per-instance file names, lock-file heartbeat so concurrent apps don't offer each other's files, only self-named files ever deleted, immediate autosave on GPU error/device loss, retry after failed write
- Content-identity-keyed R-tree cache that cannot go stale regardless of edit path; 200k-entity pick in 0.001 ms (internal numbers)
- Everything is a command: xrefs, data links, recovery and audit are all reachable from MCP, a JSON control channel, the CLI and AutoLISP

## Notable weaknesses

- No project container: no eTransmit/archive, Sheet Set Manager, Reference Manager, manifest, .bak backup, or recorded found-at/hash/mtime per reference (gaps F23, 40-70 h)
- No xref change detection: no file watcher, no 'needs reload' notice; every Reload re-reads and re-imports the whole file; xref loading after OPEN is synchronous
- Unloaded xref state is lost on reopen (xref_status not serialised); no XCLIP, no in-place xref editing, no demand loading, no PDF/image underlays
- Data links are CSV read-only, 8 MiB, stored as CADCraft xdata (invisible to AutoCAD, lost through DWG); no fields, hyperlinks, Excel or database connections
- DWG is an acadrust->DXF-text bridge with ~6x inflation; issue #57 (9.9 MB DWG, ~2 min, 1.1 GB RAM, then failure) is mitigated by limits but throughput is still an open alpha blocker; DWG save drops unmodelled data; never verified in AutoCAD; no real-file corpus
- No CI runs the Rust tests on pull requests (S1) despite the never-crash architecture; project self-scores stability 35% with 27 of 37 open issues on core paths
- No autosave in the web build; autosave is DXF not DWG; 10-minute default window of loss (no command journal)
- WBLOCK copies the source's entire symbol table and writes non-atomically; dimension associativity is always dropped on paste/insert/xref import
- docpath check is lexical only: symlinks, junctions and mapped drives can still reach another computer
- gaps.md F2 row is partly stale (says layer overrides last only for the session; the #886 test shows they persist) - docs lag the code
