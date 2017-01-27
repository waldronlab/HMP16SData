library(readr)
library(dplyr)

v13_otu <- read_tsv("http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v13.txt.gz", skip = 1)
v13_otu <- v13_otu[,c(1, 2912, 2:2911)]
v13_otu <- data.frame(v13_otu)
colnames(v13_otu) <- gsub("X\\.", "", colnames(v13_otu))
colnames(v13_otu) <- gsub("X", "", colnames(v13_otu))

v13_otu %>%
    select(-OTU.ID) %>%
    group_by(Consensus.Lineage) %>%
    summarise_each(funs(sum)) ->
    v13_otu_condensed

v13_otu_condensed$Consensus.Lineage %>%
    gsub("Root;", "", .) %>%
    gsub(";", "|", .) ->
    new_rownames

v13_otu_condensed <- as.data.frame(v13_otu_condensed)
rownames(v13_otu_condensed) <- new_rownames

v13_otu_condensed <- v13_otu_condensed[-1, -1]

url_ppAll_V13_map <- "http://hmpdacc.org/doc/ppAll_V13_map.txt"
md5_ppAll_V13_map <- "c1b561995f70c362dad2465a4dcb84fe"

url_ppAll_V35_map <- "http://hmpdacc.org/doc/ppAll_V35_map.txt"
md5_ppAll_V35_map <- "51a8c6c5b47b0c1d535405f66d5eef66"

url_hmp_downloads <- "http://downloads.hmpdacc.org"

correct_cols <- c("SampleID", "RSID", "PSN", "SN", "NAP", "ExperimentAccession",
                  "RunID", "SRS_SampleID", "Region", "BarcodeSequence",
                  "LinkerPrimerSequence", "Sex", "HMPBodySubsite",
                  "HMPBodySite", "VisitNo")

ppAll_V13_map <- read_tsv(url_ppAll_V13_map, col_names = correct_cols, skip = 1)
ppAll_V35_map <- read_tsv(url_ppAll_V35_map, col_names = correct_cols, skip = 1)

# add SRS identifiers as colnames
