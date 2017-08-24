library(readr)
library(Biobase)
# v13 file
v13_map <- read_tsv("./data/v13_map_uniquebyPSN.txt.bz2")
v13_otu <- read_tsv("./data/otu_table_psn_v13.txt.gz", skip = 1)

v13_otu  <- as.data.frame(v13_otu)
v13_ind  <- v13_otu[, c(1, 2912)]
rownames(v13_otu) <- as.character(v13_otu[, 1])
v13_otu  <- v13_otu[, -2912]
v13_otu  <- v13_otu[, -1]

# v35 file
v35_map <- read_tsv("./data/v35_map_uniquebyPSN.txt.bz2")
v35_otu <- read_tsv("./data/otu_table_psn_v35.txt.gz", skip = 1)

v35_otu  <- as.data.frame(v35_otu)
v35_ind  <- v35_otu[, c(1, 4790)]
rownames(v35_otu) <- as.character(v35_otu[, 1])
v35_otu  <- v35_otu[, -4790]
v35_otu  <- v35_otu[, -1]



abc <- v13_otu[, na.exclude(match(v13_map$`#SampleID`, colnames(v13_otu)))]
def <- v13_map[na.exclude(match(colnames(abc), v13_map$`#SampleID`)),]

def <- as.data.frame(def)
rownames(def) <- def[, 1]

ExpressionSet(data.matrix(abc), AnnotatedDataFrame(def))

