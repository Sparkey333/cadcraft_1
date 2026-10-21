# Market and stability landscape — notes for positioning "Genesis"

Compiled 2026-10-21 for the CADCraft / Civil 3D / BricsCAD Ultimate / Genesis comparison.
Part A = market and pricing (who buys, what they pay, how open-source vendors earn).
Part B = stability and referencing pain across CAD products, what vendors do about it, what still goes wrong.
Every non-obvious fact carries a URL. Items marked **(unverified)** are from memory or from a secondary
source that could not be opened; treat them as leads, not facts.

## 0. Method and access limitations (read first)

- The shared WebSearch budget for this run was exhausted after 12 searches (the limit is shared by every worker in
  the job), so most of the planned ~40 searches did not run. WebFetch failed on DNS for every host, and direct
  fetches were refused by the sandbox proxy (HTTP 403 CONNECT) for autodesk.com, bricsys.com, qcad.org, bls.gov,
  wikipedia.org, g2.com, capterra.com and others. Reddit is not reachable at all.
- What did work: (1) the 12 search results (summaries with URLs), (2) the official Autodesk Product Help MCP tool,
  which returns full text of Autodesk knowledge-base articles and product documentation (used for Part B), and
  (3) the sibling workers' notes already in this scratchpad (`civil3d-reviews.md`, `cadcraft-referencing.md`),
  whose URLs are reused here with the marker **(via sibling notes)** when I did not re-open the page myself.
- Consequences: BricsCAD crash threads, Bentley/Vectorworks/Carlson stability complaints, G2/Capterra review
  text, BLS employment counts, and the FreeCAD/QCAD/Krita/Ardour/Godot funding pages could NOT be opened.
  Those items are given from memory and flagged **(unverified)** with the URL to check.

---

# Part A — Market

## A1. Market size (civil / infrastructure design software)

Analyst numbers disagree by ~60% and none isolates "site design CAD for small firms"; use them as order-of-magnitude.

| Source | Base | Forecast | CAGR | URL |
|---|---|---|---|---|
| Report Prime | USD 2.30 B (2025) | USD 3.78 B (2032) | 7.35% | https://www.reportprime.com/civil-engineering-design-software-r11594 |
| Credence Research | USD 2.24 B (2024) | to 2032 | ~7.4% | https://www.credenceresearch.com/report/civil-engineering-design-software-market |
| Market Reports World | USD 3.71 B (2025) | to 2034 | 7.0% | https://www.marketreportsworld.com/market-reports/civil-engineering-design-software-market-14723150 |
| Spherical Insights (whole construction design software incl. BIM/CAD/FEA) | USD 10.15 B (2025) | 2026–2035 | 6.1% | https://www.sphericalinsights.com/reports/construction-design-software-market |

Reading: a ~USD 2–4 B/yr civil-design-software market growing ~7%/yr, with Asia-Pacific expected to be the largest
region (Report Prime). Drivers cited: infrastructure spending and BIM adoption. These are paid reports; the public
pages are marketing summaries and the Report Prime page is internally inconsistent (two different 2030/2032 numbers).

