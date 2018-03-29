#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr full_join
quiet_join <- function(x, y) {
    list(x, y) %>%
        lapply(colnames) %>%
        Reduce(intersect, x = .) %>%
        full_join(x, y, by = .)
}
