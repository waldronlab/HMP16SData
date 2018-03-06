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
        `#OTU ID` = "-",
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
        Description = "c",
        .default = "-"
    )

v13_map <- readr::read_tsv("inst/extdata/v13_map_uniquebyPSN.txt.bz2",
                           col_types = v13_map_col_types, skip = 0,
                           progress = FALSE)

v13_otu %>%
    dplyr::rename(rowname = `Consensus Lineage`) %>%
    dplyr::mutate(rowname = gsub("Root", "k__Bacteria", rowname)) %>%
    dplyr::mutate(rowname = gsub(";", "|", rowname)) %>%
    # dplyr::mutate(rowname = gsub("\\|g__$", "", rowname)) %>%
    # dplyr::mutate(rowname = gsub("\\|f__$", "", rowname)) %>%
    # dplyr::mutate(rowname = gsub("\\|o__$", "", rowname)) %>%
    # dplyr::mutate(rowname = gsub("\\|c__$", "", rowname)) %>%
    dplyr::group_by(rowname) %>%
    dplyr::summarise_all(sum) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames() %>%
    base::data.matrix()

v13_map %>%
    dplyr::rename()

assay_data <-
    base::colnames(v13_otu) %>%
    base::match(v13_map$sample_id, .) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::select(v13_otu, .) %>%
    base::data.matrix()

col_data <-
    base::colnames(assay_data) %>%
    base::match(v13_map$sample_id) %>%
    stats::na.exclude() %>%
    base::as.integer() %>%
    dplyr::slice(v13_map, .) %>%
    base::as.data.frame() %>%
    tibble::column_to_rownames("sample_id") %>%
    S4Vectors::DataFrame()

assay_data %<>%
    base::list(`16SrRNA` = .)

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

V13 <- SummarizedExperiment::SummarizedExperiment(assays = assay_data,
                                                  colData = col_data,
                                                  rowData = row_data,
                                                  metadata = metadata_data)

base::Sys.Date() %>%
    base::format("%Y%m%d") %>%
    base::paste("V13", "rda", sep = ".") %>%
    base::paste0("data/", .) %>%
    base::save(V13, file = ., compress = "bzip2")
