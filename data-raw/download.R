if (!require("magrittr", character.only = TRUE)) {
    BiocInstaller::biocLite("magrittr")
    require("magrittr", character.only = TRUE)
}

base::read.dcf("DESCRIPTION", "Suggests") %>%
    base::gsub("\n", "", x = .) %>%
    base::strsplit(",") %>%
    base::unlist() %>%
    for (i in .) {
        if (!require(i, character.only = TRUE)) {
            BiocInstaller::biocLite(i)
            require(i, character.only = TRUE)
        }
    }

# V13
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz",
    "inst/extdata/otu_table_psn_v13.txt.gz"
)
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2",
    "inst/extdata/v13_map_uniquebyPSN.txt.bz2"
)
utils::download.file(
    "https://www.hmpdacc.org/hmp/doc/ppAll_V13_map.txt",
    "inst/extdata/ppAll_V13_map.txt"
)
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/rep_set_v13.tre.gz",
    "inst/extdata/rep_set_v13.tre.gz"
)

# V35
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v35.txt.gz",
    "inst/extdata/otu_table_psn_v35.txt.gz"
)
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2",
    "inst/extdata/v35_map_uniquebyPSN.txt.bz2"
)
utils::download.file(
    "https://www.hmpdacc.org/hmp/doc/ppAll_V35_map.txt",
    "inst/extdata/ppAll_V35_map.txt"
)
utils::download.file(
    "http://downloads.ihmpdcc.org/data/HMQCP/rep_set_v35.tre.gz",
    "inst/extdata/rep_set_v35.tre.gz"
)

# MD5
ppAll_V13_map_file <- "ppAll_V13_map.txt"
ppAll_V13_map_md5 <- tools::md5sum("inst/extdata/ppAll_V13_map.txt")
ppAll_V35_map_file <- "ppAll_V35_map.txt"
ppAll_V35_map_md5 <- tools::md5sum("inst/extdata/ppAll_V35_map.txt")

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("Date: ", .) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)

base::paste("File: ", ppAll_V13_map_file) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)

base::paste("MD5: ", ppAll_V13_map_md5) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("Date: ", .) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)

base::paste("File: ", ppAll_V35_map_file) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)

base::paste("MD5: ", ppAll_V35_map_md5) %>%
    readr::write_lines("inst/extdata/md5.txt", append = TRUE)
