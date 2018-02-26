#' @importFrom SummarizedExperiment colData
#'
#' @keywords internal
replace_colData <- function(new_colData, x) {
    colData(x) <- new_colData
    x
}
