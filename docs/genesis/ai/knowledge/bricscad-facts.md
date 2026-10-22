# BricsCAD V26 Ultimate: editions, licence, features

Source: research worker notes `bricscad-features.md` and the JSON summary, 2026-10-21. Status: full = shipping/mature, partial = with named limits, none = absent, unknown = unverified.

## Summary

BricsCAD V26 is an AutoCAD-compatible DWG CAD sold in five inheriting editions (Lite 2D; Pro 2D/3D incl. civil and point clouds; Mechanical and BIM on top of Pro; Ultimate = all). Perpetual licences are still sold from the official store (Ultimate EUR 2,640 one-time incl. first-year maintenance, renewal EUR 440/yr, optional from year two); the US perpetual price could not be captured. It runs on Windows, Linux (x86-64) and macOS (Rosetta 2, no native Apple-silicon build yet). V26 adds 2D dynamic-block authoring, 3D solid grips, property-based selection, point-cloud linear feature detection into civil strings/surfaces, IFC 4x3, Teamcenter/Vault/ProjectWise/ACC integrations and a chat assistant (BricsCAD Assist). Civil tools (Pro+) cover TIN surfaces, grading/cut-fill balance, horizontal and vertical alignments and corridors but not parcels, pipe networks, plan production or stormwater analysis. Research caveat: only six web searches succeeded and no page could be fetched directly, so rows marked unverified need confirmation.

## Version

