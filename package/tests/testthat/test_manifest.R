test_that("manifest has required columns and checksums", {
  mf <- hydrodata_manifest()
  expect_true(nrow(mf) > 0)
  expect_true(all(c("year", "dataset", "filename", "url", "sha256") %in% names(mf)))

  sha <- mf$sha256
  expect_true(all(nchar(sha) == 64))
  expect_true(all(grepl("^[0-9a-f]{64}$", sha)))
})
