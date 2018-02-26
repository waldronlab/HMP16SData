#' Attach dbGaP metadata to HMP16SData SummarizedExperiment objects
#'
#' @param x a SummarizedExperiment object from the HMP16SData package
#' @param dbGaP_repository_key a repository key downloaded from dbGaP
#'
#' @return a SummarizedExperiment object
#' @export
#'
# @examples
#'
#' @importFrom assertthat is.readable
#' @importFrom assertthat has_extension
#' @importFrom magrittr %>%
#' @importFrom assertthat is.dir
attach_dbGaP <- function(x, dbGaP_repository_key) {
    is.readable(dbGaP_repository_key)

    has_extension(dbGaP_repository_key, "ngc")

    Sys.which("vdb-config") %>%
        nchar() %>%
        if(. == 0) {
            stop("Ensure NCBI SRA Toolkit is installed and on your PATH. \n\n",
                 "macOS: \n\t",
                 "brew install sratoolkit \n",
                 "linux: \n\t",
                 "sudo apt install sra-toolkit \n",
                 "Windows: \n\t",
                 "see https://tinyurl.com/windows-sra \n",
                 call. = FALSE)
        }

    getwd() %>%
        download_dbGaP(dbGaP_repository_key)

    is.dir("~/ncbi/dbGaP-12146/files")

    read_dbGaP() %>%
        join_colData(x) %>%
        replace_colData(x)
}

