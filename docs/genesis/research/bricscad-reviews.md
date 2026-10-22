# BricsCAD — what users say (best and worst), 2024–2026

Research notes compiled 2026-10-21 for the CADCraft / Civil 3D / BricsCAD Ultimate / "Genesis" comparison.
Worker: `research:bricscad-reviews`. Companion JSON: `bricscad-reviews.json` (same directory).

## 0. Method, sources and limits (read first)

- Ten web searches were completed (G2, Capterra, TrustRadius, Reddit x2, Bricsys forum crash threads, V26
  reviews, Linux/macOS parity, perpetual-licence/maintenance opinion, Hacker News). After that the session's
  shared web-search budget was exhausted, so no further searches (Software Advice, GetApp, AUGI/CADdigest
  opinion pieces, r/bricscad, r/civil3d "switching" threads, LISP-compatibility threads, BIM-usability threads)
  could be run.
- Page fetches were impossible: the environment's network policy denied every host needed
  (forum.bricsys.com, www.g2.com, capterra.com, www.trustradius.com, draftingbench.com, reddit.com,
  hn.algolia.com, www.bricsys.com, bricscad.octave.com, help.bricsys.com, en.wikipedia.org and the reseller
  sites). Only github.com was reachable. Consequently **every paraphrase below comes from the search engine's
  summary of the page, not from reading the page itself**. Each item carries the URL it came from; items that
  need page-level confirmation are marked *summary-only*. Nothing below is invented; where a number conflicts
  between sources both numbers are given.
- The Reddit-targeted searches returned no Reddit threads at all (only review-site and vendor pages), and the
  Hacker News `site:` search returned nothing from news.ycombinator.com. So **no Reddit or HN opinions are in
  this file** — that is a gap, not evidence that none exist.
