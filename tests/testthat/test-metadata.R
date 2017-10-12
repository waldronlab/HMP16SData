context("metadata")

test_that("metadata.csv file is present", {
  file.exists("inst/extdata/metadata.csv")
})
