# hydrodata (package prototype)

This package prototype provides lightweight helpers to fetch water-year datasets
used in the Hydro Data reports. Data are stored outside the package and pulled
on demand using a manifest file.

## Quick start

```r
install.packages("remotes")
remotes::install_github("inyo-gov/hydro-data", subdir = "package")

options(hydrodata.base_url = "https://raw.githubusercontent.com/inyo-gov/hydro-data/main/output")

hydrodata::hydrodata_list("2025")
path <- hydrodata::hydrodata_fetch("totals_means", year = "2025")
```

## How it works

- `inst/extdata/manifest.csv` lists datasets, years, filenames, and URLs.
- `hydrodata_fetch()` downloads and caches files locally.
- Set `options(hydrodata.base_url = "...")` to point at a Zenodo or OSF release.

## Next steps

- Move report content into a vignette (e.g., `vignettes/flow-report.Rmd`).
- Add data validation and checksums to the manifest.
- Publish yearly releases and update the manifest URLs.
