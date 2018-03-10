#' Coerce a SummarizedExperiment object to a phyloseq object
#'
#' Description
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#' from the \code{\link{HMP16SData}} package
#'
#' @return A \code{\link[phyloseq]{phyloseq-class}} class object
#' @export
#'
# @examples
# V13() %>%
#     as_phyloseq()
#'
#' @importFrom assertthat assert_that
#' @importFrom SummarizedExperiment assay
#' @importFrom magrittr %>%
#' @importFrom SummarizedExperiment colData
#' @importFrom S4Vectors as.data.frame
#' @importFrom SummarizedExperiment rowData
#' @importFrom S4Vectors as.matrix
#' @importFrom magrittr set_rownames
as_phyloseq <- function(x) {
    assert_that(class(x) == "SummarizedExperiment")

    if (!requireNamespace("phyloseq")) {
        stop("Please install the 'phyloseq' package to make phyloseq objects")
    }

    otu_table <-
        assay(x) %>%
        phyloseq::otu_table(taxa_are_rows = TRUE)

    sample_data <-
        colData(x) %>%
        as.data.frame() %>%
        phyloseq::sample_data()

    tax_table <-
        rowData(x) %>%
        as.matrix() %>%
        subset(select = -CONSENSUS_LINEAGE)

    tax_table <-
        rownames(otu_table) %>%
        set_rownames(tax_table, value = .) %>%
        phyloseq::tax_table()

    phyloseq::phyloseq(otu_table, sample_data, tax_table)
}
