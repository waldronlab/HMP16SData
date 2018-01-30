#' @keywords internal
delimit_clades <- function(taxize_data) {
    clade_id <-
        use_series(taxize_data, taxon_id) %>%
        paste0("n__", .)

    clade_ranks <-
        use_series(taxize_data, classification_path_ranks) %>%
        strsplit("\\|") %>%
        unlist() %>%
        extract(-1) %>%
        gsub("superkingdom", "pk__", .) %>%
        gsub("subkingdom", "bk__", .) %>%
        gsub("kingdom", "k__", .) %>%
        gsub("subphylum", "bp__", .) %>%
        gsub("phylum", "p__", .) %>%
        gsub("class", "c__", .) %>%
        gsub("order", "o__", .) %>%
        gsub("family", "f__", .) %>%
        gsub("genus", "g__", .) %>%
        gsub("species", "s__", .)

    clade_names <-
        use_series(taxize_data, classification_path) %>%
        strsplit("\\|") %>%
        unlist() %>%
        extract(-1)

    clade_data <-
        cbind.data.frame(clade_ranks, clade_names) %>%
        filter(clade_ranks != "") %>%
        filter(clade_names != "")

    clade_data %$%
        paste0(clade_ranks, clade_names) %>%
        paste0(collapse = "|") %>%
        paste(clade_id, ., sep = "|")
}
