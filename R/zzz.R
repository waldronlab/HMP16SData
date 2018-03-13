#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom utils read.csv
#' @importFrom magrittr use_series
#' @importFrom ExperimentHub createHubAccessors
#' @importFrom utils globalVariables
.onLoad <- function(libname, pkgname) {
    system.file("extdata", "metadata.csv", package = pkgname) %>%
        read.csv(stringsAsFactors = FALSE) %>%
        use_series("Title") %>%
        unique() %>%
        createHubAccessors(pkgname = pkgname, titles = .)

    globalVariables(".")
    globalVariables("paths")
    globalVariables("BioSample Accession")
    globalVariables("SN")
    globalVariables("CONSENSUS_LINEAGE")
}
