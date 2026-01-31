#' Download and cache a dataset
#'
#' Downloads the requested dataset listed in the manifest and stores it
#' in a local cache directory. Returns the local file path. If a SHA-256
#' checksum is present in the manifest, the download is verified and an
#' error is raised on mismatch.
#'
#' @param dataset Dataset key from the manifest (e.g., "totals_means").
#' @param year Water year to fetch (default "2025").
#' @param refresh If \code{TRUE}, re-download even if cached.
#' @param dest_dir Optional directory to store the download.
#' @return Local file path to the downloaded dataset.
#' @export
hydrodata_fetch <- function(dataset, year = "2025", refresh = FALSE, dest_dir = NULL) {
  mf <- hydrodata_manifest() # nolint
  if (nrow(mf) == 0) {
    stop("No manifest found. Populate inst/extdata/manifest.csv and reinstall.")
  }

  row <- mf[mf$dataset == dataset & mf$year == as.character(year), , drop = FALSE]
  if (nrow(row) == 0) {
    stop("Dataset not found in manifest for requested year.")
  }

  if (is.null(dest_dir)) {
    dest_dir <- hydrodata_data_dir() # nolint
  }
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
  }

  dest_path <- file.path(dest_dir, row$filename[1])
  if (!file.exists(dest_path) || refresh) {
    url <- row$url[1]
    utils::download.file(url, dest_path, mode = "wb", quiet = TRUE)
  }

  checksum <- row$sha256[1]
  if (!is.na(checksum) && nzchar(checksum)) {
    hash <- openssl::sha256(file = dest_path)
    hash_hex <- paste(sprintf("%02x", hash), collapse = "")
    if (!identical(hash_hex, checksum)) {
      unlink(dest_path)
      stop("Checksum mismatch for downloaded file.")
    }
  }

  dest_path
}
