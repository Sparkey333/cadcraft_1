# Autodesk Civil 3D: features, pricing, platform

Source: research worker notes `civil3d-features.md` and the JSON summary, 2026-10-21. Status: full = shipping/mature, partial = with named limits, none = absent, unknown = unverified.

## Summary

Civil 3D is the de-facto standard, DWG-native, Windows-only, subscription-only land-development and transportation design suite built on AutoCAD + Map 3D. It covers the full chain (survey DB → surfaces → parcels/COGO → alignments/profiles with criteria-based design and superelevation → assemblies/corridors → grading + Grading Optimization → gravity/pressure pipes with integrated cloud drainage analysis → sections/QTO/mass haul → plan production/sheet sets) with a dynamic object model, country kits, Dynamo/.NET/COM automation and (2027) a Tech-Preview AI assistant. Its weakest areas for a 'Genesis'-style competitor are exactly the owner's goals: AECC objects are never backward compatible (no save-to-previous; proxies; LandXML is the only escape), data shortcuts/xrefs break when files move or permissions differ (Autodesk's 2027/2027.1 'Connected References' fix is gated behind the paid Forma Design Collaboration cloud tier), cloud collaboration is single-editor file-locking via Desktop Connector with unsupported areas, stability complaints are persistent (Autodesk's own 2027 fixed-issues list documents multiple crashes), it needs 32 GB RAM / 8 GB DX12 GPU, and it has no sustainability (solar, rainwater) tooling at all.

## Version

2027.1 (Aug 2026); 2027 (Apr 2026); 2026/2026.1/2026.2 (Apr–Dec 2025). DWG format AutoCAD 2018; AECC object format R2018.2 + versioned drainage objects.

## Platforms

- Windows 11 / Windows 10 (version 17763+), 64-bit x64 only (ARM unsupported)
- No macOS, Linux or web edition (AutoCAD Web cannot edit Civil 3D objects)
- Recommended: 3+ GHz CPU, 32 GB RAM (8 GB basic), 8 GB DirectX 12 GPU (2 GB DX11 basic), ~20 GB SSD; 16 GB+ RAM / 12 GB+ VRAM for point clouds (2025–2027 requirement pages; exact 2027 table unverified)
- Requires Autodesk sign-in + Desktop Connector for cloud, online maps, Assistant and drainage cloud analysis

## Pricing

| Plan | Price | Source |
|---|---|---|
| Civil 3D standalone, annual (named user) | $2,870/yr per Autodesk pages captured by search (older snapshots); product-details page shows 'from $240/month' (annual-equivalent); resellers list 2026/2027 seats at $3,167–$3,175 and consultancies report an early-2026 list increase — current list unverified, likely ~$2,870–$3,175/yr | https://www.autodesk.com/compare/autocad-vs-civil-3d ; https://www.autodesk.com/products/civil-3d/features ; https://www.cdw.com/product/autodesk-civil-3d-2027-new-subscription-annual-1-seat/9123922 |
| Civil 3D standalone, monthly | $360/month (Autodesk compare page, older snapshot; unverified current) | https://www.autodesk.com/compare/autocad-vs-civil-3d |
| Civil 3D standalone, 3-year | $8,610 (3 annual payments; Autodesk compare page, older snapshot; unverified current) | https://www.autodesk.com/compare/autocad-vs-civil-3d |
| AEC Collection (Civil 3D + AutoCAD + Revit + InfraWorks + Navisworks Manage + ReCap Pro + Forma + Vehicle Tracking) | $3,675/yr, $460/month, $11,030/3-year (autodesk.com 2027 page) | https://www.autodesk.com/collections/architecture-engineering-construction/architects |
| Autodesk Flex (pay per day) | Civil 3D = 9 tokens/day (~$27/day at $3/token, <5,000 tokens; tiers to $2.40); minimum pack 33 tokens for $99; tokens expire after 365 days; Grading Optimization & Project Explorer free | https://www.autodesk.com/buying/flex/flex-rate-sheet ; https://adsknews.autodesk.com/en/news/autodesk-for-small-business-update-making-it-more-affordable-to-get-started-with-autodesk-flex/ |
| Education | Free, renewable 1-year single-user licence for verified students/educators (SheerID), non-commercial | https://www.autodesk.com/education/home-ew-edu-home-c |
| Licensing policy | Subscription only: new perpetual licences ended 2016, maintenance plans ended May 7 2021; Forma Data Management Essentials included; Forma Design Collaboration (cloud data shortcuts) is an extra paid subscription (price not captured) | https://www.cgchannel.com/2020/02/autodesk-to-end-maintenance-plans-and-multi-user-subs ; https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-D531E4BF-72BD-4267-8CB0-5F541C237376 |

## Survey & points

| Feature | Status | Notes | Source |
|---|---|---|---|
| Survey database (networks, figures, control, least squares, traverse, mapcheck) | full | Import Survey Data wizard (FBK, point files, drawing points, Survey LandXML); least-squares and traverse adjustment; survey DB not recommended for cloud collaboration | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-00FB26B1-BAB5-4190-B3FB-7FE3624E7F1E |
| Point groups & description keys | full | Wildcard description key sets drive styles/labels/layers; multiple group membership with precedence ordering | https://vdci.edu/learn/civil-3d/understanding-description-keysets-in-civil-3d |
| Field book / data-collector import | partial | FBK is native; Survey Data Collection Link converts raw files but users report it only handles old SurveyPro .job; most export FBK/CSV from Trimble/Leica/Topcon software (forum-sourced) | https://help.autodesk.com/cloudhelp/2023/ENU/Civil3D-UserGuide/files/GUID-4CE27FF4-A9F4-4B4C-9A17-E37564D46313.htm |
| Point clouds | partial | Attach RCP/RCS and Create Surface from Point Cloud with ground filtering/decimation; LAS/LAZ/E57 require ReCap Pro conversion first | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-2F76077A-CA80-481F-B0D3-60BE636EF31C |

## Surfaces

| Feature | Status | Notes | Source |
|---|---|---|---|
| TIN/grid/volume surfaces, breaklines, boundaries, edits, smoothing, crop | full | Composite volume surfaces, Volumes Dashboard, data clip boundaries, partial-surface data references (2026) | https://help.autodesk.com/cloudhelp/2023/ENU/Civil3D-UserGuide/files/GUID-1BFB673D-F667-410A-9400-0FAABEB5951C.htm |
| Contours & analyses (slope, aspect, elevation, watershed, water drop) | full | Watershed analysis splits TIN triangles so every watershed is whole triangles; water-drop paths; legend tables | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-C8D8B7E2-D2E5-460A-ABE7-C4131C85295E |
| LandXML import/export | full | Schemas 1.0/1.1/1.2 for surfaces, points, alignments, profiles, parcels, pipe networks, corridors, feature lines, survey; pressure networks NOT supported; LandXML 2.0 not mentioned | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-C77216E8-09FA-4D63-8182-400E9C2DB0A4 |
| DEM / GIS surface import | full | DEM files, surfaces from GIS datastores, ReCap-exported DEM TIF for lidar; large LandXML imports documented as slow/fatal with mitigation steps | https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Slow-performance-when-importing-LandXML-surface-into-Civil-3D.html |

## Parcels & COGO

| Feature | Status | Notes | Source |
|---|---|---|---|
| Parcel layout tools (slide/swing/free-form, automatic subdivision by area/frontage/depth) | full | Site topology; parcels from closed loops; union/dissolve; dynamic area and segment labels, line/curve tables | https://help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-E57675BB-8D82-4D51-9C43-93B2B680AAED.htm |
| Map check / inverse analysis | full | Export Parcel Analysis and Map Check Report with POB override, across-chord, CW/CCW, error of closure; survey Mapcheck Analysis from labels | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-3D99202F-BDD3-4585-89E1-02DE47ECFD3A |
| Legal description writer | partial | Toolbox General Legal Description and Metes-and-Bounds XSL reports with editable phrasing XML; users call it rigid (POB/direction control) and often use TBC/Carlson/App Store add-ins | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-29D1CA8E-07A6-4A6B-B889-F92FA679DC3F |

## Alignments & profiles

| Feature | Status | Notes | Source |
|---|---|---|---|
| Alignment/profile layout with criteria-based design and design checks | full | XML design criteria files (AASHTO, country kits), min-radius/K tables, violation glyphs; offset/curb-return/rail alignments; station equations | https://help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-E08E8F60-5BF1-4188-8A15-901646DF8F62.htm |
| Superelevation & cant | full | Wizard with roadway types, pivot methods, rate tables or formula, transition tables, overlap resolution, curve manager/tabular editor, superelevation views; rail cant | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-43CA7259-D1EF-46F4-B6B1-F2A7F112446D |
| Horizontal Regression Analysis (best-fit alignment to survey) | full | Added 2026.1, refined 2026.2/2027; 2027 known UI issues (blinking dialog, negative design speed accepted) | https://help.autodesk.com/view/CIV3D/2026/ENU/?guid=GUID-7E28F0FD-EC6A-4E9F-99F7-23A91CA67A81 |

## Assemblies, subassemblies & corridors

| Feature | Status | Notes | Source |
|---|---|---|---|
| Corridor modelling (baselines/regions/targets, surfaces, intersections, roundabouts, solids extraction) | full | Corridor solids with property sets for Navisworks; cannot extract solids from multiple corridors at once; 2027 fixed a corridor-rebuild crash | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-E27B6A11-FC16-42F6-A44D-F82FCE72A58B |
| Subassembly Composer (no-code PKT subassemblies) | full | Installed with product; in 2027 runs on CoreWF because .NET 10 dropped Workflow Foundation — slower first run and stricter VB script compilation may break some PKTs | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-B50CC834-E202-48FE-9C64-526EF9828535 |

## Grading

| Feature | Status | Notes | Source |
|---|---|---|---|
| Feature lines, grading criteria/groups, volumes, infills | full | 2027 lists multiple feature-line crash fixes and faster siteless feature-line edits | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-3104F008-410E-4F4B-B3F4-575184CEC138 |
| Grading Optimization | full | Free extension since 2024, integrated into the 2027 installer; iterative optimizer with pads/ponds/zones/drain lines/ridge lines/pathways, global cut-fill constraint, real-time violation/cut-fill visualization, sends TIN back | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=Grading_Optimization |
| Daylight Feature Line automation | partial | New in 2027 but Tech Preview; generates daylight feature lines from grading criteria by station range/side | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-3104F008-410E-4F4B-B3F4-575184CEC138 |
| Project Explorer (review/validate/report/edit hub) | full | Live tabbed model browser, rule-violation tooltips, multi-part swap & pipe-run slope editor, template reports to PDF/XLSX/DOCX with versioned output history | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-A7576278-F107-4FB5-9011-B98229BA888C |

## Pipe & pressure networks, stormwater

| Feature | Status | Notes | Source |
|---|---|---|---|
| Gravity pipe networks (parts catalog/Part Builder, rules, labels, interference check) | full | Two-network interference check with 3D proximity criteria; 2027 adds arch/elliptical/egg pipes in analysis and connected-stormwater-control labels | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-AF916F22-1219-446F-8C8E-B79C5DD22802 |
| Pressure networks (SQLite catalogs, Content Catalog Editor, Infrastructure Parts Editor) | full | 2027 allows catalogs in Forma Data Management; no LandXML import/export for pressure networks | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-AF1B3D3F-218A-43E1-9612-1ABEEF7A1C73 |
| Integrated drainage analysis (Autodesk Drainage Tools: ponds, underground storage, channels, catchments, Rainfall Manager, cloud InfoDrainage engine) | partial | Installed and 'production-ready' since 2026.2; Rational/Modified Rational/SCS/SBUH/Time-Area/SWMM, IDF sets, FAA/Kirpich Tc (2027); analysis runs on cloud services needing sign-in/entitlement; 2027 known Rainfall Manager crash; replaces discontinued SSA | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-C5E8C716-6C44-4578-B8A4-650363CB4CFE |
| Storm and Sanitary Analysis (SSA) | partial | Autodesk: 'currently discontinued and replaced by Drainage Analysis'; last build 2024.1.1 installs only with Civil 3D/Map 3D 2024/2025; 2027 help still documents STM round-trip for legacy installs | https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Cannot-find-the-download-for-Storm-and-Sanitary-Analysis-for-Civil-3D.html |
| Hydraflow Storm Sewers / Hydrographs / Express (culvert, inlet, channel, weir calculators) | full | Still installed with 2027 under Analyze tab; Express handles circular/box/elliptical/arch culverts and six inlet types; 2027 fixed an outlet-control culvert bug | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-F11FAAD6-F3D3-4FC7-8315-BF8329E5E35B |

## Sections, QTO, mass haul

| Feature | Status | Notes | Source |
|---|---|---|---|
| Sample lines, section views, material lists, volume reports/tables, mass haul diagrams | full | XSL-driven earthwork reports with cut/fill/shrink-swell factors; mass haul with balance line and free-haul/overhaul regions linked to corridor | https://help.autodesk.com/cloudhelp/2024/ENG/Civil3D-UserGuide/files/GUID-3EFD4BEC-EC55-420E-A3FF-D93CD84E0A24.htm |
| QTO Manager (pay items, formulas, takeoff reports) | full | CSV/AASHTO TransXML/FDOT pay-item lists, categorization XML, pay-item formulas, export to Autodesk Takeoff Catalog | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-CEA28211-D1DD-404B-8F4F-02CF32C8BCFB |

## Plan production, labels, styles, templates

| Feature | Status | Notes | Source |
|---|---|---|---|
| View frames, match lines, Create Sheets, Sheet Set Manager | full | Plan/profile, plan-only, profile-only, section sheets; Sheet Set Manager for Web when DST stored in Forma DM (legacy SSM as workaround) | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-E23210B2-8097-407C-A461-ED33DB5857B8 |
| Object/label styles, expressions, reference templates, NCS templates, country kits | full | Country kits are yearly content packs with local styles/criteria/reports; style system is a major learning-curve driver per reviews | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-BEECDB8A-96FC-453B-B1F7-D7C9066F10E6 |

## Data management & referencing

| Feature | Status | Notes | Source |
|---|---|---|---|
| Data shortcuts / data references | partial | Object-level read-only references for surfaces, alignments, profiles, corridors, pipe/pressure networks, view frame groups, ponds; official support articles list many breakage causes (moved/renamed files, permissions, long paths, network drops) and Autodesk advises never moving/renaming referenced files | https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Data-Shortcuts-appear-broken-missing-or-do-not-show-as-expected-in-Civil-3D.html |
| Xrefs & Connected References (2027) / Connected References for Data Shortcuts (2027.1) | partial | Missing-reference view, bulk path update and auto-suggested paths; suggestions only for drawings opened from a Forma Data Management project, and Dref suggestions require Forma Design Collaboration; known gap for Batch-Upload-Tool files | https://help.autodesk.com/view/ACD/2027/ENG/?guid=GUID-15FF3859-96CD-4B6C-AE38-7472F2F9691E |
| Cloud collaboration (Forma Data Management / Autodesk Docs, Desktop Connector) | partial | Essentials tier included; per-file locking (single editor); creating/repairing cloud data shortcuts needs paid Forma Design Collaboration; data-shortcut folder edits are unlocked and 'may be lost'; survey DB, SSM, reference templates flagged as unsupported/needing workarounds | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-150A307C-8206-4B82-8D2C-3C4FF1A7608D |
| Vault Professional integration | full | Check-in/out and project references; 2027 side-by-side Vault issue requires Vault 2026.3 | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-31E17435-0D68-4ACE-A4AB-4ECCA0B31658 |
| Save to previous version / object enablers / DWG compatibility | partial | AutoCAD 2018 DWG format but AECC objects are not backward compatible: older releases see proxies with all Civil 3D commands disabled; only LandXML export/import or 'Export Civil 3D Drawing' (flatten) work; version-matched Object Enabler gives view/query only | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-FA18FB87-C55B-4E1B-BA56-C4CD879C958B |
| Drawing size & performance hygiene | partial | No official limit; users treat >50 MB drawings as problematic; RegApp/DGN-linetype bloat; AutoCAD 2026 claims up to 11x faster file open / 4x faster start | https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-repair-data-shortcuts-to-slow/td-p/9408224 |

## GIS & coordinate systems

| Feature | Status | Notes | Source |
|---|---|---|---|
| Map 3D toolset (FDO connect, MAPIMPORT/MAPEXPORT, coordinate systems, object data) | full | SHP/SDF/SQLite/Oracle/PostGIS/SQL Server/WFS/WMS/geodatabase; thousands of EPSG systems; MAPCSASSIGN; KML export new in Map 3D 2027 | https://help.autodesk.com/view/MAP/2027/ENU/?guid=GUID-13879D28-47AA-4A8E-A3C5-B069EBD8CA58 |
| Autodesk Connector for ArcGIS | full | Browse ArcGIS Online/Enterprise by area of interest, import as Civil 3D objects or Map features, save back; requires coordinate system present in both Autodesk and Esri libraries; Projection Engine Data needed to avoid datum offsets | https://help.autodesk.com/view/MAP/2027/ENU/?guid=GUID-252F0F09-0708-4B71-BD9B-E8409CBDBE43 |
| Geolocation / online basemaps | partial | Esri basemaps with Autodesk sign-in; Bing imagery availability in 2026 was intermittent per forum reports (final state unverified); MrSID raster support removed in 2027 | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-1777B37B-2DDA-459B-8CDF-AD17B9331C75 |

## Interoperability

| Feature | Status | Notes | Source |
|---|---|---|---|
| InfraWorks (IMX/SQLITE, bridges) | full | Open InfraWorks Model, Export IMX, bridge round-trip; 2027 shows full bridge hierarchy | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-87A1C33C-7171-40D6-BC7D-D3F6288F1AF9 |
| Revit / IFC | full | Shared Reference Point (Civil 3D→Revit only), publish surfaces to Docs; IFC 4.3 Extension (separate download, 2022+) with IFC4/IFC4X3_ADD2 import/export and object mapping; legacy IFCEXPORT handles AutoCAD objects only | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-7FAFA066-E981-4EC3-B074-58A57F7A1D46 |
| DGN, PDF, Navisworks, LandXML | full | DGNIMPORT/EXPORT/ATTACH (V7/V8), PDFIMPORT/PDFATTACH, NWCOUT with corridor-solid property sets, LandXML 1.0–1.2; Bentley OpenRoads exchange reported lossy | https://help.autodesk.com/view/ACD/2027/PTB/?guid=GUID-81A5EE76-39A7-40A4-A5C5-E4921C03B33A |

## Automation, API & AI

| Feature | Status | Notes | Source |
|---|---|---|---|
| .NET API, COM API (LISP/VBA reachable), ObjectARX | full | 2027 moves to .NET 10 — plug-ins must be recompiled (not binary compatible with 2025/2026); known-issues page documents plug-in loading pitfalls | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-6E3F0681-759A-44CF-9AB5-7718814EDE75 |
| Dynamo for Civil 3D + Dynamo Player | full | Core 3.4.1→3.6.1 (2026.x)→4.0.2 (2027)→4.1.2 (2027.1); PythonNet3 default; 75+ drainage nodes; ML Node Autocomplete | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-FC66011C-0DED-4332-B345-AD299D7D0245 |
| Autodesk Assistant (AI) | partial | 2027 Tech Preview: standards check vs DWS/DWT, natural-language selection, drawing queries, style changes, surface slope analysis, prompt library; 2027.1 adds drainage/profile/section/attribute/layer queries and opens by default; Autodesk warns results may be inaccurate; third-party LLMs inside Autodesk's trust boundary; prompts retained up to 45 days; hands-on reports mixed (unverified) | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-95910002-F1C4-43BB-91B8-C9D660503E25 |

## Stormwater & sustainability ('neo')

| Feature | Status | Notes | Source |
|---|---|---|---|
| Stormwater storage/LID (ponds, underground storage with porosity/voids, infiltration, channels) | full | Covered by Drainage Tools; Rational through SWMM methods | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-3C5F6398-B015-43DC-B00E-9EB8A2F66CA6 |
| Rainwater harvesting / cistern sizing | none | No native tooling found in any 2026/2027 release notes or help | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-ECDDB244-F5B9-4FFF-AF02-86CB951540F4 |
| Solar / irradiance / PV layout | none | Solar, daylight, wind and carbon analyses exist only in Autodesk Forma (building/site massing), not in Civil 3D | https://www.autodesk.com/autodesk-university/class/Early-Design-Wins-How-We-Used-Forma-to-Accelerate-Sustainable-Urban-Planning-2025 |
| Embodied carbon / energy | none | Forma Carbon Insights is a separate AEC Collection component; nothing in Civil 3D | https://www.autodesk.com/collections/architecture-engineering-construction/overview |
| Old-school building techniques (vernacular, dry-stone, rammed earth, keyline/swales) | none | Only generic grading/feature-line/subassembly tools; no specific content | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=GUID-3104F008-410E-4F4B-B3F4-575184CEC138 |

## Platform & requirements

| Feature | Status | Notes | Source |
|---|---|---|---|
| Windows-only desktop; heavy hardware | partial | Win 11 / Win 10 17763+, x64 only; recommended 32 GB RAM and 8 GB DX12 GPU; no Mac/Linux/web; cloud features need sign-in + Desktop Connector | https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/System-requirements-for-Autodesk-Civil-3D-2026.html |
| Stability (never-crash) | partial | 2027 fixed-issues list documents crashes in feature lines, grading, corridors, drainage analysis, NWCOUT, surface shortcuts; 2027.1 forum thread reports splash-screen hangs; reviews cite frequent crashes on large files | https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=civil_3d_fixed_issues_2027 |

## Unique strengths

- Industry-standard breadth: one DWG-native product spans survey DB → surfaces → parcels/COGO → criteria-based alignments/profiles/superelevation → corridors → grading (+ Grading Optimization) → gravity/pressure pipes → integrated cloud drainage analysis → sections/QTO/mass haul → view frames/sheet sets, all dynamically linked so a change propagates everywhere
- Agency fit: DOT and country kits (styles, templates, design criteria XML, reports), AASHTO superelevation tables, NCS layering, pay-item QTO with TransXML/FDOT formats
- Automation depth: .NET and COM APIs (LISP/VBA reachable), Dynamo for Civil 3D with Player and 75+ drainage nodes, Subassembly Composer, Project Explorer template reporting, and (2027) an in-product AI assistant
- Ecosystem: AEC Collection bundles InfraWorks, Revit, Navisworks Manage, ReCap Pro, Vehicle Tracking, Forma; IFC 4.3 extension; Map 3D GIS/FDO and ArcGIS connector built in
- Large user/training base and hiring pool; extensive official help, tutorials, Autodesk University content; G2 reviewers rate it easier to learn than OpenRoads

## Notable weaknesses

- Referencing fragility: data shortcuts and xrefs break when files are moved/renamed, permissions differ, paths are long or Desktop Connector lags; Autodesk's own advice is 'never rename or move referenced files', and the 2027/2027.1 Connected References fix is gated behind the paid Forma Design Collaboration cloud tier
- No backward compatibility for Civil objects: cannot 'save to previous' Civil 3D objects (proxies, commands disabled); LandXML or flattening are the only escape hatches, so firms must pin a release per project
- Stability and performance: Autodesk's 2027 fixed-issues list itself documents many crashes; reviews on Capterra/G2/TrustRadius repeatedly cite crashes, slow large files and point clouds, and the need for a 32 GB / 8 GB-GPU workstation
- Cost and licensing: subscription-only (~$2,870–3,175/yr standalone, $3,675/yr Collection, plus Forma Design Collaboration for cloud shortcuts), yearly list increases, Flex at ~$27/day; perpetual licences gone since 2016
- Cloud collaboration is single-editor file locking via Desktop Connector with explicitly unsupported areas (survey DB, Sheet Set Manager, reference templates) and unlocked data-shortcut folder edits that 'may be lost'
- Churn and gaps: SSA discontinued mid-transition (replacement is cloud-only), MrSID dropped in 2027, every plug-in must be rebuilt for .NET 10, Assistant/daylight tools are Tech Preview with 'results may not be accurate', legal-description writer is rigid, pressure networks have no LandXML path
- Windows-only; no macOS, Linux or web editing; steep learning curve driven by the style/label/settings system
- No sustainability or 'neo' tooling in-product: zero rainwater-harvesting, solar/PV, carbon or vernacular-construction content (those live in Autodesk Forma, a separate product)
