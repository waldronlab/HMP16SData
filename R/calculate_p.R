#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom magrittr set_colnames
#' @importFrom dplyr mutate
calculate_p <- function(x) {
    x %>%
        apply(2, table)  %>%
        lapply(prop.table) %>%
        lapply(sort, decreasing = TRUE) %>%
        lapply(as.data.frame) %>%
        Reduce(rbind, .) %>%
        set_colnames(c("x", "%")) %>%
        mutate(x = as.character(x)) %>%
        mutate(`%` = `%` * 100)
}
