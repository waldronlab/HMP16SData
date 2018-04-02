#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom magrittr subtract
#' @importFrom knitr kable
align_kable <- function(x, significant_figures) {
    format_args <- list(nsmall = significant_figures, scientific = FALSE)

    align_arg <-
        ncol(x) %>%
        subtract(1) %>%
        rep("r", .) %>%
        c("l", .) %>%
        paste0()

    x %>%
        kable("html", digits = significant_figures, align = align_arg,
              format.args = format_args)
}
