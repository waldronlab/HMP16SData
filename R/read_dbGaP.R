#' @importFrom magrittr %>%
#' @importFrom readr read_tsv
#' @importFrom dplyr full_join
#' @importFrom dplyr select
#' @importFrom dplyr everything
#'
#' @keywords internal
read_dbGaP <- function() {
    list("~/ncbi/dbGaP-12146/files/phs000228.v4.pht001185.v4.p1.EMMES_HMP_Sample.MULTI.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht001193.v3.p1.c1.EMMES_HMP_GTV.HMP.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht002157.v1.p1.c1.EMMES_HMP_DTP_DHX_DVD.HMP.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht001187.v3.p1.c1.EMMES_HMP_DCM.HMP.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht001184.v3.p1.EMMES_HMP_Subject.MULTI.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht002158.v1.p1.c1.EMMES_HMP_DEM_ENR.HMP.txt.gz",
         "~/ncbi/dbGaP-12146/files/phs000228.v4.pht002156.v1.p1.c1.EMMES_HMP_DSU.HMP.txt.gz") %>%
        sapply(read_tsv, skip = 10) %>%
        Reduce(full_join, .) %>%
        select(SN, everything())
}
