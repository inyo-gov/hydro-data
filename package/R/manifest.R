#' Read the dataset manifest
#'
#' The manifest lists datasets, years, filenames, and URLs used by
#' \code{hydrodata_fetch()}.
#'
#' @return A data frame with manifest rows, or an empty data frame if the
#'   manifest is not available.
#' @export
hydrodata_manifest <- function() {
  path <- system.file("extdata", "manifest.csv", package = "hydrodata")
  if (!file.exists(path)) {
    return(data.frame())
  }
  utils::read.csv(path, stringsAsFactors = FALSE)
}

#' List available datasets
#'
#' @param year Optional year filter (character or numeric).
#' @return A data frame of available datasets.
#' @export
hydrodata_list <- function(year = NULL) {
  mf <- hydrodata_manifest()
  if (nrow(mf) == 0) {
    return(mf)
  }
  if (!is.null(year)) {
    mf <- mf[mf$year == as.character(year), , drop = FALSE]
  }
  mf
}
