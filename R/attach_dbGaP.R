#' Attach dbGaP metadata to a SummarizedExperiment object
#'
#' The National Center for Biotechnology Information (NCBI) database of
#' Genotypes and Phenotypes (dbGaP) has extensive metadata pretaining to the HMP
#' study. Access to this data is controlled and its use requires authorization
#' by the appropriate Data Access Committee – further information is available
#' \href{https://tinyurl.com/yb7okvga}{here}. Those with authorization will be
#' able to download a dbGaP repository key and can use it to attach the
#' controlled-access metadata to a
#' \code{\link[SummarizedExperiment]{SummarizedExperiment}} object with a single
#' command, provided the NCBI SRA Toolkit is installed and on your \code{PATH}.
#' See note below for further information.
#'
#' @param x A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#' from the \code{\link{HMP16SData}} package
#' @param dbGaP_repository_key A repository key downloaded from dbGaP; only
#' required for the initial download and not needed thereafter
#'
#' @return A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#' with protected metadata from dbGaP
#' @export
#'
#' @note
#' The NCBI SRA Toolkit is called internally and must be on your \code{PATH} or
#' an error message will be displayed. The NCBI SRA Toolkit can be readily
#' installed on multiple platforms following
#' \href{https://tinyurl.com/y845ppaa}{these} instructions or by one of the
#' following methods.
#' \subsection{Debian/Ubuntu}{
#'     Using the \href{https://wiki.debian.org/Apt}{apt} package manager:\cr\cr
#'     \code{apt install sra-toolkit}
#' }
#' \subsection{macOS}{
#'     Using the \href{https://brew.sh/}{homebrew} package manager:\cr\cr
#'     \code{brew install sratoolkit}
#' }
#'
#' @seealso \code{\link{dictionary}}
#'
#' @examples
#' \dontrun{
#' V13() %>%
#'     attach_dbGaP(dbGaP_repository_key = "~/prj_12146.ngc")
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
                 "Debian/Ubuntu: \n\t",
                 "apt install sra-toolkit \n",
                 "macOS: \n\t",
                 "brew install sratoolkit \n",
                 "Windows: \n\t",
                 "see https://tinyurl.com/y845ppaa \n",
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
