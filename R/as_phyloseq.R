#' Coerce a SummarizedExperiment object to a phyloseq object
#'
#' The \code{\link[phyloseq]{phyloseq-package}} provides a suite of methods for
#' working with 16S rRNA sequencing and other microbiome data that may be of use
#' to the users of \code{\link{HMP16SData}}. The \code{as_phyloseq} method
#' provides a means to easily coerce a
#' \code{\link[SummarizedExperiment]{SummarizedExperiment-class}} object to a
#' \code{\link[phyloseq]{phyloseq-class}} object.
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object from the \code{\link{HMP16SData}} package
#'
#' @return A \code{\link[phyloseq]{phyloseq-class}} object
#' @export
#'
#' @examples
#' V13() %>%
#'     as_phyloseq()
#'
#' @importFrom assertthat assert_that
#' @importFrom SummarizedExperiment assay
#' @importFrom magrittr %>%
#' @importFrom SummarizedExperiment colData
#' @importFrom S4Vectors as.data.frame
#' @importFrom SummarizedExperiment rowData
#' @importFrom S4Vectors as.matrix
#' @importFrom magrittr set_rownames
#' @importFrom S4Vectors metadata
#' @importFrom magrittr use_series
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

    phy_tree <-
        metadata(x) %>%
        use_series(phylogeneticTree)

    phyloseq::phyloseq(otu_table, sample_data, tax_table, phy_tree)
}
