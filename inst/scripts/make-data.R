# I. Downloading Data
# ==============================================================================
# Data from the Human Microbiome (HMP) Data Analysis and Coordination Center
# (DACC) Website was downloaded programatically on March 28, 2018, as outlined
# in data-raw/download.R script. An additional file, inst/extdata/data.csv, was
# downloaded from the HMP DACC via a web browser such that MD5 sums of files
# downloaded programatically could be checked against it. Two files downloaded
# by the data-raw/download.R script do not have MD5 sums present in the
# inst/extdata/data.csv file and, for provenance, the MD5 sums of these files
# were written to a text file, inst/extdata/MD5.txt – this step occurs at the
# end of the data-raw/download.R script. Up top for reproducibility!
#
#  ////
# !!!!  _     \\\\
# !   -'/   _  ||||
#  \   /    \`-'''|
#   \__|     \   /
#    )   |    \__\_
#   /    |     \   (
#   \
#
# What was downloaded? Excluding the inst/extdata/data.csv file, eight files in
# total were downloaded from the HMP DACC – four files for variable regions 1–3
# and four files for variable regions 3–5. The files corresponds to HMP 16S rRNA
# sequencing data processed through the QIIME pipeline, this is outlined in the
# R documentation, that were used to make SummarizedExperiment objects – the
# following files were integrated into the SummarizedExperiment objects.
#
# OTU table files with PSN identifiers:
# http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz
# http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v35.txt.gz
#
# Subject metadata files with PSN identifiers:
# http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2
# http://downloads.ihmpdcc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2
#
# Subject metadata files with SRS identifiers:
# https://www.hmpdacc.org/hmp/doc/ppAll_V13_map.txt
# https://www.hmpdacc.org/hmp/doc/ppAll_V35_map.txt
#
# Representative sequence phylogenetic trees:
# http://downloads.ihmpdcc.org/data/HMQCP/rep_set_v13.tre.gz
# http://downloads.ihmpdcc.org/data/HMQCP/rep_set_v35.tre.gz
#
# The unadulturated raw files are all available in inst/extdata and were
# downloaded with the following command.

source("data-raw/download.R")

# Feel free to check the files against the MD5 sums if you like!
#
# II. Processing Data
# ==============================================================================
# Data were processed using R Under development (unstable) (2018-03-02 r74346),
# with extensive use of the dplyr package. All scripted data processing can be
# seen in the data-raw directory. With the package as the working directory, the
# data processing could be repeated with these commands:

source("data-raw/V13.R")
source("data-raw/V35.R")

# The final result is two SummarizedExperiment objects saved in the data
# directory. These are then ready for upload to an ExperimentHub AWS S3 bucket.
# Finally, the metadata.csv file necessary for ExperimentHub resources is made
# as outlined in make-metadata.csv.
