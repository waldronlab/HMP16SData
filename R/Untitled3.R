library(readr)
library(Biobase)
library(dplyr)

map_file <- read_tsv("./data/v13_map_uniquebyPSN.txt.bz2")
otu_file <- read_tsv("http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v13.txt.gz", skip = 1)
bodysite <- "Attached_Keratinized_gingiva, Palatine_Tonsils"


rawToEset <- function(map_file, otu_file, bodysite) {
    print(map_file)
    print(otu_file)
    print(bodysite)

ExpressionSet()
}
rawToEset()

# Lucas phyloseq work
ExpressionSet2phyloseq <- function(eset, simplify = TRUE,
                                   relab = TRUE) {
  otu.table <- exprs(eset)
  sample.data <- pData(eset) %>%
    sample_data(., errorIfNULL = FALSE)

  taxonomic.ranks <- c("Kingdom", "Phylum", "Class", "Order", "Family",
                       "Genus", "Species", "Strain")
  tax.table <- rownames(otu.table) %>%
    gsub("[a-z]__", "", .) %>%
    data_frame() %>%
    separate(., ".", taxonomic.ranks, sep = "\\|", fill="right") %>%
    as.matrix()
  if(simplify) {
    rownames(otu.table) <- rownames(otu.table) %>%
      gsub(".+\\|", "", .)
  }
  rownames(tax.table) <- rownames(otu.table)
  if(!relab) {
    otu.table <- round(sweep(otu.table, 2, eset$number_reads/100, "*"))
  }
  otu.table <- otu_table(otu.table, taxa_are_rows = TRUE)
  tax.table <- tax_table(tax.table)
  phyloseq(otu.table, sample.data, tax.table)
}
