#' @keywords internal
#'
#' @importFrom readr cols
#' @importFrom magrittr %>%
#' @importFrom readr read_tsv
quiet_read <- function(x) {
    cols(.default = "?") %>%
        read_tsv(x, col_types = ., skip = 10)
}
