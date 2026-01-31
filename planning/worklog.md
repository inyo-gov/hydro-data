# Work Log

Use this log to capture decisions, data issues, and completion notes during the WY24–25 update.

## Template

**Date:**
**Task:**
**Tags:**
**Inputs/Files:**
**Notes/Decisions:**
**Outputs:**
**Follow-ups:**

---

## Entries

**Date:** 2026-01-28  
**Task:** Report metadata and site styling updates  
**Tags:** `metadata`, `styling`, `quarto`  
**Inputs/Files:** `index.qmd`, `_quarto.yml`, `styles.css`, `www/inyo_logo.png`  
**Notes/Decisions:** Updated author/date-modified and applied Inyo County branding for consistent GitHub Pages styling.  
**Outputs:** Rendered pages reflect updated theme/logo styling.  
**Follow-ups:** None.  

**Date:** 2026-01-28  
**Task:** WY2025 cache and parsing safeguards  
**Tags:** `cache`, `parsing`, `wy25`  
**Inputs/Files:** `index.qmd`, `flow.qmd`, `data/hydro/2024-25 Water Year Transfer Packet for ICWD/*.dat`  
**Notes/Decisions:** Moved to year-based cache paths for WY2025 and added fallback parse logic when WY25 RDS files are missing.  
**Outputs:** WY2025 RDS files generated when missing; year-scoped cache directories in use.  
**Follow-ups:** None.  

**Date:** 2026-01-28  
**Task:** Import-metrics placeholders in reports  
**Tags:** `reporting`, `ovga`, `tables`  
**Inputs/Files:** `index.qmd`, `flow.qmd`  
**Notes/Decisions:** Replaced static screenshots with compact import-metrics tables to keep QA/QC sections current.  
**Outputs:** Updated report sections ready for metric values.  
**Follow-ups:** Populate import-metrics tables after final OVGA imports.  

**Date:** 2026-01-28  
**Task:** Peer review and Zenodo templates  
**Tags:** `peer-review`, `zenodo`, `citation`  
**Inputs/Files:** `CITATION.cff`, `zenodo.json`, `paper/*`, `planning/*`  
**Notes/Decisions:** Templated citation metadata and manuscript scaffolding for PeerJ/Zenodo workflow.  
**Outputs:** `CITATION.cff`, `zenodo.json`, `paper/*`, `planning/peer_review_pipeline.md`  
**Follow-ups:** Fill in placeholders in `CITATION.cff` and `zenodo.json`.  

**Date:** 2026-01-28  
**Task:** Flow plots and pumping QA/QC buildout  
**Tags:** `plots`, `dygraphs`, `qaqc`, `pumping`  
**Inputs/Files:** `flow.qmd`, `code/R/functions.R`  
**Notes/Decisions:** Converted key flow plots to dygraphs, added linked-wells QA/QC plots, and introduced wellfield total pumping plots.  
**Outputs:** Rendered `docs/flow.html` with interactive flow and pumping QA/QC plots.  
**Follow-ups:** None.  

**Date:** 2026-01-29  
**Task:** OVGA filename parameters and duplicate checks  
**Tags:** `ovga`, `parameters`, `qaqc`  
**Inputs/Files:** `flow.qmd`  
**Notes/Decisions:** Standardized OVGA output filenames via `wy_year` and added "No duplicates found" messaging for quick QA/QC reads.  
**Outputs:** Updated OVGA export filenames and duplicate-check callouts in report.  
**Follow-ups:** None.  

**Date:** 2026-01-29  
**Task:** Top-10 stream gages and WY/RY labeling  
**Tags:** `plots`, `wy-ry`, `dygraphs`  
**Inputs/Files:** `flow.qmd`, `data/hydro/staid_current.csv`  
**Notes/Decisions:** Replaced single-stream plot with top-10 WY gages and included gage names; clarified WY (Oct–Sep) vs RY (Apr–Mar) in headings and narrative.  
**Outputs:** Rendered `docs/flow.html` with top-10 gage plots and clearer year definitions.  
**Follow-ups:** None.  

