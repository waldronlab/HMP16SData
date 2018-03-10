#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom readr read_tsv
#' @importFrom dplyr full_join
read_dbGaP <- function() {
    list(paths$EMMES_HMP_Sample_file_path,
         paths$EMMES_HMP_GTV_file_path,
         paths$EMMES_HMP_DTP_DHX_DVD_file_path,
         paths$EMMES_HMP_DCM_file_path,
         paths$EMMES_HMP_Subject_file_path,
         paths$EMMES_HMP_DEM_ENR_file_path,
         paths$EMMES_HMP_DSU_file_path) %>%
        lapply(read_tsv, skip = 10) %>%
        Reduce(full_join, x = .)
}
