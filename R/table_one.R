#' Produce a summary data.frame of key demographic variables
#'
#' Sometimes it is desirable to produce a summary of key demographic variables
#' for presentation. The \code{\link{table_one}} and \code{\link{kable_one}}
#' methods are a quick way to do so – they not only summarize key demographic
#' variables from \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object(s) in the \code{\link{HMP16SData}} package but remove abbreviations
#' and underscores in column and variable names that might otherwise be
#' ambigious. The \code{\link{table_one}} method returns a \emph{tidy} (i.e. one
#' sample observation per line) \code{data.frame} object or a named \code{list}
#' of \emph{tidy} \code{data.frame} objects. The \code{\link{kable_one}} method
#' can then be used to produce a publication-ready \code{HTML} table that could,
#' for example, be pasted into a word processor.
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object or a named \code{list} of
#' \code{\link[SummarizedExperiment]{SummarizedExperiment-class}} objects from
#' the \code{\link{HMP16SData}} package
#' @param VISITNO logical; if \code{FALSE}, the \code{VISITNO} column(s) of
#' \code{SummarizedExperiment} \code{colData} will not be summarized
#' @param SEX logical; if \code{FALSE}, the \code{SEX} column(s) of
#' \code{SummarizedExperiment} \code{colData} will not be summarized
#' @param RUN_CENTER logical; if \code{FALSE}, the \code{RUN_CENTER} column(s)
#' of \code{SummarizedExperiment} \code{colData} will not be summarized
#' @param HMP_BODY_SITE logical; if \code{FALSE}, the \code{HMP_BODY_SITE}
#' column(s) of \code{SummarizedExperiment} \code{colData} will not be
#' summarized
#' @param HMP_BODY_SUBSITE logical; if \code{FALSE}, the \code{HMP_BODY_SUBSITE}
#' column(s) of \code{SummarizedExperiment} \code{colData} will not be
#' summarized
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
