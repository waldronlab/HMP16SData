#' Title
#'
#' Description
#'
#' @param x Description
#' @param VISITNO Description
#' @param SEX Description
#' @param RUN_CENTER Description
#' @param HMP_BODY_SITE Description
#' @param HMP_BODY_SUBSITE Description
#'
#' @return Description
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
