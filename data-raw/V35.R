devtoo::load_suggests()

# can't avoid a function within a function here
V35_otu_col_types <- readr::cols(.default = readr::col_integer(),
                                 `#OTU ID` = readr::col_character(),
                                 `Consensus Lineage` = readr::col_character())

V35_otu <- readr::read_tsv("inst/extdata/otu_table_psn_v35.txt.gz",
                           col_types = V35_otu_col_types, skip = 1,
                           progress = FALSE)

# can't avoid a function within a function here
V35_map_col_types <- readr::cols(`#SampleID` = readr::col_integer(),
                                 RSID = readr::col_integer(),
                                 visitno = readr::col_integer(),
                                 sex = readr::col_character(),
                                 RUNCENTER = readr::col_character(),
                                 HMPbodysubsite = readr::col_character(),
                                 Mislabeled = readr::col_skip(),
                                 Contaminated = readr::col_skip(),
                                 Description = readr::col_character())

V35_map <- readr::read_tsv("inst/extdata/v35_map_uniquebyPSN.txt.bz2",
                           col_types = V35_map_col_types)

# can avoid a function within a function here but
# everything() used to avoid excessive selection
V35_otu %<>%
    dplyr::rename(otu_id = `#OTU ID`) %>%
    dplyr::rename(consensus_lineage = `Consensus Lineage`) %>%
    dplyr::select(otu_id, consensus_lineage, dplyr::everything()) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames("otu_id")

row_data <-
    V35_otu %>%
    dplyr::select(consensus_lineage) %>%
    S4Vectors::DataFrame()

V35_otu %<>%
    dplyr::select(-consensus_lineage)

V35_map_colnames <- base::c("sample_id", "run_sample_id", "visit_number", "sex",
                            "run_center", "hmp_body_subsite", "description")

V35_map %<>%
    magrittr::set_colnames(V35_map_colnames)

assay_data <-
    base::colnames(V35_otu) %>%
    base::match(V35_map$sample_id, .) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::select(V35_otu, .) %>%
    base::data.matrix()

col_data <-
    base::colnames(assay_data) %>%
    base::match(V35_map$sample_id) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::slice(V35_map, .) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames("sample_id") %>%
    S4Vectors::DataFrame()

assay_data %<>%
    base::list()

metadata_data <-
    Biobase::MIAME(name = "Human Microbiome Project Consortium",
                   title = "Structure, function and diversity of the healthy
                   human microbiome",
                   abstract = "Studies of the human microbiome have revealed
                   that even healthy individuals differ remarkably in the
                   microbes that occupy habitats such as the gut, skin and
                   vagina. Much of this diversity remains unexplained, although
                   diet, environment, host genetics and early microbial exposure
                   have all been implicated. Accordingly, to characterize the
                   ecology of human-associated microbial communities, the Human
                   Microbiome Project has analysed the largest cohort and set of
                   distinct, clinically relevant body habitats so far. We found
                   the diversity and abundance of each habitat's signature
                   microbes to vary widely even among healthy subjects, with
                   strong niche specialization both within and among
                   individuals. The project encountered an estimated 81-99% of
                   the genera, enzyme families and community configurations
                   occupied by the healthy Western microbiome. Metagenomic
                   carriage of metabolic pathways was stable among individuals
                   despite variation in community structure, and ethnic/racial
                   background proved to be one of the strongest associations of
                   both pathways and microbes with clinical metadata. These
                   results thus delineate the range of structural and functional
                   configurations normal in the microbial communities of a
                   healthy population, enabling future characterization of the
                   epidemiology, ecology and translational applications of the
                   human microbiome.",
                   url = "https://www.ncbi.nlm.nih.gov/pubmed/22699609",
                   pubMedIds = "22699609") %>%
    base::list(experimentData = .)

V35 <- SummarizedExperiment::SummarizedExperiment(assays = assay_data,
                                                  colData = col_data,
                                                  rowData = row_data,
                                                  metadata = metadata_data)

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("V35", "rda", sep = ".") %>%
    base::paste0("./data/", .) %>%
    base::save(V35, file = ., compress = "bzip2")
