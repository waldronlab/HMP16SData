library(readr)
library(magrittr)
library(dplyr)
library(tibble)
library(Biobase)

v13_otu <- read_tsv("inst/extdata/otu_table_psn_v13.txt.gz", col_types = cols(.default = col_integer(), `#OTU ID` = col_character(), `Consensus Lineage` = col_character()), skip = 1, progress = FALSE)
v13_map <- read_tsv("inst/extdata/v13_map_uniquebyPSN.txt.bz2", col_names = c("sample_id", "run_sample_id", "visit_number", "sex", "run_center", "hmp_body_subsite", "description"), col_types = "ccccccc----", skip = 1, progress = FALSE)

v13_otu %<>%
  rename(otu_id = `#OTU ID`) %>%
  rename(consensus_lineage = `Consensus Lineage`) %>%
  select(otu_id, consensus_lineage, everything()) %>%
  as.data.frame() %>%
  column_to_rownames("otu_id")

feature_data <-
  v13_otu %>%
  select(consensus_lineage) %>%
  AnnotatedDataFrame()

v13_otu %<>%
  select(-consensus_lineage)

assay_data <-
  colnames(v13_otu) %>%
  match(v13_map$sample_id, .) %>%
  na.exclude() %>%
  as.integer() %>%
  select(v13_otu, .) %>%
  data.matrix()

pheno_data <-
  colnames(assay_data) %>%
  match(v13_map$sample_id) %>%
  na.exclude() %>%
  as.integer() %>%
  slice(v13_map, .) %>%
  AnnotatedDataFrame()

ExpressionSet(assay_data, pheno_data, feature_data)
