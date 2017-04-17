source("https://bioconductor.org/biocLite.R")
biocLite()
library(readr)
library(magrittr)
library(dplyr)
#install the package phyloseq
biocLite(c("phyloseq"))

#install.packages("phyloseq")
library(phyloseq)
# packageVersion("phyloseq")
library(Biostrings)
# packageVersion("Biostrings")

#Download the OTU abundance file
temp_otutax = tempfile()
otu_url = "http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v13.txt.gz"
download.file(otu_url, temp_otutax)

#Downlaod the Sample Map file
temp_map = tempfile()
map_url = "http://downloads.hmpdacc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2"
download.file(map_url, temp_map)
temp_map = bzfile(temp_map)

#Only to test if this code helps
v13_map <- read_tsv("./v13_map_uniquebyPSN.txt.bz2")
v13_otu <- read_tsv("./otu_table_psn_v13.txt.gz", skip = 1)

temp_map = read_tsv(temp_map)
temp_otuax = read_tsv(temp_otuax)

#Download the phylogenetic tree
temp_tree = tempfile()
tree_url = "http://downloads.hmpdacc.org/data/HMQCP/rep_set_v13.tre.gz"
download.file(tree_url, temp_tree)
tree = read_tree(temp_tree)
head(taxa_names(tree))
tree$tip.label <- gsub("'", "", tree$tip.label, fixed = TRUE)
head(tree$tip.label)

#Download the representative sequences
zipped_refseq = tempfile()
refseq_url = "http://downloads.hmpdacc.org/data/HMQCP/rep_set_v13.fna.gz"
download.file(refseq_url, zipped_refseq)

unzipped_rsfile = tempfile()
refseqgzcon = gzfile(zipped_refseq)
writeLines(readLines(refseqgzcon), unzipped_rsfile)

refseqs = readDNAStringSet(unzipped_rsfile)
refseqs

head(names(refseqs))
names(refseqs) = gsub("(^[[:print:]]{7,13})([[:space:]]{1,})([[:print:]]{0,}$)",
                      
                      "\\1", names(refseqs))
head(names(refseqs))

#Import the data and create the phyloseq Objects 
system.time(HMPv13 <- import_qiime(temp_otutax, temp_map, tree, refseqs))
HMPv13 <- import_qiime(temp_otutax, temp_map, tree, refseqs)

#Import the data using only temp otu.()
system.time(HMPv13 <- import_qiime(temp_otutax))
HMPv13 <- import_qiime(temp_otutax)

system.time(HMPv13 <- import_qiime(temp_map))
HMPv13 <- import_qiime(temp_map)

system.time(HMPv13 <- import_qiime(refseqs))
HMPv13 <- import_qiime(refseqs)

system.time(HMPv13 <- import_qiime(tree))
HMPv13 <- import_qiime(tree)

#Basic features of HMPv35
ntaxa(HMPv13)

nsamples(HMPv13)

sample_variables(HMPv13)

rank_names(HMPv13)

head(tax_table(HMPv13))

#Save HMPV35 to an RData file
save(HMPv13, file = "HMPv13.RData", compress = "bzip2")

