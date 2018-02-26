#' Translate taxonomic identifiers to NCBI taxonomy standard
#'
#' @param x a taxonomic identifiers to translate to NCBI taxonomy standard
#'
# @return
#' @export
#'
# @examples
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
