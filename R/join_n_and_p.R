#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr full_join
#' @importFrom dplyr mutate
#' @importFrom dplyr arrange
join_n_and_p <- function(x, y) {
    row_order <-
        mapply(order_rows, x$x, y$x) %>%
        Reduce(c, .) %>%
        unique()

    z <-
        full_join(x, y, by = "x") %>%
        mutate(x = factor(x, row_order)) %>%
        arrange(x) %>%
        mutate(x = as.character(x))

    z[is.na(z)] <- 0

    z
}