- Branding note: G2 now lists the product as "Octave BricsCAD" and the vendor pages live at
  `bricscad.octave.com` (https://www.g2.com/products/octave-bricscad/reviews,
  https://bricscad.octave.com/bricscad/ultimate). Bricsys was part of Hexagon
  (https://www.3dnatives.com/en/wp-json/wp/v2/posts/66905); the Octave name indicates Hexagon's software
  spin-off. The corporate details are *unverified this session*. Wikipedia lists the current stable release as
  26.2.08 (September 2026) and notes BricsCAD Shape was discontinued as a standalone product with V26
  (https://en.wikipedia.org/wiki/BricsCAD, *summary-only*).

## 1. Aggregate ratings (with counts and URLs)

| Site | Rating | Count | URL | Notes |
|---|---|---|---|---|
| G2 ("Octave BricsCAD") | 4.5 / 5 | 135 reviews (134 on compare pages) | https://www.g2.com/products/octave-bricscad/reviews | Sub-scores from G2's AI summaries: ease of setup 9.1, quality of support 9.0 (https://www.g2.com/compare/bricscad-vs-solidworks, https://www.g2.com/compare/autodesk-fusion-vs-bricscad). *summary-only* |
| Capterra | 4.5 / 5 | 18 reviews | https://capterra.com/p/159378/BricsCAD/reviews/ | Ease of use 4.6, customer service 3.9. Listing last updated Aug 2025. Starting price shown: $590 one-time. Austrian mirror shows same 4.5/18 (https://www.capterra.at/reviews/159378/bricscad). *summary-only* |
| TrustRadius | 10 / 10 trScore | 11 ratings on product page; "2 reviews" on the all-reviews page | https://www.trustradius.com/products/bricscad/reviews | Feature sub-scores: 2D drafting 8.2 (highest), rendering & visualization 6.6 (lowest). Tiny sample. *summary-only* |
| SaaSWorthy | 4.7 / 5 | 131 ratings | https://www.saasworthy.com/product/bricscad/reviews | Aggregator; likely re-uses G2/Capterra data. *summary-only* |
| Trustpilot (company: bricsys.com) | 3.0 / 5 | 4 reviews | https://nl-be.trustpilot.com/review/bricsys.com | One reviewer: requests for a registration code went unanswered. *summary-only* |
| GetApp (CA) | not captured | — | https://www.getapp.ca/software/276675/bricscad | Listing exists; rating not in search summary. |
| Software Advice | not captured | — | — | Search budget exhausted before this lookup. |
| AlternativeTo | not captured | — | https://www.alternativeto.net/software/bricscad/about/ | One commenter: "does everything I used to do in AutoCAD LT". |

Reading of the aggregates: the volume sites (G2, SaaSWorthy) are solidly positive at 4.5–4.7; the small-sample
sites diverge wildly (TrustRadius 10/10 on 11 ratings, Trustpilot 3.0 on 4), so only the G2 figure is
statistically meaningful. The one consistent soft spot across sites is **support responsiveness** (Capterra
customer-service 3.9 vs ease-of-use 4.6; Trustpilot complaints), which contradicts G2's 9.0 support score —
treat support quality as "mixed".

## 2. Praise, by theme

### 2.1 AutoCAD familiarity and easy switch
- G2 reviewers say BricsCAD is easy to learn for people coming from AutoCAD because it "operates similarly";
  it opens DWG files, produces clean PDFs, and supports AutoCAD routines (LISP) and toolbars
  (https://www.g2.com/products/bricscad/reviews, https://www.g2.com/compare/autocad-vs-octave-bricscad).
- An Indian reseller listing claims retraining takes about a day — vendor marketing, not a user
  (https://m.indiamart.com/proddetail/bricscad-fast-efficient-drafting-software-24963692355.html).
- TrustRadius reviewers describe it as easy for newcomers to pick up and note strong compatibility with
  AutoTURN vehicle-tracking software (a civil/site-design add-on)
  (https://www.trustradius.com/products/bricscad/reviews).

### 2.2 Price and the perpetual licence
- "Costs much less than AutoCAD, with one-time license options" is the most repeated G2 praise
  (https://www.g2.com/products/bricscad/reviews). A TrustRadius reviewer calls it "a cheaper alternative to
  AutoCAD LT"; an AlternativeTo commenter says it does everything they did in AutoCAD LT.
- Capterra shows a $590 one-time starting price (Lite) (https://capterra.com/p/159378/BricsCAD/).
- The independent Drafting Bench V26 review confirms perpetual licensing "remains available alongside
  subscriptions" in the V26 cycle (https://draftingbench.com/bricscad-v26-review/).
- A forum commenter claims maintenance is ~60 % cheaper than buying an upgrade every year (one user's
  arithmetic) (https://forum.bricsys.com/discussion/40010/maintenance-contract). Another forum poster reported a
  $236 upgrade-to-new-perpetual price that Bricsys sales confirmed
  (https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move).
- A Japanese Bricsys-staff blog argues the perpetual licence is more cost-effective than subscription for V25
  (vendor-authored) (https://note.com/bricscad/n/n34134155aab0?hl=en).

### 2.3 Setup and support (the positive half of a split verdict)
- G2 AI summaries: ease of setup 9.1, quality of support 9.0
  (https://www.g2.com/compare/bricscad-vs-solidworks). See §3.7 for the opposite view.

### 2.4 V26 improvements (mostly vendor claims; one independent reviewer)
- Drafting Bench (independent) calls V26 "a year of maturation": released 26 Oct 2025, V26.2 shipped
  31 Mar 2026 and carried most of the cycle's new capability, including the AI-driven "BricsCAD Assist"
  documentation panel; headline feature is Dynamic Block creation/editing
  (https://draftingbench.com/bricscad-v26-review/).
- Vendor figures (not independently verified): "more than 60 new and enhanced features", up to 25x faster 3D
  solid edits vs V25, 2.7–2.8x faster DWG file operations, 80 % more robust sheet-metal recognition
  (https://www.augi.com/articles/detail/whats-new-in-bricscad-v26,
  https://www.modelcamtechnologies.com/Whats-New-in-BricsCAD-V26-A-Complete-Feature-Breakdown,
  https://bricscad.octave.com/news/bricscad-r-v26-the-true-cad-alternative-now-smarter-and-more-scalable).
- Reseller KTF Software praises faster loading, the new block parameters/actions and "Auto Mapping for Civil
  Points" (reseller, not end user) (https://ktfsoftware.com/news/bricscad-v26-our-first-impressions-and-new-features-overview/).

### 2.5 Linux exists and is usable
- Forum users on Linux report that it works, with "a bit more stable" feel than the Mac build, though with GUI
  flaws (https://forum.bricsys.com/discussion/38446/first-expirience-with-bricscad-on-linux). A 2022 lag thread
  concluded the cause was NVIDIA driver setup, not BricsCAD
  (https://forum.bricsys.com/discussion/36154/bricscad-viewport-lags-any-improvement).

## 3. Complaints, by theme (severity judged for a professional user)

### 3.1 Crashes and stability regressions in V25 — HIGH
All from the official Bricsys forum, 2025; user reports, not Bricsys-confirmed bugs; *summary-only*.
- Jan 2025, V25.1.07: fatal errors while panning/zooming. Bricsys support had the user set `MTFLAGS=0`
  (disables multithreaded display); one user said that fixed it; an AMD-GPU user reported black-screen crashes
  that started after an update (https://forum.bricsys.com/discussion/39491/panning-and-crashing).
- Apr 2025, V25.2.03: crashes when copying an element then panning; one user did a clean install, still
  crashed, and reinstalled an older build to meet a deadline
  (https://forum.bricsys.com/discussion/39703/bricscad-25-2-03-keeps-crashing-panning).
- Aug 2025 "briscad crashing": slowness and crashes; one user says V25 is "considerably worse than V24" for
  crashing and performance; another counted a fifth crash in three hours on a simple model; a reply suggested
  faulty RAM (https://forum.bricsys.com/discussion/39609/briscad-crashing).
- Mar 2025: crashes on closing or during autosave; a separate post recalls a V25 save bug in certain
  situations with no leftover lock file (https://forum.bricsys.com/discussion/39481/file-saving-bricscad-v25).
- Windows memory-usage thread (https://forum.bricsys.com/discussion/39930/bricscad-windows-memory-usage) and
  "Error loading lrx file V25" (https://forum.bricsys.com/discussion/39941/error-loading-lrx-file-v25) and
  "GUI Problems" (https://forum.bricsys.com/discussion/39634/gui-problems) are further V25 quality threads.
- A .NET plug-in that worked in V24 crashed at V25 start-up
  (https://forum.bricsys.com/discussion/39410/bricscad-2025-debugging-net-plugin) — API/ABI churn between
  yearly versions.
- A user in a maintenance dispute says every drawing session crashes
  (https://forum.bricsys.com/discussion/comment/58808 "Joining the Outlaws").
- V26 on macOS: "a lot more crashing since V26.1.08"; one user says V26 cannot save some files V25 handles
  (https://forum.bricsys.com/discussion/40271/v26-peformance-issues).
- Capterra, Mar 2025 (German, 1/5): "unusable for professional architecture work because of performance
  problems and bugs" (https://capterra.com/p/159378/BricsCAD/reviews/).
- SaaSWorthy's listed weaknesses include "occasional instability" (https://www.saasworthy.com/product/bricscad/reviews).
Pattern: each yearly major release ships with regressions that are patched over the x.1/x.2 cycle; users on
deadlines roll back. The `MTFLAGS=0` advice means the multithreaded display path is the usual suspect.

### 3.2 macOS build quality and parity — HIGH for Mac users
- Thread titled "BricsCad for Mac seems to be a perpetual beta app": freezing, beachballs, GUI issues and
  missing Windows feature parity "for years"
  (https://forum.bricsys.com/discussion/39292/bricscad-for-mac-seems-to-be-a-perpetual-beta-app).
- A user states the Mac build is still Intel-only with no native Apple-silicon binary; Wikipedia says all
  editions are "compatible with Apple Silicon" — the two are reconcilable if compatibility means Rosetta;
  **unverified which is right** (https://forum.bricsys.com/discussion/39801/as-version-of-bricscad-for-v26,
  https://en.wikipedia.org/wiki/BricsCAD).
- 2025: the Mac graphics layer moved to Metal and "has large performance issues compared to the OpenGL
  implementation"; another commenter blames Apple's platform
  (https://forum.bricsys.com/discussion/40271/v26-peformance-issues).
- Older threads: "Problems with BricsCAD and Mac" (https://forum.bricsys.com/discussion/38171/problems-with-bricscad-and-mac).

### 3.3 Linux build: second-class but improving — MEDIUM
- Wayland: black window and crash report on 25.2.03 with a GDK assertion failure in the terminal
  (https://forum.bricsys.com/discussion/39653/wayland-black-window-and-crash-report).
- "Linux and Mac versions seem to have the same flaws and do not offer the same experience as Windows";
  "same or similar amount of GUI flaws and unexpected crashes" on Mac and Linux, Linux slightly more stable
  (https://forum.bricsys.com/discussion/38446/first-expirience-with-bricscad-on-linux).
- "Quality of Bricscad desktop integration" thread (https://forum.bricsys.com/discussion/35751/quality-of-bricscad-desktop-integration)
  and "CPU Usage" (https://forum.bricsys.com/discussion/37628/cpu-usage).

### 3.4 Performance on large drawings and in 3D — MEDIUM
- G2 common cons: "large file handling performance" (https://www.g2.com/products/octave-bricscad/reviews).
- "MASSIVE lag when selecting objects ... when structure browser is open"
  (https://forum.bricsys.com/discussion/35754/massive-lag-when-selecting-objects-and-genearal-working-in-environment-when-structure-browser-is-ope).
- 3D viewport speed complaints are "common across platforms"
  (https://forum.bricsys.com/discussion/36154/bricscad-viewport-lags-any-improvement).
- G2: parametric blocks are "weaker than AutoCAD's and can slow things down"
  (https://www.g2.com/compare/autocad-vs-octave-bricscad).
- Vendor's own V26 claims of 25x/2.8x speed-ups implicitly concede V25 was slow in those paths.

### 3.5 Dynamic blocks and AutoCAD-feature gaps — MEDIUM
- TrustRadius con: "incomplete support for dynamic blocks" (https://www.trustradius.com/products/bricscad/reviews).
- V26 finally adds Dynamic Block creation/editing, but it is "still marked experimental and unavailable to US
  users because of licensing" per the independent Drafting Bench review
  (https://draftingbench.com/bricscad-v26-review/) — presumably patent-related; *reason unverified*.
- G2: "a few AutoCAD commands and tools aren't available or are less polished"; "minor differences compared to
  more established CAD programs can be seen during complicated operations"
  (https://www.g2.com/products/bricscad/reviews).

### 3.6 Licensing policy shift (effective 1 Jan 2026) — MEDIUM
- New Upgrade and Support Policy: support covers the latest version plus three previous (up from two), but
  owners of very old perpetual licences can no longer upgrade without maintenance; Bricsys framed it as
  favouring maintenance customers. Thread title calls it "a cynical move"; posters say maintenance costs keep
  rising and the policy pushes people toward subscription
  (https://forum.bricsys.com/discussion/39918/the-new-upgrade-and-support-policy-a-cynical-move,
  https://forum.bricsys.com/discussion/40010/maintenance-contract).
- Prices seen (undated, *summary-only*, currencies differ): Bricsys maintenance page €710/yr for Pro
  (https://bricscad.octave.com/maintenance); the Ultimate product page lists a maintenance renewal of
  €440/yr (https://bricscad.octave.com/bricscad/ultimate) — **lower than Pro, so one of these is probably
  misread; unverified**; NOVEDGE lists $292 maintenance for Pro perpetual
  (https://novedge.com/collections/new-releases); Noricad explains the licensing model
  (https://noricad.co.uk/news/first-category/bricscad-pricing-licensing-subscription-explained/); official
  store https://www.bricsys.com/en-us/store/bricscad. No evidence of a specific 2025 perpetual price increase
  was found.

### 3.7 Support responsiveness — MEDIUM (split verdict)
- Capterra customer-service sub-score 3.9 (vs 4.6 ease of use) (https://capterra.com/p/159378/BricsCAD/reviews/).
- Trustpilot: registration-code requests unanswered (https://nl-be.trustpilot.com/review/bricsys.com).
- G2 comparison pages list "support response time" as a common complaint
  (https://www.g2.com/compare/bricscad-vs-zwcad) — yet G2's own summary scores support 9.0. Net: ticket
  support is good when it engages (the `MTFLAGS=0` reply came from support) but slow or silent for some.

### 3.8 Learning resources and community size — LOW-MEDIUM
- G2: "difficulty with learning due to limited resources" (https://www.g2.com/products/octave-bricscad/reviews).
- "User community is smaller compared to well-established software like AutoCAD ... fewer forums and
  third-party resources" (https://www.saashub.com/compare-nanocad-vs-bricscad).
- SaaSWorthy: "steep learning curve for some features" (https://www.saasworthy.com/product/bricscad/reviews).

### 3.9 UI — LOW
- TrustRadius con: "dated-looking interface" (https://www.trustradius.com/products/bricscad/reviews).
- No Quad-cursor-specific opinions were captured (search budget).

### 3.10 Civil tools maturity — MEDIUM (inferred; no direct user reviews captured)
- No user review of the native civil tools surfaced. Evidence is structural: the third-party Civil Site Design
  add-on sells itself on BricsCAD as "the best Civil 3D alternative" and imports Civil 3D surfaces/alignments
  directly (https://civilsitedesign.com/apps/civil-site-design-for-bricscad/,
  https://chasmtech.com/products/civil-site-design-for-bricscad-the-best-civil-3d-alternative/), which implies
  the native TIN/alignment/corridor tools (spirals, parabolic vertical curves, CORRIDOR from template since V21:
  https://help.bricsys.com/pl-pl/document/bricscad/whats-new-in-bricscad-v21/civil-tools) are not treated by
  the market as a complete site-design stack (no pipe networks, labels, plan production in the Civil 3D sense
  — *inference, unverified*).
- The only civil-flavoured praise is V26 "Auto Mapping for Civil Points" (reseller) and AutoTURN
  compatibility (TrustRadius).

### 3.11 Rendering and visualisation — LOW
- TrustRadius lowest sub-score 6.6 (https://www.trustradius.com/products/bricscad/reviews).

### 3.12 BIM usability — NOT CAPTURED
- Search budget ran out before the BIM-usability query. No claim made.

## 4. What users wish for (synthesised from the complaints)
1. A stable x.0 release — stop shipping regressions that force roll-backs (§3.1).
2. A native Apple-silicon Mac build with Windows feature parity and a Metal renderer that is not slower than
   OpenGL (§3.2).
3. Full Wayland support and polished desktop integration on Linux (§3.3).
4. Large-drawing and 3D-viewport performance (§3.4).
5. Dynamic-block creation available to everyone, including US users, and out of "experimental" (§3.5).
6. The remaining "few AutoCAD commands" and polish gaps closed (§3.5).
7. Keep cheap perpetual upgrades for old licences; stop raising maintenance (§3.6).
8. Faster, more reliable support tickets and licence/registration handling (§3.7).
9. More tutorials, docs and a larger community (§3.8).
10. Less dated UI (§3.9); better rendering (§3.11).
11. Stable plug-in API across yearly versions (.NET/BRX breakage) (§3.1).
12. (Inferred) native civil tools that do not require a third-party add-on for a site-design workflow (§3.10).

## 5. Lessons for Genesis / CADCraft (editorial, derived from the above)
- BricsCAD's whole pitch is "AutoCAD-compatible, cheaper, perpetual"; its reviews show that pitch works
  (4.5/5 on 135 G2 reviews) **until** stability or platform parity slips — the loudest 2025 threads are crashes
  and the Mac build. A never-crash policy is a real differentiator, not a nicety.
- Yearly major versions that break plug-ins and regress stability are resented; users value a boring, stable
  release train and roll back when they cannot get one.
- Cross-platform builds that lag the primary platform earn a "perpetual beta" label; parity must be enforced,
  not promised.
- Licence-policy changes against perpetual holders generate the angriest threads; an open-source app avoids
  the category entirely.
- Dynamic blocks being withheld from US users on licensing grounds is a reminder that AutoCAD-parity
  features can carry IP risk; a clean-room approach must be documented.
- The support split (fast and good vs silent) suggests users judge support by worst case; a public issue
  tracker with visible status would beat a ticket queue.

## 6. Gaps to close in a follow-up (not done this session)
- Open the G2, Capterra, TrustRadius pages to date and count the 2024–2026 reviews individually.
- Reddit: r/bricscad, r/cad, r/AutoCAD "switched to BricsCAD" and r/civil3d "BricsCAD for site work" threads.
- Hacker News (hn.algolia.com) — none captured.
- Bricsys forum: civil-tools threads, LISP-compatibility threads, BIM-workflow threads, Quad opinions.
- AUGI/CADdigest/upFront.eZine opinion pieces on V25/V26 and on the Octave spin-off.
- Verify the Apple-silicon native-build question and the €440 vs €710 maintenance figures.
- Verify why V26 dynamic-block creation is unavailable in the US.


## Corrections after the fact-check (2026-10-21)

- TrustRadius: the 6.6 'rendering/visualization' figure is the category average; BricsCAD's own score there is 8.0 (one rating). Headline 10/10 on 11 ratings with 2 written reviews.
