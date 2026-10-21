# CADCraft deep-read: referencing, data connections, file containment, crash safety

Research worker notes, 2026-10-21. Source: repo at `/home/user/cadcraft_1`, v0.10.0 (`Cargo.toml` line 7), HEAD `0cf3bdea` (2026-10-21, "Merge pull request #1398"). Everything below is read from source unless a URL is given. The upstream project is `storytold/cadcraft` (the clone's origin is a fork, `Sparkey333/cadcraft_1`); issue numbers (#57, #525, #886, …) refer to upstream.

Legend used in the summary JSON: **full** = works end to end with tests; **partial** = exists with named limits; **none** = absent.

---

## 1. External references (xrefs)

### 1.1 What exists

Files: `crates/engine/src/cmd/blocks/xref.rs` (589 lines, commands + interactive prompt machines), `xref/load.rs` (535 lines, path resolution and loading), `xref/bind.rs` (256 lines, Bind/XBIND), `crates/io/src/dxf_xref.rs` (46 lines, what is saved), `crates/ui-egui/src/xrefs.rs` (External References palette), tests `crates/engine/tests/xref.rs` (11 tests).

Commands (`xref.rs` `specs()`):
- `xattach` (alias `xa`, menu Insert ▸ DWG Reference...) `{path, name?, overlay?, at?, scale?, rotation?}` → `{name, handle, xref}`.
- `xref` (aliases `xr`, `externalreferences`, menu Window ▸ Reference Manager) lists xrefs as JSON; in the app it opens the External References palette.
- `-xref` with options `?`, `bind`, `detach`, `path`, `unload`, `reload`, `overlay`, `attach`, `type`.
- `xbind` `{type: block|dimstyle|layer|linetype|style, names}`.
- `xopen` `{name}` or selected reference → runs `open` on the resolved file.

Data model (`crates/doc/src/tables.rs` lines 661–708): an xref is a `Block` with `xref_path: Option<String>` ("the referenced drawing's path as the user gave it, absolute, relative to the host drawing's folder or a bare file name"), `xref_overlay: bool`, and `xref_status: XrefStatus` which is **session state, `#[serde(default)]`, not saved**. `XrefStatus` = NotLoaded | Loaded | Unloaded | NotFound | Unresolved (labels "Not loaded", "Loaded", "Unloaded", "Not Found", "Unresolved"); the palette and `-xref ?` add "Unreferenced" when a loaded xref has zero INSERTs (`describe()` in `xref.rs`).

Loading (`load.rs`): the referenced file's **model space becomes the block's objects**; its layers, linetypes, text/dim/mleader/table styles and blocks come in renamed `xref|name` (layer `0` and ByLayer/ByBlock/Continuous stay the host's: `shared()`). Dependent symbols the host already has keep the host's settings ("so layer changes survive a reload", `import()`). Objects get new host handles; dimension associativity is cleared on import (`adopt` closure). INSBASE and INSUNITS of the referenced drawing become the block base and units.

### 1.2 Path handling: relative vs absolute, what is followed

`load::candidates(path, host, chosen)`:
1. A path **the user just typed** (`chosen = true`, XATTACH / `-xref path`) is used as given; a relative one is joined to the host drawing's folder; backslashes are normalised to `/` on non-Windows.
2. A path **stored in the drawing** goes through `crate::doc_path::resolve` (`crates/engine/src/doc_path.rs`, a thin wrapper over the `craft-docpath` crate) — see §2.
3. Then, if there is a host file, the **bare file name is tried beside the host** (`dir.join(name)`), so a drawing saved with `C:\old\job\gone.dxf` still finds `gone.dxf` next to the host on any platform (test `missing_files_leave_the_host_intact`, and `paths_resolve_against_the_host_folder_then_by_name` in `load.rs`).
4. First candidate that `is_file()` wins. On wasm nothing is found ("files are not available on the web").

The path is **saved exactly as given** (`mark_xrefs` in `crates/io/src/dxf_write.rs` lines 2671–2690 writes BLOCK group 70 bit 4 (12 for overlay) and the path in group 1; reader `dxf_read.rs` lines 1690–1810 reads it back). There is **no AutoCAD-style "path type" (Full / Relative / No path) switch**; the UI's `relative_to_host()` in `ui-egui/src/xrefs.rs` makes the picked path relative when attaching through the file picker. Nested xrefs resolve relative to **their own file** (`fetch()` passes `Some(&file)` as host for nested loads), which matches AutoCAD's behaviour for relative nested paths.

### 1.3 Missing / refused xrefs

- File not found → `XrefStatus::NotFound`, detail `"<path>: file not found"`, block left empty, status echoed at open: `Xref "gone" not loaded: gone.dxf: file not found.` The **host opens normally and the reference survives a save** (test `missing_files_leave_the_host_intact`).
- Refused path (other computer, URL, device) → `XrefStatus::Unresolved`, detail `"<path>: not opened, <reason>"` (e.g. "another computer"); XOPEN of it errors with the same reason (test `saved_xref_paths_are_followed_beside_the_host_or_on_this_computer_only`).
- Unreadable / too big / circular / too deep → `Unresolved` with a reason; **"Every failure leaves the xref's block empty with a status saying why; nothing here stops the host drawing from opening"** (`load.rs` module doc). `load_in` clears whatever partially imported on failure.
- `xattach` of a file that cannot be loaded **changes nothing** (the cloned drawing is discarded: `attach()` in `xref.rs`).

Nesting and limits (`load.rs`): attachments load with the referenced drawing, overlays do not (`fetch()` filters `!b.xref_overlay`; test `overlays_do_not_load_in_the_drawings_that_reference_their_host`); depth capped at `MAX_BLOCK_DEPTH = 16` (`crates/doc/src/extents.rs` line 10); circular references detected by a canonicalised file chain (`Ctx.chain`; test `circular_and_deeply_nested_references_are_bounded`: a→b→a loads `b` but not `b|a`); caps `MAX_XREF_OBJECTS = 4_000_000`, `MAX_XREF_FILES = 1000`, `MAX_XREF_BYTES = 512 MiB` per file, `MAX_XREF_TOTAL_BYTES = 1 GiB` per load. Referenced files are read through the host's io hooks, byte-limited with `take(limit+1)`.

### 1.4 What is saved vs lost (gaps.md F2 and the code)

Saved (`crates/io/src/dxf_xref.rs` `saved_view`): the xref BLOCK record (flagged, path, **no objects**), and the xref-dependent **LAYER records with the host's overrides** (colour, freeze, etc.; DXF group 70 bits 16|32 = 48) plus the linetypes those layers use. Dropped on save: `xref|` blocks, text/dim/mleader/table styles and other linetypes (they come back from the file).

- **Layer overrides (VISRETAIN=1 behaviour) survive save and reopen in DXF and DWG** — test `xref_layer_overrides_survive_save_and_reopen_in_dxf_and_dwg` (#886). Note: `docs/gaps.md` row F2 still says "Unloaded state and xref-layer overrides last only for the session"; the layer-override half of that sentence is stale relative to the test (#886 landed after the row was written). The **Unloaded state is genuinely lost**: `xref_status` is not serialised, `load_all` at open loads every xref whose status is not `Unloaded`, and a freshly read block has the default `NotLoaded`.
- Not saved anywhere: the resolved "found at" path (recomputed each time by `describe()`), load time, file hash/mtime — there is **no staleness detection and no file watcher** (grep for notify/watch in engine and ui-egui found nothing), so a changed xref on disk is only noticed when the user presses Reload.

gaps.md F2 (verbatim, `docs/gaps.md` line 28): "XREF editing in place and clipping: XCLIP is missing. REFEDIT, REFSET and REFCLOSE edit a block reference in place (…#813); left: editing an xref in place (its source drawing is not written back; XOPEN opens it), picking nested references, a dimmed look for the locked drawing and a banner with Save and Discard, attribute sync of other references (ATTSYNC). XATTACH, the External References palette, -XREF (Bind/Detach/Path/Unload/Reload/Overlay), XBIND, XOPEN, overlays, relative paths and loading at open are done (#525). Unloaded state and xref-layer overrides last only for the session" — estimate 15–25 h, impact "Medium: xrefs can't be edited in place or clipped".

Also absent: XCLIP, demand loading / spatial index of xrefs (XLOADCTL), xref fading (XDWGFADECTL), xref change notification balloon, "Reference Manager" external tool, path-type choice, DGN/PDF/image/point-cloud underlays (`gaps.md` FF10: "PDF import and underlays (PDFATTACH); raster image attach (IMAGEATTACH)" not done; no `imageattach`/`pdfattach` command found in `crates/engine/src/cmd`), ETRANSMIT (§5).

### 1.5 Bind (`bind.rs`)

`-xref bind` turns a **loaded** xref into a normal block; dependent names `xref|name` become `xref$0$name` (first free number), or plain `name` with the Insert type (host symbol of that name wins, the xref's definition is dropped). Nested `a|b|c` → `a$0$b$0$c`. XBIND copies one symbol with its dependencies (layer→linetype, dimstyle→textstyle, block→everything it uses), bounded by `MAX_BLOCK_DEPTH`. Tests: `bind_makes_the_xref_part_of_the_drawing`, `bound_names`.

### 1.6 Palette (`crates/ui-egui/src/xrefs.rs`)

Rows: Reference Name, Status (Not Found / Unresolved drawn in the theme's warning colour), Type, Saved Path; buttons Reload All, Reload, Unload, Detach, Bind, Bind (Insert), Open; XATTACH from the palette uses the host file picker then types the (relative) path at the XATTACH prompt. It is a thin view over the engine commands.

---

## 2. craft-docpath: which stored paths may be opened

`crates/engine/src/doc_path.rs` (38 lines): "Paths stored in a drawing: xref paths and table data links. Such a path reaches the file system only through `resolve`: a relative path is taken from the drawing's folder, and only files on this computer, or on the network share the drawing itself is on, are opened (see `craft_docpath`). A refused path is handled like a missing file, with the reason in its status. Paths the user gives a command (XATTACH, -XREF Path, DATALINK) are their own choice and are used as given." The wrapper additionally refuses any non-absolute result as `Refused::Invalid` (so without a host file a relative path names nothing).

Dependency: `craft-docpath = { version = "0.1.0", git = "https://github.com/storytold/craft-libs", rev = "82a24b0…" }` (`Cargo.toml` line 28). The crate lives at `crates/docpath` in https://github.com/storytold/craft-libs (MIT/Apache-2.0, "Rust libraries for the Craft Apps"). From the source at https://raw.githubusercontent.com/storytold/craft-libs/82a24b006eefa036b43c09a67fb9a3fbd17ffe63/crates/docpath/src/lib.rs (fetched 2026-10-21):
- `pub enum Refused { Network, Device, Url, Invalid }`; `pub fn resolve(raw: &str, document: Option<&Path>) -> Result<PathBuf, Refused>`; also `classify`, `is_local`, `resolve_absolute`.
- Rules: `file:` URLs are reduced to paths (only empty host / `localhost` / a drive count as local); relative paths join the document's folder, root-relative (`\x`) the document's drive or share, drive-relative `C:x` only when the document is on C; `.`/`..` folded lexically, climbing above a root refused; a UNC path is allowed **only on the document's own share** (host and share compared ignoring ASCII case); other shares and `file://host/…` → `Network`; `\\.\`, `\??\`, `\\?\GLOBALROOT\`, reserved names (NUL, COM1…) → `Device`; URL-shaped strings (`https:`, `mailto:`, `jar:`) → `Url`; on Windows a colon inside a name is `Invalid` (alternate data streams); control characters → `Invalid`.
- Explicit caveat in its docs: the check is **purely lexical**; symlinks, junctions, mapped and `subst` drives are not checked, so a local-looking path can still reach another computer.

Tests in CADCraft: `doc_path.rs::relative_paths_resolve_beside_the_drawing_and_other_computers_are_refused`; `load.rs::paths_resolve_against_the_host_folder_then_by_name`; `tests/xref.rs::saved_xref_paths_are_followed_beside_the_host_or_on_this_computer_only` (UNC, `file://host`, and on unix a `//host/…` double-slash path all end `Unresolved` with "another computer"; a user-given path to the same file loads).

Assessment: a deliberate, tested **security/portability policy for stored paths** that AutoCAD does not have (AutoCAD follows any path, including network shares, and warns via the security "trusted locations" only for executables). This is a keeper for Genesis.

---

## 3. Data connections

### 3.1 Table data links (CSV only)

`crates/engine/src/cmd/table/breaks.rs`: `datalink` `{handle, path (.csv, .txt/.tsv tab-separated), startRow?, remove?}` → `{rows, cols}`; `datalinkupdate` (also interactive, select tables). `DataLink { path, start_row }` lives on the table (`crates/doc/src/tables/tablebreak.rs` lines 57–64, `Table.data_link`, `crates/doc/src/entity.rs` line 956). Reading: `MAX_LINK_BYTES = 8 MiB`, UTF-8 lossy with BOM strip, CSV parser bounded to `MAX_ROWS`/`MAX_COLS` (`parse_csv`), separator sniffed from extension/content; `link_file()` uses the path as given when just chosen and `doc_path::resolve` when stored (same refusal policy as xrefs). Not available on wasm ("data links can't read files in the browser").

Limits (`docs/gaps.md` F11): "data links read CSV only (no Excel ranges, no write-back, not on the web)"; "custom cell styles, breaks and data links travel as CADCraft xdata (not through DWG)"; "formulas aren't read from or written as AutoCAD FIELD objects (other programs see values)". So a CADCraft data link is **invisible to AutoCAD** (no DATALINK dictionary object) and lost through DWG.

### 3.2 Other data paths

- `tableexport` → CSV (`cmd/table/cells.rs`), `dataextraction` (`cmd/blocks/extract.rs`, CSV; gaps F11/#534) — one-way exports.
- No FIELD command, no HYPERLINK command, no dbConnect/OLE, no DesignCenter/ADCENTER, no Excel links (grep of `crates/engine/src/cmd` for `"field"`, `"hyperlink"`, `"adcenter"` found no command specs).
- Agent/automation surface (relevant to "data connections" in the Genesis sense): MCP server (`crates/mcp/src/tools.rs`: `command_line`, `script`, `execute`, `list_commands`, `inspect_drawing`, `query_entities`, `render`, `find_text`, `new_drawing`, `open`, `save`, `cancel`, plus `screenshot`, `ui_inspect`, `ui_click` when connected to a window), JSON control channel (`docs/control-protocol.md`: `cmdline.*`, `engine.execute`, `drawing.inspect`, `ui.*`, `app.open/save/quit`), `cadcraft-cli` (info, convert, run, commands, mcp, perf), AutoLISP core (`crates/engine/src/lisp`). Everything is a command (`CommandSpec`), so any data integration can be scripted.

---

## 4. File containment: copy between drawings, insert, templates

### 4.1 Clipboard (`crates/engine/src/cmd/clipboard.rs`, 359 lines)

COPYCLIP, CUTCLIP, COPYBASE; PASTECLIP, PASTEORIG, PASTEBLOCK. The engine clipboard holds the entities **plus the definitions they need** (`defs_for`: layers, linetypes, text/dim/mleader/table styles and blocks, walked through nested block references with `MAX_WALK = 5_000_000`, including records referenced by records — a layer's linetype, a dimstyle's text style). Paste (`merge`): adds what the target lacks; **a name the target already has keeps the target's definition** (AutoCAD-compatible rule, deterministic); a generated `*…` block whose name is taken gets a fresh generated name (`block_names`, BTreeMap so order is deterministic); **pasted objects get new handles; associative-dimension links are dropped** (`adopt`). PASTEBLOCK names the block `A$C<handseed hex>`. `ClipSource.uid` records the source drawing, so PASTEORIG is enabled only for objects from another drawing (as in AutoCAD).

Cross-window: the clipboard is serialised as a DXF text document with `$INSBASE` (`system_text`, cap `MAX_SYSTEM_OBJECTS = 50_000`) and put on the OS clipboard by `crates/ui-egui/src/clipboard.rs`; `load_system_text` accepts DXF text up to 256 MiB from the OS clipboard, so paste into another CADCraft window (or any app that reads DXF text) works. Not AutoCAD's binary clipboard format, so copy/paste **with AutoCAD** only works via DXF text if AutoCAD could read it (it can't from the clipboard — unverified, but AutoCAD uses its own OLE formats).

### 4.2 INSERT from file (`crates/engine/src/cmd/blocks/insert_file.rs`)

`-INSERT C:\parts\bolt.dxf`, `bolt=C:\parts\bolt.dwg`, JSON `{file}`: the file's model space becomes a block named after the file (base = `$INSBASE`), with its layers/linetypes/styles/blocks merged by the same "existing name wins, anonymous collisions renamed" rule; self-referencing definitions refused; path without extension tries `.dwg` then `.dxf`. This is **user-chosen input, so it bypasses doc_path** (correct per policy).

### 4.3 WBLOCK, IMPORT/EXPORT

`wblock` `{path, name? | handles?, base?}` (`crates/engine/src/cmd/blocks.rs` lines 335–380) writes selected objects or a block to a new file — but it **copies all layers, linetypes, text/dim styles and all blocks of the source** (`d.layers = src.layers.clone(); … d.blocks = src.blocks.clone()`) rather than only the ones used (unlike the clipboard's `defs_for`), so WBLOCK output carries the whole symbol table of the source; no PURGE pass. Writes with plain `std::fs::write` (not the atomic tmp+rename `store()` used by SAVE).

`import`/`export` (`crates/engine/src/cmd/exchange.rs`): DXF/DWG/SVG in, DXF/DWG/SVG/PNG/PDF out; import merges tables and blocks with the same rule and transforms by `at`/`scale`. `compare` (`cmd/file/compare.rs`, #563): geometric diff with another file or open drawing, `MAX_OBJECTS = 200_000`, overlay with next/previous navigation.

### 4.4 Templates (`crates/engine/src/cmd/file/template.rs`)

NEW/QNEW from `.dwt` (DWG content) or `.dxf`; `QNEWTEMPLATE` is a process-wide profile setting; the new drawing is untitled so the template is never overwritten by accident; "CADCraft ships no template; templates are the user's files" (clean-room policy). No template-stored xref/path policy.

### 4.5 Foreign data round-trip (`crates/doc/src/foreign.rs`)

Objects CADCraft does not model (XRECORDs, extension dictionaries, reactors, xdata, colour books, ACDSDATA with ACIS bodies) are kept as raw DXF groups and written back through DXF (#528); **through DWG the bridge drops custom-class entities/objects, xdata on table records and blocks, colour books, reactors** (`docs/gaps.md` top row 1, alpha blocker).

### 4.6 What there is no container for

No project/workspace/bundle concept (grep for project file / bundle in engine and doc found nothing), no Sheet Set Manager, no eTransmit/Archive, no Reference Manager (`docs/gaps.md` F23: "No Sheet Set Manager, eTransmit, Share, Traces, Markup Import, Activity Insights", 40–70 h; `docs/target-app-parity.md` line 162: "Collaboration and cloud … 5% … none of these exist"). No `.bak` on save (no ISAVEBAK; grep found no `.bak` writer); SAVE is atomic (`store()` writes `<path>.cadcraft-tmp` then renames, `cmd/file.rs` lines ~400–410) but the previous version is gone after the rename.

---

## 5. Autosave, drawing recovery, audit

### 5.1 Autosave (`crates/engine/src/autosave.rs`, 460 lines; UI glue `crates/ui-egui/src/autosave.rs`)

- SAVETIME default 10 min (0 = off, max 600), SAVEFILEPATH (per-user default set by the host). Every drawing with changes since its last autosave is written as **DXF** to `<SAVEFILEPATH>/<title>_<pid>-<starthex>_<uid>.sv$` on a background thread named `autosave`, via `<path>.tmp` + rename. Dirty detection is by `Arc` pointer identity (`DocState::is_dirty()` = `!Arc::ptr_eq(drawing, saved)`; the autosaver keeps `Weak<Drawing>` of what it last wrote) — no hashing, O(1).
- Files are deleted when the drawing is saved/closed or the app exits normally; a leftover means a crash. A lock file `<instance>.lock` is refreshed every 60 s (`HEARTBEAT_SECS`), stale after 5 min (`STALE_LOCK_SECS`), so a concurrently running copy's files are not offered. **Only names parsing as `<title>_<instanceid>_<uid>.sv$` are ever read or deleted** (`is_instance_id`, `parse_file_name`), so SAVEFILEPATH can be a shared temp folder (test `files_of_other_programs_in_the_autosave_folder_are_never_deleted`).
- Failed writes are retried SAVETIME later without another change (`reap()` → `unwritten`). A **GPU error or device loss triggers an immediate autosave** (`save_now`, `gpu_fault_tick` in `ui-egui/src/autosave.rs`; wgpu errors are captured through `on_uncaptured_error` / `set_device_lost_callback` in `ui-egui/src/gpu.rs` instead of panicking).
- Drawing Recovery (`drawingrecovery` command, `cmd/audit.rs`): lists autosaves of dead instances oldest first, opens one as an **unsaved untitled copy** (RECOVER with `copy: true`) and adopts its file so a second crash doesn't lose it; discard deletes.
- Tests: `crates/engine/tests/autosave.rs` (8: timing plan, close/zero/no-folder, name round trip, foreign files untouched, recovery listing, background write + removal on exit, retry after failure, recover-as-copy).
- Gaps: **no autosave in the web build** (`docs/gaps.md` top row 5 and F4, 3–5 h); autosave files are DXF not DWG; no separate tolerant "recover mode" in the readers (F4).

### 5.2 AUDIT / RECOVER (`crates/engine/src/audit.rs`, 661 lines; `cmd/audit.rs`)

`check()` reports, `fix()` repairs: tables (missing Standard styles), header, handseed/duplicate handles → renumbered, invalid geometry (NaN/degenerate) → removed, missing blocks → empty block recreated, missing layers → recreated with defaults, dangling style/linetype references → Standard/ByLayer, dangling object references → dropped, block cycles → closing reference removed, groups and constraints referencing missing objects → cleaned. "Repairs never guess at content." AUDITCTL writes a `.adt` log beside the drawing. RECOVER = open as tolerantly as the readers allow + fix; opens unchanged (like OPEN) when nothing was wrong.

---

## 6. Never-crash: guards, lints, hostile tests, caps

### 6.1 Policy and lints

`CLAUDE.md` "Never crash": no `unwrap/expect/panic/unreachable/todo/unimplemented` in non-test code, `unsafe_code = "forbid"`, every production crate root has `#![deny(clippy::unwrap_used, clippy::expect_used, clippy::panic, clippy::unimplemented, clippy::todo, clippy::unreachable)]` (e.g. `crates/dwg/src/lib.rs` lines 7–8). Input-derived numbers "are hostile": `get()` not `[i]`, checked arithmetic, no NaN casts, capped allocations. Gate before commit: `cargo xtask ci` (fmt, clippy -D warnings, tests, assets, layers, wasm).

### 6.2 Guard layers (`catch_unwind` sites)

| Site | File | What happens on a panic |
|---|---|---|
| `Session::execute` | `crates/engine/src/lib.rs` ~line 896 | drawing and selection restored from the pre-command `Arc<Drawing>`; `EngineError::Internal(cmd, msg)` |
| interactive input `feed()` | `lib.rs` ~line 1231 | `Internal`; the session restores `Running.before` |
| `Guarded` wrapper | `crates/engine/src/guard.rs` | factory, `begin`, `input`, `prompt`, `preview`, `preview_objects`, `drag`, `editing_mtext` all wrapped; a panic in prompt/preview sets a `broken` flag, shows "Internal error; press Enter to end the command", and ends the command at the next input with the drawing restored. Test `panics_in_a_command_machine_end_the_command_not_the_app` covers factory/begin/prompt/preview/input |
| `finish_open` | `lib.rs` ~line 784 | docs list truncated back, `Internal("open")` |
| `read_file` (OPEN off-thread read) | `cmd/file.rs` line ~267 | "the file could not be read" |
| DWG reader / writer | `crates/dwg/src/lib.rs` lines 75, 98, 499, 515 | acadrust panics become `Err("the DWG reader failed on this file")` etc. |
| AutoLISP tick | `crates/engine/src/lisp/mod.rs` lines 272, 313 | the script is ended with an error |
| canvas regen thread | `crates/ui-egui/src/canvas/rebuild.rs` line 142 | the job is dropped; the canvas rebuilds on the UI thread |

Plus `refuse_non_finite` (`crates/engine/src/finite.rs`): after any undoable command, if a changed object has NaN/∞ coordinates or overflowing extents, the whole command is reverted with "the result is too large: object … would get infinite or undefined coordinates. Nothing was changed".

### 6.3 Hostile-input tests

~40 test functions named `hostile_*` across the workspace (grep `fn hostile_`), e.g. `crates/engine/src/tests.rs::hostile_params_never_panic` (runs **every registered command** with null, arrays, strings, 1e308 points, bogus handles, negative radii, junk gradients), `hostile_variable_like_input_never_panics`, `tests/xref.rs::hostile_xref_input_never_panics` (NaN DXF, empty file, `../../../../dev/null`, empty path, a directory as path, scale 0, rotation 1e308, name `a|b`, NUL byte, non-string path; every `-xref`/`xbind`/`xopen` misuse), `tests/count.rs::hostile_nesting_is_bounded`, `doc/tests/lin_pat_parse.rs::hostile_linetype_files_never_panic_and_stay_capped`, `lisp/tests.rs::hostile_lisp_never_panics`, `spatial.rs::hostile_queries_match_scan`, `mcp` bad-argument tests. Total `#[test]` functions in the workspace: 2,110 (grep count). `CLAUDE.md` also names `hostile_dxf_does_not_panic` as the DXF regression test (not located under that exact name in this grep; unverified).

### 6.4 Caps on input-sized work

`MAX_BLOCK_DEPTH = 16` (block/xref nesting, used in extents, snap, compare, array, count, xref load/bind); DXF tokenizer `MAX_TAGS = 50_000_000` (`crates/dxf/src/lib.rs`); `dxf_raw.rs`: `MAX_OBJECTS = 1_000_000`, `MAX_XDATA_GROUPS = 16_384`, `MAX_DEPTH = 64` ownership chain, `MAX_HANDLE = 2^48` ("handles above this are not believed"); `dxf_read.rs`: `MAX_OBJECTS 1M`, `MAX_CELLS 1M`, hatch `MAX_HATCH_SOURCES 4096 / MAX_PATTERN_LINES 1024 / MAX_PATTERN_DASHES 256`, `MAX_VPORT_TILES 64`; `dxf_ext.rs` payload 64 MiB, constraints 1M, layer states 100k; SVG reader 64 MiB decompressed / 500k elements; PDF 256 pages; DWG `Limits::DEFAULT` 512 MiB DWG / 1 GiB DXF; xref caps (§1.3); clipboard 50k objects / 256 MiB text; data link 8 MiB; compare 200k objects; undo `MAX_UNDO = 2000` snapshots (`undoctl.rs`); autosave scans at most 10,000 directory entries.

### 6.5 Stability caveats the docs themselves state

`docs/gaps.md` Stability: S1 "No CI runs `cargo xtask ci` on pull requests (only packaging lint and release builds)"; S3 "40 open PRs, many community bug fixes awaiting review"; S4 open correctness issues (#166, #44, #134); S5 no UI smoke test of every command. `docs/target-app-parity.md`: Stability dimension **35%**, discount "Stability on real machines ×0.85: 27 of 37 open issues are core-path bugs; about 60 correctness fixes merged on 2026-10-10 alone"; "Launch and stability ×0.90: startup crash on Intel UHD graphics (#33, fixed in 0.4.0)… AMD GL driver crashes avoided (#31)". So: the engine is structurally crash-resistant, but the project has no CI gate on PRs and little real-machine testing.

---

## 7. Performance structures

### 7.1 Copy-on-write entity store (`crates/doc/src/store.rs`, 367 lines)

Entities live in chunks `Arc<Vec<Arc<Entity>>>` of `CHUNK_MAX = 1024` in draw order; a 64-shard handle index (`Arc<HashMap<Handle, chunk id>>`, Fibonacci hashing). **Cloning a store copies only chunk and shard pointers; an edit copies one chunk and one shard.** Consequence: every undo snapshot, every `before` copy taken by `Session::execute`, every autosave `Arc<Drawing>` and the clipboard's `defs` are O(1) to take — this is what makes "restore the drawing on panic" and background autosave free. `same_as()` / `chunk_slices()` expose chunk identity for caches.

### 7.2 Spatial index (`crates/engine/src/spatial.rs`, 565 lines)

`rstar` R-tree per space over entity bounds, used by picking, window/crossing/fence selection and object snaps. Cache of `CACHE_SIZE = 4` indexes keyed by **content identity** (the cache holds a clone of the store; an entry is reused only while every chunk pointer is shared), so a stale index is impossible whatever path edited the drawing (command, mid-command preview, undo/redo, script). Incremental rebuild: only changed chunks are re-measured; the previous tree is patched when ≥ half its chunks survive, else bulk-loaded. Spaces under `MIN_INDEXED = 256` entities are scanned. Parity tests assert identical results to brute force (`hostile_queries_match_scan`). Measured (`docs/hardware-parity.md` lines 36–38, internal, 2026-10-06, `cadcraft-cli perf`): 200,000 entities pick in 0.001 ms, about 4 ms after an edit; GPU frame ≈ 4 ms; 1M entities untested. Zoom/pan display-list rebuilds moved off the UI thread on 2026-10-13 after 2–4.5 s stalls per zoom step on a hatched 12k-entity (340k primitive) architect's DWG.

### 7.3 Opening files

OPEN is split: `cmd::file::read_file(path)` (slow: bytes → `Drawing`, no session needed, run on a worker thread by the host) and `finish_open` (fast: add to session, then `xref::after_open` loads xrefs **synchronously on the session thread**). So xref loading is not off-thread today, and every Reload re-reads and re-imports the whole referenced file (no parsed cache, no mtime check).

---

## 8. DWG path (`crates/dwg`, `acadrust`) and issue #57

- `crates/dwg/src/lib.rs`: "DWG files are read with the `acadrust` crate (MPL-2.0, used unmodified as a dependency) and converted to DXF bytes, which CADCraft's own DXF reader maps to its document model; saving goes the other way." Pinned `acadrust = "0.6.4"` (`crates/dwg/Cargo.toml`); crates.io: acadrust 0.6.5 published 2026-10-18, MPL-2.0, repo https://github.com/hakanaktt/acadrust, 46,951 downloads (https://crates.io/api/v1/crates/acadrust, fetched 2026-10-21). Native only (memory-maps); wasm has no DWG.
- Read runs in acadrust **failsafe mode** (undecodable records skipped, counted and reported as `read_notes` → echoed on OPEN and returned as `warnings`); a file whose object stream can't be read fails with the reason. DWG → DXF text is "about 6x" larger (10 MB DWG ≈ 60 MB DXF), written through a `CappedWriter` that stops at the DXF limit. Both reader and writer run under `catch_unwind`. Workarounds for acadrust 0.6.3/0.6.4 gaps are applied in the bridge (merged table cells, table style title/header flags, dimension flag bit 0, orphaned DGN line-style components — #1482: an 83 MB site plan with 888,483 orphan components / 1.2 GB DXF now opens).
- Issue #57 (https://github.com/storytold/cadcraft/issues/57, opened 2026-10-09, still open as of fetch): a 9.9 MB AC1024 (2010) DWG on CADCraft 0.3.0 / macOS Apple silicon: no window for ~1 min 50 s while memory grew to ≈ 1.1 GB, then "invalid parameters for `open`: file too large" and an empty Drawing1; a 2.1 MB AC1015 file opened in seconds. Commit 61875b1 / PR #175 "DWG open: stop runaway conversions early and name the limit" landed; `docs/gaps.md` FF6 (alpha blocker, 6–10 h): "DWG throughput: a 10 MB DWG took ~2 min to fail (#57)"; `docs/file-format-parity.md` line 55: "limits now stop runaway conversions early (#175), but the throughput problem remains … DWG ≈ 30% read".
- DWG write drops: custom-class entities and objects, xdata on table records and blocks, colour books, reactors (acadrust), VP layer overrides; pre-R13 DWG not read at all. No real-file corpus; never checked in AutoCAD (`docs/gaps.md` top rows 1–2).

---

## 9. Status table (as returned in the JSON)

See the JSON `categories`. Short form: xref attach/overlay/reload/unload/detach/path/bind/xbind/xopen/palette/relative paths/missing-file tolerance/nesting & cycle bounds/layer overrides persisted = **full**; unload state persisted, change notification, XCLIP, in-place xref edit, demand loading, underlays, path-type control, eTransmit, sheet sets, project container, .bak = **none**; data links (CSV read-only, xdata-carried) = **partial**; clipboard/insert/import = **full** with deterministic merge rules; WBLOCK = **partial** (whole symbol table copied, non-atomic write); templates = **full** (no shipped templates by design); autosave/recovery/audit = **full** on desktop, **none** on web; never-crash guards/lints/hostile tests/caps = **full**; CI gate on PRs = **none**; COW store and R-tree = **full**; DWG = **partial** (bridge, failsafe, limits; throughput and write losses open).

---

## 10. Design lessons for Genesis (keep / change)

### Project container that bundles a drawing with its references
- **Keep** the `craft-docpath` policy (stored paths are followed only locally or on the document's own share; refusals are statuses, not errors) and the "bare file name beside the host" fallback — together they make a folder-shaped project relocatable by construction.
- **Change**: CADCraft has no container at all. Genesis should define a **project manifest** (one file beside the drawings, e.g. `project.toml/json`) that lists every reference (xref, data link, image/PDF underlay, font, template, plot style) with its *project-relative* path, a content hash, size, mtime and the role it plays; "Package / eTransmit" is then just "copy everything in the manifest into one folder/zip, rewrite paths relative" — a few hundred lines, not AutoCAD's 40–70 h F23 feature. Persist the xref status (Unloaded) and the `foundAt` path too: CADCraft loses Unloaded on reopen (`xref_status` is `#[serde(default)]`).
- Save a `.bak`/versioned previous copy alongside the atomic tmp+rename (CADCraft has the atomic write but no backup), and make WBLOCK prune definitions like the clipboard's `defs_for` instead of copying the whole symbol table.

### Link health checks
- **Keep** the per-reference status enum with a human reason (`Loaded / Unloaded / Not Found / Unresolved(reason) / Unreferenced`), computed at open and on reload, and shown in colour in the palette. Keep "every failure leaves an empty block and a status; nothing stops the host from opening."
- **Change**: add a single `linkcheck` command that walks the manifest (xrefs *and* data links *and* nested refs) and reports found-at / missing / refused / **changed since last load** (hash or mtime+size recorded at load — CADCraft records neither). Add a file watcher (CADCraft has none) so a modified xref raises a "reload available" notice instead of waiting for a manual Reload. Note the docpath caveat (lexical; symlinks and mapped drives not checked) and decide whether to follow symlinks after canonicalising.

### Fast re-referencing
- **Keep** the COW `EntityStore` (`Arc` chunks of 1024): it makes snapshots, undo, autosave and the spatial cache O(1) and is the natural substrate for *sharing* a loaded reference between the host, the reference palette and caches without copying.
- **Change**: CADCraft re-reads and re-imports the whole referenced file on every Reload and loads xrefs synchronously after OPEN (`after_open`). Genesis should (1) keep a process-wide **parsed-reference cache** keyed by (canonical path, size, mtime, hash) so re-opening or re-attaching the same file is a pointer copy, (2) load references on the worker thread the way OPEN already splits `read_file` / `finish_open`, (3) index each reference's bounds in its own R-tree so picking/snapping through a reference does not expand it (CADCraft's `MAX_BLOCK_DEPTH`-bounded expansion is correct but linear), (4) consider demand loading by viewport extents for big site bases (AutoCAD's XLOADCTL). Keep the caps (files, bytes, objects, depth, cycle chain) — they are the reason a bad reference cannot take the host down.

### Deterministic copy between drawings
- **Keep** the merge rules exactly: existing named definitions in the target win, anonymous `*` blocks get fresh generated names, nested blocks and record-to-record dependencies (layer→linetype, dimstyle→textstyle) are carried, new handles, dimension associativity dropped. They are implemented three times (clipboard, insert-from-file, import) with the same shape — Genesis should have **one** `merge_definitions` function used by paste, insert, import, xref-bind and project packaging.
- **Change**: give every object a stable GUID in addition to the handle so a second paste/insert of the same source object can be detected (idempotent update instead of duplicate), carry a **merge report** (what was kept, renamed, dropped) back to the user/agent as the command result, and preserve associativity by remapping handles when both ends of the association were copied. Keep DXF-text as the cross-process clipboard format (it already lets agents and other windows exchange geometry).

### Crash-proofing
- **Keep everything**: the lint wall (`deny(unwrap_used, expect_used, panic, …)`, `forbid(unsafe_code)`), `Result` everywhere, `catch_unwind` at every boundary (command, interactive step, open, file read, DWG bridge, LISP, render thread) with **restore from the pre-command `Arc<Drawing>`**, the non-finite refusal, the "hostile_*" test convention (one per feature, plus `hostile_params_never_panic` across all commands), caps on every input-sized loop/allocation, background autosave with instance lock files and tmp+rename, immediate autosave on GPU fault, GPU errors captured via callbacks instead of panics.
- **Change/add**: (1) a CI gate that runs the full `cargo xtask ci` on every PR (CADCraft's S1 gap — 2–3 h — and the reason "stability 35%" despite the architecture); (2) a **command journal** (append-only log of executed commands + params per drawing) so recovery replays to the last keystroke instead of the last 10-minute autosave; (3) autosave in the web build (IndexedDB) — CADCraft's top-5 gap; (4) a DWG path that does not inflate 6x into DXF text (stream acadrust's document model straight into the entity store, or fix throughput upstream) — #57 is the one crash-adjacent failure users actually reported; (5) fuzzing of the DXF/DWG/CSV readers (the hostile tests are hand-written cases); (6) crash/hang telemetry opt-in so "zero crashes" is measurable.

---

## 11. Sources

- Repo files cited inline (all under `/home/user/cadcraft_1`): `CLAUDE.md`, `docs/gaps.md` (rows 1–6, F2, F4, F11, F23, FF6, S1–S5), `docs/target-app-parity.md`, `docs/file-format-parity.md`, `docs/hardware-parity.md`, `docs/roadmap.md` (alpha gate), `ROADMAP.md`, `docs/control-protocol.md`, and the source files named in each section.
- https://github.com/storytold/cadcraft/issues/57 (fetched 2026-10-21).
- https://github.com/storytold/craft-libs and https://raw.githubusercontent.com/storytold/craft-libs/82a24b006eefa036b43c09a67fb9a3fbd17ffe63/crates/docpath/src/lib.rs (fetched 2026-10-21).
- https://crates.io/api/v1/crates/acadrust (fetched 2026-10-21): v0.6.5, MPL-2.0, repo https://github.com/hakanaktt/acadrust.
