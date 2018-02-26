#' @importFrom magrittr %>%
#' @importFrom SummarizedExperiment colData
#' @importFrom tibble rownames_to_column
#' @importFrom dplyr mutate
#' @importFrom dplyr inner_join
#' @importFrom dplyr distinct
#' @importFrom tibble column_to_rownames
#' @importFrom S4Vectors DataFrame
#'
#' @keywords internal
join_colData <- function(dbGaP_data, x) {
    x %>%
        colData() %>%
        as.data.frame() %>%
        rownames_to_column(var = "SN") %>%
        mutate(SN = as.integer(SN)) %>%
        inner_join(dbGaP_data) %>%
        distinct(SN, .keep_all = TRUE) %>%
        column_to_rownames("SN") %>%
        DataFrame()
}
