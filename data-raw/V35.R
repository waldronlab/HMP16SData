library(readr)
library(magrittr)
library(dplyr)
library(tibble)
library(SummarizedExperiment)

v35_otu <- read_tsv("inst/extdata/otu_table_psn_v35.txt.gz", col_types = cols(.default = col_integer(), `#OTU ID` = col_character(), `Consensus Lineage` = col_character()), skip = 1, progress = FALSE)
v35_map <- read_tsv("inst/extdata/v35_map_uniquebyPSN.txt.bz2", col_types = cols(`#SampleID` = col_integer(), RSID = col_integer(), visitno = col_integer(), sex = col_character(), RUNCENTER = col_character(), HMPbodysubsite = col_character(), Mislabeled = col_skip(), Contaminated = col_skip(), Description = col_character()))

v35_otu %<>%
    dplyr::rename(otu_id = `#OTU ID`) %>%
    dplyr::rename(consensus_lineage = `Consensus Lineage`) %>%
    select(otu_id, consensus_lineage, everything()) %>%
    as.data.frame() %>%
    column_to_rownames("otu_id")

feature_data <-
    v35_otu %>%
    select(consensus_lineage) %>%
    DataFrame()

v35_otu %<>%
    select(-consensus_lineage)

v35_map %<>%
    set_colnames(c("sample_id", "run_sample_id", "visit_number", "sex", "run_center", "hmp_body_subsite", "description"))

assay_data <-
    colnames(v35_otu) %>%
    match(v35_map$sample_id, .) %>%
    na.exclude() %>%
    as.integer() %>%
    select(v35_otu, .) %>%
    data.matrix()

pheno_data <-
    colnames(assay_data) %>%
    match(v35_map$sample_id) %>%
    na.exclude() %>%
    as.integer() %>%
    dplyr::slice(v35_map, .) %>%
    as.data.frame() %>%
    column_to_rownames("sample_id") %>%
    DataFrame()

experiment_data <- MIAME(name = "Human Microbiome Project Consortium", title = "Structure, function and diversity of the healthy human microbiome", abstract = "Studies of the human microbiome have revealed that even healthy individuals differ remarkably in the microbes that occupy habitats such as the gut, skin and vagina. Much of this diversity remains unexplained, although diet, environment, host genetics and early microbial exposure have all been implicated. Accordingly, to characterize the ecology of human-associated microbial communities, the Human Microbiome Project has analysed the largest cohort and set of distinct, clinically relevant body habitats so far. We found the diversity and abundance of each habitat's signature microbes to vary widely even among healthy subjects, with strong niche specialization both within and among individuals. The project encountered an estimated 81-99% of the genera, enzyme families and community configurations occupied by the healthy Western microbiome. Metagenomic carriage of metabolic pathways was stable among individuals despite variation in community structure, and ethnic/racial background proved to be one of the strongest associations of both pathways and microbes with clinical metadata. These results thus delineate the range of structural and functional configurations normal in the microbial communities of a healthy population, enabling future characterization of the epidemiology, ecology and translational applications of the human microbiome.", url = "https://www.ncbi.nlm.nih.gov/pubmed/22699609", pubMedIds = "22699609")

V35 <- SummarizedExperiment(assays=list(assay_data), colData=pheno_data, 
            rowData=feature_data, metadata=list(experimentData=experiment_data))