Vendor scale for context **(unverified, from memory; check investor pages)**: Autodesk FY2026 revenue ≈ USD 6.9 B
with AEC the largest segment (https://investors.autodesk.com); Bentley Systems 2025 revenue ≈ USD 1.4–1.5 B, ~90%
subscription (https://investors.bentley.com); Bricsys is a Hexagon company and does not publish revenue.

## A2. Who buys, and what they are sensitive to

Segments (qualitative; counts are **unverified, from memory** — verify at https://www.bls.gov/oes/):
- **Small civil / site-design firms (1–50 staff)**: the core Civil 3D and BricsCAD buyer. US BLS OES lists roughly
  340k civil engineers and ~100k architectural/civil drafters **(unverified)**; most work in "architectural,
  engineering and related services" firms, which are predominantly small. Pain: per-seat subscription cost,
  licence audits, data-shortcut/xref breakage between offices, crashes on deadline (see Part B).
- **Surveyors**: ~45k US surveyors **(unverified)**; buy Carlson Survey, Trimble Business Center, Civil 3D (often
  reluctantly: "lousy surveying software", RPLS forum, https://rpls.com/forums/software-cad-mapping/least-squares-adjustment-autocad-civil-3d/ **(via sibling notes)**).
  Value perpetual licences and field-to-finish; "3 seats of Carlson IntelliCAD for the price of a single seat of C3d"
  (https://rpls.com/forums/software-cad-mapping/surveying-software/ **(via sibling notes)**).
- **Landscape architects / designers**: ~18k US **(unverified)**; buy Vectorworks Landmark, Land F/X on AutoCAD,
  SketchUp; price-sensitive, Mac-heavy.
- **Owner-builders, homesteaders, permaculture designers**: no analyst covers them; they use SketchUp Free/Go,
  QCAD/LibreCAD/FreeCAD, QGIS, Google Earth and spreadsheets (see `opensource-reviews.md` from the sibling worker).
  Willingness to pay is near zero for software but non-zero for outcomes (a stamped plan, a permit set, a cut/fill
  number) — this is the segment where a free, crash-proof, data-connected tool has no incumbent.
- **Municipalities / DOTs / utilities**: standardise on Civil 3D or Bentley OpenRoads/MicroStation (state DOT CADD
  manuals, e.g. MaineDOT requires DGN/OpenRoads; Caltrans runs both; NMDOT publishes Civil 3D 2025 templates —
  https://www.maine.gov/mdot/caddsupport/docs/2024/ElectronicExchangeofCADD2024%20-10-25-24.pdf,
  https://dot.ca.gov/programs/design/manual-cadd-users-manual, https://www.dot.nm.gov/?p=8469 **(via sibling notes)**).
  They buy on deliverable-format compliance, not price; an open tool wins here only by writing their formats
  (DWG/DGN/LandXML) faithfully.

## A3. Price points (USD, list, as found 2026-10-21)

| Product | Price | Licence | Source / notes |
|---|---|---|---|
| Autodesk Civil 3D | $360/mo; $2,870/yr; $8,610/3-yr | subscription only (no perpetual since 2016) | https://www.autodesk.com/solutions/aec/civil-3d-subscription-faq (page undated; reseller CDW lists 2027 annual at $3,174.99: https://www.cdw.com/product/autodesk-civil-3d-2027-new-subscription-annual-1-seat/9123922) |
| Autodesk Flex | $300 per 100 tokens; Civil 3D ≈ 9 tokens/day | pay-per-day | FAQ above; token rate via https://wiki.licenseware.io/wiki/autodesk-single-user-and-flex/ **(via sibling notes)**; Autodesk's own guidance says Flex suits occasional use and "do not rely on sample token amounts" (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Use-Flex-tokens-with-an-Autodesk-subscription.html) |
| Autodesk AEC Collection | ≈ $3,375/yr | subscription | licensing-consultancy figure, **unverified** (https://autodesksaudits.com/blog/autodesk-aec-collection-guide/ **(via sibling notes)**); includes Civil 3D, AutoCAD, Revit, InfraWorks |
| Autodesk Forma | Forma Data Management ≈ $45/mo annual ($540/yr); Design Collaboration ≈ $78/mo ($936/yr); Forma Build from ≈ $117/mo | subscription | third-party guide dated June 2026 (https://www.thepricer.org/how-much-does-bim-360-cost/); Autodesk's buy page renders placeholders (https://www.autodesk.com/products/forma-for-buildings/buy). Site-design Forma is bundled with AEC Collection **(unverified)** |
| BricsCAD Ultimate | USD 1,180 (bricsys.com page as indexed) | perpetual one-time **and/or** annual — the indexed snippet is ambiguous; CDW lists a 1-year subscription at $1,121.99 | https://bricsys.com/ms-my/bricscad/ultimate, https://www.cdw.com/product/bricscad-ultimate-subscription-license-1-year-1-user/7964043 — defer to `bricscad-features.md` for the verified figure; maintenance is an extra annual fee (https://cadsoftwaredirect.com/bricscad-ultimate.html) |
| Carlson Survey | ≈ $2,150 (standalone w/ IntelliCAD); $3,250–3,575 with embedded AutoCAD OEM | perpetual; maintenance ≈ 10% of retail/yr; upgrades never > 50% of retail | reseller FAQ, undated (https://thatcadgirl.com/faq/what-to-know-about-purchasing-carlson-software/) |
| Carlson Civil Suite / Select Suite Pick 4 | ≈ $4,250 | perpetual | same FAQ |
| Bentley OpenSite Designer | from $3,168/yr (Virtuoso 12-month, 1 licence + 2 Keys) | subscription | https://www.bentley.com/en/products/opensite-designer/ (via search) |
| Bentley OpenRoads Designer | $6,057/yr practitioner; perpetual $15,142 | both | G2 listing updated 2026-03-25, third-party (https://g2.com/products/openroads-designer/pricing) |
| 12d Model | quote only ("open price"); UC-win/Road plug-in US$750; subscription ≈ 40% of product price/yr after year 1 | perpetual + subscription, CodeMeter dongle | https://www.forum8.co.jp/ENGLISH/shokai/12d-2-e.htm, https://www.g2.com/products/12d/pricing, https://12dwiki.com.au/category/installing-and-upgrading-12d-model/ |
| Vectorworks Landmark | $1,530/yr; ≈ $170/mo monthly | subscription only for new buyers; perpetual (Service Select) holders being migrated (+8%/yr cap for two years after conversion; +16% year-1 if staying) | https://www.vectorworks.net/start/buy-more-save-more, https://www.vectorworks.net/subscription-switch, https://www.renderahouse.com/blog/vectorworks-pricing |
| SketchUp Pro | $399/yr ($99.99/mo); Studio $819–859/yr; Go $129/yr | subscription only; pricing changed July 2025 | https://www.renderahouse.com/blog/sketchup-pricing, https://www.myarchitectai.com/blog/sketchup-pricing |
| Land F/X | Planting F/X $695/yr; Irrigation F/X $995/yr; F/X CAD $775/yr; Detail F/X $175/yr | subscription since 2023-01-01; needs AutoCAD or F/X CAD | https://www.landfx.com/kb/admin-issues/info/6514-subscription, https://www.landfx.com/frequently-asked-questions.html (official pages disagree: FAQ still shows $575/$875) |
| Trimble Business Center | no public list; reseller perpetual Intermediate dongle $4,734.25, Advanced network $4,405; subscription tiers with 40–80% multi-seat discounts to 2026-10-31 | perpetual + subscription | https://cansel.ca/product/trimble-business-center-intermediate-dongle-license-515801, https://csdsinc.com/product/trimble-business-center-advanced-network-license-500357, https://www.cansel.ca/service-support/warranty-subscription-renewals/tbc-trade-In |

Observations:
- The only *perpetual* options left among the serious civil tools are BricsCAD, Carlson, 12d, Bentley (at ~2.5× the
  annual price) and TBC dongles. Autodesk, Vectorworks, SketchUp and Land F/X are subscription-only. This is the
  single clearest pricing gap: "own your tool" is now a niche that incumbents are abandoning.
- Company-level reputation follows the licence model: Autodesk the company scores 1.5/5 on Trustpilot (171
  reviews; auto-renewal billing and chat support) while Civil 3D the product scores 4.4/5 on G2/Capterra
  (https://uk.trustpilot.com/review/autodesk.com, https://www.g2.com/products/civil-3d/reviews **(via sibling notes)**).
- Yearly list increases (6–9% for Autodesk in Jan 2026 per licensing consultancies, **unverified**) and the removal
  of network licences push small firms toward Flex, which "negatively impacts occasional users" because idle sessions
  burn tokens (https://www.openlm.com/blog/autodesk-flex-is-it-the-right-solution-for-you/ **(via sibling notes)**).

## A4. How open-source and low-cost CAD vendors make money

Sourced:
- **Blender Foundation** (the reference case): FY2024 total income ≈ €3.1 M (from €2.55 M), Development Fund income
  +21%, yet the foundation *operated at a loss* in 2024 and the board warned reserves were below acceptable levels;
  small "Join the 2%" donations rose from 10% to 20% of income; plan: more corporate patrons, more small donors,
  keep a three-month cash buffer (https://www.blender.org/?p=95075, https://cgpress.org/archives/blender-foundation-reports-higher-donations-but-warns-of-low-reserves-in-2024-annual-report.html,
  https://80.lv/articles/blender-reports-operating-at-a-loss-in-2024). Corporate patrons announced 2025–2026:
  Dell €30k/yr, an OctaneRender developer ≥ €240k/yr, Wacom +€210k/yr tied to a tablet partnership, Netflix
  Animation Studios (early 2026) (https://www.cgchannel.com/tag/blender-development-fund/,
  https://cgpress.org/archives/intel-signs-up-as-blender-fund-corporate-patron.html). Corporate Patron tier was
  ≥ €120k/yr in a 2021 post (https://fund.blender.org/about).
  Lesson: even the most successful open-source creative tool, with hundreds of thousands of users, runs on ~€3 M/yr
  and is one bad year from trouble; recurring small donations plus a handful of strategic corporate patrons is the
  model, and hardware/GPU vendors are the natural patrons (for CAD: workstation, GPU, survey-hardware vendors).

From memory **(unverified — verify at the URLs)**:
- **FreeCAD**: the FreeCAD Project Association (FPA, https://fpa.freecad.org) collects donations (Open Collective /
  Liberapay) and pays grants to contributors. The VC-backed commercial attempt **Ondsel** (hosted "Lens" sharing SaaS
  + a curated FreeCAD distribution, founded 2023) announced it was shutting down in December 2024, saying it could
  not reach sustainable revenue in time; its UI/assembly work was upstreamed into FreeCAD 1.0
  (https://ondsel.com/blog/goodbye/). Lesson: a hosted-collaboration layer on top of a free desktop CAD did not
  find paying customers fast enough; the open-source project outlived the company.
- **QCAD** (RibbonSoft): GPL Community Edition free; QCAD Professional sold per major version at roughly €40, QCAD/CAM
  roughly €100, plus paid add-ons and support (https://qcad.org/en/shop). A one-person company sustained for 20+
  years on low-priced perpetual "pro" builds.
- **Krita** (Krita Foundation): identical software sold on Steam / Microsoft Store / Epic as a paid convenience build
  while the website download is free; plus a Development Fund of monthly donors and occasional sponsors; funds a
  handful of full-time developers (https://fund.krita.org).
- **Ardour**: source free; official binaries are pay-what-you-want (USD 1 minimum) or a monthly subscription
  (≈ USD 4–10) that includes updates; the free demo build goes silent after a few minutes
  (https://community.ardour.org/download). A single maintainer plus contributors, funded almost entirely by users.
- **Godot** (Godot Foundation): Development Fund of individual and corporate members (https://fund.godotengine.org)
  plus a separate commercial company, **W4 Games**, selling console ports, cloud services and support. Lesson: keep
  the foundation (engine) and the company (services) legally separate.
- Generic models (well documented, e.g. https://en.wikipedia.org/wiki/Business_models_for_open-source_software):
  support/maintenance contracts (Red Hat-style), hosting/SaaS of the collaboration layer (GitLab, WordPress.com),
  open-core / dual licensing (MySQL, Qt — risky for trust), plug-in / asset marketplaces (Blender Market is
  third-party; Autodesk App Store is first-party), paid training and certification, sponsorship by
  hardware vendors, grants (NGI, Sovereign Tech Fund), and "pro" convenience builds.

What this means for Genesis (see `wishes`): the credible stack is (1) free, perpetual, open desktop app;
(2) paid hosted project container + link-health service (the thing Civil 3D users already pay ACC for and hate);
(3) paid support and training for firms; (4) a plug-in marketplace later; (5) sponsorship from survey-hardware
and GPU vendors. Avoid: dual licensing, feature paywalls in the core, and selling a SaaS *before* the desktop tool
is the one people already use (the Ondsel lesson).

---

# Part B — Stability and referencing pain

## B1. Evidence of crash volume

### Autodesk's own release notes (primary evidence)
Counting entries that say "crash", "hang", "froze", "stop working", "unresponsive" or "stability issue":
- **Civil 3D 2027.1** (single point release, 2026): ≈ 17 such fixes, including: crash adding an offset alignment;
  crash when repairing a Corridor data reference; crash repairing a corridor reference with Data Shortcut Manager;
  Autodesk Assistant Auto Apply crash on double-click; hang during corridor solid updates; hang creating daylight
  feature lines; hang modifying grading fill slope; freeze from PG topology; hang when grading boundary is near a PI;
  crash in pipe-network interference check; crash in "Save Block As"; crash with station tracker; crash changing a
  network-referenced surface; crash on Nearest osnap in profile view; crash importing a large TIFF; Rainfall Manager
  crash. Also: "Data Shortcut XML files could be unexpectedly modified when opening a host drawing, resulting in
  broken references for other users. This fix addresses a known scenario but may not cover all cases."
  (https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=civil_3d_fixed_issues_2027_1)
- **Civil 3D 2027** (cumulative): ≈ 12 crash/freeze fixes (corridor solids, drainage analysis without access,
  feature-line reverse/join, stretch to split point, trim+undo repeatedly, grading freezes, elliptical pipe swap,
  NWCOUT) (https://help.autodesk.com/view/CIV3D/2027/ENU/?guid=civil_3d_fixed_issues_2027)
- **Civil 3D 2026.1**: ≈ 15 stability fixes; notable wording: "Civil3D would stop working at grip editing or moving a
  feature line. To apply the fix, need run audit command first" and "part of surface isn't created from grading
  sometimes, need rebuild grading surface if data is already corrupted" — i.e. fixes that require the user to repair
  already-damaged data (https://help.autodesk.com/view/CIV3D/2026/ENU/?guid=civil_3d_fixed_issues_2026_1)
- **Civil 3D 2026.2**: ≈ 11 stability fixes (COGO editor, Dynamo, grading transitions, Mapcheck on Windows 11,
  export, Subassembly Composer, wall breakline) (https://help.autodesk.com/view/CIV3D/2026/ENU/?guid=civil_3d_fixed_issues_2026_2)
- **Civil 3D 2024.3**: two *data-loss* fixes — "alignment data was lost after saving and reopening a drawing" and
  infinity-radius parsing causing "loss of data after saving and reopening" — plus "Improved stability when
  recovering and repairing drawings" (https://help.autodesk.com/view/CIV3D/2024/ENU/?guid=civil_3d_2024_3_fixed_issues)
Reading: 10–17 crash/hang fixes per point release, every release, for a product in its ~20th year. The crash
surface is concentrated in feature lines/grading, corridors, data references, pipes, and add-ins.

### Autodesk knowledge base: a taxonomy of "FATAL ERROR: Unhandled Access Violation" articles
Each is a separate KB article, which is itself evidence of volume:
- on save (corrupt AEC objects; remedy: export everything to LandXML, re-import, purge, audit — or fall back to the
  .sv$) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-Fatal-Error-on-Save-and-program-crash.html
- on save (second article: RECOVERALL, -PURGE regapps on all xrefs, WBLOCK into a new drawing) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-Fatal-Error-on-Drawing-Save.html
- on save in any AutoCAD vertical when proxy graphics overwhelm memory (set PROXYGRAPHICS 0) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Fatal-error-when-saving-a-drawing-using-SAVE-or-QSAVE.html
- crash on save creating only a .tmp (reinstall VC++ runtimes, WBLOCK) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-crashes-during-saving.html
- on open (corrupt xrefs, Civil objects nested in blocks, back-saved files) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-crashes-while-opening-a-drawing-file.html and https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Fatal-Error-Unhandled-Access-Violation-Reading-Oxffffff-Exception-at-xxxxx-when-opening-drawing-in-Civil-3D.html
- feature lines (grip edit, grading, copy between sites, surface rebuild) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/FATAL-ERROR-Unhandled-Access-Violation-when-grip-editing-feature-lines-in-Civil-3D.html
- inserting a pipe (remedy: reset Civil 3D to defaults) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/FATAL-ERROR-Unhandled-Access-Violation-Reading-when-inserting-pipe-to-a-network-in-Civil-3D.html
- Object Viewer (second monitor scaling, GPU driver) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Crash-when-using-the-object-viewer-in-Civil-3D.html
- Vault auto-login at startup, Vault commands https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Fatal-Error-Unhandled-Access-Violation-when-starting-Civil-3D-with-automatic-login-to-Vault.html
- at launch (profile, plug-ins, clean reinstall) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Fatal-Error-crash-when-launching-Civil-3D-2019.html
Pattern in the remedies: "install updates, reset the user profile, update the GPU driver, uninstall plug-ins,
purge/audit/recover, WBLOCK into a fresh file, reinstall". The product has no internal fault isolation; the user
performs the isolation by hand.

### Forums and reviews (via sibling notes, URLs re-cited)
- "Civil 3D 2026 Crashing": "crashes on me at least once a week"; "the most unstable release of an AutoCAD based
  product since AutoCAD R13"; workaround GFXDX12=0 (https://forums.autodesk.com/t5/civil-3d-forum/civil-3d-2026-crashing/td-p/14083638)
- Capterra: "buggy and can often crash without warning"; crashes "even with files of smaller sizes" (https://www.capterra.com/p/199886/Civil-3D/reviews)
- G2 2026 roundup: reviewers "frequently flag instability when working with large or complex model files" (https://learn.g2.com/best-civil-engineering-design-software)
- AutoCAD 2026.1.2 crashed saving drawings containing Civil 3D styles until the 2026.2.2 object enabler (https://forums.autodesk.com/t5/autocad-forum/crash-in-autocad-2026-1-2-saving-drawings-containing-civil3d/td-p/14230627)
- 2027 "Save Block As" freeze confirmed as a defect; users reverted to 2026 (https://forums.autodesk.com/t5/civil-3d-forum/save-block-as-causes-freeze-and-error-report-civil-3d-2027/td-p/14082804)
- Feature-line UNDO making feature lines disappear "with no way to recover" (https://forums.autodesk.com/t5/civil-3d-forum/disappearing-feature-lines/m-p/9652045)
- Pipe runs delete themselves; fatal error creating sheets (https://forums.autodesk.com/t5/civil-3d-forum/pressure-pipe-pipe-run-issues-pipe-runs-delete-themselves-fatal/td-p/9683295)

### Other products **(not collected this run — unverified)**
- BricsCAD: Bricsys publishes per-build release notes that list crash fixes and runs a public forum
  (https://forum.bricsys.com, https://www.bricsys.com/en-us/release-notes); the sibling `bricscad-reviews.md`
  should hold the actual threads. From memory, common BricsCAD complaints are crashes in specific DWG files from
  AutoCAD verticals (proxy/AEC objects), on Linux/macOS builds lagging Windows, and after major-version upgrades.
- Bentley OpenRoads/MicroStation: crash reports cluster around ProjectWise references and large terrain; Vectorworks:
  crashes on large site models and after yearly upgrades; Carlson: inherits IntelliCAD/AutoCAD OEM stability.
  None of these could be verified this run.

## B2. Referencing pain: data shortcuts, xrefs, paths

### Civil 3D data shortcuts (DREF) — official admissions
- Data shortcuts "appear broken, missing, or do not work as expected" when: the Working Folder is wrong or moved; a
  drawing was moved or renamed; the working folder was renamed/moved; the network folder was unavailable at startup
  or intermittent; files live on a non-Microsoft network; Desktop Connector is out of date; permissions are missing.
  Remedies are manual: re-associate project, Repair Broken References one by one (or Repair All), ManageDataShortcuts,
  remove and recreate, add server paths to Trusted Locations (and WSSETTINGS must be "save" or it reverts).
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Data-Shortcuts-appear-broken-missing-or-do-not-show-as-expected-in-Civil-3D.html
- Each shortcut is an XML file holding the *path* to the source drawing. In BIM 360/ACC/Forma projects "insufficient
  permissions among project members will modify this file every time it is used, truncating or expanding the path as
  it applies to each specific member, making it unavailable for others"; shortcut paths end up pointing at
  `C:\Users\<name>\DC\ACCDocs\...` instead of the project, and `DwgRelPath` can be blank.
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Data-shortcuts-have-a-Broken-Reference-status-in-Civil-3D-prospector-for-a-project-stored-in-BIM-360.html
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/ACC-Docs-Data-Shortcuts-path-to-User-folder-instead-of-Docs-in-Civil-3D.html
- Civil 3D 2027.1 fixed "Data Shortcut XML files could be unexpectedly modified when opening a host drawing, resulting
  in broken references for other users... may not cover all cases" (release notes above).
- Official Docs workflow doc: "Currently, there is no safety mechanism such as locking to ensure that multiple users
  are not modifying data shortcuts concurrently. Changes to the data shortcut folder structure may be lost since they
  are not synced automatically." https://help.autodesk.com/view/CIV3D/2023/ENU/?guid=GUID-150A307C-8206-4B82-8D2C-3C4FF1A7608D
- Surfaces whose references break "each time the drawing is opened" after a project move; workaround is to
  *stop referencing* ("Geometry Stored in Drawing") https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Data-references-to-surface-are-broken-each-time-the-drawing-is-opened-in-Civil-3D.html
- Shortcuts that silently stop synchronising (source must be saved *and closed*; corrupt shortcuts; network) —
  remedy includes copy the drawing, delete the original, repair, AECCFORCESYNCHRONIZEREFERENCES
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-2019-Data-shortcuts-do-not-synchronize-and-the-notification-balloon-synchronize-references-fails-to-show.html
- Duplicate shortcuts of the same name after migration to Forma/ACC; "shortcuts pathed to a particular network may not
  want to re-path to another location. Disconnecting temporarily from a server location can help."
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Duplicate-Dref-s-automatically-created-with-same-name.html
- Opening a drawing with DREFs from a network location "takes a long time (sometimes hours)" (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Opening-drawing-with-Data-Shortcuts-takes-a-long-time-in-Civil-3D.html **(via sibling notes)**);
  "Repair broken reference" hangs 15+ min (https://forums.autodesk.com/t5/civil-3d-forum/repair-broken-reference/td-p/13396490 **(via sibling notes)**);
  institutional rule "objects and files are NOT renamed or moved after they have been data referenced" (WisDOT,
  https://c3dkb.dot.wi.gov/Content/c3d/data-mgt/dm-repair-data-ref.htm **(via sibling notes)**).
- Known issue 2024: Save As to Forma cannot update relative paths if ISAVEPERCENT > 0 (https://help.autodesk.com/view/CIV3D/2024/ENU/?guid=Civil3D_ReleaseNotes_2024_Release_Notes_2024_known_issues_html).
- Shortcut files lock the source with .dwl/.dwl2 while syncing (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/DWL-s-Linger-After-Synchronizing-a-Data-Reference-in-Civil-3D-2020.html).

### AutoCAD xrefs — the path model and its failure modes (official docs)
- Three saved-path types: full, relative, none. Relative "is the most flexible option" but "if the file that is being
  referenced is located on a different local hard drive or on a network server, the relative path option is not
  available"; moving a host drawing means "you must edit any relative paths ... or relocate the referenced files".
  "No path" triggers a search of host folder → support paths → PROJECTNAME paths → shortcut "Start In".
  https://help.autodesk.com/view/ACD/2027/ENU/?guid=GUID-164C2548-91E6-476D-AFDF-6257340C2EE2
- Default path type is now relative (REFPATHTYPE); an unsaved host shows a "pending relative path"
  https://help.autodesk.com/view/ACD/2026/PTB/?guid=GUID-A987D2FF-45BD-474E-99C1-E6316A42F667
- "Relative path cannot be assigned" causes include: host not saved; xref on another drive; mapped drive vs UNC for
  the same share; **"Automatic save setting in AutoCAD is too frequent"** (remedy: raise SAVETIME above 2 minutes or
  turn it off) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/When-trying-to-attach-a-drawing-as-external-reference-with-a-relative-path-the-message-appears-Relative-path-cannot-be-assigned.html
- Unresolved xrefs: moved/renamed/deleted files, permissions, relative path from another system, cloud storage, nested
  parent changed, path > 256 chars, corruption, circular reference, third-party "system care" tools, DNS client / IP
  helper services stopped, drive letter hijacked by a USB device, different drive mappings per user. Remedies: hunt
  the file, Select New Path, copy xrefs beside the host, PROJECTNAME, Reference Manager, avoid NAS/SAN/DFS, exclude
  antivirus scanning. https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/XREF-in-AutoCAD-is-Unresolved.html
- After a server migration, absolute paths break and opening drawings "might take a long time, freeze the program, or
  fail entirely" — advice: unplug the network cable before opening
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/External-reference-xref-is-missing-in-AutoCAD-after-file-server-migration-or-renaming.html
- Reference Manager (stand-alone, not in LT): bulk repath, missing-file report, CSV export — but "changes multiple
  paths at once, and you cannot undo your actions. Use extreme caution" and may resave drawings to a different DWG
  format https://help.autodesk.com/view/ACD/2027/ENU/?guid=GUID-D04C68E3-DCB9-4251-AB96-DC02C90E1573
- Nested xrefs must be detached/repaired in their own parent; xrefs on locked layers or inside blocks won't detach;
  "dummy file with the same name" is an official workaround https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Xref-will-not-detach.html

### Bind and eTransmit (containment tools)
- Bind vs Insert: Bind renames every dependent named object `FLOOR1|WALL` → `FLOOR1$0$WALL` (incrementing $n$ on
  collision); Insert merges by name and the bound object "assumes the properties of the locally defined named
  object" — silent property changes on merge. https://help.autodesk.com/view/ACD/2027/PLK/?guid=GUID-E3039A04-4524-462B-AA27-E5F7DE8C4E9E
  Known bind defects: parcel labels turn to "???" after bind (fixed 2024), profile-view band labels missing after
  xref+bind (fixed 2027) (release notes above).
- eTransmit packages DWG + xrefs + images/PDF/DGN/DWF + CTB/STB/PC3/FMP automatically, but **not** SHX/TTF fonts,
  .pat hatch files, .lin linetypes, .pmp, OLE-linked files, or anything referenced by URL; options to bind, purge,
  down-save, include fonts and data-link files. Path handling: "Use organized folder structure" converts absolute
  paths inside the root to relative, moves outside files up to one level into the root.
  https://help.autodesk.com/view/ACD/2027/PTB/?guid=GUID-C32FA153-88D6-41D9-B868-0DFF59509CD2,
  https://help.autodesk.com/view/ACD/2027/PTB/?guid=GUID-9A2F96E5-34D1-4504-A5F3-54BCD410041D,
  https://help.autodesk.com/view/ACD/2027/ENU/?guid=GUID-DD451786-5D5A-42A5-92D5-943CE9D66016
- eTransmit itself silently omits files (corrupt profile, proxy objects in nested files); for data shortcuts you must
  use the stand-alone Data Shortcut Editor to migrate paths
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Not-all-files-are-included-in-eTransmit-zip-package-in-AutoCAD-LT.html

## B3. DWG corruption and bloat

- Autodesk's list of corruption causes: old drawings reused for years; AutoCAD terminated while saving; outdated
  version; third-party add-ins; DWG written by non-RealDWG products; bad sectors; failing RAM; network anomalies
  (transmission errors, file locking, latent writes); OS issues; power surges
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Recovering-drawing-files-which-fail-to-open-in-AutoCAD.html
- "Drawing file is not valid": transmittal issues, improper conversion, files on cloud sync folders (Dropbox, Google
  Drive, OneDrive), non-Microsoft networks, NAS/SAN, thumb drives, VPN dropped while working, Desktop Connector not
  updated, DWG opened directly from email, encryption. Last resorts: PDFIMPORT the plot, or ask the author again.
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Drawing-file-is-not-valid-error-message.html
- RECOVER can itself fail or stop at 99% (corrupt recovery file, xrefs that are also corrupt); advice: move the file
  somewhere the xref paths won't resolve, DDINSERT into a blank drawing, Partial Open
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/RECOVER-command-will-not-open-file-in-AutoCAD.html
- A drawing can demand recovery *every* time it is opened; remedies escalate to WBLOCK, copy-paste into a blank
  drawing, EXPORTTOAUTOCAD (strips intelligence), save to older format, round-trip through DXF ("the old R12 format can
  disrupt or break newer data objects") https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Drawing-always-prompts-to-recover-when-opened-in-AutoCAD.html
- Bloat: official size-reduction checklist = detach xrefs, OVERKILL, -PURGE Regapps, PURGE all, -SCALELISTEDIT reset,
  delete layer filters, SAVEAS, WBLOCK, split into xrefs, CONVERTPOLY
  https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/how-to-reduce-the-size-of-a-dwg-file-in-autocad.html;
  a drawing stays ~8 MB "even after deleting everything" https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Drawing-DWG-file-size-too-large-relative-after-working-with-AutoCAD-product.html;
  "large number of annotation scales" warning propagating through xrefs https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/AutoCAD-warning-This-drawing-contains-a-large-number-of-annotation-scales.html;
  AEC objects from verticals cannot be purged in plain AutoCAD (PURGEAECDATA / EXPORTTOAUTOCAD) https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Unable-to-purge-some-objects-from-drawing-in-AutoCAD.html
- Field reports **(via sibling notes)**: 20 MB → 1.6 GB after pasting a corridor as a block (https://forums.autodesk.com/t5/civil-3d-forum/urgent-file-size-is-huge/td-p/13769483);
  > 100,000 RegApps in one file (https://www.dlt.com/blog/2015/06/10/civil_3d_file_size); AUDIT itself hangs
  (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Civil-3D-Drawing-hangs-up-Especially-upon-running-an-AUDIT.html);
  crash mid-save leaves a truncated DWG "no footer, no way to fix" (https://forums.augi.com/showthread.php?176841-Unable-to-recover-drawing-quot-Drawing-file-is-not-valid-quot);
  DOT hygiene rituals Purge → Audit → Recover before every submission (https://ftp.mdt.mt.gov/other/webdata/external/esdc/library/Support-Civil3DUserMaintenanceSupport.pdf).
- Civil 3D objects are not backward compatible; older releases see proxies and disable all Civil 3D commands; LandXML
  is the only path (https://help.autodesk.com/cloudhelp/2026/ENU/Civil3D-UserGuide/files/GUID-FA18FB87-C55B-4E1B-BA56-C4CD879C958B.htm **(via sibling notes)**).

## B4. How products mitigate — and the fine print

| Mitigation | What it does | What still goes wrong (official sources) |
|---|---|---|
| Autosave (.sv$, SAVETIME 10 min default) | temp copy in %TEMP% on a timer | timer resets on every manual save, so frequent savers "never" get an .sv$; files are deleted on normal close; off when a LISP/script or Block Editor crashes mid-command; custom/read-only paths silently stop it; must be renamed to .dwg by hand (https://help.autodesk.com/view/ACD/2027/ENU/?guid=GUID-C62ED04D-3638-4EFE-ADA1-5677F7DE7835, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-ensure-autosave-is-always-on-in-AutoCAD.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/autosave-file-for-a-drawing-is-not-found-after-crash-in-autocad.html) |
| Backup (.bak, ISAVEBAK) | previous version beside the DWG on each save | only one generation kept; not created when saving to Forma Data Management since AutoCAD 2022.1; a read-only .bak can block cloud sync (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Understanding-AutoCAD-backup-and-autosave-files.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-not-fully-synchronizing-in-Collaboration-for-Civil-3D.html) |
| Drawing Recovery Manager | lists DWG/BAK/SV$/_recover after a crash | drawings never saved once are not tracked; only works after a crash, not during a session; recovered file needs AUDIT |
| AUDIT / RECOVER / RECOVERALL | fix or delete invalid objects | can hang or crash; "objects erased" are gone; may need to be repeated every open |
| Full-Time CRC Validation | integrity check on every object read | off by default, "should only be enabled when troubleshooting" because it slows opening |
| Customer Error Reporting (CER) | sends minidump + command history to Autodesk; triage by severity and count | REPORTERROR must be 1; needs proxy whitelist; dump files overwritten by the next crash (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Error-Reporting.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Gather-data-from-CER-or-Autocad-Language-Pack-English-Error-Report-from-Civil-3D.html) |
| File locking (.dwl/.dwl2) | WHOHAS info only — "since AutoCAD 2000 the program no longer controls file locking"; OS/server does | stale .dwl after a crash → "in use or read-only"; cloud drives "often do not have any type of file locking" (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-locking-no-longer-controlled-by-software.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Error-DWG-file-is-currently-in-use-or-is-read-only.html) |
| Relative paths / PROJECTNAME / Reference Manager | survive folder moves; bulk repath | not available across drives/servers; mapped-vs-UNC breaks it; Reference Manager has no undo (B2) |
| Bind / eTransmit / Archive | flatten or package | renames or silently merges named objects; omits fonts/.pat/.lin/URL refs by default (B2) |
| Data shortcuts (Civil 3D) | share objects between drawings | XML path files mutate per user; no concurrency lock; hours to sync over WAN; "do not move or rename" rule (B2) |
| Desktop Connector + Docs/Forma (cloud workshare) | lock-on-open, versioning, on-demand download | sync failures leave work in "Modified" that co-workers cannot see; "Conflict" → *local changes discarded* to the Recycle Bin; "Free Up Space" before sync deletes unsynced work; no file locking on long paths; shortcut-sync balloon can appear before upload finishes so clicking it loads stale data (https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Losing-data-when-working-with-DWG-files-in-Desktop-Connector.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-shows-Conflict-State-in-Desktop-Connector.html, https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Locking-DWG-files-in-not-working-correctly-in-Desktop-Connector.html, https://help.autodesk.com/view/CIV3D/2023/ENU/?guid=Civil3D_ReleaseNotes_2023_2_1_Release_Notes_2023_2_1_known_issues_html) |
| Vault (Civil 3D) | check-in/out, project folders | fatal errors on auto-login and Vault commands; corridor references could not be created (fixed 2024.3) |
| Object enablers / proxy graphics | let plain AutoCAD see Civil objects | PROXYGRAPHICS=1 can exhaust memory on save (B1); enabler version mismatches crash AutoCAD (B1) |

### How CADCraft (the reference open-source engine) compares — from `cadcraft-referencing.md` **(via sibling notes)**
- Structural never-crash: no panics in production code (clippy deny lints), `catch_unwind` around every command and
  interactive step with drawing restored from the pre-command `Arc<Drawing>`, ~40 `hostile_*` tests, input caps
  (`MAX_BLOCK_DEPTH = 16`, object/byte limits), non-finite results reverted. Autosave as DXF every SAVETIME on a
  background thread, lock-file heartbeat so stale instances are offered for recovery, GPU device-loss triggers an
  immediate autosave; AUDIT/RECOVER that "never guess at content". Atomic tmp+rename save — but **no .bak**, no web
  autosave, no CI gate on PRs, Stability dimension self-rated 35%.
- Referencing: `craft-docpath` policy follows stored paths only locally or on the document's own share (refusal is a
  status, not an error); xref status (Unloaded) is session-only and lost on reopen; no file watcher; every Reload
  re-parses the whole file; no project container, no eTransmit, no Reference Manager, no Sheet Set.
- These are exactly the two halves Genesis should combine: CADCraft's crash discipline + a real container/link model.

## B5. Synthesis — what reviewers say still goes wrong, ranked

1. **Crashes on save and on open** are the worst class because they are where data is lost; Autodesk's remedies
   assume the user keeps .bak/.sv$ hygiene and knows WBLOCK/RECOVERALL.
2. **References are strings, not identities.** Every product stores a path (absolute, relative, or "search for it");
   every move, rename, drive-mapping difference, permission difference, cloud cache path or VPN drop breaks it, and
   repair is manual and per-reference.
3. **Containment is an afterthought.** eTransmit/Archive/Bind exist but omit fonts/patterns/linetypes/URL refs,
   rename or silently merge named objects, and have no undo.
4. **Cloud worksharing moved the failure from "file not found" to "your work was discarded"** (Conflict status, Free
   Up Space, stale sync balloons), with locking delegated to a connector that itself needs resets.
5. **Bloat and corruption are normal operating conditions** (RegApps, AEC NOD, annotation scales, proxy graphics),
   managed by ritual (Purge → Audit → Recover) rather than by construction.
6. **Version lock-in**: no save-back for Civil objects, enablers and country kits lag each release, so mixed-version
   teams silently damage files.

---

# Wishes = concrete opportunities for Genesis

Business model
- Free, perpetual, open desktop app (the "own your tool" gap: only BricsCAD/Carlson/12d/TBC still sell perpetual).
- Paid, optional hosted **project container + link-health service** (what firms pay ACC/Docs for) — but only after
  the desktop app is the one people already use (Ondsel lesson).
- Paid support/training contracts for firms and municipalities; certification for deliverable standards.
- Sponsorship from survey-hardware, workstation and GPU vendors (Blender's corporate-patron model); a "2%" small-donor
  programme; grants.
- Later: a plug-in marketplace; never dual licensing or feature paywalls in the core.

Stability
- Keep CADCraft's never-crash discipline (no panics, catch_unwind per command, hostile tests, caps) and add a CI gate.
- Crash-safe writes by construction: atomic save + N-generation backups + continuous journal, not a 10-minute timer
  that resets on manual save; autosave on web too.
- Integrity checking (CRC/hash per object) always on, with cost hidden by incremental loading.
- No RegApp/NOD bloat by construction; deterministic save; file size reported per table so bloat is visible.
- Documented, versioned object schema with forward/backward readers ("save to older version" exists on day one).
- Plug-ins sandboxed (process or WASM) so an add-in cannot take the host down (most Civil 3D crash classes are
  add-in/enabler/runtime interactions).
- Crash telemetry opt-in that files a reproducible bug with the drawing excerpt (CER without the email form).

Referencing and containment
- References by **content identity + project-relative path**, with a manifest (`project.json`) listing every xref,
  data link, image, font, template and plot style with hash/size/mtime/role; relocation and packaging become trivial.
- `linkcheck` command: found / missing / refused / changed-since-load for every link, nested included; file watcher
  that raises "reload available".
- One movable project folder; copy = deep copy with link rewrite; export package includes fonts/patterns/linetypes.
- Shared objects (surfaces, alignments) referenced by ID through the manifest, not per-user XML path files; explicit
  locking/merge semantics for concurrent edits; local-first sync that never discards local work (keep both versions).
- Persist reference state (Unloaded, found-at path) and show health in colour in the palette.
- Deterministic merge rules on paste/insert/bind (existing name wins, anonymous names regenerated) exposed in a
  preview so nothing changes silently.


## Corrections after the fact-check (2026-10-21)

- Autodesk Flex no longer starts at USD 300 for 100 tokens: since 4 June 2026 the minimum purchase is 33 tokens for USD 99 (USD 3 per token unchanged; Civil 3D draws 9 tokens per day). Sources in Appendix A of the comparison page.
