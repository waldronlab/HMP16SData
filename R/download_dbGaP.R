download_dbGaP <- function(current_directory, dbGaP_repository_key) {
    system("vdb-config --import", dbGaP_repository_key)

    system.file("extdata/cart_DAR48406_201802201501.krt",
                package = "HMP16SData") %>%
        system("prefetch", .)

    setwd("~/ncbi/dbGaP-12146/")

    system("vdb-decrypt files/")

    setwd(current_directory)
}
