# WY24–25 Update Checklist

## 0) Prep
- [ ] Create folder `data/hydro/2024-25 Water Year Transfer Packet for ICWD/`
- [ ] Add new transfer packet files:
  - [ ] `DepthRP_2024-25.dat`
  - [ ] `DepthGE_2024-25.dat`
  - [ ] `OwensValley_DepthWSE_2024-25.dat`
  - [ ] `VolumeMonthAF_2024-25.dat`
  - [ ] `summary_stations24-25.csv`
- [ ] Verify/update reference files as needed:
  - [ ] `data/hydro/Owens_Monitoring_Points.csv`
  - [ ] `data/hydro/rp_elev.csv`
  - [ ] `data/hydro/gse_staids.csv`
  - [ ] `data/hydro/Production.csv`
  - [ ] `data/hydro/Flows.csv`
  - [ ] `data/hydro/staid_current.csv`

## 1) Groundwater processing (`index.qmd`)
- [ ] Update input `.dat` paths to `2024-25` packet
- [ ] Set `wYear <- '2025'`
- [ ] Point RDS read/write to `data/hydro/2025/`
- [ ] Update `hist` source to `Monitoring_Wells_Master_2024.csv`
- [ ] Update output names:
  - [ ] `output/testwellwy2025.csv`
  - [ ] `output/Monitoring_Wells_Master_2025.csv`
  - [ ] `output/ovga_uploads_mw_with_rpe_102024_092025_zn.csv`
- [ ] Update `last_ovga_mw` to prior year upload file

## 2) Groundwater QA/QC
- [ ] Check record counts for annual update and master DB
- [ ] Review missing RP elevation table
- [ ] Spot-check indicator well hydrographs
- [ ] Confirm OVGA upload row counts are reasonable vs last year

## 3) Flow + Pumping processing (`flow.qmd`)
- [ ] Update `file_path_flow` to `VolumeMonthAF_2024-25.dat`
- [ ] Update `sum_stations` to `summary_stations24-25.csv`
- [ ] Update `monthlies` input to `totals_means_thru_sep_2024.csv`
- [ ] Update ICWD master outputs:
  - [ ] `data/hydro/totals_means_thru_sep_2025.csv`
  - [ ] `output/totals_means_thru_sep_2025.csv`
- [ ] Update OVGA export names:
  - [ ] `output/ovga_swflow_import_wy25.csv`
  - [ ] `output/ovga_production_import_wy24-25.csv` (or `wy25`, pick one)

## 4) Flow + Pumping QA/QC
- [ ] Confirm `read != -777` filtering worked
- [ ] Check `get_dupes()` results for flow + production exports
- [ ] Spot-check a few stations and annual totals
- [ ] Review QA/QC plots for obvious anomalies

## 5) Render + publish
- [ ] Render Quarto site
- [ ] Verify `docs/index.html` and `docs/flow.html`
- [ ] Verify download links point to WY25 outputs
- [ ] Commit outputs + docs update

## 6) GitHub Release data capsule (WY2025)
- [ ] Create a GitHub Release for WY2025 (tag name + title)
- [ ] Attach minimal inputs:
  - [ ] `DepthRP_2024-25.dat`
  - [ ] `DepthGE_2024-25.dat`
  - [ ] `OwensValley_DepthWSE_2024-25.dat`
  - [ ] `VolumeMonthAF_2024-25.dat`
  - [ ] `summary_stations24-25.csv` (when delivered)
  - [ ] Reference files if updated this year (e.g., `Owens_Monitoring_Points.csv`, `rp_elev.csv`, `gse_staids.csv`, `Production.csv`, `Flows.csv`, `staid_current.csv`)
- [ ] Attach master snapshot used for update:
  - [ ] `Monitoring_Wells_Master_2024.csv`
- [ ] Attach WY2025 outputs:
  - [ ] `output/2025wy/ICWD/testwellwy2025.csv`
  - [ ] `output/2025wy/ICWD/Monitoring_Wells_Master_2025.csv`
  - [ ] `output/2025wy/ICWD/totals_means_thru_sep_2025.csv`
  - [ ] `output/2025wy/OVGA/ovga_uploads_mw_with_rpe_102024_092025_zn.csv`
  - [ ] `output/2025wy/OVGA/ovga_swflow_import_wy25.csv`
  - [ ] `output/2025wy/OVGA/ovga_production_import_wy24-25.csv`
- [ ] Update `package/inst/extdata/manifest.csv` to point at release URLs (and refresh checksums)
