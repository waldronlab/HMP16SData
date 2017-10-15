context("data")

test_that("data are SummarizedExperiment objects", {
    data("20171011.V13")
    expect_s4_class(V13, "SummarizedExperiment")
    data("20171011.V35")
    expect_s4_class(V35, "SummarizedExperiment")
})
