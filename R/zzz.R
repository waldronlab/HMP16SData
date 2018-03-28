#' @keywords internal
#'
#' @importFrom utils globalVariables
.onLoad <- function(libname, pkgname) {
    create_hub_accessors(pkgname)

    globalVariables("CONSENSUS_LINEAGE")
    globalVariables(".")
    globalVariables("phylogeneticTree")
    globalVariables("paths")
    globalVariables("BioSample Accession")
    globalVariables("SN")
    globalVariables("Freq")
    globalVariables("N")
    globalVariables("%")
}
