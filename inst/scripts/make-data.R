# I. Downloading Data
# ==============================================================================
# Therein lies the problem, the data from the Human Microbiome (HMP) Website,
# specifically the mapping files for variable regions 1-3 and 3-5, as relates to
# data processed through the QIIME pipeline are no longer available. And when
# they were available, they were not downloaded programatically - could have,
# should have, would have. Anyway, the files included in the inst/extdata
# directory are exactly as downloaded from the HMP website but there is no MD5
# to check against. How about an ASCII high five instead?
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
# Basically, users will just have to have faith that the raw files are
# unadulturated, which they are, and that perhaps sometime in the future the HMP
# Data Analysis and Coordination Center (DACC) will fix the issue. What is the
# issue? There are two URLs
# (http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2 and
# http://downloads.ihmpdcc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2) that are
# not readable, well they were once upon a time until someone updated the files
# with a strange encoding. So, the point, the files in inst/extdata are these
# files but the same results could not be achieved with the present URLs. Ok, so
# data were download some time ago and put into inst/extdata - specifically
# mapping and otu table files. The URLs of the mapping files are above and the
# otu table were downloaded from
# (http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz and
# http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v35.txt.gz). All this,
# just to say that for complete reproducibility it would be necessary to use the
# files exactly as they are in inst/extdata if a reproduction of this work was
# attempted. Basically, files were downloaded some time ago and placed in
# inst/extdata.
#
# II. Processing Data
# ==============================================================================
# Data were processed using R (3.4.1), with extensive use of the dplyr package.
# All scripted data processing can be seen in the data-raw directory. With the
# package as the working directory, the data processing could be repeated with
# these commands:

source("data-raw/V13.R")
source("data-raw/V35.R")

# The final result is two SummarizedExperiment objects saved in the data
# directory. These are then ready for upload to an ExperimentHub AWS S3 bucket.
# Finally, the metadata.csv file necessary for ExperimentHub resources is made
# as outlined in make-metadata.csv.
