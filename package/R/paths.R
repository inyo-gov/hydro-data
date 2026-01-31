#' Local cache directory for hydrodata files
#'
#' Returns the user-specific cache directory used to store downloaded
#' datasets. On modern R versions this uses \code{tools::R_user_dir};
#' otherwise it falls back to \code{~/.cache/hydrodata}.
#'
#' @return A character path to the cache directory.
#' @export
hydrodata_data_dir <- function() {
  if ("tools" %in% loadedNamespaces() && "R_user_dir" %in% getNamespaceExports("tools")) {
    return(tools::R_user_dir("hydrodata", "cache"))
  }
  path <- file.path(path.expand("~"), ".cache", "hydrodata")
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }
  path
}

#' Base URL for published datasets
#'
#' Reads the \code{hydrodata.base_url} option if set, otherwise returns
#' the default GitHub raw URL for the hydro-data repository outputs.
#'
#' @return A character URL prefix.
#' @export
hydrodata_base_url <- function() {
  opt <- getOption("hydrodata.base_url")
  if (!is.null(opt) && nzchar(opt)) {
    return(opt)
  }
  "https://raw.githubusercontent.com/inyo-gov/hydro-data/main/output"
}
