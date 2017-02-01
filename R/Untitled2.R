library(readr)
library(dplyr)
library(Biobase)


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

rownames(v13_otu) <- v13_otu$OTU.ID

v13_otu$Consensus.Lineage %<>%
    gsub("Root;", "", .) %>%
    gsub(";", "|", .)

v13_otu <- v13_otu[, -1]

colnames(v13_otu) %>%
    match(ppAll_V13_map$PSN) %>% {
        sum(is.na(.))
    }
v13_Left_Antecubital_fossa_map <- ppAll_V13_map %>% filter(HMPBodySubsite == "Left_Antecubital_fossa")

wanted_columns <- v13_Left_Antecubital_fossa_map$PSN
wanted_columns <- wanted_columns[1:211]
wanted_columns <- as.character(wanted_columns)

v13_otu %>%
    select(one_of(wanted_columns)) ->
v13_Left_Antecubital_fossa_otu

v13_Left_Antecubital_fossa_map <- as.data.frame(v13_Left_Antecubital_fossa_map)
rownames(v13_Left_Antecubital_fossa_map) <- v13_Left_Antecubital_fossa_map$PSN

AnnotatedDataFrame(v13_Left_Antecubital_fossa_map)

v13_Left_Antecubital_fossa_map %<>%
    select(PSN, NAP, SRS_SampleID, Region, BarcodeSequence,
           LinkerPrimerSequence, Sex, HMPBodySubsite, HMPBodySite, VisitNo)

v13_Left_Antecubital_fossa_map %>%
    distinct() %>% filter(PSN == colnames(v13_Left_Antecubital_fossa_otu))


pheno_data <- v13_Left_Antecubital_fossa_map[1:144, ]
rownames(pheno_data) <- pheno_data$PSN
AnnotatedDataFrame(pheno_data)
ExpressionSet(data.matrix(v13_Left_Antecubital_fossa_otu))


subset_colnames <- colnames(v13_Left_Antecubital_fossa_otu)
subset_matches <- match(subset_colnames, v13_Left_Antecubital_fossa_map$PSN)

v13_Left_Antecubital_fossa_map <- v13_Left_Antecubital_fossa_map[subset_matches, ]

v13_Left_Antecubital_fossa_otu %>%
    match(v13_Left_Antecubital_fossa_map$PSN, colnames(v13_Left_Antecubital_fossa_otu))

match(colnames(v13_Left_Antecubital_fossa_otu), v13_Left_Antecubital_fossa_map$PSN)


setOtherRownames <- function(x, y) {
    print(x)
    print(y)
}

setOtherRownames(9, 5)
