#' @keywords internal
#'
#' @importFrom magrittr %>%
download_dbGaP <- function(dbGaP_repository_key) {
    system.file("extdata/cart_DAR48406_201802201501.krt",
                package = "HMP16SData") %>%
        paste("prefetch", ., "--ngc", dbGaP_repository_key) %>%
        system()

    paste("vdb-decrypt", paths$dbGaP_directory, "--ngc", dbGaP_repository_key) %>%
        system()
}
