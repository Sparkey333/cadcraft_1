# Autodesk Civil 3D — what users say, best and worst (2024–2026)

Research notes compiled 2026-10-21 for the CADCraft / Civil 3D / BricsCAD Ultimate / "Genesis" comparison.
All facts below carry a URL. Items marked **(unverified)** could not be confirmed against the primary page.
Reviews are paraphrased, never copied at length.

## 0. Method and access limitations (read first)

- Tooling: WebSearch (summarised search results) was the only working channel. Direct page fetches (WebFetch / curl)
  were refused by the sandbox proxy (HTTP 403 CONNECT) for g2.com, capterra.com, trustradius.com, softwareadvice.com,
  getapp.com, forums.autodesk.com, help.autodesk.com and most blogs. So every number below is what the search index
  reported for the page, not a reading of the live page. Treat counts as "as indexed, 2026" with ±small drift.
- **Reddit is not accessible**: the search backend returns `400 ... domains are not accessible to our user agent: ['reddit.com']`
  and no Reddit thread surfaced in ~12 differently phrased queries. r/civil3d, r/civilengineering, r/Surveying and r/cad
  evidence therefore could NOT be collected. Proxies used instead: Autodesk Community (forums.autodesk.com), RPLS.com
  (surveyor forum), AUGI, Capterra/G2/GetApp/Software Advice/TrustRadius reviews, reseller support blogs (IMAGINiT,
  EnvisionCAD, CAD Masters), state DOT Civil 3D knowledge bases (WisDOT, MDT, Caltrans).
