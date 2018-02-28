#' Translate taxonomic identifiers to NCBI taxonomy standard
#'
#' @param x a SummarizedExperiment object with taxonomic identifiers to
#' translate NCBI taxonomy standard
#' @param taxonomy_column the name of the rowData column that contains taxonomic
#' identifiers to be translated
#'
#' @return A SummarizedExperiment object with taxonomic identifiers translated
#' NCBI taxonomy standard. A column, ncbi_taxonomy, is added to rowData with the
#' following syntax: n__NCBI Taxonomy ID, pk__superkingdom, k__kingdom,
#' bk__subkingdom, p__phylum, bp__subphylum, c__class, o__order, f__family,
#' g__genus, s__species. Taxonomic levels are pipe delimited and represented as
#' a character string. For example:
#' n__1578|pk__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales|f__...
#'
#' @export
#'
#' @note Be aware that translation of taxonomic identifiers uses the Global
#' Names Recognition and Discovery API and the translation of many identifiers
#' will take a long time.
#'
#' @examples V13()[1:5, 1:5] %>% translate_identifiers()
#'
#' @importFrom SummarizedExperiment rowData<-
#' @importFrom SummarizedExperiment rowData
#' @importFrom magrittr %>%
#' @importFrom magrittr extract
#' @importFrom pbapply pbsapply
translate_identifiers <- function(x, taxonomy_column = "consensus_lineage") {
    rowData(x)$ncbi_taxonomy <-
        rowData(x) %>%
        extract(, taxonomy_column) %>%
        pbsapply(to_ncbi, USE.NAMES = FALSE)

    x
}
