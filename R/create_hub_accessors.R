#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom utils read.csv
#' @importFrom magrittr use_series
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom AnnotationHub query
#' @importFrom magrittr %<>%
#' @importFrom magrittr extract
create_hub_accessors <- function(pkgname) {
    titles <-
        system.file("extdata", "metadata.csv", package = pkgname) %>%
        read.csv(stringsAsFactors = FALSE) %>%
        use_series("Title") %>%
        unique()

    eh <-
        ExperimentHub() %>%
        query(pkgname)

    ns <- asNamespace(pkgname)

    for (title in titles) {
        ehid <-
            query(eh, title) %>%
            names()

        if (length(ehid) == 0L) {
            sQuote(title) %>%
                stop(" not found in ExperimentHub")
        } else if (length(ehid) != 1L) {
            ehid %<>%
                rev() %>%
                extract(1)
        }

        accessor <- hub_accessor_factory(ehid)

        assign(title, accessor, envir = ns)
        namespaceExport(ns, title)
    }
}
