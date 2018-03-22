#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr arrange
#' @importFrom dplyr desc
#' @importFrom magrittr set_colnames
#' @importFrom dplyr mutate
calculate_n <- function(x) {
    x %>%
        apply(2, table)  %>%
        lapply(as.data.frame) %>%
        lapply(arrange, desc(Freq)) %>%
        Reduce(rbind, .) %>%
        set_colnames(c("x", "N")) %>%
        mutate(x = as.character(x)) %>%
        mutate(N = format(N, big.mark = ",", scientific = FALSE))
}
