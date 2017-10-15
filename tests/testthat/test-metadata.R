context("metadata")

metadata_file <- system.file("extdata", "metadata.csv", package = "HMP16SData")

test_that("metadata.csv file is present", {
    expect_true(file.exists(metadata_file))
})

test_that("metadata.csv file does not contain empty values", {
    expect_false(any(grepl(",,", readLines(metadata_file))))
})
