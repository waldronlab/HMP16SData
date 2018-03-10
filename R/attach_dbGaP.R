#' Attach dbGaP metadata to HMP16SData SummarizedExperiment objects
#'
#' Description
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#' from the \code{\link{HMP16SData}} package
#' @param dbGaP_repository_key A repository key downloaded from dbGaP
#'
#' @return A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#' with protected metadata from dbGaP
#' @export
#'
#' @note
#' Note
#'
#' @seealso \code{\link{dictionary}}
#'
#' @examples
#' \dontrun{
#' V13() %>%
#'     attach_dbGaP("~/prj_12146.ngc")
#' }
#'
#' @importFrom assertthat is.dir
#' @importFrom assertthat assert_that
#' @importFrom assertthat is.readable
#' @importFrom assertthat has_extension
#' @importFrom magrittr %>%
#' @importFrom SummarizedExperiment colData<-
attach_dbGaP <- function(x, dbGaP_repository_key = "") {
    Sys.which("vdb-config") %>%
        nchar() %>%
        if (. == 0) {
            stop("Ensure NCBI SRA Toolkit is installed and on your PATH. \n\n",
                 "macOS: \n\t",
                 "brew install sratoolkit \n",
                 "linux: \n\t",
                 "sudo apt install sra-toolkit \n",
                 "Windows: \n\t",
                 "see https://tinyurl.com/windows-sra \n",
                 call. = FALSE)
        }

    if (!is.dir(paths$files_directory_path)) {
        assert_that(is.readable(dbGaP_repository_key))
        assert_that(has_extension(dbGaP_repository_key, "ngc"))

        getwd() %>%
            download_dbGaP(dbGaP_repository_key)
    }

    colData(x) <-
        read_dbGaP() %>%
        join_colData(x)

    x
}
