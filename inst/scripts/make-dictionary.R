# I. Notes
# ==============================================================================
# This script is used to process the dictionary.csv file in the inst/extdata
# directory. It assumes the project directory to be the current directory. The
# dictionary.csv file is derived from dbGaP XML data dictionary files — the
# source URLs are available in the dictionary R documentation.

if (!require("magrittr", character.only = TRUE)) {
    BiocManager::install("magrittr")
    require("magrittr", character.only = TRUE)
}

base::read.dcf("DESCRIPTION", "Suggests") %>%
    base::gsub("\n", "", x = .) %>%
    base::strsplit(",") %>%
    base::unlist() %>%
    for (i in .) {
        if (!require(i, character.only = TRUE)) {
            BiocManager::install(i)
            require(i, character.only = TRUE)
        }
    }

dictionary_col_types <-
    readr::cols(
        VARIABLE = "c",
        DESCRIPTION = "c",
        TYPE = "c",
        UNITS = "c",
        MINIMUM = "n",
        MAXIMUM = "n",
        CODED_VALUES = "c",
        COMMENT = "c"
    )

dictionary <-
    readr::read_csv("inst/extdata/dictionary.csv",
                    col_types = dictionary_col_types, progress = FALSE) %>%
    base::as.data.frame()

devtools::use_data(dictionary, overwrite = TRUE)
