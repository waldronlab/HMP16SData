attach_dbGaP <- function(HMP16S_data, dbGaP_repository_key) {
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
        join_colData(HMP16S_data) %>%
        replace_colData(HMP16S_data)
}

