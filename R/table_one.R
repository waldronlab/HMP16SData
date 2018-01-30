#' Title
#'
#' @param foo description
#' @param visit_number description
#' @param sex description
#' @param run_center description
#' @param hmp_body_subsite description
#'
# @return
#' @export
#'
# @examples
#'
#' @importFrom magrittr %<>%
#' @importFrom SummarizedExperiment colData
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#' @importFrom dplyr rename
#' @importFrom tools toTitleCase
#' @importFrom dplyr rename_all
table_one <- function(foo, visit_number = TRUE, sex = TRUE, run_center = FALSE,
                      hmp_body_subsite = TRUE) {
    foo %<>%
        colData() %>%
        as.data.frame() %>%
        select(-run_sample_id) %>%
        select(-description)

    if(visit_number) {
        foo %<>%
            mutate(
                visit_number = case_when(
                    visit_number == "1" ~ "One",
                    visit_number == "2" ~ "Two",
                    visit_number == "3" ~ "Three"
                )
            )
    } else {
        foo %<>%
            select(-visit_number)
    }

    if(sex) {
        foo %<>%
            mutate(sex = toTitleCase(sex))
    } else {
        foo %<>%
            select(-sex)
    }

    if(run_center) {
        foo %<>%
            mutate(run_center = gsub("0", "Missing", run_center)) %>%
            mutate(run_center = gsub("BCM", "Baylor College of Medicine", run_center)) %>%
            mutate(run_center = gsub("BI", "Broad Institute", run_center)) %>%
            mutate(run_center = gsub("JCVI", "J. Craig Venter Institute", run_center)) %>%
            mutate(run_center = gsub("WUGC", "Genome Sequencing Center at Washington University", run_center)) %>%
            mutate(run_center = gsub(",", "/", run_center)) %>%
            rename(institution = run_center)
    } else {
        foo %<>%
            select(-run_center)
    }

    if(hmp_body_subsite) {
        foo %<>%
            mutate(hmp_body_subsite = gsub("_", " ", hmp_body_subsite)) %>%
            mutate(hmp_body_subsite = toTitleCase(hmp_body_subsite)) %>%
            rename(body_habitat = hmp_body_subsite)
    } else {
        foo %<>%
            select(-hmp_body_subsite)
    }

    foo %<>%
        rename_all(gsub, pattern = "_", replacement = " ") %>%
        rename_all(toTitleCase)

    foo
}
