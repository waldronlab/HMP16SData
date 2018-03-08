if (!require("magrittr", character.only = TRUE)) {
    BiocInstaller::biocLite("magrittr")
    require("magrittr", character.only = TRUE)
}

base::read.dcf("DESCRIPTION", "Suggests") %>%
    base::gsub("\n", "", .) %>%
    base::strsplit(",") %>%
    base::unlist() %>%
    for (i in .) {
        if (!require(i, character.only = TRUE)) {
            BiocInstaller::biocLite(i)
            require(i, character.only = TRUE)
        }
    }

v13_otu_col_types <-
    readr::cols(
        `#OTU ID` = "c",
        `Consensus Lineage` = "c",
        .default = "i"
    )

v13_otu <- readr::read_tsv("inst/extdata/otu_table_psn_v13.txt.gz",
                           col_types = v13_otu_col_types, skip = 1,
                           progress = FALSE)

v13_map_col_types <-
    readr::cols(
        `#SampleID` = "i",
        RSID = "i",
        visitno = "i",
        sex = "c",
        RUNCENTER = "c",
        HMPbodysubsite = "c",
        Description = "-",
        .default = "-"
    )

v13_map <- readr::read_tsv("inst/extdata/v13_map_uniquebyPSN.txt.bz2",
                           col_types = v13_map_col_types, skip = 0,
                           progress = FALSE)

v13_otu %<>%
    base::colnames() %>%
    base::match(v13_map$`#SampleID`, .) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::select(v13_otu, `#OTU ID`, `Consensus Lineage`, .) %>%
    dplyr::rename(rowname = `#OTU ID`) %>%
    dplyr::rename(CONSENSUS_LINEAGE = `Consensus Lineage`)

v13_map %<>%
    dplyr::rename(rowname = `#SampleID`) %>%
    dplyr::rename(VISITNO = visitno) %>%
    dplyr::rename(SEX = sex) %>%
    dplyr::rename(RUN_CENTER = RUNCENTER) %>%
    dplyr::rename(HMP_BODY_SUBSITE = HMPbodysubsite) %>%
    dplyr::mutate(SEX = tools::toTitleCase(SEX)) %>%
    dplyr::mutate(HMP_BODY_SUBSITE = base::gsub("_", " ", HMP_BODY_SUBSITE)) %>%
    dplyr::mutate(HMP_BODY_SUBSITE = tools::toTitleCase(HMP_BODY_SUBSITE))

# assays <-
    dplyr::select(v13_otu, -CONSENSUS_LINEAGE) %>%
    tibble::column_to_rownames() %>%
    base::data.matrix() %>%
    S4Vectors::SimpleList() %>%
    magrittr::set_names("16SrRNA")

# rowData <-
    dplyr::select(v13_otu, CONSENSUS_LINEAGE) %>%
    dplyr::mutate(SUPERKINGDOM = "Bacteria") %>%
    dplyr::mutate(PHYLUM = HMP16SData:::match_clade("p__", CONSENSUS_LINEAGE)) %>%
    dplyr::mutate(CLASS = HMP16SData:::match_clade("c__", CONSENSUS_LINEAGE)) %>%
    dplyr::mutate(ORDER = HMP16SData:::match_clade("o__", CONSENSUS_LINEAGE)) %>%
    dplyr::mutate(FAMILY = HMP16SData:::match_clade("f__", CONSENSUS_LINEAGE)) %>%
    dplyr::mutate(GENUS = HMP16SData:::match_clade("g__", CONSENSUS_LINEAGE)) %>%
        .[1:2000,] %>%
    View()
    # S4Vectors::DataFrame()

# row_data <-
#     v13_otu %>%
#     dplyr::select(CONSENSUS_LINEAGE) %>%
#     S4Vectors::DataFrame()

# v13_otu %<>%
#     dplyr::select(-CONSENSUS_LINEAGE)

# assay_data <-
#     base::colnames(v13_otu) %>%
#     base::match(v13_map$sample_id, .) %>%
#     stats::na.exclude() %>%
#     base::as.integer() %>%
#     dplyr::select(v13_otu, .) %>%
#     base::data.matrix()

col_data <-
    base::colnames(assay_data) %>%
    base::match(v13_map$sample_id) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::slice(v13_map, .) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames("sample_id") %>%
    S4Vectors::DataFrame()

# assay_data %<>%
#     base::list(`16SrRNA` = .)

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
    base::list() %>%
    magrittr::set_names("experimentData")

V13 <- SummarizedExperiment::SummarizedExperiment(assays = assay_data,
                                                  colData = col_data,
                                                  rowData = row_data,
                                                  metadata = metadata_data)

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("V13", "rda", sep = ".") %>%
    base::paste0("data/", .) %>%
    base::save(V13, file = ., compress = "bzip2")
