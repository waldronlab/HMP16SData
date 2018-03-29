#' Produce a summary data.frame of key demographic variables
#'
#' Sometimes it is desirable to produce a summary of key demographic variables..
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object or
#' a named \code{list} of
#' \code{\link[SummarizedExperiment]{SummarizedExperiment}} objects from the
#' \code{\link{HMP16SData}} package
#' @param VISITNO logical; if \code{FALSE}, the \code{VISITNO} column is dropped
#' @param SEX logical; if \code{FALSE}, the \code{SEX} column is dropped
#' @param RUN_CENTER logical; if \code{FALSE}, the \code{RUN_CENTER} column is
#' dropped
#' @param HMP_BODY_SITE logical; if \code{FALSE}, the \code{HMP_BODY_SITE}
#' column is dropped
#' @param HMP_BODY_SUBSITE logical; if \code{FALSE}, the \code{HMP_BODY_SUBSITE}
#' column is dropped
#'
#' @return A \code{data.frame} object or a named \code{list} of
#' \code{data.frame} objects
#' @export
#'
#' @seealso \code{\link{kable_one}}
#'
#' @examples
#' V13() %>%
#'     table_one()
#'
#' @importFrom magrittr %>%
#' @importFrom assertthat assert_that
#' @importFrom magrittr %<>%
#' @importFrom magrittr extract2
table_one <- function(x, VISITNO = TRUE, SEX = TRUE, RUN_CENTER = TRUE,
                      HMP_BODY_SITE = TRUE, HMP_BODY_SUBSITE = TRUE) {
    if (class(x) == "list") {
        names(x) %>%
            is.null() %>%
            isFALSE() %>%
            assert_that(msg = "list elements must be named")
    }

    if (class(x) != "list") {
        assert_that(class(x) == "SummarizedExperiment")

        x %<>%
            list()
    }

    assert_that(class(x) == "list")

    x %<>%
        lapply(tidy_data, VISITNO, SEX, RUN_CENTER, HMP_BODY_SITE,
               HMP_BODY_SUBSITE)

    if (length(x) == 1) {
        x %<>%
            extract2(1)
    }

    x
}
