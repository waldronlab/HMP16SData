#' @importFrom utils read.csv
#' @importFrom ExperimentHub createHubAccessors
#' @importFrom utils globalVariables
#'
#' @keywords internal
.onLoad <- function(libname, pkgname) {
    metadata_file <- system.file("extdata", "metadata.csv", package = pkgname)
    titles <- read.csv(metadata_file, stringsAsFactors = FALSE)$Title

    createHubAccessors(pkgname, titles)

    globalVariables(".")
}
