#' @keywords internal
order_rows <- function(x, y) {
    if (x == y) {
        x
    } else {
        c(x, y)
    }
}
