# Genesis: the land-development CAD, compared and planned

> **Last reviewed:** 2026-10-21 · **Last updated:** 2026-10-21 · **Change:** major (first version) · **Scope:** CADCraft 0.10.0, Autodesk Civil 3D 2026, BricsCAD V26 Ultimate

This folder holds the deep comparison between the four products this fork cares about, kept
separate and then compared:

1. **CADCraft** (this repository): the open-source, pure-Rust 2D CAD, as it stands.
2. **Autodesk Civil 3D**: the land-development benchmark.
3. **BricsCAD Ultimate**: the top perpetual-licence AutoCAD alternative.
4. **Genesis** (working name): the simpler open-source land-development and site-design CAD we
   intend to build on CADCraft's crates: better referencing and data connections, self-contained
   project files, fast references, zero crashes, and old-school plus "neo" building techniques
   (solar, rain collection, earth building, passive siting) as first-class objects.

| File | What it is |
|---|---|
| [`comparison.html`](comparison.html) | The analysis. Pure HTML and CSS (no scripts, no external resources); open it in any browser or print it. Sections: executive summary, method, one section per product, a head-to-head matrix (new versus missing), pooled reviews best and worst, the Genesis plan (principles, feature set, old-school and neo techniques, architecture, backlog from reviews, market and pricing, roadmap and risks), verification log and sources |
| [`research/`](research/) | The research workers' working notes with every URL, one markdown file per topic, and the JSON summaries the page was generated from |

## How it was made

- CADCraft facts were measured in this repository on 2026-10-21 (source read, release build, headless
  smoke test, 200,000-entity benchmark, desktop app driven over the control channel under a
  virtual display).
- Civil 3D and BricsCAD facts come from vendor documentation and store pages; user opinions from
  review sites, forums and communities (2024–2026), paraphrased with URLs.
- Key claims (prices, feature presence, ratings) were handed to independent fact-checkers told to
  refute them; the verdicts are in Appendix A of the page.
- No Autodesk or Bricsys software was run, decompiled or copied, and no GPL CAD source was read
  (clean-room rule in `CLAUDE.md`). Product names are used nominatively.

## Regenerating the page

The page is generated from the JSON summaries in `research/` plus hand-written sections by a small
Python script that is not part of the Rust workspace (it lives outside the repository so that the
"Rust only" rule for application code is untouched). To refresh numbers: re-run the measurements in
Appendix A, update the JSON files, regenerate, and add a row below.

## Revision history

| Date | Change | Summary |
|---|---|---|
| 2026-10-21 | major | First version of the comparison, the Genesis plan and the research notes |