- YouTube comment themes: not indexable through this tool; nothing collected. (Jeff Bartels' "Civil Immersion" and
  Christopher Fugitt's "Civil 3D Reminders" did not surface in search; no content from them is cited.)
- Autodesk Ideas board: the "most kudoed" tab page itself could not be loaded; individual ideas and vote counts come from
  indexed snapshots and may be stale.

## 1. Aggregate ratings (as indexed Oct 2026)

| Site | Rating | Count | Sub-scores | URL |
|---|---|---|---|---|
| G2 | 4.4 / 5 | ~300 reviews (one G2 page shows "4.4/5 (390)" — count differs by page; unverified which is current) | Mid-market 44.5% of reviewers; entry price shown $275/mo | https://www.g2.com/products/civil-3d/reviews |
| Capterra | 4.4 / 5 | 39 verified reviews (page "last updated March 13, 2026") | Ease of use 4.0, Customer service 3.7, Features 4.6, Value for money 4.0 | https://www.capterra.com/p/199886/Civil-3D/reviews |
| GetApp (same review pool as Capterra) | 4.4 / 5 | 39 | Ease 4.0, Value 4.0, Features 4.6, Support 3.7, "recommend" 90%, positive reviews 85% | https://www.getapp.com/industries-software/a/civil-3d/ and https://www.getapp.co.uk/reviews/2048876/civil-3d |
| Software Advice (same pool) | 4.4 / 5 | 39 (profile page shows 36 — stale) | — | https://www.softwareadvice.com/construction/civil-3d-profile/reviews/ |
| TrustRadius | 9.5 / 10 (comparison pages show 9.3) | 34 reviews and ratings | — | https://www.trustradius.com/products/autodesk-civil-3d/reviews |
| SaaSworthy (mirrors G2 pool) | 4.5 / 5 | "300 ratings" | — | https://www.saasworthy.com/product/civil-3d/reviews |
| Trustpilot — Autodesk the company (not Civil 3D) | 1.5 / 5 ("Bad"; one snippet shows 1.3) | 171 reviews | Complaints: auto-renewal billing, support chat | https://uk.trustpilot.com/review/autodesk.com |
| Gartner Peer Insights — Autodesk vendor, CAD market | 4.5 Service & Support (small sample) | — | — | https://www.gartner.com/reviews/market/cad-software/vendor/autodesk |

Reading: product review sites rate the *capability* highly (features 4.6) while ease-of-use (4.0), support (3.7) and
value (4.0) lag; the company-level Trustpilot score (1.5) captures the licensing/billing/support anger that product
sites under-weight. G2's AI summary: reviewers praise design power, "many note it can be slow with large files"
(https://www.g2.com/products/civil-3d/reviews).

## 2. PRAISE — grouped by theme

### 2.1 Industry standard / ecosystem
- G2 reviewers call it "the industry standard for producing construction documents", strong in site development and
  utility design; comprehensive toolset for grading, drainage, marking (https://www.g2.com/products/civil-3d/reviews).
- DOT adoption is a patchwork, not a mandate: NMDOT publishes Civil 3D 2025 templates for consultants
  (https://www.dot.nm.gov/?p=8469); ODOT accepts Civil 3D deliverables but supports only MicroStation/GEOPAK
  (https://www.dot.state.oh.us/caddmapping/Pages/autodesk.aspx); Caltrans runs MicroStation and Civil 3D
  (https://dot.ca.gov/programs/design/manual-cadd-users-manual); MaineDOT requires Bentley DGN/OpenRoads
  (https://www.maine.gov/mdot/caddsupport/docs/2024/ElectronicExchangeofCADD2024%20-10-25-24.pdf).
- Capterra: "if you've already used AutoCAD the interface is almost the same" (familiarity) and it works with other
  Autodesk products and third-party apps; extensive documentation (https://www.capterra.com/p/199886/Civil-3D/reviews).

### 2.2 Dynamic model (surfaces, alignments, profiles, corridors)
- G2: surfaces/profiles/proposed grading "definitely speeds up the process compared to the old way by hand"; corridor
  creation "particularly powerful ... dynamic nature" (https://www.g2.com/products/civil-3d/reviews).
- Capterra: handles "vast amounts of data" and does topography and roads "better than any other software"; praised
  plan views and road-profile drawing; a July-2026 construction reviewer calls it essential for bridging field survey
  data and earthwork models despite the learning curve (https://www.capterra.com/p/199886/Civil-3D/reviews).
- TrustRadius 10/10 reviewer: "very intuitive and easy to pick up" (minority view)
  (https://www.trustradius.com/products/autodesk-civil-3d/reviews).
- RPLS surveyor: the Survey Database for linework and surfaces "is what it does best"; traverse editor as fast as
  other methods (https://rpls.com/forums/software-cad-mapping/civil3d-for-cadastral-drafting/).

### 2.3 Recent performance and feature work (vendor-stated, partly user-confirmed)
- 2025.1: corridor/surface performance; object-snap moves on large corridors "20 to 80 times faster" (vendor claim)
  (https://www.autodesk.com/blogs/aec/2024/08/19/whats-new-in-civil-3d-2025-1/); corridor surface builds 3–4x faster,
  `AeccFastCorridorSurfaceBuild` variable (https://www.symetri.co.uk/insights/blog/whats-new-in-autodesk-civil-3d-2025/);
  MMS surface cache file written only on surface change
  (https://augi.com/articles/detail/autodesk-autocad-civil3d-2025-whats-new-in-civil-3d-2025).
- Dynamo for Civil 3D 2025.1 added 1,120 nodes; earlier 226-node set had pushed people to third-party packages
  (https://dynamobim.org/?p=55568). 2026 added catchment nodes
  (https://www.autodesk.com/blogs/aec/2025/04/02/whats-new-in-civil-3d-2026/).
- 2026: modeless 3D Model Viewer; Project Explorer Object Sets runnable from command line; corridor transition control;
  pressure-network edits; surface/corridor transparency "most well-received feature in 2026" (Autodesk's words)
  (https://www.autodesk.com/blogs/aec/2025/08/14/whats-new-in-civil-3d-2026-1-expanded-features-and-new-drainage-design-and-analysis-workflows/,
  https://resources.imaginit.com/civil-solutions-blog/new-in-civil-3d-2026-smarter-tools-for-smoother-workflows).
- 2026.1/2026.2: InfoDrainage-powered Drainage Analysis (2-year development, tech preview since 2026.0)
  (https://www.autodesk.com/blogs/aec/2025/12/11/whats-new-in-civil-3d-2026-2).
- 2027 (April 2026): daylight feature line to existing surface (grading tech preview) — forum users call the Daylight
  Feature Line tool "impressive" and the main reason to install; feature-line stability fixes (crashes during weed,
  insert intermediate points, undo/redo) (https://btl-blog.com/2026/04/02/autodesk-autocad-2027-and-civil-3d-2027-key-updates-explained/,
  https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).
- Some users explicitly report stability: "2024 and 2025 were perfectly stable"; "haven't had any issues with 2027"
  (https://forums.autodesk.com/t5/civil-3d-forum/why-civil-3d-is-poor-software-aimed-only-at-autodesk-profits/td-p/12894406,
  https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).

### 2.4 Community
- The Autodesk forum community (and LISP ecosystem) is repeatedly cited as what keeps the product usable
  (https://forums.autodesk.com/t5/civil-3d-forum/why-civil-3d-is-poor-software-aimed-only-at-autodesk-profits/td-p/12894406).

## 3. COMPLAINTS — grouped by theme, with severity

Severity scale: **HIGH** = loses work / blocks delivery / drives switching; **MED** = daily friction, workaround exists;
**LOW** = annoyance.

### 3.1 Crashes, fatal errors, stability — HIGH
- Capterra (Jan 2025, NZ CAD draftsman at 10k+ firm): "buggy and can often crash without warning"; another: indispensable
  but "a lot of legacy bugs that cause issues and crashes often"; another: crashes "even with files of smaller sizes"
  (https://www.capterra.com/p/199886/Civil-3D/reviews).
- G2: "sometimes it crashes when too many files are open, and there are times when files do not save"; G2's 2026 roundup:
  reviewers "frequently flag instability when working with large or complex model files"
  (https://www.g2.com/products/civil-3d/reviews, https://learn.g2.com/best-civil-engineering-design-software).
- Civil 3D 2026 thread "Civil 3D 2026 Crashing": one user "crashes on me at least once a week"; another calls 2026 "the
  most unstable release of an AutoCAD based product since AutoCAD R13"; another: several crashes daily, no pattern;
  counter-voice: "no more crashes than previous version". Workaround reported: set `GFXDX12` 1→0
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2026-crashing/td-p/14083638).
- Specific 2025–2026 crash classes documented by Autodesk/forums:
  - Toolspace crash caused by Leica Cyclone 3DR 2025.1.0 add-in (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2026-crashes-when-opening-toolspace/td-p/13603491)
  - "Unhandled exception" after installing AutoCAD MEP 2026 — shared AEC components not all updated to .NET 10; reset tool helps only temporarily (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2026-keeps-getting-unhandled-exception-at-address/m-p/14254439)
  - Drawings that crash on Open but open under RECOVER (paper-space entities/text/viewports) (https://forums.autodesk.com/t5/civil-3d-forum/c3d-2026-crash-on-drawings-when-i-open-vs-recover/td-p/13914898)
  - AutoCAD 2026.1.2 crash saving drawings containing Civil 3D styles — fixed by 2026.2.2 object enabler, Autodesk acknowledged (https://forums.autodesk.com/t5/autocad-forum/crash-in-autocad-2026-1-2-saving-drawings-containing-civil3d/td-p/14230627)
  - 2025 Coordinate Transformation tool fatal error (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Crash-with-CER-on-using-Coordinate-Transformation-tool-in-Civil-3D-2025.html)
  - Pressure-network "Unhandled Access Violation" on fitting properties / swap parts (corrupt fittings, migrated catalogs) (https://resources.imaginit.com/civil-3d/unhandled-access-violation-reading-0xxxxxx-often-occurs-with-pressure-networks)
  - Plant 3D 2025 Object Enabler conflict → e0434352h exceptions (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2025-crashing-with-quot-unhandled-e0434352h-exception/td-p/14110572)
  - 2025 closes abruptly without error (graphics drivers suspected) (https://forums.autodesk.com/t5/civil-3d-forum/2025-closes-abrutly/td-p/12818678)
  - Startup crashes from mismatched VC++/.NET runtimes after Windows Update (https://resources.imaginit.com/support-blog/fix-civil-3d-startup-crashes-by-verifying-required-vc-and-net-runtimes)
  - Data shortcut creation crash (FATAL ERROR e06d7363h) in 2023, fixed only by upgrading (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-crashing-when-i-create-a-data-shortcut/td-p/12376371)
  - ACC data-shortcut folder creation crash (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Creating-data-shortcut-folder-in-ACC-crash-Civil-3D.html)
  - Grading-optimization / vehicle-tracking ground-conflict constant crash (https://forums.autodesk.com/t5/vehicle-tracking-forum/constant-crash-when-using-ground-conflict-report/td-p/14173266)
  - Python node launch crash in 2026 Dynamo (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-keep-crashing-whenever-i-launch-python-node-in-c3d-2026/td-p/13935253)
- 2027: hangs on splash after 2027.1 update (https://forums.autodesk.com/t5/civil-3d-forum/issues-with-2027-1-update/td-p/14263099);
  "Save Block As" freeze confirmed by Autodesk as 2027 defect, some users reverted to 2026
  (https://forums.autodesk.com/t5/civil-3d-forum/save-block-as-causes-freeze-and-error-report-civil-3d-2027/td-p/14082804);
  2026 DWG with swept path crashes 2027 on open (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2026-crashing/td-p/14083638).
- Feature-line UNDO making feature lines disappear "with no way to recover" (validated 2020.4/2021.1; 2027 notes claim
  undo/redo fixes) (https://forums.autodesk.com/t5/civil-3d-forum/disappearing-feature-lines/m-p/9652045).
- "Horrible software" (Oct 2023): "one of the top 2 worst softwares that I use ... always rolled out before it's ready";
  a repair wiped customisations; update checker said up-to-date while an update sat on the account page
  (https://forums.autodesk.com/t5/civil-3d-forum/horrible-software/td-p/12301619).
- Takeaway: crashes are the single most repeated negative across every source class; many are add-in/enabler/.NET
  interaction failures, i.e. ecosystem fragility, not just core bugs.

### 3.2 Performance with large surfaces / corridors / big files — HIGH
- Capterra: "resource-heavy ... runs poorly on lower-capacity computers"; "cannot handle large-size files"; large
  point-cloud processing needs a powerful workstation (https://www.capterra.com/p/199886/Civil-3D/reviews).
- GetApp: "large survey files eat up the memory" (https://www.getapp.co.uk/reviews/2048876/civil-3d).
- G2: "quite heavy and sometimes slow, especially with large or complex projects" (https://www.g2.com/products/civil-3d/reviews).
- Forum numbers: 20–30 acre surface, ~20 MB file, feature-line edits 10 s to >5 min
  (https://forums.autodesk.com/t5/civil-3d-forum/how-can-improve-surface-performance/td-p/14119538); corridor edit 18 s
  for event viewer, 25 s with auto-rebuild (https://forums.autodesk.com/t5/civil-3d-forum/why-civil-3d-slow-how-to-make-it-fast/td-p/11243204);
  2.5×2.5 km aerial surface ≈ 6.25 M points (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-very-slow/td-p/10199395).
- Single-threaded: "C3D is only using a single core even though new PCs have 8+ cores"; WHIPTHREAD only threads
  regen/redraw; advice is to buy for single-thread clock
  (https://forums.autodesk.com/t5/civil-3d-forum/multicore-processors-more-2-cores-c3d-peer-support/td-p/13247896,
  https://forums.autodesk.com/t5/civil-3d-ideas/multi-core-support-multi-thread-processing/idi-p/6564295/page/2).
- Autodesk's own performance page lists surface data clips, LOD reduction (2025+), reference-only surfaces, manual
  rebuild, `AeccPurgeAcaNodObjects` (https://help.autodesk.com/view/CIV3D/2026/ENU/?caas=caas%2Fsfdcarticles%2Fsfdcarticles%2FImproving-Civil-3D-performance-s.html).
- Hardware acceleration is inconsistent: one blogger says disabling it removed "80% of my lag" (unverified blog)
  (https://www.sehatdiri.com/2026/07/civil-3d-slow-fix-performance-guide.html — low-quality source).
- Autodesk recommended spec: 32 GB RAM, 8 GB DX12 GPU (https://autodesk.com/civil3d-systemrequirements-2025-enu).
- 2027 users report performance regressions and rolled back to 2026
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).

### 3.3 Data shortcuts (DREF) / references breaking or slow — HIGH
- Autodesk KB: opening a drawing with data references from a network location "takes a long time (sometimes hours)",
  stuck on "synchronizing data shortcuts" (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Opening-drawing-with-Data-Shortcuts-takes-a-long-time-in-Civil-3D.html).
- Sheet files with only DREFs+XREFs taking >20 min to open on 2019.2 vs ~3 min on 2018
  (https://forums.autodesk.com/t5/civil-3d-forum/c3d-2019-2-drawing-files-open-extremely-slow/td-p/8481353).
- "Repair broken reference" hangs; users end-task after 15 min; workaround: open source, save, go back and sync —
  "9 out of 10 times this works and is 100 times faster"
  (https://forums.autodesk.com/t5/civil-3d-forum/repair-broken-reference/td-p/13396490,
  https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-repair-data-shortcuts-to-slow/td-p/9408224).
- "Endlessly synchronising data shortcuts" with multi-baseline corridors over network
  (https://forums.autodesk.com/t5/civil-3d-forum/endlessly-synchronising-data-shortcuts/td-p/11745113).
- Shortcuts stop auto-synchronising with Desktop Connector 16.16 (2025 thread)
  (https://forums.autodesk.com/t5/civil-3d-forum/data-shortcuts-not-synchronizing-automatically-in-civil3d-2024/td-p/14107769).
- Root causes per practitioners: moved/renamed drawings, changed folder structure, long paths, hand-edited XML,
  differently mapped drives (Caltrans uses a DSSYSVAR environment variable to dodge this), copy/paste-in-place silently
  breaking the live link (https://www.civilanarchyden.com/post/civil-3d-datashortcuts-vs-xrefs,
  https://resources.imaginit.com/support-blog/best-practices-for-working-with-drefs-xrefs-and-blocks-in-civil-3d,
  https://dot.ca.gov/-/media/dot-media/programs/design/documents/cadd/caddman-ch3-sect6-a11y.pdf).
- Rule users must memorise: "civil objects and files are NOT renamed or moved after they have been data referenced"
  (WisDOT) (https://c3dkb.dot.wi.gov/Content/c3d/data-mgt/dm-repair-data-ref.htm). VPN: Civil 3D "unresponsive for
  several minutes or more" creating shortcuts (https://c3dkb.dot.wi.gov/Content/c3d/data-mgt/dm-remot-c3d-prjct.htm).
- Surfaces data-shortcut'd default to saving a copy in the consuming drawing → bloat; must set "Reference Only"
  (https://forums.autodesk.com/t5/civil-3d-forum/data-shortcuts-not-resulting-in-reduced-file-size/td-p/9719015).
- Force-sync command `AECCFORCESYNCHRONIZEREFERENCES`; rebuild shortcut if corrupt
  (https://resources.imaginit.com/support-blog/force-data-reference-updates).
- 2025 release notes: DREF sync from Docs sped up by caching source files, "efficiency depends on Desktop Connector
  response and source file size" (https://help.autodesk.com/view/CIV3D/2025/ENU/?guid=Civil3D_ReleaseNotes_2025_Release_Notes_2025_fixed_issues_html).
- Takeaway for Genesis: referencing is path-based, file-copy-fragile, network-latency-bound and repaired by hand.

### 3.4 File bloat, corruption, AUDIT/RECOVER habits — HIGH (data loss) / MED (daily)
- 2025 "URGENT - File size is huge": accidental copy/paste of a corridor as block ballooned 20 MB → 1.6 GB
  (https://forums.autodesk.com/t5/civil-3d-forum/urgent-file-size-is-huge/td-p/13769483).
- RegApps bloat: >100,000 REGAPPS found in one file; -PURGE RegApps halved a 20k-regapp file
  (https://www.dlt.com/blog/2015/06/10/civil_3d_file_size, same 2025 thread above).
- Unexplained growth cured by `AeccPurgeAcaNodObjects` (AECB definitions) in 2020–2022
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2020-21-and-22-file-size-bloating-drawing-only-includes/td-p/11750362);
  Autodesk KB on near-empty drawings with large size (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-has-large-drawing-file-size-which-does-not-contain-any-objects.html).
- Institutional hygiene rituals: MDT's user-maintenance guide prescribes Purge → Audit → Recover, unload unused xrefs
  (https://ftp.mdt.mt.gov/other/webdata/external/esdc/library/Support-Civil3DUserMaintenanceSupport.pdf); WisDOT: check
  for stale .dwl/.dwl2 lock files first, then AUDIT, RECOVER, RECOVERALL
  (https://c3dkb.dot.wi.gov/Content/c3d/fil-sftwr-mgt/fil-sftwr-mgt-fix-dmgd-crpt-dwgs.htm); AUGI: -PURGE RegApps,
  WBLOCK to new file as last resort (https://www.augi.com/articles/detail/civil-3d-file-management).
- AUDIT itself can hang/crash on some drawings (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-Drawing-hangs-up-Especially-upon-running-an-AUDIT.html).
- Crash mid-save → truncated file "no footer, no way to fix", rely on .bak
  (https://forums.augi.com/showthread.php?176841-Unable-to-recover-drawing-quot-Drawing-file-is-not-valid-quot).
- Fatal error on open from corrupt XREFs, Civil objects nested in AutoCAD blocks, back-saved files; first step RECOVER
  (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-crashes-while-opening-a-drawing-file.html).
- Survey database corruption when copied to a share ("disk image is malformed"); DB locked for all others while one
  user edits; NAS/cloud storage unsupported for survey DBs
  (https://forums.autodesk.com/t5/civil-3d-forum/corrupt-c3d-survey-database-quot-disk-image-is-malformed-quot/td-p/12643784,
  https://www.infratechcivil.com/pages/survey-databases,
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-The-survey-database-is-not-readable-You-might-not-have-access-permissions-to-the-file-or-directory.html).

### 3.5 Styles, templates, settings complexity — MED
- Capterra: menus to configure items are "hidden"; G2: "some tools and settings are not very intuitive"; G2 2026
  roundup: meaningful time investment "particularly when configuring project templates, pipe networks, or custom
  standards for the first time" (https://www.capterra.com/p/199886/Civil-3D/reviews, https://learn.g2.com/best-civil-engineering-design-software).
- "Practically everything in Civil 3D is Style based, and dependent on another Civil 3D Object" — makes setup and
  troubleshooting hard (https://www.cadtutor.net/forum/topic/53203-learn-civil-3d-in-1-2-weeks/).
- Template building: "not recommended [from scratch] due to the time investment"; pruning is "a lot of work";
  maintenance is continuous (https://thecadmasters.com/civil-3d-template-development-part-1/,
  https://zentekconsultants.net/building-useable-civil-3d-templates-part-2-basic-cad-settings/,
  https://www.infratechcivil.com/pages/tutorial-civil-3d-creating-templates). No source gives a duration; "takes months"
  is **unverified**.
- 2027 forum: templates from 2026 reported not backward compatible (user claim)
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).
- Call to rebuild: "Autodesk should recreate CIVIL3D and let the creators of Revit design it" — "convoluted", steep
  curve (https://forums.autodesk.com/t5/civil-3d-forum/autodesk-should-recreate-civil3d-and-let-the-creators-of-revit/td-p/11797077).

### 3.6 Learning curve — MED
- Capterra ease-of-use 4.0; "remarkably steep learning curve due to its sheer complexity" (July 2026 reviewer);
  G2: "invest in certified training" is top advice (https://www.capterra.com/p/199886/Civil-3D/reviews, https://www.g2.com/products/civil-3d/reviews).
- Training providers: 2–3 months to fundamentals; three months "unlikely to be enough time to cover all of the many
  tools" (https://vdci.edu/learn/civil-3d/how-long-does-it-take-to-learn-civil-3d, https://vdci.edu/learn/civil-3d/learn-civil-3d-in-three-months).
- ASCE forum: basic drawing in 30–60 min; detailed project development "much more time"; learned mostly from senior
  engineers on live projects (https://collaborate.asce.org/discussion/autocadcivil-3d).

### 3.7 Subscription cost, licence enforcement, billing — MED-HIGH (drives switching)
- Official US list (Autodesk FAQ): $360/month, $2,870/year, $8,610/3-year; Flex from $300 per 100 tokens, Civil 3D
  draws 9 tokens per day of use (https://www.autodesk.com/solutions/aec/civil-3d-subscription-faq,
  https://wiki.licenseware.io/wiki/autodesk-single-user-and-flex/). Reseller/aggregator pages show other figures
  ($275/mo, $2,945/yr, $320 flat) — these conflict; treat $2,870/yr as the one official figure found. **Not confirmed
  as the 2026 price.**
- AEC Collection 2026 list cited as $3,375/named user/yr by licensing consultancies (commercially motivated sources);
  Jan-2026 list increases of 6–9% claimed (https://autodesksaudits.com/blog/autodesk-aec-collection-guide/,
  https://autodesksaudits.com/blog/autodesk-price-increase-history/) — **unverified against Autodesk**.
- Capterra: one reviewer rated value 1.0/5 for the price; G2 pricing page: price vs plain AutoCAD and prohibitive for
  individuals/students (https://www.capterra.com/p/199886/Civil-3D/reviews, https://www.g2.com/products/civil-3d/pricing).
- No perpetual licences: previous-version rights end when subscription ends
  (https://forums.autodesk.com/t5/civil-3d-forum/perpetual-licenses-vs-subscription/td-p/7173322,
  https://forums.autodesk.com/t5/installation-licensing-forum/perpetual-license/td-p/10139823).
- Network (multi-user) licences retired (dates in sources conflict: 2021 / Feb 2023 / Feb 2024; education network
  licences end 25 Mar 2026); 2-for-1 trade-in; Flex "negatively impacts occasional users", idle sessions burn tokens
  (https://wiki.licenseware.io/wiki/autodesk-named-user-transition/, https://www.openlm.com/blog/autodesk-flex-is-it-the-right-solution-for-you/).
- Surveyors: "3 seats of Carlson IntelliCAD for the price of a single seat of C3d"; one moved to BricsCAD after 20+
  years of AutoCAD over the pricing model (https://rpls.com/forums/software-cad-mapping/surveying-software/,
  https://rpls.com/forums/strictly-surveying/buy-older-version-of-civil-3d/).
- Company-level: Trustpilot 1.5/5 — auto-renewal charges (one user billed for a 3-year renewal), unhelpful chat
  support (https://uk.trustpilot.com/review/autodesk.com). Expired subscriptions cannot be restarted
  (https://www.autodesk.com/support/account/manage/billing/cancel).
- Licence audits: Autodesk License Compliance / BSA letters; "more licences installed than owned" is the common
  finding (https://www.autodesk.com/ca-en/genuine/audits, https://scottandscottllp.com/practice-areas/software-disputes/autodesk-software-audits/).
- Sentiment thread: "why civil 3d is poor software aimed only at autodesk profits" — little competition means little
  incentive to fix long-standing issues; "slow operation ... millions of errors and bugs"
  (https://forums.autodesk.com/t5/civil-3d-forum/why-civil-3d-is-poor-software-aimed-only-at-autodesk-profits/td-p/12894406).

### 3.8 Version incompatibility (no save-back; proxy objects; enablers) — MED-HIGH
- Official: AECC objects in each release "are not backward compatible"; older releases show proxies and disable all
  Civil 3D commands; only path is LandXML export/import
  (https://help.autodesk.com/cloudhelp/2026/ENU/Civil3D-UserGuide/files/GUID-FA18FB87-C55B-4E1B-BA56-C4CD879C958B.htm).
- "This drawing contains newer versions of objects" — view/print only, cannot save
  (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Error-This-drawing-contains-newer-versions-of-objects-when-opening-in-Civil-3D.html).
- Object enabler is version-locked; AC650_R2 proxy warnings persist in AutoCAD 2026.1.1 even with the 2026 enabler
  (https://forums.autodesk.com/t5/autocad-forum/persistent-ac650-r2-proxy-objects-in-autocad-2026-1-1-despite/td-p/13956981);
  stripping intelligence via AECTOACAD / EXPORTC3DDRAWING is the fallback.
- Mixed-version teams silently damage files (opens fine, objects proxied) (https://btl-blog.com/2026/02/01/autodesk-civil-3d-version-mismatch-can-cause-serious-issues/).
- Extensions/country kits/state kits lag each release (SHP utility had no 2027 at launch)
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242,
  https://forums.autodesk.com/t5/civil-3d-forum/what-about-autodesk-civil-3d-2027-country-kits/td-p/14078592).
- 2027 dropped MrSID raster support ("security"), filed under "enhancements", "deal breaker for many of us", users
  rolled back (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-no-mrsid-support/td-p/14076807,
  https://forums.autodesk.com/t5/civil-3d-forum/mr-sid-no-longer-supported-with-2027/td-p/14079790,
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-2027-MrSID-files-are-not-supported-in-Civil-3D-2027.html).
- 2026.2 removed Sheet Set Manager for Web → no cloud plotting from inside Civil 3D
  (https://forums.autodesk.com/t5/civil-3d-forum/2026-2-connected-sheet-set-manager-no-cloud-plotting/td-p/13977035).

### 3.9 Windows-only — LOW-MED
- Autodesk: "Civil 3D is only available for Windows"; Mac not in product plans; Idea "Civil 3D for Macbook Pro"
  status Future Consideration (Feb 2023); users run Parallels/VMware with "some performance loss"; one would "buy 8
  versions tomorrow" (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-for-mac/td-p/6826148,
  https://forums.autodesk.com/t5/civil-3d-ideas/civil-3d-for-macbook-pro/idi-p/11759117, https://www.parallels.com/apps/autodesk/).

### 3.10 Collaboration: ACC / Autodesk Docs / Desktop Connector / Vault — MED-HIGH
- Desktop Connector 16.x: stale locks after crash/shutdown, slow sync, duplicates, files not unlocked; Civil 3D freezes
  opening drawings/XREFs (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Locking-and-Syncing-issues-in-Desktop-Connector-v16-x.html,
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Performance-and-accessibility-issues-in-Desktop-Connector.html).
- Data loss: changes "not uploaded to Autodesk Docs and the data is lost" when sync fails (file stuck "Modified")
  (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Losing-data-when-working-with-DWG-files-in-Desktop-Connector.html);
  partial syncs open older versions (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-not-fully-synchronizing-in-Collaboration-for-Civil-3D.html).
- Files on ACC "keep locking themselves" (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-files-on-acc-keep-locking-themselves/td-p/12972908);
  "Drawing file is write protected" works in 2025, not 2026 (vendor blog diagnosis)
  (https://resources.imaginit.com/civil-solutions-blog/fixing-civil-3d-drawing-file-is-write-protected).
- Collaboration for Civil 3D needs the Pro tier (now "Forma Design Collaboration"), not base BIM Collaborate
  (https://www.manandmachine.co.uk/autodesk-bim-collaborate-vs-bim-collaborate-pro/,
  https://www.autodesk.com/products/forma-design-collaboration/overview). Repeated renames (BIM 360 → ACC → Forma)
  make users cautious about upgrading (2025 thread above).
- Vault: shared surfaces missing after first check-in; bloated/corrupt files slow check-in/out (older)
  (https://forums.autodesk.com/t5/Vault-General/Vault-and-Civil-3D-Data-Shortcuts/m-p/3379803,
  https://augi.com/articles/detail/loading-a-civil-3d-project-to-autodesk-vault).

### 3.11 Labels and annotation quirks — MED-LOW
- Labels "disappear completely", stop updating, reappear only temporarily after zoom/regen; causes: display cache
  desync, viewport annotation-scale mismatch, AECCVIEWPORTOPT; fixes REGENALL/AUDIT/RECOVERALL
  (https://resources.imaginit.com/support-blog/civil-3d-labels-randomly-disappear).
- Dragged labels shift/disappear after regen; "most label issues are caused by overrides and drag states"
  (https://resources.imaginit.com/support-blog/fixing-civil-3d-labels-that-randomly-move-or-disappear-2).
- Corridor labels don't update after rebuild until REGEN (2024 Idea)
  (https://forums.autodesk.com/t5/civil-3d-ideas/idb-p/civil-3d-ideas-en/label-name/production%20drafting/tab/most-kudoed/page/31 — indexed snippet, unverified).
- "Always computed" labels confuse CAD users; multi-line label formatting is where people struggle most
  (https://cadpilot.com/home/jump-on-c3d/jump-on-c3d/2020/12/01/label-style-structure-in-civil-3d/).
- Pressure appurtenances ignore plot style/colour in profile views, defect ≥12 months
  (https://forums.autodesk.com/t5/civil-3d-forum/c3d-2026-defect-appurtenances-ignore-plot-style-and-color/td-p/13706026).

### 3.12 Pipe networks / pressure networks — MED
- Pipe Runs: broken connectivity after trim/extend, structures misalign, profiles fail to update; keep networks small
  (Dec 2025) (https://resources.imaginit.com/support-blog/title-best-practices-for-using-pipe-runs-in-civil-3d).
- Pipe runs can't do vertical bends; every pipe run needs an alignment (tedious)
  (https://forums.autodesk.com/t5/civil-3d-forum/what-s-new-in-civil-3d-2025/td-p/12685535,
  https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2022-pressure-networks/td-p/11880508).
- "Pressure Pipes--impractical, or what am I missing?"; instructor abandoned pressure networks after "so many
  glitches, crashes and workarounds" (https://forums.autodesk.com/t5/civil-3d-forum/pressure-pipes-impractical-or-what-am-i-missing/td-p/10073869).
- Pipe runs delete themselves, fatal error creating sheets (https://forums.autodesk.com/t5/civil-3d-forum/pressure-pipe-pipe-run-issues-pipe-runs-delete-themselves-fatal/td-p/9683295).
- Fittings/appurtenances vanish from plan/profile after a crash (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Fittings-and-pressure-network-parts-disappearing-from-plan-or-profile-view-in-Civil-3D.html).
- Default parts inconsistent after reloading parts list; inverts default to −0.33 ft despite rules (MDT state kit, Feb 2025)
  (https://www.mdt.mt.gov/other/webdata/external/CADDResources/StateKit/Updates_C3DStateKit_Open.pdf).
- Bulk part swap was only one-at-a-time for years (WisDOT wrote its own command; Project Explorer now does it)
  (https://ftp.mdt.mt.gov/other/webdata/external/esdc/library/MDTSKYT-SwapNetworkParts.pdf,
  https://forums.autodesk.com/t5/civil-3d-ideas/swap-multiple-parts/idi-p/8143241).
- "Pipe network nightmare" thread (https://forums.autodesk.com/t5/civil-3d-forum/pipe-network-nightmare/m-p/13606517).

### 3.13 Grading — MED
- "Frustration Grading with Feature Lines": surface would not generate over 4 of 9 infill areas
  (https://forums.autodesk.com/t5/civil-3d-forum/frustration-grading-with-feature-lines/td-p/11610337).
- Feature-line-to-surface grading empty / wrong side / inaccurate on curves; 3D polyline sometimes works where feature
  line doesn't (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Grading-from-feature-line-to-surface-does-not-work.html).
- Grading Optimization (2026) won't raise ridge endpoints; "intended mostly for conceptual grading"
  (https://forums.autodesk.com/t5/civil-3d-forum/grading-optimization-ridge-lines-and-drain-lines/td-p/13750133).
- Feature lines as breaklines sometimes have no effect (IMAGINiT known issue list, cited in search; unverified page).
- 2027's daylight feature line is still a "technology preview" — users ask why
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).

### 3.14 Support quality — MED-LOW
- Capterra customer-service 3.7; one reviewer: online support "shocking" (https://www.capterra.com/p/199886/Civil-3D/reviews).
- "Autodesk technical support (has anyone else found that they suck)": multiple calls, tickets and a forum post to get
  a callback (https://forums.autodesk.com/t5/civil-3d-forum/autodesk-technical-support-has-anyone-else-found-that-they-suck/m-p/7951255).
- Update notification unreliable (see "Horrible software").

### 3.15 Surveyor-specific (RPLS) — MED
- "C3d is good modelling and drafting software, but it is lousy surveying software. Carlson is far better"
  (https://rpls.com/forums/software-cad-mapping/least-squares-adjustment-autocad-civil-3d/); "hated every time they
  used it for any survey work" (https://rpls.com/forums/software-cad-mapping/does-civil-3d-provide-value-to-the-typical-surveyor/);
  sluggish, twitchy graphics; survey DB and smart objects "add complexity without much return"; "Autodesk cares
  nothing about Surveying" (https://rpls.com/forums/software-cad-mapping/carlson-survey-and-civil-3d-compatability/).

### 3.16 AI features (2027) — LOW (but telling)
- Autodesk Assistant tech preview: slope-analysis/zoom-to prompts didn't reproduce the demo; verifying results costs
  more time than doing it by hand; IMAGINiT hands-on found inconsistent object counts between identical runs
  (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242,
  https://resources.imaginit.com/civil-3d/autodesk-assistant-tech-preview-tips-and-tricks).
- Users would rather have long-standing bugs fixed: "Autodesk spends more effort on rebranding than on fixing".

## 4. What users want (Ideas board, forum, AUGI history)

Ideas board status counts (indexed snapshot, date unclear): ~3,731–3,750 "Gathering Support", 141 Implemented,
91 Accepted, 27 Future Consideration (https://forums.autodesk.com/t5/civil-3d-ideas/idb-p/civil-3d-ideas-en).
A forum user claims only 6–7 of the top-20 most-voted ideas are implemented after 10+ years and some "implemented"
ones don't do what was asked (user claim, unverified) (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2027-will-it-actually-be-worth-the-install-hassle/td-p/14076242).
Autodesk: votes are "one factor"; roadmap is a plan not a promise (https://www.autodesk.com/blogs/aec/autodesk-civil-infrastructure-public-roadmap/,
https://www.autodesk.com/blogs/aec/2023/06/08/help-shape-autodesk-aec-roadmaps/).

Top wishes (ranked by how often/strongly they recur across sources; vote counts where indexed):
1. Stability first — ship when ready; fix decade-old bugs before AI/cloud/rebrands (forums, Capterra).
2. Multi-core / multi-threaded processing for all operations (Idea "Multi-Core Support | Multi-Thread Processing";
   count not indexed) (https://forums.autodesk.com/t5/civil-3d-ideas/multi-core-support-multi-thread-processing/idi-p/6564295/page/2).
3. Skewed corridor sections/regions (Idea, 124 votes, 22 comments; still unimplemented, "on the list for a decade")
   (https://forums.autodesk.com/t5/civil-3d-ideas/skewed-corridor-sections/idi-p/6658484).
4. Data references that are fast, resilient to moves/renames/copies, and work over VPN/cloud without hour-long syncs.
5. Save-back / cross-version interoperability for Civil 3D objects (no Idea found; official answer is LandXML).
6. Lighter files: automatic purge of RegApps/AECB NOD bloat; reference-only surfaces by default.
7. Grading: production-ready (not "tech preview") daylighting, reliable feature-line-to-surface, optimizer that honours ridge/drain lines.
8. Pipes: vertical bends in pipe runs, pipe runs without alignments, bulk edits, stable pressure networks, fittings
   that don't vanish; pressure piping was AUGI's #1 wish back in 2011 (https://www.augi.com/articles/detail/augi-presents-wish-list-2011-to-autodesk).
9. Labels that don't disappear / move; corridor labels auto-update; plan-view corridor labels (Idea 21 votes), cross-slope labels (20 votes).
10. Mac (Idea, Future Consideration) / cross-platform.
11. Perpetual or fairer licensing; keep network licences; cheaper seats for small firms, individuals, students.
12. Timely extensions, country/state kits and object enablers at release; don't remove formats (MrSID) without alternatives.
13. Expose Civil 3D object data in AutoCAD Fields; OSNAP that works on all Civil 3D objects (AUGI 2011–2013 lists)
    (https://augi.com/articles/detail/2013-augi-top-ten-wish-list-results).
14. Work-area boundary tool; reverse surface colour scheme; feature-line "used by" tooltip (small Ideas, 2–few votes).

## 5. Implications for Genesis (the parent document's #4) — derived, not sourced

- "Zero crashes" is the headline differentiator users are asking for; the crash classes above are mostly add-in,
  enabler, runtime and corrupt-object interactions → sandbox plug-ins, validate on load, never trust stored objects.
- Referencing: replace path-string references with content-addressed / ID-based links that survive move, rename,
  copy and sync; make "reference-only" the default; make sync incremental and local-first (no VPN stalls).
- Containment: a project should be one movable folder (or single container) with relative, self-healing links;
  copy = deep-copy with link rewrite, never silent divergence.
- Files: no RegApp/NOD bloat by construction; deterministic save; crash-safe atomic writes (no truncated DWGs).
- Versioning: stable, documented object schema with forward/backward readers so "save to older version" exists.
- Simplicity: fewer, explicit styles; labels that are visibly computed; no hidden settings dialogs.
- Licensing: perpetual or transparent; no auto-renew traps; cross-platform (Windows/mac/Linux/web).
