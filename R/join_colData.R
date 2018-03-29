#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom SummarizedExperiment colData
#' @importFrom S4Vectors as.data.frame
#' @importFrom tibble rownames_to_column
#' @importFrom dplyr mutate
#' @importFrom dplyr inner_join
#' @importFrom dplyr distinct
#' @importFrom tibble column_to_rownames
join_colData <- function(dbGaP_data, x) {
    x %>%
        colData() %>%
        as.data.frame() %>%
        rownames_to_column(var = "SN") %>%
        mutate(SN = as.integer(SN)) %>%
        inner_join(dbGaP_data,  by = "SN") %>%
        distinct(SN, .keep_all = TRUE) %>%
        column_to_rownames(var = "SN") %>%
        make_DataFrame()
}
