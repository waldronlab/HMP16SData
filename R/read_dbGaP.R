#' @keywords internal
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr rename
read_dbGaP <- function(dbGaP_directory) {
    list(paths$EMMES_HMP_Sample_file,
         paths$EMMES_HMP_GTV_file,
         paths$EMMES_HMP_DTP_DHX_DVD_file,
         paths$EMMES_HMP_DCM_file,
         paths$EMMES_HMP_Subject_file,
         paths$EMMES_HMP_DEM_ENR_file,
         paths$EMMES_HMP_DSU_file) %>%
        lapply(c, dbGaP_directory) %>%
        lapply(rev) %>%
        lapply(paste, collapse = .Platform$file.sep) %>%
        lapply(quiet_read) %>%
        Reduce(quiet_join, x = .) %>%
        rename(BioSample_Accession = `BioSample Accession`)
}
