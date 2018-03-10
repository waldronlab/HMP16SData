#' @keywords internal
#'
#' @importFrom methods slotNames
#' @importFrom methods slot
#' @importFrom methods slot<-
#' @importFrom magrittr %>%
fix_MIAME <- function(x) {
    for (i in slotNames(x)) {
        if (class(slot(x, i)) == "character") {
            slot(x, i) <-
                slot(x, i) %>%
                gsub("\\s+", " ", x = .)
        }
    }

    x
}
