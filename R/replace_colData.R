#' @keywords internal
#'
#' @importFrom SummarizedExperiment colData<-
replace_colData <- function(new_colData, x) {
    colData(x) <- new_colData

    x
}
