#' @keywords internal
#'
#' @importFrom utils globalVariables
.onLoad <- function(libname, pkgname) {
    create_hub_accessors(pkgname)

    globalVariables(".")
    globalVariables("paths")
    globalVariables("BioSample Accession")
    globalVariables("SN")
    globalVariables("CONSENSUS_LINEAGE")
    globalVariables("Freq")
    globalVariables("N")
    globalVariables("%")
}
