#' @importFrom magrittr %>%
#'
#' @keywords internal
download_dbGaP <- function(working_directory, dbGaP_repository_key) {
    paste("vdb-config --import", dbGaP_repository_key) %>%
        system()

    system.file("extdata/cart_DAR48406_201802201501.krt",
                package = "HMP16SData") %>%
        paste("prefetch", .) %>%
        system()

    setwd(paths$dbGaP_directory_path)

    system("vdb-decrypt files/")

    setwd(working_directory)
}
