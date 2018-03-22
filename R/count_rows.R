#' @keywords internal
#'
#' @importFrom magrittr %>%
count_rows <- function(x) {
    x %>%
        apply(2, unique) %>%
        sapply(length) %>%
        cumsum() %>%
        as.integer()
}
