#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom magrittr subtract
#' @importFrom knitr kable
align_kable <- function(x) {
    format_args <- list(nsmall = 2, scientific = FALSE)

    align_arg <-
        ncol(x) %>%
        subtract(1) %>%
        rep("r", .) %>%
        c("l", .) %>%
        paste0()

    x %>%
        kable("html", digits = 2, align = align_arg, format.args = format_args)
}
