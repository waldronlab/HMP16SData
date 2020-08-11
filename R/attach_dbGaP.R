#' Attach dbGaP metadata to a SummarizedExperiment object
#'
#' The National Center for Biotechnology Information (NCBI) database of
#' Genotypes and Phenotypes (dbGaP) has extensive metadata pretaining to the HMP
#' study. Access to this metadata is controlled and its use requires
#' authorization by the appropriate Data Access Committee – further information
#' is available \href{https://tinyurl.com/yb7okvga}{here}. Those with
#' authorization will be able to download a dbGaP repository key and can use it
#' to attach the controlled-access metadata to a
#' \code{\link[SummarizedExperiment]{SummarizedExperiment-class}} object with a
#' single command, provided the NCBI SRA Toolkit is installed and on the user's
#' \code{PATH}. See note below for further information.
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object from the \code{\link{HMP16SData}} package
#' @param dbGaP_repository_key A repository key downloaded from dbGaP; only
#' required for the initial download and not needed thereafter
#'
#' @return A \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object with protected metadata from dbGaP attached
#' @export
#'
#' @note
#' The NCBI SRA Toolkit is called internally and must be on the user's
#' \code{PATH} or an error message will be displayed. The NCBI SRA Toolkit can
#' readily be installed on multiple platforms following
#' \href{https://tinyurl.com/y894uvvf}{these} instructions.
#'
#' @seealso \code{\link{dictionary}}
#'
#' @examples
#' \dontrun{
#' V13() %>%
#'     attach_dbGaP(dbGaP_repository_key = "~/prj_12146.ngc")
#' }
#'
#' @importFrom magrittr %>%
#' @importFrom stringr str_remove
#' @importFrom stringr str_replace
#' @importFrom assertthat assert_that
#' @importFrom assertthat has_extension
#' @importFrom assertthat is.readable
#' @importFrom SummarizedExperiment colData<-
attach_dbGaP <- function(x, dbGaP_repository_key = "") {
    dbGaP_directory <-
        str_remove(dbGaP_repository_key, "\\.ngc") %>%
        str_replace(".+_", "dbGaP-")

    if (!dir.exists(dbGaP_directory)) {
        assert_that(has_extension(dbGaP_repository_key, "ngc"))
        assert_that(is.readable(dbGaP_repository_key))

        Sys.which("vdb-config") %>%
            nchar() %>%
            if (. == 0) {
                stop("Ensure NCBI SRA Toolkit is installed and on your PATH.\n",
                     "       See https://tinyurl.com/y894uvvf for help.\n",
                     "       Check with Sys.getenv(\"PATH\")",
                     call. = FALSE)
            }

        download_dbGaP(dbGaP_repository_key, dbGaP_directory)
    }

    message("\nJoining the colData...\n")

    colData(x) <-
        read_dbGaP(dbGaP_directory) %>%
        join_colData(x)

    x
}
