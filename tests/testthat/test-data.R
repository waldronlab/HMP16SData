context("data")

test_that("data are SummarizedExperiment objects", {
    expect_s4_class(V13(), "SummarizedExperiment")
    expect_s4_class(V35(), "SummarizedExperiment")
})
