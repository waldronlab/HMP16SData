library(readr)
library(magrittr)
library(dplyr)

# v13_map <- read_tsv("data/ppAll_V13_map.txt")

# read the tsv file
v13_map <- read_tsv("./data/ppAll_V13_map.txt")
v13_otu <- read_tsv("./data/otu_table_psn_v13.txt", skip = 1)
v35_map <- read_tsv("./data/ppAll_V35_map.txt")
v35_otu <- read_tsv("./data/otu_table_psn_v35.txt", skip = 1)
v13_Stool_map <- v13_map %>% filter(HMPBodySubsiteHMPBodySite == "Stool")

# make new dataframes by bodysite for v13
v13_Stool_map <- v13_map %>% filter(HMPbodysubsite == "Stool")
v13_Saliva_map <- v13_map %>% filter(HMPbodysubsite == "Saliva")
v13_Tongue_dorsum_map <- v13_map %>% filter(HMPbodysubsite == "Tongue_dorsum")
v13_Hard_palate_map <- v13_map %>% filter(HMPbodysubsite == "Hard_palate")
v13_Buccal_mucosa_map <- v13_map %>% filter(HMPbodysubsite == "Buccal_mucosa")
v13_Attached_Keratinized_gingiva_map <- v13_map %>% filter(HMPbodysubsite == "Attached_Keratinized_gingiva")
v13_Palatine_Tonsils_map <- v13_map %>% filter(HMPbodysubsite == "Palatine_Tonsils")
v13_Throat_map <- v13_map %>% filter(HMPbodysubsite == "Throat")
v13_Supragingival_plaque_map <- v13_map %>% filter(HMPbodysubsite == "Supragingival_plaque")
v13_Subgingival_plaque_map <- v13_map %>% filter(HMPbodysubsite == "Subgingival_plaque")
v13_Anterior_nares_map <- v13_map %>% filter(HMPbodysubsite == "Anterior_nares")
v13_Left_Retroauricular_crease_map <- v13_map %>% filter(HMPbodysubsite == "Left_Retroauricular_crease")
v13_Right_Retroauricular_crease_map <- v13_map %>% filter(HMPbodysubsite == "Right_Retroauricular_crease")
v13_Right_Antecubital_fossa_map <- v13_map %>% filter(HMPbodysubsite == "Right_Antecubital_fossa")
v13_Vaginal_introitus_map <- v13_map %>% filter(HMPbodysubsite == "Vaginal_introitus")
v13_Mid_vagina_map <- v13_map %>% filter(HMPbodysubsite == "Mid_vagina")
v13_Posterior_fornix_map <- v13_map %>% filter(HMPbodysubsite == "Posterior_fornix")
v13_Left_Antecubital_fossa_map <- v13_map %>% filter(HMPbodysubsite == "Left_Antecubital_fossa")

# make new dataframes by bodysite for v35
v35_Stool_map <- v35_map %>% filter(HMPbodysubsite == "Stool")
v35_Saliva_map <- v35_map %>% filter(HMPbodysubsite == "Saliva")
v35_Tongue_dorsum_map <- v35_map %>% filter(HMPbodysubsite == "Tongue_dorsum")
v35_Hard_palate_map <- v35_map %>% filter(HMPbodysubsite == "Hard_palate")
v35_Buccal_mucosa_map <- v35_map %>% filter(HMPbodysubsite == "Buccal_mucosa")
v35_Attached_Keratinized_gingiva_map <- v35_map %>% filter(HMPbodysubsite == "Attached_Keratinized_gingiva")
v35_Palatine_Tonsils_map <- v35_map %>% filter(HMPbodysubsite == "Palatine_Tonsils")
v35_Throat_map <- v35_map %>% filter(HMPbodysubsite == "Throat")
v35_Supragingival_plaque_map <- v35_map %>% filter(HMPbodysubsite == "Supragingival_plaque")
v35_Subgingival_plaque_map <- v35_map %>% filter(HMPbodysubsite == "Subgingival_plaque")
v35_Anterior_nares_map <- v35_map %>% filter(HMPbodysubsite == "Anterior_nares")
v35_Left_Retroauricular_crease_map <- v35_map %>% filter(HMPbodysubsite == "Left_Retroauricular_crease")
v35_Right_Retroauricular_crease_map <- v35_map %>% filter(HMPbodysubsite == "Right_Retroauricular_crease")
v35_Right_Antecubital_fossa_map <- v35_map %>% filter(HMPbodysubsite == "Right_Antecubital_fossa")
v35_Vaginal_introitus_map <- v35_map %>% filter(HMPbodysubsite == "Vaginal_introitus")
v35_Mid_vagina_map <- v35_map %>% filter(HMPbodysubsite == "Mid_vagina")
v35_Posterior_fornix_map <- v35_map %>% filter(HMPbodysubsite == "Posterior_fornix")
v35_Left_Antecubital_fossa_map <- v35_map %>% filter(HMPbodysubsite == "Left_Antecubital_fossa")

v13_Stool_otu <- v13_otu[, colnames(v13_otu) %in% v13_Stool_map$`PSN`]

