# Annual Water Year Update Guide

**Purpose:** This guide provides step-by-step instructions for processing the annual LADWP data transfer and updating the hydro data reports for a new water year.

**Target audience:** Future staff, collaborators, or AI assistants updating this workflow for WY2026 and beyond.

---

## Overview

Each October, LADWP delivers a new water-year transfer packet containing:
- Depth-to-water measurements (3 files: DepthRP, DepthGE, DepthWSE)
- Monthly flow and production volumes (VolumeMonthAF)
- Summary stations data (optional)

This repository processes those files, merges them with historical data, runs QA/QC checks, and exports OVGA-ready upload files.

**Two main reports:**
1. `index.qmd` — Depth-to-water (DTW) processing
2. `flow.qmd` — Flow and production processing

---

## Quick Start: What to Change for the Next Water Year

### Step 0: Prepare the Data

1. **Create the new transfer packet folder:**
   ```
   data/hydro/2025-26 Water Year Transfer Packet for ICWD/
   ```

2. **Add the LADWP transfer files:**
   - `DepthRP_2025-26.dat`
   - `DepthGE_2025-26.dat`
   - `OwensValley_DepthWSE_2025-26.dat`
   - `VolumeMonthAF_2025-26.dat`
   - `summary_stations25-26.csv` (if delivered)

3. **Update reference files (if needed):**
   - `data/hydro/Owens_Monitoring_Points.csv` — Download from https://owens.gladata.com/api/export.ashx?v=mp (requires login)
   - `data/hydro/rp_elev.csv` — Reference point elevations (from LADWP or ICWD)
   - `data/hydro/gse_staids.csv` — Ground surface elevations
   - `data/hydro/Production.csv` — Production well metadata
   - `data/hydro/Flows.csv` — Flow gage metadata
   - `data/hydro/staid_current.csv` — Station ID lookup

### Step 1: Update `index.qmd` (Depth to Water)

**Line ~76-82:** Update input file paths and water year
```r
file_pathWSE <- here('data','hydro','2025-26 Water Year Transfer Packet for ICWD','OwensValley_DepthWSE_2025-26.dat')
file_pathRP <- here('data','hydro','2025-26 Water Year Transfer Packet for ICWD','DepthRP_2025-26.dat')
file_pathGE <- here('data','hydro','2025-26 Water Year Transfer Packet for ICWD','DepthGE_2025-26.dat')
wYear <- '2026'
```

**Line ~108-110:** Update RDS cache paths
```r
depthRP_path <- here('data','hydro','2026','depthRP.RDS')
depthGE_path <- here('data','hydro','2026','depthGE.RDS')
depthWSE_path <- here('data','hydro','2026','depthWSE.RDS')
```

**Line ~159:** Update last year's OVGA upload reference
```r
last_ovga_mw <- read_csv(here('output','ovga_uploads_mw_with_rpe_102024_092025_zn.csv'))
```

**Line ~162:** Update historical master database source
```r
hist <- read_csv(here('output','Monitoring_Wells_Master_2025.csv'))
```

**Line ~496-508:** Update ICWD output paths and filenames
```r
out_icwd <- here("output", "2026wy", "ICWD")
testwell.up %>% write_csv(file.path(out_icwd, "testwellwy2026.csv"))
raw_update %>% write_csv(file.path(out_icwd, "testwellwy2026_raw.csv"))
testwells.combined %>% write_csv(file.path(out_icwd, "Monitoring_Wells_Master_2026.csv"))
```

**Line ~1010, ~1011:** Update OVGA output paths and filenames
```r
out_ovga <- here("output", "2026wy", "OVGA")
write_ovga_dtw_csv(upload, file.path(out_ovga, "ovga_uploads_mw_with_rpe_102025_092026_zn.csv"))
writexl::write_xlsx(upload, file.path(out_ovga, "ovga_uploads_mw_with_rpe_102025_092026_zn.xlsx"))
```

**Section headers to update (lines 474-488, 929-933):** Update water year labels in links:
```markdown
### 2026 water year
[Completed DATE annual update (testwellwy2026.csv)](...)
```

### Step 2: Update `flow.qmd` (Flow and Production)

**Line ~48-50:** Update water year variables
```r
wy_year <- 2026
wy_short <- sprintf("%02d", wy_year %% 100)
wy_range <- sprintf("%02d-%02d", (wy_year - 1) %% 100, wy_year %% 100)
```

