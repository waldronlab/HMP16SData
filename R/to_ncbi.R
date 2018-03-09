#' @importFrom magrittr %>%
#' @importFrom taxize gnr_resolve
#' @importFrom dplyr filter
#'
#' @keywords internal
to_ncbi <- function(x) {
    taxize_data <-
        gsub("(.+)__", "", x) %>%
        gsub("(.+);", "", .) %>%
        gsub("(.+)\\|", "", .) %>%
        gnr_resolve(fields = "all")

    if (nrow(taxize_data) == 0){
        return(NA_character_)
    } else {
        taxize_data %>%
            filter(submitted_name == matched_name) %>%
            filter(data_source_title == "NCBI") %>%
            delimit_clades()
    }
}
