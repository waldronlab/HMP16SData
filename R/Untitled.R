library(readr)
library(magrittr)
library(dplyr)

# read the tsv file
v13_map <- read_tsv("./data/v13_map_uniquebyPSN.txt")
v13_otu <- read_tsv("./data/otu_table_psn_v13.txt", skip = 1)
v35_map <- read_tsv("./data/v35_map_uniquebyPSN.txt")
v35_otu <- read_tsv("./data/otu_table_psn_v35.txt", skip = 1)

# make new dataframes by bodysite
v13_Stool_map <- v13_map %>% filter(HMPbodysubsite == "Stool")
v13_Saliva
v13_Tongue_dorsum
v13_Hard_palate
v13_Buccal_mucosa
v13_Attached_Keratinized_gingiva
v13_Palatine_Tonsils
v13_Throat
v13_Supragingival_plaque
v13_Subgingival_plaque
v13_Anterior_nares
v13_Left_Retroauricular_crease
v13_Right_Retroauricular_crease
v13_Right_Antecubital_fossa
v13_Vaginal_introitus
v13_Mid_vagina
v13_Posterior_fornix
v13_Left_Antecubital_fossa

# add the rownames from last column
v13_Stool_otu <- v13_otu[, colnames(v13_otu) %in% v13_Stool$`#SampleID`]


# map the colnames to bodysite and sample ID

