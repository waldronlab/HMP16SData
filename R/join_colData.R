join_colData <- function(dbGaP_data, HMP16S_data) {
    HMP16S_data %>%
        colData() %>%
        as.data.frame() %>%
        rownames_to_column(var = "SN") %>%
        mutate(SN = as.integer(SN)) %>%
        inner_join(dbGaP_data) %>%
        distinct(SN, .keep_all = TRUE) %>%
        column_to_rownames("SN") %>%
        DataFrame()
}