**Line ~84-92:** Update input file paths
```r
file_path_flow <- here('data','hydro','2025-26 Water Year Transfer Packet for ICWD','VolumeMonthAF_2025-26.dat')
sum_stations_path <- here('data','hydro','2025-26 Water Year Transfer Packet for ICWD','summary_stations25-26.csv')
```

**Line ~107:** Update historical totals source
```r
monthlies <- read_csv(here('data','hydro','totals_means_thru_sep_2025.csv'))
```

**Line ~156:** Update last year's raw flow file
```r
file_path_flow_prev <- here("data", "hydro", "2024-25 Water Year Transfer Packet for ICWD", "VolumeMonthAF_2024-25.dat")
```

**Line ~279, ~295-297:** Update ICWD output paths and filenames
```r
totals_means %>% write_csv(here('data','hydro','totals_means_thru_sep_2026.csv'))
out_icwd <- here("output", "2026wy", "ICWD")
totals_means %>% write_csv(file.path(out_icwd, "totals_means_thru_sep_2026.csv"))
```

**Line ~372-373:** OVGA flow export uses parameterized filename (already handled by `wy_short`)
```r
# No change needed - uses wy_short variable
swflow2 %>% write_csv(file.path(out_ovga, paste0("ovga_swflow_import_wy", wy_short, ".csv")))
```

**Line ~476-479:** OVGA production export uses parameterized filename (already handled by `wy_range`)
```r
# No change needed - uses wy_range variable
tm.well.flow %>% write_csv(file.path(out_ovga, paste0("ovga_production_import_wy", wy_range, ".csv")))
```

### Step 3: Quality Control

**Run the reports and check:**
1. Record counts are reasonable compared to prior year
2. No duplicates in OVGA exports
3. Hydrographs show expected trends
4. Missing RP elevations are documented
5. Export files have correct column names and formats

**Key QA/QC checks in `index.qmd`:**
- Table 1: Staids not in OVGA list (for backend review)
- Table 2: Staids needing data quality resolution
- Record attrition table
- Wellfield hydrographs

**Key QA/QC checks in `flow.qmd`:**
- Linked wells plots
- Seasonal totals and percentiles
- Export comparison tables
- Raw data exclusions

### Step 4: Render and Publish

1. **Render the Quarto site:**
   ```bash
   quarto render
   ```

2. **Verify outputs:**
   - `docs/index.html` (DTW report)
   - `docs/flow.html` (flow/production report)
   - `output/2026wy/ICWD/` (internal database files)
   - `output/2026wy/OVGA/` (upload files for OVGA)

3. **Commit and push:**
   ```bash
   git add .
   git commit -m "WY2026 annual update"
   git push origin main
   ```

### Step 5: Create GitHub Release (Optional but Recommended)

Create a GitHub Release to archive the WY2026 data capsule:

1. **Tag:** `wy2026` or `v2026.1.0`
2. **Title:** "Water Year 2026 Data Release"
3. **Attach files:**
   - Input `.dat` files from LADWP
   - Master snapshot from prior year (`Monitoring_Wells_Master_2025.csv`)
   - WY2026 outputs (ICWD and OVGA files)
   - Any updated reference files

4. **Update package manifest** (`package/inst/extdata/manifest.csv`) to point to the new release URLs

---

## Common Issues and Solutions

### Issue: RDS cache files causing problems
**Solution:** Delete cache files in `data/hydro/2026/` and re-run. The code will regenerate them.

### Issue: "staid not found" errors
**Solution:** Check that reference files (Flows.csv, Production.csv, staid_current.csv) have been updated with any new staids from LADWP.

### Issue: OVGA import rejects upload file
**Solution:** 
1. Check column names match OVGA schema exactly
2. Verify staids in upload are in OVGA monitoring points list
3. Check for invalid values (NA, -777, >= 500 ft for DTW)
4. Review the exclusions tables for details

### Issue: Missing RP elevations
**Solution:**
1. Check if WSE-estimated RP is available (see Table 2 in index.qmd)
2. Use `ovga_uploads_wy2026_wse_estimate_only.csv` for staids with WSE-derived RP
3. Send Table 2 to hydrologist for metadata resolution

### Issue: Plots not rendering
**Solution:** Ensure required packages are installed: tidyverse, dygraphs, ggExtra, lubridate, DT

---

## File Naming Conventions

### ICWD (Internal) Outputs
- `testwellwy{YEAR}.csv` — Annual DTW update (daily aggregated)
- `testwellwy{YEAR}_raw.csv` — Annual DTW update (all reads, pre-aggregation)
- `Monitoring_Wells_Master_{YEAR}.csv` — Full historical DTW database
- `totals_means_thru_sep_{YEAR}.csv` — Full historical flow/production database

