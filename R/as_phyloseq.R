#' Coerce a SummarizedExperiment class object to a phyloseq class object
#'
#' @param x a SummarizedExperiment object from the HMP16SData package
#'
#' @return a phyloseq object
#' @export
#'
#' @examples V13() %>% as.phyloseq()
#'
#' @importFrom assertthat see_if
#' @importFrom magrittr %>%
as_phyloseq <- function(x) {
    see_if(class(x) == "SummarizedExperiment")

    if (!requireNamespace("phyloseq")) {
        stop("Please install the 'phyloseq' package to make phyloseq objects")
    }

}
