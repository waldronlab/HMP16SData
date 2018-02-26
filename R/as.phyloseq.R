#' Coerce a SummarizedExperiment class object to a phyloseq class object
#'
#' @param x A SummarizedExperiment object from the HMP16SData package
#'
#' @return a phyloseq object
#' @export
#'
#' @examples V13() %>% as.phyloseq()
#'
#' @importFrom assertthat see_if
#' @importFrom magrittr %>%
#' @importFrom methods as
#' @importFrom curatedMetagenomicData ExpressionSet2phyloseq
as.phyloseq <- function(x) {
    see_if(class(x) == "SummarizedExperiment")

    as(x, "ExpressionSet") %>%
        ExpressionSet2phyloseq()
}