# add the rownames from last column for v13
v13_Stool_otu <- v13_otu[, colnames(v13_otu) %in% v13_Stool_map$`SampleID`]
v13_Saliva_otu <- v13_otu[, colnames(v13_otu) %in% v13_Saliva_map$`#SampleID`]
v13_Tongue_dorsum_otu <- v13_otu[, colnames(v13_otu) %in% v13_Tongue_dorsum_map$`#SampleID`]
v13_Hard_palate_otu <- v13_otu[, colnames(v13_otu) %in% v13_Hard_palate_map$`#SampleID`]
v13_Buccal_mucosa_otu <- v13_otu[, colnames(v13_otu) %in% v13_Buccal_mucosa_map$`#SampleID`]
v13_Attached_Keratinized_gingiva_otu <- v13_otu[, colnames(v13_otu) %in% v13_Attached_Keratinized_gingiva_map$`#SampleID`]
v13_Palatine_Tonsils_otu <- v13_otu[, colnames(v13_otu) %in% v13_Palatine_Tonsils_map$`#SampleID`]
v13_Throat_otu <- v13_otu[, colnames(v13_otu) %in% v13_Throat_map$`#SampleID`]
v13_Supragingival_plaque_otu <- v13_otu[, colnames(v13_otu) %in% v13_Supragingival_plaque_map$`#SampleID`]
v13_Subgingival_plaque_otu <- v13_otu[, colnames(v13_otu) %in% v13_Subgingival_plaque_map$`#SampleID`]
v13_Anterior_nares_otu <- v13_otu[, colnames(v13_otu) %in% v13_Anterior_nares_map$`#SampleID`]
v13_Left_Retroauricular_crease_otu <- v13_otu[, colnames(v13_otu) %in% v13_Left_Retroauricular_crease_map$`#SampleID`]
v13_Right_Retroauricular_crease_otu <- v13_otu[, colnames(v13_otu) %in% v13_Right_Retroauricular_crease_map$`#SampleID`]
v13_Right_Antecubital_fossa_otu <- v13_otu[, colnames(v13_otu) %in% v13_Right_Antecubital_fossa_map$`#SampleID`]
v13_Vaginal_introitus_otu <- v13_otu[, colnames(v13_otu) %in% v13_Vaginal_introitus_map$`#SampleID`]
v13_Mid_vagina_otu <- v13_otu[, colnames(v13_otu) %in% v13_Mid_vagina_map$`#SampleID`]
v13_Posterior_fornix_otu <- v13_otu[, colnames(v13_otu) %in% v13_Posterior_fornix_map$`#SampleID`]
v13_Left_Antecubital_fossa_otu <- v13_otu[, colnames(v13_otu) %in% v13_Left_Antecubital_fossa_map$`#SampleID`]


# add the rownames from last column for v35
v35_Stool_otu <- v35_otu[, colnames(v35_otu) %in% v35_Stool_map$`#SampleID`]
v35_Saliva_otu <- v35_otu[, colnames(v35_otu) %in% v35_Saliva_map$`#SampleID`]
v35_Tongue_dorsum_otu <- v35_otu[, colnames(v35_otu) %in% v35_Tongue_dorsum_map$`#SampleID`]
v35_Hard_palate_otu <- v35_otu[, colnames(v35_otu) %in% v35_Hard_palate_map$`#SampleID`]
v35_Buccal_mucosa_otu <- v35_otu[, colnames(v35_otu) %in% v35_Buccal_mucosa_map$`#SampleID`]
v35_Attached_Keratinized_gingiva_otu <- v35_otu[, colnames(v35_otu) %in% v35_Attached_Keratinized_gingiva_map$`#SampleID`]
v35_Palatine_Tonsils_otu <- v35_otu[, colnames(v35_otu) %in% v35_Palatine_Tonsils_map$`#SampleID`]
v35_Throat_otu <- v35_otu[, colnames(v35_otu) %in% v35_Throat_map$`#SampleID`]
v35_Supragingival_plaque_otu <- v35_otu[, colnames(v35_otu) %in% v35_Supragingival_plaque_map$`#SampleID`]
v35_Subgingival_plaque_otu <- v35_otu[, colnames(v35_otu) %in% v35_Subgingival_plaque_map$`#SampleID`]
v35_Anterior_nares_otu <- v35_otu[, colnames(v35_otu) %in% v35_Anterior_nares_map$`#SampleID`]
v35_Left_Retroauricular_crease_otu <- v35_otu[, colnames(v35_otu) %in% v35_Left_Retroauricular_crease_map$`#SampleID`]
v35_Right_Retroauricular_crease_otu <- v35_otu[, colnames(v35_otu) %in% v35_Right_Retroauricular_crease_map$`#SampleID`]
v35_Right_Antecubital_fossa_otu <- v35_otu[, colnames(v35_otu) %in% v35_Right_Antecubital_fossa_map$`#SampleID`]
v35_Vaginal_introitus_otu <- v35_otu[, colnames(v35_otu) %in% v35_Vaginal_introitus_map$`#SampleID`]
v35_Mid_vagina_otu <- v35_otu[, colnames(v35_otu) %in% v35_Mid_vagina_map$`#SampleID`]
v35_Posterior_fornix_otu <- v35_otu[, colnames(v35_otu) %in% v35_Posterior_fornix_map$`#SampleID`]
v35_Left_Antecubital_fossa_otu <- v35_otu[, colnames(v35_otu) %in% v35_Left_Antecubital_fossa_map$`#SampleID`]


# map the colnames to bodysite and sample ID

#split the map by body site which gives a list of each body site.
#lapply(colnames(v13_otu) %in% v13_Stool_map$`PSN`)

#using split funtion to get a list of each bodysite with all the elements.
split(v13_map, v13_map$HMPBodySubsiteHMPBodySite)


v13_map_bodysite <- lapply(v13_map , FUN= function(x) {x [,colnames(v13_otu) %in% x$`PSN`]})

v13_map_bodysite <- lapply(v13_map, FUN = function (element) {
  element <- element[, colnames(v13_map) %in% element$PSN]
  element
})

lapply(v13_map_bodysite, head)

