#' @keywords internal
#'
#' @importFrom dplyr full_join
calculate_n_and_p <- function(x) {
    y <- calculate_n(x)
    z <- calculate_p(x)
    full_join(y, z, by = "x")
}
