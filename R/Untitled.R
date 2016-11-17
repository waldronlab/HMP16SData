# read the tsv file
data <- read_tsv("./myfile.tsv")

# add the rownames from last column
data[, 233] <- gsub("Root;", "", data[, 233])
data[, 231] <- gsub(";", "|", data[, 231])
rownames(data) <- data[, 231]

# map the colnames to bodysite and sample ID