**Date:** 2026-01-29  
**Task:** Seasonal pumping totals and percentiles  
**Tags:** `analysis`, `tables`, `pumping`, `wy-ry`  
**Inputs/Files:** `flow.qmd`, `code/R/functions.R`  
**Notes/Decisions:** Added seasonal totals (Apr–Sep, Oct–Mar, Apr–Mar) by site and wellfield plus WY/RY percentile tables for WY2025.  
**Outputs:** Rendered seasonal totals and percentile tables in `docs/flow.html`.  
**Follow-ups:** None.  

**Date:** 2026-01-29  
**Task:** Export diffs and raw-data exclusions  
**Tags:** `exports`, `tables`, `qaqc`  
**Inputs/Files:** `flow.qmd`, `data/hydro/Flows.csv`, `data/hydro/Production.csv`  
**Notes/Decisions:** Added tables comparing last-year vs current exports and raw-data exclusions for flow and production.  
**Outputs:** Rendered export-diff and exclusions tables in `docs/flow.html`.  
**Follow-ups:** None.  

**Date:** 2026-01-30  
**Task:** Plot padding for first/last year visibility  
**Tags:** `plots`, `padding`, `dygraphs`  
**Inputs/Files:** `flow.qmd`, `code/R/functions.R`  
**Notes/Decisions:** Added per-series left/right padding so first and last year bars render fully.  
**Outputs:** Rendered `docs/flow.html` with no year-end clipping.  
**Follow-ups:** None.  

**Date:** 2026-01-30  
**Task:** Pumping plot scaling and label cleanup  
**Tags:** `plots`, `scaling`, `labels`  
**Inputs/Files:** `flow.qmd`, `code/R/functions.R`  
**Notes/Decisions:** Set y-axis ranges based on stacked totals for Big Pine and exempt-well plots and labeled dygraph values as `AF`.  
**Outputs:** Rendered `docs/flow.html` with corrected y-axis scaling and labels.  
**Follow-ups:** None.  

**Date:** 2026-01-30  
**Task:** RY2025 completeness note  
**Tags:** `reporting`, `wy-ry`  
**Inputs/Files:** `flow.qmd`  
**Notes/Decisions:** Noted that RY2025 totals are incomplete without Oct–Mar data.  
**Outputs:** Report note added to `docs/flow.html`.  
**Follow-ups:** Revisit once Oct–Mar 2025–26 data are delivered to complete RY2025.  

**Date:** 2026-01-31  
**Task:** Package documentation, tests, and checksum validation  
**Tags:** `package`, `tests`, `checksums`, `docs`  
**Inputs/Files:** `package/R/*`, `package/inst/extdata/manifest.csv`, `package/tests/*`, `package/man/*`  
**Notes/Decisions:** Added SHA-256 checksum fields to the manifest and enforced checksum validation in `hydrodata_fetch()`. Added testthat coverage for manifest fields and checksum format; regenerated `.Rd` docs.  
**Outputs:** Package docs and tests updated; manifest now includes checksums.  
**Follow-ups:** Consider adding checksum verification to the package README examples.  

**Date:** 2026-01-31  
**Task:** Vignette expansion and package README note  
**Tags:** `package`, `vignette`, `examples`, `documentation`  
**Inputs/Files:** `package/vignettes/hydro-data-website.Rmd`, `README.md`  
**Notes/Decisions:** Expanded vignette with example data access for each dataset type and added root README instructions for package install from GitHub.  
**Outputs:** Vignette now demonstrates DTW, totals, flow, and production access; root README mentions package.  
**Follow-ups:** None.  

**Date:** 2026-01-31  
**Task:** Website build and publication prep  
**Tags:** `quarto`, `website`, `docs`, `render`  
**Inputs/Files:** `index.qmd`, `flow.qmd`, `analysis.qmd`, `docs/`  
**Notes/Decisions:** Ran `quarto render` to refresh GitHub Pages output. Marked `analysis.qmd` as draft and removed it from the navbar until ready.  
**Outputs:** Updated `docs/` site build; analysis page excluded.  
**Follow-ups:** Re-render after title/citation updates to publish the new report title.  

**Date:** 2026-01-31  
**Task:** Report title and citation alignment  
**Tags:** `metadata`, `citation`, `reporting`  
**Inputs/Files:** `index.qmd`, `CITATION.cff`  
**Notes/Decisions:** Updated report title to "Depth to water - annual water year updates" for consistency across report and citation.  
**Outputs:** Title and citation metadata updated in source files.  
**Follow-ups:** Ensure site build reflects the updated title.  

