#' Translate taxonomic identifiers to NCBI taxonomy standard
#'
#' @param x a taxonomic identifier to translate to NCBI taxonomy standard
#'
#' @return a taxonomic identifier translated to NCBI taxonomy standard
#' @export
#'
#' @examples translate_identifiers("f__LaCtObaCiLlAcEaE;g__LaCTobaCIllus")
#'
#' @importFrom magrittr %>%
#' @importFrom taxize gnr_resolve
#' @importFrom dplyr filter
translate_identifiers <- function(x) {
    gsub("(.+)__", "", x) %>%
        gsub("(.+);", "", .) %>%
        gsub("(.+)\\|", "", .) %>%
        gnr_resolve(fields = "all") %>%
        filter(submitted_name == matched_name) %>%
        filter(data_source_title == "NCBI") %>%
        delimit_clades()
}

lilEx <- function(x, taxonomy_column = "consensus_lineage") {
    x %>%
        rowData() %>%
        extract(1:3, taxonomy_column) %>%
        sapply(translate_identifiers, USE.NAMES = FALSE)
}

V13 %>% lilEx()
