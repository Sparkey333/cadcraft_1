# BricsCAD V26 / Ultimate (Bricsys, a Hexagon company) — feature research notes

Compiled 2026-10-21 for the CADCraft / Civil 3D / BricsCAD Ultimate / "Genesis" comparison.

## 0. Method and limitations (read first)

- Six WebSearch queries (extended mode) succeeded before the shared per-turn web-search budget was
  exhausted. Every direct page fetch (WebFetch and curl) was refused by the session's egress proxy
  for bricsys.com, help.bricsys.com, forum.bricsys.com, bricscad.octave.com, draftingbench.com,
  novedge.com, wikipedia.org and the GitHub Bricsys org (HTTP 403 CONNECT). No Agent tool exists in
  this session, so the "web-fetch" fallback was not available either.
- Consequence: facts below marked **[S]** are supported by a URL returned by a search result
  summary; facts marked **[U] unverified** come from the researcher's background knowledge of
  BricsCAD (V21–V25 era) and must be confirmed by a verifier before being quoted. No price, rating
  or quote is invented; where a number could not be sourced it is stated as unknown.
- Vendor naming: the official BricsCAD site now resolves to `bricscad.octave.com` (search results
  call it "Octave's official store"). Octave appears to be the new brand of the Hexagon unit that
  contains Bricsys [U — only the domain is evidence]. Bricsys was acquired by Hexagon in 2018 [U,
  Wikipedia: https://en.wikipedia.org/wiki/BricsCAD].

## 1. Product and version

- Product: BricsCAD. Current major release: **V26**, which "arrives this October" per the vendor
  news post (i.e. October 2025) [S: https://bricscad.octave.com/news/the-true-cad-alternative-bricscad-v26-arrives-this-october].
- A V26.2 point release exists: the official What's-New page carries a `?f=v262` filter
  [S: https://www.bricsys.com/en-us/bricscad/v26?f=v262]. Search summaries warned that secondary
  pages mix V26 and V26.2 features and that exact per-feature dates are inconsistent.
- Vendor positioning: "The True CAD Alternative" (AutoCAD-compatible DWG CAD); V26 marketed as
  bringing "more than 60 new, enhanced, and experimental features" across general design,
  manufacturing, BIM and surveying [S: https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better,
  https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown].
- Independent review headline: "BricsCAD V26 reviewed: a year of maturation" (DraftingBench)
  [S: https://draftingbench.com/bricscad-v26-review/].

## 2. Editions (what each adds)

Structure confirmed by the reseller page: Lite is the base; Pro builds on Lite; Mechanical and BIM
each build on Pro; Ultimate covers both [S: https://novedge.com/collections/all/products/buy-bricscad-lite-upgrade,
https://novedge.com/collections/test/products/buy-bricscad-pro-upgrade,
https://novedge.com/collections/test/products/buy-bricscad-bim-upgrade,
https://novedge.com/collections/test/products/buy-bricscad-mechanical-upgrade].

| Edition | Vendor/reseller description [S] | What it adds (background, [U] unless noted) |
|---|---|---|
| Lite | "High-performing, compatible, and concise 2D drafting and detailing" | 2D drafting, DWG 2018, LISP; no 3D solid modelling, no BRX/.NET API [U] |
| Pro | "2D/3D CAD and modeling… powerful, intuitive and interoperable" | 3D direct modelling (ACIS), 3D constraints, parametric blocks, rendering, point clouds, **civil tools (TIN, grading, alignments)** [S: Wikipedia says Pro includes the civil suite and point-cloud processing "previously separate modules or requiring add-ons" — https://en.wikipedia.org/wiki/BricsCAD], BRX/.NET/VBA APIs [U] |
| Mechanical | "mechanical 2D design and drafting combined with intelligent 3D assembly modeling" | sheet metal, assemblies/BOM, mechanical drafting; V26: Siemens Teamcenter integration [S: V26 search results] |
| BIM | "AI-driven BIM, built on our single 2D and 3D DWG design platform" | IFC, BIMify, Propagate, Quickdraw, project classification; V26: deeper IFC 4x3, ProjectWise and ACC integrations [S] |
| Ultimate | "powerful and seamless workflows, from BIM to mechanical design on a single platform" | everything in Mechanical + BIM; installed size min 3 GB [S: system requirements page] |

- The task's "top perpetual edition" = **Ultimate**. It is the edition with every tool, so the
  feature inventory below is "Ultimate's point of view" unless a row says otherwise.

## 3. Licensing and pricing

### Perpetual still offered in 2026?
- **Yes, as far as the sources show.** The official Octave/Bricsys store lists BricsCAD Ultimate at a
  "one time fee of €2,640 for a lifetime perpetual license", first-year maintenance included
  [S: https://bricscad.octave.com/bricscad/ultimate; store: https://bricscad.octave.com/store/bricscad].
  The maintenance page states "from year two, renewal is up to you", i.e. maintenance is optional
  after year one [S: https://bricscad.octave.com/maintenance].
- Resellers still sell perpetual Ultimate: £2,257 (CAD Software Direct) [S: https://www.cadsoftwaredirect.com/cad-modelling/buy-bricsys-bricscad/bricscad-ultimate];
  £1,890 incl. first-year maintenance (Brighter Graphics) [S: https://store.brightergraphics.com/products/bricscad-ultimate-perpetual].
- Page dates could not be verified (fetch blocked); treat "still offered in 2026" as **likely but
  date-unverified**.
- A Bricsys forum thread titled "The new 'Upgrade and Support Policy': a cynical move" discusses a
  changed upgrade/support policy for perpetual holders; its content could not be read
  [S (existence only): https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move].
  Verifier: find what changed (upgrade pricing after a maintenance lapse, support entitlement).

### Prices found
| Plan | Price | Source | Note |
|---|---|---|---|
| Ultimate perpetual (official store, EUR) | €2,640 one-time, incl. 1st-year maintenance | https://bricscad.octave.com/bricscad/ultimate | official |
| Ultimate maintenance renewal (official store, EUR) | €440 / year | https://bricscad.octave.com/maintenance | official |
| Ultimate perpetual (UK reseller) | £2,257 | https://www.cadsoftwaredirect.com/cad-modelling/buy-bricsys-bricscad/bricscad-ultimate | reseller |
| Ultimate perpetual (UK reseller) | £1,890 incl. 1st-year maintenance | https://store.brightergraphics.com/products/bricscad-ultimate-perpetual | reseller; two UK prices disagree |
| Ultimate maintenance renewal (US reseller) | $484.00 | https://novedge.com/collections/new-releases | reseller, date unverified |
| Ultimate maintenance (US reseller) | $441 | https://acad2bcad.com/bricscad-maintenance | reseller, disagrees with Novedge |
| Ultimate perpetual in USD | **not found** | — | official US store page could not be fetched |
| Subscriptions (monthly/annual/3-year), Lite/Pro/BIM/Mechanical prices, network licences | **not captured** | https://bricscad.octave.com/store/bricscad ; https://www.getapp.com/construction-software/a/bricscad/ | search budget exhausted before these queries ran |

- Rough USD equivalent of €2,640 is on the order of US$2,800–3,100 depending on rate [derived, not a
  list price]. Do not quote as a US list price.
- Licensing types known from background [U]: single-user perpetual, volume/network (floating)
  licences, subscription (annual), academic licences, 30-day trial. Verifier should confirm.

## 4. Feature inventory by category (Ultimate's point of view)

Status key: full / partial / none / unknown. "[S]" sourced, "[U]" unverified background knowledge.

### 4.1 2D drafting and DWG compatibility
| Feature | Status | Notes | Source |
|---|---|---|---|
| Native DWG (2018 format, read/write) | full | BricsCAD is built on the ODA Drawings SDK and saves DWG natively; DWG 2018 is the current AutoCAD file version [U] | https://en.wikipedia.org/wiki/BricsCAD |
| Full 2D drafting/annotation toolset (lines, hatches, dimensions, mtext, tables, leaders, fields) | full | Lite is "2D drafting and detailing" [S]; feature-level list not captured | https://novedge.com/collections/all/products/buy-bricscad-lite-upgrade |
| Dynamic blocks (use) | full | AutoCAD dynamic blocks have been usable (grips/visibility) for years [U] | — |
| Dynamic blocks (create/edit) | full (new in V26) | "BricsCAD now supports creating and editing 2D Dynamic Blocks" [S] | https://zentekconsultants.net/whats-new-in-bricscad-v26/ ; https://www.bricsys.com/en-us/bricscad/v26?f=v262 |
| Parametric blocks (Bricsys' own) | full (Pro+) | Bricsys' parametric-block system, with Auto-Parametrize [S: AI tools page]; Pro-level [U] | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| LISP (AutoLISP-compatible), DCL | full | All editions incl. Lite [U] | https://en.wikipedia.org/wiki/BricsCAD |
| BRX (ObjectARX-compatible C++), .NET, COM, VBA | full (Pro+) | Pro and above [U]; Lite excluded [U] | https://en.wikipedia.org/wiki/BricsCAD |
| CUI / CUIX customization, PGP aliases, workspaces | full | V26 adds a workspace-selection launcher [S]; CUI editing exists [U] | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better |
| Quad cursor (context tool palette) | full | "predictive Quad cursor, powered by machine learning, anticipates your next move" [S]; model ships locally, ranks commands, no cloud [S: DraftingBench] | https://bricscad.octave.com/bricscad/features/ai-driven-tools ; https://draftingbench.com/bricscad-v26-review/ |
| Blockify | full | converts repeated geometry into blocks; "reduce file sizes by up to 90%" claim [S]; not new in V26 [S] | https://bricscad.octave.com/bricscad/features/ai-driven-tools ; https://draftingbench.com/bricscad-v26-review/ |
| Manipulator (move/rotate/scale/mirror widget) | full | long-standing BricsCAD tool [U] | — |
| Property-based selection / Filter panel queries | full (new in V26) | select/deselect/add/remove by property query [S] | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| Display scaling on mixed-DPI monitors | partial→improved V26 | "Smarter scaling across fractional monitors" [S] | https://bricscad.octave.com/blog/get-up-to-speed-from-bricscad-v25-to-v26-whats-better-for-your-workflow-blog |
| Annotative objects, layouts, plotting/publish, plot styles (CTB/STB) | full | standard DWG platform features [U] | — |

### 4.2 Referencing and data
| Feature | Status | Notes | Source |
|---|---|---|---|
| Xrefs (attach/overlay, relative paths, clip, bind) | full | standard DWG xref support [U] | — |
| Drawing Explorer (central manager for layers, blocks, xrefs, styles, images, PDF underlays) | full | long-standing BricsCAD panel [U] | — |
| Sheet Set Manager (.dst) | full | SHEETSET command, AutoCAD-compatible .dst [U] | — |
| eTransmit | full | ETRANSMIT command packages a drawing with its references [U] | — |
| PDF underlay / PDF import | full | PDFATTACH / PDFIMPORT [U] | — |
| Data links (tables linked to spreadsheets/CSV) | unknown | could not be verified in this session | — |
| Point clouds (import/visualise/section) | full (Pro+) | Pro includes point-cloud processing [S: Wikipedia]; V26 "improved point-cloud handling" and **linear feature detection** that creates lines, polylines, civil strings or surfaces from a point cloud [S] | https://en.wikipedia.org/wiki/BricsCAD ; https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| Document management / PDM integrations | full (new in V26) | Siemens Teamcenter (Mechanical), Autodesk Vault, Bentley ProjectWise, Autodesk Construction Cloud integrations listed as V26 additions [S] | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better ; https://zentekconsultants.net/whats-new-in-bricscad-v26/ |
| Bricsys 24/7 (cloud document management / collaboration) | full (separate product) | Bricsys 24/7 is a cloud DMS/collaboration service, not the support desk [U] | — |

### 4.3 3D and parametric
| Feature | Status | Notes | Source |
|---|---|---|---|
| 3D direct modelling (push/pull, solids) | full (Pro+) | V26: 3D solid manipulation grips on primitives/polysolids; one-step fillet/chamfer on full solids [S] | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better ; https://zentekconsultants.net/whats-new-in-bricscad-v26/ |
| 3D geometric/dimensional constraints | full (Pro+) | [U] | — |
| Parametric blocks + Auto-Parametrize | full (Pro+) | Auto-Parametrize listed among AI-driven tools [S] | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| Sheet metal | full (Mechanical/Ultimate) | [U] | — |
| Assemblies / BOM / mechanical drafting | full (Mechanical/Ultimate) | Mechanical = "intelligent 3D assembly modeling" [S] | https://novedge.com/collections/test/products/buy-bricscad-mechanical-upgrade |
| BIM modelling, classification, IFC | full (BIM/Ultimate) | V26: "Deeper IFC 4x3 compatibility", improved project-classification tools [S] | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| BIMify (ML classification of 3D objects as BIM elements, user can override) | full (BIM/Ultimate) | [S] | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| Propagate (replicate detail to all matching locations) | full (BIM/Ultimate) | [S] | https://novedge.com/blogs/news/artificial-intelligence-in-bricscad-bim-enhance-your-bim-workflows-with-six-key-design-phase-processes |
| Rendering (materials, lights) | full (Pro+) | [U] | — |

### 4.4 Civil / land-development tools (Pro and above)
| Feature | Status | Notes | Source |
|---|---|---|---|
| TIN surfaces (create, edit, merge, extract mesh/contours) | full | TIN, TINEDIT (add/remove points, breaklines, boundaries); merge; contour extraction [S] | https://help.bricsys.com/en-us/document/bricscad/civil-tools/civil-commands |
| Grading | partial | GRADING creates a graded surface between an entity and a TIN surface, or an offset/slope graded surface; GRADINGBALANCE positions a project by balancing cut and fill [S]. No feature-line/grading-group system like Civil 3D [U] | https://help.bricsys.com/en-us/document/command-reference/g/grading-command ; https://help.bricsys.com/en-us/document/bricscad/civil-tools/working-with-gradings |
| Horizontal alignments | full | by PIs, by elements, imported from LandXML and from Civil 3D [S] | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Vertical alignments (profiles) | partial | exist; "Projection is required to create Vertical Alignments and Corridors" [S]; profile-view labelling/styles depth unknown | same |
| Corridors | partial | corridors exist (same help text) [S]; template/subassembly depth unknown; no Subassembly Composer equivalent [U] | same |
| Cross sections / sample lines | unknown | not captured | — |
| Civil Explorer (panel) | partial/unknown | appears in a vendor UI screenshot caption only; role and edition not confirmed [S] | https://bricscad.octave.com/industries/civil-engineering |
| Civil points / point groups / description keys | partial/unknown | civil points exist [U]; survey database, description keys unknown | — |
| LandXML import/export | partial | alignment import from LandXML sourced [S]; surface LandXML I/O likely [U] | https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US |
| Civil 3D object import | partial | alignments importable "from AutoCAD Civil 3D" [S]; Civil 3D objects otherwise appear as proxies [U] | same |
| Point cloud → linear features / surfaces | full (new V26) | lines, polylines, civil strings or surfaces from point cloud [S] | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| Geolocation / map tiles / coordinate systems | unknown | GEOGRAPHICLOCATION exists in background knowledge [U]; CRS library breadth not verified | — |
| Parcels, legal descriptions, map check | none | no evidence of parcel objects [U] | — |
| Pipe networks / pressure networks, storm analysis | none | no evidence [U] | — |
| Plan production (view frames, sheets from alignments) | none | no evidence [U] | — |
| Quantity takeoff, mass haul, superelevation, criteria-based design | none/unknown | no evidence [U] | — |
| Vendor framing | — | Pro is marketed "for Civil Engineers: Preliminary & Site Design" and as a "Civil and Survey Toolkit" (V24), i.e. preliminary/site-level rather than full Civil 3D replacement [S] | https://bricscad.octave.com/blog/bricscad-pro-for-civil-engineers-preliminary-and-site-design ; https://bricscad.octave.com/blog/bricscad-pro-v24-civil-and-survey-toolkit |

### 4.5 AI / machine-learning features
| Feature | Status | Notes | Source |
|---|---|---|---|
| Predictive Quad (ML command ranking, local model, no cloud) | full | [S] | https://bricscad.octave.com/bricscad/features/ai-driven-tools ; https://draftingbench.com/bricscad-v26-review/ |
| Blockify | full | "up to 90%" file-size claim [S]; DraftingBench argues it is deterministic pattern matching, "not neural inference" [S] | same |
| Auto-Parametrize | full (Pro+) | not new to V26 [S]; same deterministic critique | same |
| BIMify, Propagate | full (BIM/Ultimate) | [S] | https://bricscad.octave.com/bricscad/features/ai-driven-tools |
| BricsCAD Assist (chat assistant) | partial/unknown | named as a V26 "chat assistant" in search summaries [S]; scope (help lookup vs. command execution), edition and whether it is cloud-based unknown | https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better |
| Generative "Copilot" that drafts geometry from prompts | none | no source describes one [S: search found nothing under that name] | — |

### 4.6 Platforms and system requirements
| Item | Value | Source |
|---|---|---|
| Windows | Windows 10 and 11, x86-64 only; note that Microsoft ended Windows 10 support 2025-10-14 | https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements |
| Linux | Ubuntu 22.04 LTS and newer supported releases; openSUSE and Fedora builds after April 2022 with glibc ≥ 2.35; x86-64 only; 3D hardware acceleration NOT supported on Intel graphics or dual-GPU laptops | same |
| macOS | macOS 12 Monterey or later; runs on Apple silicon through Rosetta 2 (since V21.2.06); native Apple-silicon build "planned in a future version" | same |
| CPU | min Core i5 / Ryzen 5; recommended i7/i9 / Ryzen 7/9 | same |
| RAM | 8 GB min, 16 GB recommended | same |
| Disk | 3 GB for installed Ultimate | same |
| ARM (Windows on ARM, Linux ARM) | none | x86-64 only [S] | same |
| Web/WASM build | none | no evidence [U] | — |

### 4.7 Interoperability
| Format | Status | Notes | Source |
|---|---|---|---|
| DWG / DXF (all versions to 2018) | full | [U] | https://en.wikipedia.org/wiki/BricsCAD |
| DGN import | full/partial | DGNIMPORT [U] | — |
| PDF (import, underlay, export) | full | [U] | — |
| IFC (2x3, 4, 4x3) import/export | full (BIM/Ultimate) | "Deeper IFC 4x3 compatibility" in V26 [S] | https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown |
| STEP / IGES | full (Pro+) | import/export [U] | — |
| Rhino 3DM | partial | import [U] | — |
| SketchUp SKP | partial | import (BIM) [U] | — |
| Revit RVT/RFA | partial | import via ODA (BIM) [U] | — |
| LandXML | partial | see civil table [S] | — |
| Point clouds (e57, las/laz, pts, rcp…) | full (Pro+) | [U] formats; capability [S] | https://en.wikipedia.org/wiki/BricsCAD |
| PLM/CDE: Teamcenter, Vault, ProjectWise, ACC | full (new V26) | [S] | https://zentekconsultants.net/whats-new-in-bricscad-v26/ |

### 4.8 Stability and performance
- Vendor claims: V26 is "Smarter and More Scalable" [S: https://bricscad.octave.com/news/bricscad-r-v26-the-true-cad-alternative-now-smarter-and-more-scalable];
  Blockify "up to 90%" smaller files [S].
- Counter-evidence: a Bricsys forum thread "V26 Performance issues" reports crashes and slowdowns,
  "mostly on macOS and Linux" (anecdotal, user reports) [S: https://forum.bricsys.com/discussion/comment/58591/].
- macOS runs under Rosetta 2 emulation, which is a structural performance disadvantage on Apple
  silicon until the promised native build ships [S: system requirements page].
- Autosave / recovery / AUDIT / RECOVER: standard DWG-platform commands exist [U]; no
  crash-rate statistics available. Status: partial (mitigations exist, no "never crash" guarantee).
- No independent benchmark vs AutoCAD captured in this session.

### 4.9 Support and community
| Item | Status | Notes | Source |
|---|---|---|---|
| Official forum | full | forum.bricsys.com is active (two threads cited above) | https://forum.bricsys.com/discussion/comment/58591/ |
| Help centre with per-command reference | full | help.bricsys.com command reference pages (GRADING etc.) | https://help.bricsys.com/en-us/document/command-reference/g/grading-command |
| Support desk (support requests, reseller network) | full | included with maintenance/subscription [U]; policy change discussed in forum thread [S existence only] | https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move |
| Bricsys 24/7 | full (separate cloud DMS product) | collaboration/document management, not the support channel [U] | — |
| Third-party ecosystem (resellers, training, blogs: Novedge, Zentek, ModelCAM, CAD Software Direct) | full | multiple resellers publish V26 breakdowns [S] | https://zentekconsultants.net/whats-new-in-bricscad-v26/ ; https://novedge.com/blogs/design-news/what-new-features-are-the-bricsys-team-excited-about-in-bricscad-v26-shorts |

## 5. Unique strengths (vs Civil 3D and vs CADCraft/Genesis)
1. Perpetual licence with optional maintenance after year one, from the official store (€2,640
   Ultimate) — the main structural difference from Autodesk, which sells subscription only [S].
2. One DWG platform spanning 2D, 3D direct modelling, sheet metal, BIM and civil (Ultimate), on
   Windows, macOS and Linux [S].
3. AutoCAD-compatible automation surface: LISP in every edition; BRX/.NET/COM in Pro+ [U] — lowers
   migration cost for firms with LISP libraries.
4. Local, non-cloud machine-learning (predictive Quad) and deterministic productivity tools
   (Blockify, Auto-Parametrize) that do not depend on vendor servers [S: DraftingBench].
5. V26 broadened enterprise integrations (Teamcenter, Vault, ProjectWise, ACC) and point-cloud
   feature extraction into civil strings/surfaces [S].
6. Linux support is rare among commercial DWG CADs [S: system requirements].

## 6. Notable weaknesses
1. Civil tools are "preliminary and site design" level: TIN, grading, alignments, corridors with
   projection; **no parcels, pipe/pressure networks, plan production, survey database, quantity
   takeoff or stormwater analysis** found [S for scope; U for absences].
2. macOS build is Rosetta-emulated, no native Apple-silicon build yet; Linux 3D acceleration is
   unsupported on Intel GPUs and dual-GPU laptops [S].
3. User reports of V26 crashes/slowdowns on macOS and Linux [S, anecdotal].
4. Pricing transparency: the US perpetual price for Ultimate could not be found in this session;
   reseller USD maintenance figures disagree ($441 vs $484) [S].
5. "AI" branding is contested: a reviewer calls Blockify/Auto-Parametrize deterministic
   pattern-matching rather than neural inference [S].
6. A forum thread complains about a new upgrade-and-support policy for perpetual holders (content
   unverified) [S existence only].
7. Dynamic-block authoring only arrived in V26, years after AutoCAD; data-link support unknown.

## 7. Key claims handed to verifiers
- BricsCAD V26 released October 2025 (vendor news "arrives this October").
- Ultimate perpetual €2,640 one-time incl. first-year maintenance; renewal €440/yr; maintenance optional from year two (official Octave store).
- US reseller maintenance renewal $484 (Novedge) vs $441 (acad2bcad).
- Pro and above include civil tools (TIN, grading, alignments) and point clouds (Wikipedia).
- Corridors and vertical alignments exist and require projection (help.bricsys.com).
- V26 adds creating/editing 2D dynamic blocks.
- V26 adds Teamcenter, Vault, ProjectWise and ACC integrations; IFC 4x3; point-cloud linear feature detection.
- Platforms: Windows 10/11 x86-64, Ubuntu 22.04+/openSUSE/Fedora glibc≥2.35 x86-64, macOS 12+ via Rosetta 2; native Apple-silicon planned.
- Predictive Quad uses a locally shipped ML model (DraftingBench).
- Forum reports of V26 performance issues mostly on macOS/Linux.

## 8. Open questions / follow-ups (not answerable in this session)
- Official US-store USD prices for all five editions (perpetual, maintenance, annual/monthly/3-year subscription, network).
- Exact edition matrix (Lite vs Pro) for BRX/.NET, 3D constraints, parametric blocks, point clouds, civil.
- What the new "Upgrade and Support Policy" changed.
- Scope of BricsCAD Assist (help-only chat vs. command execution; cloud or local).
- Data-link (Excel/CSV table) support; sheet-set and eTransmit parity details; relative-path xref defaults.
- Civil: cross sections, civil points/description keys, LandXML surface I/O, geolocation/CRS library, Civil 3D proxy handling.
- Native Apple-silicon status in V26.x.

## Sources (all URLs returned by the six successful searches)
- https://www.bricsys.com/en-us/bricscad/v26?f=v262
- https://bricscad.octave.com/blog/whats-new-in-bricscad-r-v26-the-true-cad-alternative-just-got-even-better
- https://bricscad.octave.com/news/bricscad-r-v26-the-true-cad-alternative-now-smarter-and-more-scalable
- https://bricscad.octave.com/news/the-true-cad-alternative-bricscad-v26-arrives-this-october
- https://bricscad.octave.com/blog/get-up-to-speed-from-bricscad-v25-to-v26-whats-better-for-your-workflow-blog
- https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown
- https://zentekconsultants.net/whats-new-in-bricscad-v26/
- https://novedge.com/blogs/design-news/what-new-features-are-the-bricsys-team-excited-about-in-bricscad-v26-shorts
- https://storekonia.com/whats-new-in-bricscad-v26-the-true-cad-alternative-just-got-even-better/
- https://bricscad.octave.com/bricscad/ultimate
- https://bricscad.octave.com/maintenance
- https://bricscad.octave.com/store/bricscad
- https://novedge.com/collections/new-releases
- https://acad2bcad.com/bricscad-maintenance
- https://www.cadsoftwaredirect.com/cad-modelling/buy-bricsys-bricscad/bricscad-ultimate
- https://store.brightergraphics.com/products/bricscad-ultimate-perpetual
- https://www.getapp.com/construction-software/a/bricscad/
- https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move
- https://forum.bricsys.com/discussion/comment/58591/
- https://en.wikipedia.org/wiki/BricsCAD
- https://novedge.com/collections/all/products/buy-bricscad-lite-upgrade
- https://novedge.com/collections/test/products/buy-bricscad-pro-upgrade
- https://novedge.com/collections/test/products/buy-bricscad-bim-upgrade
- https://novedge.com/collections/test/products/buy-bricscad-mechanical-upgrade
- https://help.bricsys.com/en-us/document/bricscad/civil-tools/civil-commands
- https://help.bricsys.com/en-us/document/bricscad/civil-tools/working-with-gradings
- https://help.bricsys.com/document/_guides--BCAD_civil_tools--GD_creatingalignments/V23/EN_US
- https://help.bricsys.com/en-us/document/command-reference/g/grading-command
- https://bricscad.octave.com/industries/civil-engineering
- https://bricscad.octave.com/blog/bricscad-pro-for-civil-engineers-preliminary-and-site-design
- https://bricscad.octave.com/blog/bricscad-pro-v24-civil-and-survey-toolkit
- https://bricscad.octave.com/blog/whats-new-for-civil-design-in-bricscad-v21/grading-2
- https://www.youtube.com/watch?v=9slBsZhlFgk
- https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/bricscad-system-requirements
- https://help.bricsys.com/en-us/document/bricscad/installation-and-licensing/installing-bricscad/minimum-system-requirements-and-recommendations
- https://bricscad.octave.com/bricscad/features/ai-driven-tools
- https://draftingbench.com/bricscad-v26-review/
- https://bricscad.octave.com/blog/machine-learning-and-cad
- https://novedge.com/blogs/news/artificial-intelligence-in-bricscad-bim-enhance-your-bim-workflows-with-six-key-design-phase-processes
- https://zentekconsultants.net/bricscad-bim/
- https://bricscad.octave.com/blog/artificial-intelligence-in-bim-and-renovation


## Update after the fact-check and a later search (2026-10-21)

- Bricsys now trades as Octave (a Hexagon spin-off); the product pages live at bricscad.octave.com with bricsys.com mirrors.
- BricsCAD V27 launched with a keynote on 20 October 2026 (release notes build 27.1.05): Dynamic Input at the cursor, Quad marking-menu gestures, an AI chat panel for documentation, constraints on 2D blocks, dynamic-block library migration, Auto Mapping linework from survey codes, point clouds as mesh objects, Tool Palettes customised from model space. The inventory above describes V26; V27 pricing was not re-checked.
- V26 shipped in October 2025 (press release 26/27 October; trade press 16 October); the cited 'arrives this October' page is the pre-launch teaser.
