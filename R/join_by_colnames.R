#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr full_join
join_by_colnames <- function(x, y) {
    list(x, y) %>%
        lapply(colnames) %>%
        Reduce(c, .) %>%
        unique() %>%
        full_join(x, y, by = .)
}
