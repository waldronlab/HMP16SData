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

# warnings are expected, see https://github.com/tidyverse/readr/issues/750
v13_map <- readr::read_tsv("inst/extdata/v13_map_uniquebyPSN.txt.bz2",
                           col_types = v13_map_col_types, progress = FALSE)

v13_srs_col_names <-
    base::c(
        "SampleID",
        "RSID",
        "PSN",
        "SN",
        "NAP",
        "ExperimentAccession",
        "RunID",
        "SRS_SampleID",
        "Region",
        "BarcodeSequence",
        "LinkerPrimerSequence",
        "Sex",
        "HMPBodySubsite",
        "HMPBodySite",
        "VisitNo"
    )

v13_srs_col_types <-
    readr::cols(
        SampleID = "-",
        RSID = "-",
        PSN = "i",
        SN = "-",
        NAP = "-",
        ExperimentAccession = "-",
        RunID = "-",
        SRS_SampleID = "c",
        Region = "-",
        BarcodeSequence = "-",
        LinkerPrimerSequence = "-",
        Sex = "-",
        HMPBodySubsite = "-",
        HMPBodySite = "-",
        VisitNo = "-",
        .default = "-"
    )

# warnings are expected, see https://github.com/tidyverse/readr/issues/750
v13_srs <- readr::read_tsv("inst/extdata/ppAll_V13_map.txt",
                           col_names = v13_srs_col_names,
                           col_types = v13_srs_col_types, skip = 1,
                           progress = FALSE)

v13_otu %<>%
    base::colnames() %>%
    base::match(v13_map$`#SampleID`, table = .) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::select(v13_otu, `#OTU ID`, `Consensus Lineage`, .) %>%
    dplyr::rename(rowname = `#OTU ID`) %>%
    dplyr::rename(CONSENSUS_LINEAGE = `Consensus Lineage`)

v13_map %<>%
    dplyr::rename(PSN = `#SampleID`) %>%
    dplyr::rename(VISITNO = visitno) %>%
    dplyr::rename(SEX = sex) %>%
    dplyr::rename(RUN_CENTER = RUNCENTER) %>%
    dplyr::rename(HMP_BODY_SUBSITE = HMPbodysubsite) %>%
    dplyr::mutate(SEX = tools::toTitleCase(SEX)) %>%
    dplyr::mutate(HMP_BODY_SUBSITE = base::gsub("_", " ", HMP_BODY_SUBSITE)) %>%
    dplyr::mutate(HMP_BODY_SUBSITE = tools::toTitleCase(HMP_BODY_SUBSITE)) %>%
    dplyr::mutate(
        HMP_BODY_SITE = dplyr::case_when(
            HMP_BODY_SUBSITE == "Stool" ~ "Gastrointestinal Tract",
            HMP_BODY_SUBSITE == "Saliva" ~ "Oral",
            HMP_BODY_SUBSITE == "Tongue Dorsum" ~ "Oral",
            HMP_BODY_SUBSITE == "Hard Palate" ~ "Oral",
            HMP_BODY_SUBSITE == "Buccal Mucosa" ~ "Oral",
            HMP_BODY_SUBSITE == "Attached Keratinized Gingiva" ~ "Oral",
            HMP_BODY_SUBSITE == "Palatine Tonsils" ~ "Oral",
            HMP_BODY_SUBSITE == "Throat" ~ "Oral",
            HMP_BODY_SUBSITE == "Supragingival Plaque" ~ "Oral",
            HMP_BODY_SUBSITE == "Subgingival Plaque" ~ "Oral",
            HMP_BODY_SUBSITE == "Left Retroauricular Crease" ~ "Skin",
            HMP_BODY_SUBSITE == "Right Retroauricular Crease" ~ "Skin",
            HMP_BODY_SUBSITE == "Left Antecubital Fossa" ~ "Skin",
            HMP_BODY_SUBSITE == "Right Antecubital Fossa" ~ "Skin",
            HMP_BODY_SUBSITE == "Anterior Nares" ~ "Airways",
            HMP_BODY_SUBSITE == "Vaginal Introitus" ~ "Urogenital Tract",
            HMP_BODY_SUBSITE == "Mid Vagina" ~ "Urogenital Tract",
            HMP_BODY_SUBSITE == "Posterior Fornix" ~ "Urogenital Tract"
        )
    )

v13_srs %<>%
    dplyr::rename(SRS_SAMPLE_ID = SRS_SampleID) %>%
    dplyr::distinct()

assays <-
    dplyr::select(v13_otu, -CONSENSUS_LINEAGE) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames() %>%
    base::data.matrix() %>%
    S4Vectors::SimpleList() %>%
    magrittr::set_names("16SrRNA")

colData <-
    base::colnames(v13_otu) %>%
    base::match(v13_map$PSN) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::slice(v13_map, .) %>%
    dplyr::left_join(v13_srs, by = "PSN") %>%
    dplyr::select(RSID, VISITNO, SEX, RUN_CENTER, HMP_BODY_SITE,
                  HMP_BODY_SUBSITE, SRS_SAMPLE_ID) %>%
    S4Vectors::DataFrame()

rowData <-
    dplyr::select(v13_otu, CONSENSUS_LINEAGE) %>%
    dplyr::mutate(SUPERKINGDOM = "Bacteria") %>%
    dplyr::mutate(PHYLUM = base::sapply(CONSENSUS_LINEAGE,
                                        HMP16SData:::match_clade, "p__")) %>%
    dplyr::mutate(CLASS = base::sapply(CONSENSUS_LINEAGE,
                                       HMP16SData:::match_clade, "c__")) %>%
    dplyr::mutate(ORDER = base::sapply(CONSENSUS_LINEAGE,
                                       HMP16SData:::match_clade, "o__")) %>%
    dplyr::mutate(FAMILY = base::sapply(CONSENSUS_LINEAGE,
                                        HMP16SData:::match_clade, "f__")) %>%
    dplyr::mutate(GENUS = base::sapply(CONSENSUS_LINEAGE,
                                       HMP16SData:::match_clade, "g__")) %>%
    S4Vectors::DataFrame()

experimentData <-
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
    HMP16SData:::fix_MIAME()

phylogeneticTree <- phyloseq::read_tree("inst/extdata/rep_set_v13.tre.gz")

metadata <- base::list(experimentData = experimentData,
                       phylogeneticTree = phylogeneticTree)

V13 <- SummarizedExperiment::SummarizedExperiment(assays = assays,
                                                  colData = colData,
                                                  rowData = rowData,
                                                  metadata = metadata)

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("V13", "rda", sep = ".") %>%
    base::paste0("data/", .) %>%
    base::save(V13, file = ., compress = "bzip2")
