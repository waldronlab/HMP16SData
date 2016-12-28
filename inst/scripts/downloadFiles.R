downloadFiles <- function() {
    system.file("extdata", "data.csv", package = "HMP16SData") %>%
    read_csv(col_types = cols_only(
        `File Description` = col_character(),
        `v13 Download` = col_character(),
        `v13 Size` = col_integer(),
        `v13 MD5` = col_character(),
        `v35 Download` = col_character(),
        `v35 Size` = col_integer(),
        `v35 MD5` = col_character()
    ))
}
