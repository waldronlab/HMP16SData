#' @keywords internal
#'
#' @importFrom magrittr %>%
count_rows <- function(x) {
    x %>%
        apply(2, unique) %>%
        lapply(length) %>%
        as.integer() %>%
        cumsum()
}
