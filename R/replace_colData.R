replace_colData <- function(new_colData, HMP16S_data) {
    colData(HMP16S_data) <- new_colData
    HMP16S_data
}