V27 (launch keynote 20 October 2026; Windows release notes already at build 27.1.05). The inventory below was researched against V26 (October 2025, V26.2 March 2026) and marks V27 additions where known; V27 pricing was not re-checked (editor's own search, 2026-10-21)

## Platforms

- Windows 10 and 11, x86-64 only (Microsoft ended Windows 10 support 2025-10-14)
- Linux x86-64: Ubuntu 22.04 LTS and newer supported releases; openSUSE/Fedora builds after April 2022 with glibc >= 2.35; 3D acceleration unsupported on Intel graphics and dual-GPU laptops
- macOS 12 Monterey or later; runs on Apple silicon through Rosetta 2 (since V21.2.06); native Apple-silicon build planned, not shipped
- Hardware: Core i5/Ryzen 5 min (i7/i9, Ryzen 7/9 recommended); 8 GB RAM min, 16 GB recommended; 3 GB disk for Ultimate
- No ARM, web or mobile build

## Pricing

| Plan | Price | Source |
|---|---|---|
| Ultimate perpetual (official store, EUR) | EUR 2,640 one-time, includes first-year maintenance | https://bricscad.octave.com/bricscad/ultimate |
| Ultimate perpetual in USD (third-party listing) (added from the editor's own web search on 2026-10-21) | TrustRadius lists a one-time fee of USD 2,100 for Ultimate on premise (unofficial; its embedded data also shows 590, which is the Lite figure); the official store quotes EUR 2,640 only | https://www.trustradius.com/products/bricscad/pricing |
| Ultimate maintenance renewal (official store, EUR) | EUR 440 per year; 'from year two, renewal is up to you' (optional). Caveat: the reviews worker read Pro maintenance at EUR 710/yr on the same domain, which would make Ultimate cheaper than Pro; one of the two figures is a rendering or regional artefact, so confirm in the live store (reconciled after the fact-check and critique, 2026-10-21) | https://bricscad.octave.com/maintenance |
| Ultimate subscription (official store, EUR) (added from the editor's own web search on 2026-10-21) | EUR 1,176 per year; EUR 3,171 for three years (regional Bricsys store pages; the US maintenance page also shows EUR 1,176/yr for Ultimate, which conflicts with the EUR 440 renewal figure on the product page: verify in the live store) | https://www.bricsys.com/en-us/store/bricscad |
| Maintenance terms (official) (added from the editor's own web search on 2026-10-21) | Every new licence includes one year of BricsCAD Maintenance; renewal is optional from year two and can be bought from 90 days before the contract ends | https://www.bricsys.com/en-us/maintenance |
| Ultimate perpetual (UK reseller) | GBP 2,257 (CAD Software Direct); GBP 1,890 incl. first-year maintenance (Brighter Graphics) - two reseller prices disagree | https://www.cadsoftwaredirect.com/cad-modelling/buy-bricsys-bricscad/bricscad-ultimate |
| Ultimate maintenance renewal (US resellers, USD) | USD 484.00 (Novedge) vs USD 441 (acad2bcad); figures disagree, dates unverified | https://novedge.com/collections/new-releases |
| Ultimate perpetual in USD (official US store) | not found in this session (page fetch blocked); EUR 2,640 is roughly USD 2,800-3,100 by exchange rate, not a list price | https://bricscad.octave.com/store/bricscad |
| Perpetual availability 2026 | Still offered per official store and resellers (page dates unverified); a forum thread criticises a new 'Upgrade and Support Policy' for perpetual holders (content unread) | https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move |

## V27 additions (October 2026)

| Feature | Status | Notes | Source |
|---|---|---|---|
| Dynamic Input at the cursor and Quad marking-menu gestures for 2D entities (editor's own search, 2026-10-21) | full | Listed on Octave's What's New in BricsCAD V27 page | https://bricscad.octave.com/bricscad/v27 |
| AI chat panel for documentation and how-to guidance (editor's own search, 2026-10-21) | full | An AI-driven chat panel inside the interface; scope limited to help and guidance per the launch page | https://bricscad.octave.com/bricscad/v27 |
| Constraints on 2D blocks; migration of dynamic-block libraries from other CAD (editor's own search, 2026-10-21) | full | Release notes 27.1.05 add incremental constraint solving while dragging grips of constrained 2D entities | https://boa.bricscad.octave.com/common/releasenotes.jsp |
| Auto Mapping: linework from survey codes; point clouds shared as mesh objects (editor's own search, 2026-10-21) | full | Auto Mapping for civil points already existed in V26 (reseller first-impressions); V27's launch page lists linework from survey codes as new (reconciled after the fact-check and critique, 2026-10-21) | https://bricscad.octave.com/v27/launch |
| Tool Palettes customised from model space (editor's own search, 2026-10-21) | full | Launch page item | https://bricscad.octave.com/bricscad/v27 |

## 2D drafting & DWG compatibility

| Feature | Status | Notes | Source |
|---|---|---|---|
| Native DWG read/write (through DWG 2018 format, ODA-based) | full | Official compatibility page: opens and saves DWG R11/12, R13, R14, 2000, 2004, 2007, 2010, 2013 and 2018/2021 (AC1032) plus the matching ASCII and binary DXF versions (editor's own search, 2026-10-21) | https://help.bricsys.com/en-us/document/bricscad/getting-started-with-bricscad/working-in-bricscad/drawing-file-format-compatibility-in-bricscad |
| Complete 2D drafting/annotation toolset | full | Lite edition is 'concise 2D drafting and detailing'; feature list not itemised | https://novedge.com/collections/all/products/buy-bricscad-lite-upgrade |
| Dynamic blocks: use AutoCAD dynamic blocks | full | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Dynamic blocks: create and edit 2D dynamic blocks | full | New in V26: 'BricsCAD now supports creating and editing 2D Dynamic Blocks' | https://zentekconsultants.net/whats-new-in-bricscad-v26/ |
| Parametric blocks (Bricsys native) + Auto-Parametrize | full | Pro and above; Auto-Parametrize listed among AI-driven tools, not new to V26 | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| LISP (AutoLISP-compatible) and DCL | full | All editions including Lite; unverified (background knowledge; page fetch blocked, search budget exhausted) | https://en.wikipedia.org/wiki/BricsCAD |
| BRX (ObjectARX-compatible C++), .NET, COM, VBA APIs | full | Pro and above; Lite excluded; unverified (background knowledge; page fetch blocked, search budget exhausted) | https://en.wikipedia.org/wiki/BricsCAD |
| CUI/CUIX customization, PGP aliases, workspaces | full | V26 adds a workspace-selection launcher | https://bricscad.octave.com/blog/get-up-to-speed-from-bricscad-v25-to-v26-whats-better-for-your-workflow-blog |
| Quad cursor (context palette) with ML command prediction | full | Model ships locally with the install and ranks commands; no cloud dependency | https://draftingbench.com/bricscad-v26-review/ |
| Blockify (convert repeated geometry to blocks) | full | Vendor claims up to 90% file-size reduction; reviewer calls it deterministic pattern matching | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| Manipulator widget | full | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Property-based selection in Filter panel | full | New in V26: select/deselect/add/remove by property query | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| Mixed-DPI display scaling | partial | Improved in V26 ('smarter scaling across fractional monitors') | https://bricscad.octave.com/blog/get-up-to-speed-from-bricscad-v25-to-v26-whats-better-for-your-workflow-blog |
| Layouts, plotting, publish, plot styles, annotative scaling | full | Standard DWG platform; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| AutoLISP compatibility in practice (added from the editor's own web search on 2026-10-21) | full | Migration reports: all but a handful of hundreds of AutoCAD LISP files ran unchanged; startup files are on_start.lsp / on_doc_load.lsp instead of acad.lsp; compiled .fas/.vlx cannot be loaded; DCL and ActiveX-style Visual LISP code run on Mac and Linux too (mostly vendor-affiliated sources) | https://www.cadnauseam.com/2017/01/21/bricscads-lisp-kicks-sand-in-the-face-of-autocads/ |

## Referencing & data

| Feature | Status | Notes | Source |
|---|---|---|---|
| Xrefs (attach/overlay, clip, bind, relative paths) | full | Attach (with nested xrefs) or Overlay (first level only), Bind, Detach, Path, Reload, Unload at the -XREF prompt; Full, Relative and No-path types switchable from the External References palette (relative paths need a saved host drawing and are rebuilt when the drawing moves); XCLIP and a reference-manager-style report were not confirmed in the help pages found (editor's own search, 2026-10-21) | https://help.bricsys.com/en-us/document/bricscad-bim/project-collaboration/using-xrefs |
| Drawing Explorer (central manager for layers, blocks, xrefs, styles, images, underlays) | full | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Sheet Set Manager (.dst) | full | Sheet Set Manager panel opens .dst files (a DST dropped on the window opens in the Sheet Set Explorer); subsets, sheets, publish and eTransmit from the panel (editor's own search, 2026-10-21) | https://help.bricsys.com/en-us/document/bricscad/panels/sheet-set-manager-panel |
| eTransmit packaging | full | ETRANSMIT packages drawings with their references; launched for selected sheets or sheet sets from the Sheet Set Manager; a forum reply says multiple arbitrary files cannot be selected at once (workaround: a temporary sheet set) (editor's own search, 2026-10-21) | https://forum.bricsys.com/discussion/comment/33990 |
| PDF underlay and PDF import | full | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Data links (tables linked to spreadsheets) | full | DATALINK links tables to .xls/.xlsx/.csv (whole sheet, named range or cell range) with Full, Relative or No-path storage, keep-formulas or solve-in-Excel options, and optional write-back through DATALINKUPDATE; forum reports of 'unexpected error' when the workbook is open in Excel and slow updates on cluttered workbooks (added from the editor's own web search on 2026-10-21) | https://help.bricsys.com/en-us/document/dialog-boxes/d/datalink-edit-dialog-box |
| Point clouds (import, visualise, section) | full | Pro and above include point-cloud processing; V26 improves handling | https://en.wikipedia.org/wiki/BricsCAD |
| Point-cloud linear feature detection | full | New in V26: outputs lines, polylines, civil strings or surfaces | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| PDM/CDE integrations: Siemens Teamcenter, Autodesk Vault, Bentley ProjectWise, Autodesk Construction Cloud | full | All listed as V26 additions (Teamcenter in Mechanical) | https://zentekconsultants.net/whats-new-in-bricscad-v26/ |
| Bricsys 24/7 cloud document management | full | Separate cloud DMS/collaboration product, not the support desk; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |

## 3D & parametric

| Feature | Status | Notes | Source |
|---|---|---|---|
| 3D direct modelling of solids | full | Pro+; V26 adds 3D solid manipulation grips and one-step fillet/chamfer on full solids | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better |
| 3D geometric and dimensional constraints | full | Pro+; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Sheet metal | full | Mechanical/Ultimate; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Assemblies, BOM, mechanical drafting | full | Mechanical = 'intelligent 3D assembly modeling' | https://novedge.com/collections/test/products/buy-bricscad-mechanical-upgrade |
| BIM modelling and classification | full | BIM/Ultimate; V26 improves project-classification tools | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| IFC import/export incl. IFC 4x3 | full | V26: 'Deeper IFC 4x3 compatibility' | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| BIMify (ML classification of 3D objects, user override) | full | BIM/Ultimate | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| Propagate (replicate detail to matching locations) | full | BIM/Ultimate | https://novedge.com/blogs/news/artificial-intelligence-in-bricscad-bim-enhance-your-bim-workflows-with-six-key-design-phase-processes |
| Rendering | full | Pro+; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |

## Civil / land-development tools (Pro and above)

| Feature | Status | Notes | Source |
|---|---|---|---|
| TIN surfaces (create, edit, merge, contours, mesh extraction) | full | TIN and TINEDIT commands; breaklines and boundaries supported | https://help.bricsys.com/en-us/document/bricscad/civil-tools/civil-commands |
| Grading | partial | GRADING creates graded surface to a TIN or offset/slope surface; GRADINGBALANCE balances cut/fill; no Civil 3D-style feature lines/grading groups (unverified absence) | https://help.bricsys.com/en-us/document/command-reference/g/grading-command |
| Horizontal alignments | full | By PIs, by elements, imported from LandXML and from Civil 3D | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Vertical alignments (profiles) | partial | Exist; 'Projection is required to create Vertical Alignments and Corridors'; labelling/style depth unknown | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Corridors | partial | Exist per help text; template/subassembly depth unknown; no Subassembly Composer equivalent (unverified) | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Civil Explorer panel | partial | Appears only in a vendor UI caption; role and edition unconfirmed | https://bricscad.octave.com/industries/civil-engineering |
| Civil points, point groups, description keys (no survey database, no least-squares adjustment found) | partial | CIVILPOINT entities carry number, elevation, name, raw and expanded description and custom attributes, drawn by symbol and label styles; CIVILPOINTGROUP builds groups by wildcard name and elevation filters; points from CAD points, blocks (attribute mapping), object vertices, station/offset measures or ASCII import; CIVILPOINTEXPORT writes them out; no survey database or least-squares adjustment found (added from the editor's own web search on 2026-10-21) | https://help.bricsys.com/en-us/document/command-reference/c/civilpoint-command |
| LandXML import/export | partial | Alignment import sourced; surface I/O likely but unverified | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Civil 3D object import | partial | Alignments importable from Civil 3D; other objects as proxies (unverified) | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Cross sections / sample lines | unknown | Not captured |  |
| Geolocation, map tiles, coordinate-system library | unknown | GEOGRAPHICLOCATION exists in background knowledge; breadth unverified |  |
| Parcels, legal descriptions, map check | none | No evidence found; unverified absence |  |
| Pipe and pressure networks, stormwater/hydrology analysis | none | No evidence found; unverified absence |  |
| Plan production (view frames, sheets from alignments) | none | No evidence found; unverified absence |  |
| Quantity takeoff, mass haul, superelevation, criteria-based design | none | No evidence found; unverified absence |  |
| Vendor scope statement | partial | Marketed as 'Preliminary & Site Design' and a 'Civil and Survey Toolkit', not a Civil 3D replacement | https://bricscad.octave.com/blog/bricscad-pro-for-civil-engineers-preliminary-and-site-design |
| GRADINGBALANCE and linked gradings (added from the editor's own web search on 2026-10-21) | full | GRADING creates graded surfaces attached to their input entity and target TIN; GRADINGBALANCE (V21+) finds the level that balances cut and fill; a 2024 forum thread shows extending a TIN beyond its spot levels needs breakline workarounds | https://help.bricsys.com/en-us/document/bricscad/civil-tools/working-with-gradings |

## AI / machine-learning features

| Feature | Status | Notes | Source |
|---|---|---|---|
| Predictive Quad (local ML command ranking) | full | Runs locally, adapts to session data, no cloud | https://draftingbench.com/bricscad-v26-review/ |
| Blockify | full | Deterministic geometry matching marketed as AI | https://draftingbench.com/bricscad-v26-review/ |
| Auto-Parametrize | full | Pro+; not new to V26 | https://draftingbench.com/bricscad-v26-review/ |
| BIMify and Propagate | full | BIM/Ultimate | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| BricsCAD Assist chat assistant | partial | Named as a V26 chat assistant; scope (help vs command execution), edition and cloud dependency unknown | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better |
| Generative copilot drafting geometry from prompts | none | No source describes one under any name |  |

## Platforms & system requirements

| Feature | Status | Notes | Source |
|---|---|---|---|
| Windows 10/11 x86-64 | full | Official | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |
| Linux x86-64 (Ubuntu 22.04+, openSUSE, Fedora glibc >= 2.35) | full | 3D acceleration unsupported on Intel graphics and dual-GPU laptops | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |
| macOS 12+ | partial | Runs under Rosetta 2 on Apple silicon; native build only planned | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |
| ARM / web / mobile | none | x86-64 only; no WASM or mobile build | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |

## Interoperability

| Feature | Status | Notes | Source |
|---|---|---|---|
| DWG/DXF all versions | full | R11/12 through 2018/2021 (AC1032) per the official compatibility page (editor's own search, 2026-10-21) | https://help.bricsys.com/en-us/document/bricscad/getting-started-with-bricscad/working-in-bricscad/drawing-file-format-compatibility-in-bricscad |
| DGN import | partial | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| PDF import/underlay/export | full | unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| IFC 2x3/4/4x3 | full | BIM/Ultimate; V26 deepened 4x3 | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| STEP/IGES | full | Pro+; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Rhino 3DM, SketchUp SKP, Revit RVT import | partial | Import only, BIM/Pro editions; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| LandXML | partial | See civil category | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Point-cloud formats | full | Capability sourced; format list unverified | https://en.wikipedia.org/wiki/BricsCAD |
| PLM/CDE connectors (Teamcenter, Vault, ProjectWise, ACC) | full | New in V26 | https://zentekconsultants.net/whats-new-in-bricscad-v26/ |

## Stability & performance

| Feature | Status | Notes | Source |
|---|---|---|---|
| Vendor scalability/performance claims | partial | V26 marketed 'Smarter and More Scalable'; Blockify 'up to 90%' smaller files; no independent benchmark captured | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better |
| User-reported V26 stability | partial | Forum thread reports crashes and slowdowns, mostly on macOS and Linux (anecdotal) The loudest crash threads (V25.1/V25.2 panning crashes with the MTFLAGS=0 workaround, AMD black screens) were on Windows; macOS and Linux reports add platform-specific problems (reconciled after the fact-check and critique, 2026-10-21) | https://forum.bricsys.com/discussion/comment/58591/ |
| Autosave, recovery, AUDIT/RECOVER | partial | Standard DWG-platform mitigations exist (unverified); no never-crash guarantee or crash statistics |  |
| Apple-silicon performance | partial | Rosetta 2 emulation until native build ships | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |

## Support & community

| Feature | Status | Notes | Source |
|---|---|---|---|
| Official forum (forum.bricsys.com) | full | Active; V26 performance and policy threads cited | https://forum.bricsys.com/discussion/comment/58591/ |
| Help centre with per-command reference | full | help.bricsys.com | https://help.bricsys.com/en-us/document/command-reference/g/grading-command |
| Support desk via maintenance/subscription and reseller network | full | Policy recently changed per forum thread title; details unread | https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move |
| Bricsys 24/7 | full | Cloud DMS/collaboration product, not a support channel; unverified (background knowledge; page fetch blocked, search budget exhausted) |  |
| Reseller/training ecosystem | full | Novedge, Zentek, ModelCAM, CAD Software Direct publish V26 breakdowns | https://zentekconsultants.net/whats-new-in-bricscad-v26/ |

## Unique strengths

- Perpetual licence still sold from the official store (Ultimate EUR 2,640) with maintenance optional after year one, unlike Autodesk's subscription-only model
- One DWG platform spanning 2D, 3D direct modelling, sheet metal, BIM and civil (Ultimate) on Windows, Linux and macOS
- AutoCAD-compatible automation surface: LISP in all editions, BRX/.NET/COM in Pro+ (unverified edition split), easing migration of LISP libraries
- Local, non-cloud machine learning (predictive Quad) and deterministic productivity tools (Blockify, Auto-Parametrize) that do not depend on vendor servers
- V26 enterprise integrations (Teamcenter, Vault, ProjectWise, ACC) and point-cloud extraction into civil strings/surfaces
- Commercial DWG CAD with a supported Linux build

## Notable weaknesses

- Civil tools are preliminary/site-design level: no parcels, pipe/pressure networks, plan production, survey database, quantity takeoff or stormwater analysis found
- macOS build is Rosetta-emulated with no native Apple-silicon build; Linux 3D acceleration unsupported on Intel GPUs and dual-GPU laptops
- User reports of V26 crashes and slowdowns on macOS and Linux
- US perpetual price for Ultimate not discoverable in this session; reseller USD maintenance figures disagree (USD 441 vs 484)
- 'AI' branding contested: reviewer describes Blockify/Auto-Parametrize as deterministic pattern matching, not neural inference
- Forum complaint about a new upgrade-and-support policy for perpetual holders (content unverified)
- Dynamic-block authoring only arrived in V26; data-link support unknown
