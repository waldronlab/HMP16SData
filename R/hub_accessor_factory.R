#' @keywords internal
#'
#' @importFrom ExperimentHub ExperimentHub
hub_accessor_factory <- function(ehid) {
    force(ehid)

    function(metadata = FALSE) {
        eh <- ExperimentHub()

        if (metadata) {
            eh[ehid]
        } else {
            eh[[ehid]]
        }
    }
}
