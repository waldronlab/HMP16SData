# I. Notes
# ==============================================================================
# For now, HMP16Sdata is a two trick pony - further tricks are possible in the
# future. What this means for documentation is that the script written below is
# expecting exactly two datasets (one for variable region 1-3 and another for
# variable region 3-5) and can produce metadata for them without issue. There
# would only be an issue if further data were added (e.g. a dataset for variable
# region 6-9, although it doesn't exists). If such a change were needed, it
# would require a few additional strings below. Why isn't the process of
# generating metadata fully automated then? This is because automated metadata
# generation would require a good deal of work for very little payoff and
# HMP16Sdata is, after all, only a two trick pony. That said, automated metadata
# generation should be considered if the package grows larger (unlikely, given
# that funding for the HMP ended in 2010). So, enjoy the script for what it is
# and consider automated metadata generation if you have a boatload more data.

devtoo::load_suggests()

Title <-
    base::dir("data") %>%
    base::strsplit("\\.") %>%
    base::sapply(extract, 2) %>%
    base::unique() %>%
    base::as.character()

Description <- base::c("16S rRNA sequencing data for variable regions 1-3",
                       "16S rRNA sequencing data for variable regions 3-5")

BiocVersion <-
    BiocInstaller::biocVersion() %>%
    base::as.character()

Genome <- base::as.character(NA)

SourceType <- base::as.character("TXT")

SourceUrl <- base::c(
    "http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz,
     http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2",
    "http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v35.txt.gz,
     http://downloads.ihmpdcc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2"
)

SourceVersion  <- base::as.character(NA)

Species <- base::as.character("Homo Sapiens")

TaxonomyId <- base::as.character("9606")

Coordinate_1_based <- base::as.logical(NA)

DataProvider <- base::as.character("NIH Common Fund Human Microbiome Project")

Maintainer <- base::as.character("Lucas Schiffer <schiffer.lucas@gmail.com>")

RDataClass <- base::as.character("SummarizedExperiment")

DispatchClass <- base::as.character("Rda")

RDataPath <-
    base::dir("data") %>%
    base::paste("HMP16Sdata", ., sep = "/")

if(file.exists("inst/extdata/metadata.csv")) {
    old_metadata <- utils::read.csv("inst/extdata/metadata.csv")

    new_metadata <- base::data.frame(Title, Description, BiocVersion, Genome,
                                     SourceType, SourceUrl, SourceVersion,
                                     Species, TaxonomyId, Coordinate_1_based,
                                     DataProvider, Maintainer, RDataClass,
                                     DispatchClass, RDataPath)

    base::rbind(old_metadata, new_metadata) %>%
        dplyr::distinct() %>%
        utils::write.csv("inst/extdata/metadata.csv", row.names = FALSE)
} else {
    base::data.frame(Title, Description, BiocVersion, Genome, SourceType,
                     SourceUrl, SourceVersion, Species, TaxonomyId,
                     Coordinate_1_based, DataProvider, Maintainer, RDataClass,
                     DispatchClass, RDataPath) %>%
    utils::write.csv("inst/extdata/metadata.csv", row.names = FALSE)
}

