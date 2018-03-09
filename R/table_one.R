#' Produce a data.frame of categorical variables that can be summarized
#'
#' @param x a SummarizedExperiment object from the HMP16SData package
#' @param visit_number logical indicating if visit_number should be included
#' @param sex logical indicating if sex should be included
#' @param run_center logical indicating if run_center should be included
#' @param hmp_body_subsite logical indicating if hmp_body_subsite should be
#' included
#'
#' @return a tidy \code{data.frame} with one sample observation per row ready to
#' be summarized
#' @export
#'
#' @examples
#' V35() %>%
#'     table_one()
#'
#' @importFrom magrittr %<>%
#' @importFrom SummarizedExperiment colData
#' @importFrom magrittr %>%
#' @importFrom S4Vectors as.data.frame
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#' @importFrom dplyr rename
#' @importFrom tools toTitleCase
#' @importFrom dplyr rename_all
table_one <- function(x, visit_number = TRUE, sex = TRUE, run_center = FALSE,
                      hmp_body_subsite = TRUE) {
    x %<>%
        colData() %>%
        as.data.frame() %>%
        select(visit_number, sex, run_center, hmp_body_subsite)

    if (visit_number) {
        x %<>%
            mutate(
                visit_number = case_when(
                    visit_number == "1" ~ "One",
                    visit_number == "2" ~ "Two",
                    visit_number == "3" ~ "Three"
                )
            )
    } else {
        x %<>%
            select(-visit_number)
    }

    if (sex) {
        x %<>%
            mutate(sex = toTitleCase(sex))
    } else {
        x %<>%
            select(-sex)
    }

    if (run_center) {
        x %<>%
            mutate(run_center = gsub("0", "Missing", run_center)) %>%
            mutate(run_center =
                       gsub("BCM", "Baylor College of Medicine", run_center)
                   ) %>%
            mutate(run_center = gsub("BI", "Broad Institute", run_center)) %>%
            mutate(run_center =
                       gsub("JCVI", "J. Craig Venter Institute", run_center)
                   ) %>%
            mutate(run_center =
                       gsub(
                           "WUGC",
                           "Genome Sequencing Center at Washington University",
                           run_center)
                   ) %>%
            mutate(run_center = gsub(",", "/", run_center)) %>%
            rename(institution = run_center)
    } else {
        x %<>%
            select(-run_center)
    }

    if (hmp_body_subsite) {
        x %<>%
            mutate(hmp_body_subsite = gsub("_", " ", hmp_body_subsite)) %>%
            mutate(hmp_body_subsite = toTitleCase(hmp_body_subsite)) %>%
            rename(body_habitat = hmp_body_subsite)
    } else {
        x %<>%
            select(-hmp_body_subsite)
    }

    x %<>%
        rename_all(gsub, pattern = "_", replacement = " ") %>%
        rename_all(toTitleCase)

    x
}
