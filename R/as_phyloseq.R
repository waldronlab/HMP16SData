#' Coerce a SummarizedExperiment class object to a phyloseq class object
#'
#' @param x a SummarizedExperiment object from the HMP16SData package
#'
#' @return a phyloseq object
#' @export
#'
#' @examples V13() %>% as.phyloseq()
#'
#' @importFrom assertthat see_if
# @importFrom SummarizedExperiment assay
#' @importFrom magrittr %>%
# @importFrom SummarizedExperiment colData
# @importFrom S4Vectors as.data.frame
# @importFrom SummarizedExperiment rowData
# @importFrom S4Vectors as.matrix
#' @importFrom magrittr set_rownames
as_phyloseq <- function(x) {
    see_if(class(x) == "SummarizedExperiment")

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
        set_rownames(tax_table, .) %>%
        phyloseq::tax_table()

    phyloseq::phyloseq(otu_table, sample_data, tax_table)
}
