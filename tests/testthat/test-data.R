context("data")

test_that("data are SummarizedExperiment objects", {
    V13() %>%
        expect_s4_class("SummarizedExperiment")

    V35() %>%
        expect_s4_class("SummarizedExperiment")
})