### OVGA (Upload) Outputs
- `ovga_uploads_mw_with_rpe_{MMYYYY}_{MMYYYY}_zn.csv` — DTW upload (reported RP only)
- `ovga_uploads_wy{YY}_wse_estimate_only.csv` — DTW upload (WSE-estimated RP only)
- `ovga_swflow_import_wy{YY}.csv` — Flow upload
- `ovga_production_import_wy{YY-YY}.csv` — Production upload

### Exclusions and QA/QC
- `ovga_excl_not_in_list_wy{YEAR}.csv` — Table 1: Not in OVGA list
- `ovga_excl_data_quality_wy{YEAR}.csv` — Table 2: Data quality issues
- `ovga_flow_exclusions_wy{YEAR}.csv` — Flow exclusions
- `ovga_production_exclusions_wy{YEAR}.csv` — Production exclusions

---

## For AI Assistants: Processing Checklist

If you're an AI assistant helping with the next water year update, follow this workflow:

1. **Read this guide first** to understand the annual update process

2. **Check the water year checklist** (`planning/wy{YY}checklist.md`) for the current year's specific tasks

3. **Update paths systematically:**
   - Input file paths (from LADWP transfer packet)
   - Cache/RDS paths (create new year folder)
   - Historical input references (last year's master files)
   - Output paths and filenames (new water year)

4. **Key variables to update:**
   - `index.qmd`: `wYear`, input paths, output paths, RDS paths, `hist` source, `last_ovga_mw` source
   - `flow.qmd`: `wy_year`, `file_path_flow`, `sum_stations_path`, `monthlies` source, `file_path_flow_prev`

5. **Run QA/QC checks after rendering:**
   - Compare record counts to prior year
   - Check for duplicates
   - Review exclusions tables
   - Verify hydrographs show reasonable trends

6. **Export files to deliver:**
   - Send Table 1 (`ovga_excl_not_in_list_wy{YEAR}`) to hydrologist for backend OVGA list review
   - Send Table 2 (`ovga_excl_data_quality_wy{YEAR}`) to hydrologist for RP elevation resolution
   - Upload OVGA files to https://owens.gladata.com/

7. **Log your work** in `planning/worklog.md` with date, task, files, decisions, and follow-ups

---

## Directory Structure

```
hydro-data/
├── index.qmd                    # Main DTW report
├── flow.qmd                     # Flow/production report
├── data/hydro/
│   ├── 2024-25 Water Year Transfer Packet for ICWD/
│   ├── 2025-26 Water Year Transfer Packet for ICWD/  ← Create for next year
│   ├── 2025/                   # RDS cache files (depthRP.RDS, etc.)
│   ├── 2026/                   # ← Create for next year
│   ├── Owens_Monitoring_Points.csv
│   ├── rp_elev.csv
│   ├── gse_staids.csv
│   ├── Production.csv
│   ├── Flows.csv
│   └── staid_current.csv
├── output/
│   ├── 2025wy/
│   │   ├── ICWD/              # Internal database outputs
│   │   └── OVGA/              # OVGA upload files
│   └── 2026wy/                # ← Create for next year
│       ├── ICWD/
│       └── OVGA/
├── planning/
│   ├── wy25checklist.md       # This year's checklist
│   ├── wy26checklist.md       # ← Copy and adapt for next year
│   └── worklog.md             # Running log of changes
└── docs/                      # Rendered HTML reports (GitHub Pages)
```

---

## Detailed Workflow

### Phase 1: Data Preparation

1. Create new transfer packet folder under `data/hydro/`
2. Place LADWP `.dat` files in the folder
3. Update monitoring points CSV from OVGA if needed
4. Check if RP elevations need updating

### Phase 2: Groundwater (DTW) Processing

**File:** `index.qmd`

1. **Update line ~76-82:** Input file paths and `wYear` variable
2. **Update line ~108-110:** RDS cache paths for new year
3. **Update line ~159:** Last year's OVGA upload (for comparison)
4. **Update line ~162:** Historical master source
5. **Update line ~496-508:** ICWD output paths/filenames
6. **Update line ~1010-1011:** OVGA output paths/filenames
7. **Render:** `quarto render index.qmd`

**Expected outputs in `output/2026wy/`:**
- `ICWD/testwellwy2026.csv` — Annual update (daily)
- `ICWD/testwellwy2026_raw.csv` — Annual update (all reads)
- `ICWD/Monitoring_Wells_Master_2026.csv` — Full historical database
- `OVGA/ovga_uploads_mw_with_rpe_102025_092026_zn.csv` — OVGA DTW upload
- `OVGA/ovga_excl_not_in_list_wy2026.csv` — Table 1 for hydrologist
- `OVGA/ovga_excl_data_quality_wy2026.csv` — Table 2 for hydrologist

### Phase 3: Flow and Production Processing

**File:** `flow.qmd`

1. **Update line ~48:** `wy_year <- 2026` (auto-calculates `wy_short` and `wy_range`)
2. **Update line ~84:** `file_path_flow` to new VolumeMonthAF file
3. **Update line ~87:** `sum_stations_path` to new summary stations file
4. **Update line ~107:** `monthlies` source to last year's totals_means
5. **Update line ~156:** `file_path_flow_prev` to last year's VolumeMonthAF
6. **Update line ~279, ~295:** ICWD output paths for `totals_means_thru_sep_2026.csv`
7. **Render:** `quarto render flow.qmd`

**Expected outputs in `output/2026wy/`:**
- `ICWD/totals_means_thru_sep_2026.csv` — Full historical flow/production
- `OVGA/ovga_swflow_import_wy26.csv` — OVGA flow upload
- `OVGA/ovga_production_import_wy25-26.csv` — OVGA production upload
- `OVGA/ovga_flow_exclusions_wy2026.csv` — Flow exclusions
- `OVGA/ovga_production_exclusions_wy2026.csv` — Production exclusions

### Phase 4: Quality Control

**Run these checks before committing:**

1. **Record counts:**
   - DTW: Compare `testwellwy2026.csv` row count to prior year
   - Flow/production: Compare OVGA upload counts to prior year

2. **Duplicates:**
   - Check "No duplicates found" messages in both reports
   - If duplicates exist, investigate and resolve

3. **Exclusions:**
   - Review Table 1 (not in OVGA list) — send to hydrologist
   - Review Table 2 (data quality) — send to hydrologist
   - Check if new staids need backend addition

4. **Hydrographs:**
   - Spot-check indicator wells for anomalies
   - Verify water-year vertical lines are positioned correctly

5. **Export formats:**
   - Verify OVGA column names match schema
   - Check that no invalid values (-777, NA, >= 500) made it through

### Phase 5: Publish

1. **Render full site:**
   ```bash
   quarto render
   ```

2. **Review GitHub Pages output:**
   - https://inyo-gov.github.io/hydro-data/ (or your org URL)

3. **Commit and push:**
   ```bash
   git add .
   git commit -m "WY2026 annual update complete"
   git push origin main
   ```

4. **Create GitHub Release** (optional but recommended for provenance):
   - Tag: `wy2026`
   - Attach: Input files, master snapshot, WY2026 outputs
   - Update package manifest to point to release assets

### Phase 6: Handoff

**Send these files to hydrologist/DB manager:**

1. **OVGA list updates:**
   - `output/2026wy/OVGA/ovga_excl_not_in_list_wy2026.csv` (Table 1)
   
2. **Metadata resolution:**
   - `output/2026wy/OVGA/ovga_excl_data_quality_wy2026.csv` (Table 2)

3. **OVGA uploads:**
   - `output/2026wy/OVGA/ovga_uploads_mw_with_rpe_102025_092026_zn.csv` (DTW)
   - `output/2026wy/OVGA/ovga_swflow_import_wy26.csv` (flow)
   - `output/2026wy/OVGA/ovga_production_import_wy25-26.csv` (production)

---

## Tips for Success

1. **Start early:** Allow time for QA/QC and metadata resolution before the upload deadline

2. **Use version control:** Commit frequently with clear messages

3. **Test before full render:** Run individual code chunks in RStudio to catch errors early

4. **Keep a work log:** Document decisions, issues, and follow-ups in `planning/worklog.md`

5. **Check reference files:** Verify that monitoring points, RP elevations, and metadata files are current

6. **Compare to prior year:** Use export comparison tables to spot missing/added staids

7. **Cache management:** If re-running after fixing data issues, delete RDS cache files to force re-parsing

---

## Resources

- **OVGA Web Application:** https://owens.gladata.com/
- **Monitoring Points API:** https://owens.gladata.com/api/export.ashx?v=mp (requires auth)
- **GitHub Repository:** https://github.com/inyo-gov/hydro-data
- **Published Reports:** https://inyo-gov.github.io/hydro-data/
- **Checklist Template:** `planning/wy25checklist.md` (copy for next year)

---

## Questions?

If something is unclear or the workflow has changed, update this guide and document the changes in the work log. This guide is a living document and should evolve as the workflow improves.
