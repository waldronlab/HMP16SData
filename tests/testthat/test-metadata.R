context("metadata")

metadata_file <- system.file("extdata", "metadata.csv", package = "HMP16SData")

test_that("metadata.csv file is present", {
    file.exists(metadata_file) %>%
        expect_true()
})

test_that("metadata.csv file does not contain empty values", {
    readLines(metadata_file) %>%
        grepl(",,", x = .) %>%
        any() %>%
        expect_false()
})
