#' @keywords internal
#'
#' @importFrom magrittr %<>%
#' @importFrom SummarizedExperiment colData
#' @importFrom magrittr %>%
#' @importFrom S4Vectors as.data.frame
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#' @importFrom dplyr rename
tidy_data <- function(x, VISITNO, SEX, RUN_CENTER, HMP_BODY_SITE,
                      HMP_BODY_SUBSITE) {
    x %<>%
        colData() %>%
        as.data.frame() %>%
        select(VISITNO, SEX, RUN_CENTER, HMP_BODY_SITE, HMP_BODY_SUBSITE)

    if (VISITNO) {
        x %<>%
            mutate(
                VISITNO = case_when(
                    VISITNO == "1" ~ "One",
                    VISITNO == "2" ~ "Two",
                    VISITNO == "3" ~ "Three"
                )
            ) %>%
            rename(`Visit Number` = VISITNO)
    } else {
        x %<>%
            select(-VISITNO)
    }

    if (SEX) {
        x %<>%
            rename(Sex = SEX)
    } else {
        x %<>%
            select(-SEX)
    }

    if (RUN_CENTER) {
        x %<>%
            mutate(RUN_CENTER = gsub("0", "Missing", RUN_CENTER)) %>%
            mutate(
                RUN_CENTER = gsub("BCM", "Baylor College of Medicine",
                                  RUN_CENTER)
            ) %>%
            mutate(RUN_CENTER = gsub("BI", "Broad Institute", RUN_CENTER)) %>%
            mutate(
                RUN_CENTER = gsub("JCVI", "J. Craig Venter Institute",
                                  RUN_CENTER)
            ) %>%
            mutate(
                RUN_CENTER = gsub(
                    "WUGC",
                    "Genome Sequencing Center at Washington University",
                    RUN_CENTER
                )
            ) %>%
            mutate(RUN_CENTER = gsub(",", ", ", RUN_CENTER)) %>%
            rename(`Run Center` = RUN_CENTER)
    } else {
        x %<>%
            select(-RUN_CENTER)
    }

    if (HMP_BODY_SITE) {
        x %<>%
            rename(`HMP Body Site` = HMP_BODY_SITE)
    } else {
        x %<>%
            select(-HMP_BODY_SITE)
    }

    if (HMP_BODY_SUBSITE) {
        x %<>%
            rename(`HMP Body Subsite` = HMP_BODY_SUBSITE)
    } else {
        x %<>%
            select(-HMP_BODY_SUBSITE)
    }

    x
}
