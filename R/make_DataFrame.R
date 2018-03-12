#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom S4Vectors DataFrame
make_DataFrame <- function(x) {
    rownames(x) %>%
        DataFrame(x, row.names = .)
}
