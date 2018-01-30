translate_identifiers <- function(x) {
    gsub("(.+)__", "", x) %>%
        gsub("(.+);", "", .) %>%
        gsub("(.+)\\|", "", .) %>%
        gnr_resolve(fields = "all") %>%
        filter(submitted_name == matched_name) %>%
        filter(data_source_title == "NCBI") %>%
        delimit_clades()
}

# test_one <- "Root;p__Firmicutes;c__Bacilli;o__Lactobacillales;f__Lactobacillaceae;g__Lactobacillus"
# test_two <- "Root;Fungi;Basidiomycota;Agaricomycotina;Agaricomycetes;Agaricomycetes_Incertae sedis;Polyporales;Polyporaceae;Ryvardenia;Ryvardenia campyla"
#
# translate_identifiers(test_one)
# translate_identifiers(test_two)
