#' @keywords internal
#'
#' @importFrom utils globalVariables
globalVariables("paths")

paths <- new.env()

paths$home_directory <- Sys.getenv("HOME")
paths$ncbi_directory <- "ncbi"
paths$dbGaP_directory <- "dbGaP-12146"
paths$files_directory <- "files"

paths$EMMES_HMP_Sample_file <-
    "phs000228.v4.pht001185.v4.p1.EMMES_HMP_Sample.MULTI.txt.gz"

paths$EMMES_HMP_GTV_file <-
    "phs000228.v4.pht001193.v3.p1.c1.EMMES_HMP_GTV.HMP.txt.gz"

paths$EMMES_HMP_DTP_DHX_DVD_file <-
    "phs000228.v4.pht002157.v1.p1.c1.EMMES_HMP_DTP_DHX_DVD.HMP.txt.gz"

paths$EMMES_HMP_DCM_file <-
    "phs000228.v4.pht001187.v3.p1.c1.EMMES_HMP_DCM.HMP.txt.gz"

paths$EMMES_HMP_Subject_file <-
    "phs000228.v4.pht001184.v3.p1.EMMES_HMP_Subject.MULTI.txt.gz"

paths$EMMES_HMP_DEM_ENR_file <-
    "phs000228.v4.pht002158.v1.p1.c1.EMMES_HMP_DEM_ENR.HMP.txt.gz"

paths$EMMES_HMP_DSU_file <-
    "phs000228.v4.pht002156.v1.p1.c1.EMMES_HMP_DSU.HMP.txt.gz"

# ~/ncbi/dbGaP-12146/
paths$dbGaP_directory_path <-
    file.path(paths$home_directory, paths$ncbi_directory, paths$dbGaP_directory)

# ~/ncbi/dbGaP-12146/files
paths$files_directory_path <-
    file.path(paths$dbGaP_directory_path, paths$files_directory)

# phs000228.v4.pht001185.v4.p1.EMMES_HMP_Sample.MULTI.txt.gz
paths$EMMES_HMP_Sample_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_Sample_file)

# phs000228.v4.pht001193.v3.p1.c1.EMMES_HMP_GTV.HMP.txt.gz
paths$EMMES_HMP_GTV_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_GTV_file)

# phs000228.v4.pht002157.v1.p1.c1.EMMES_HMP_DTP_DHX_DVD.HMP.txt.gz
paths$EMMES_HMP_DTP_DHX_DVD_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_DTP_DHX_DVD_file)

# phs000228.v4.pht001187.v3.p1.c1.EMMES_HMP_DCM.HMP.txt.gz
paths$EMMES_HMP_DCM_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_DCM_file)

# phs000228.v4.pht001184.v3.p1.EMMES_HMP_Subject.MULTI.txt.gz
paths$EMMES_HMP_Subject_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_Subject_file)

# phs000228.v4.pht002158.v1.p1.c1.EMMES_HMP_DEM_ENR.HMP.txt.gz
paths$EMMES_HMP_DEM_ENR_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_DEM_ENR_file)

# phs000228.v4.pht002156.v1.p1.c1.EMMES_HMP_DSU.HMP.txt.gz
paths$EMMES_HMP_DSU_file_path <-
    file.path(paths$files_directory_path, paths$EMMES_HMP_DSU_file)
