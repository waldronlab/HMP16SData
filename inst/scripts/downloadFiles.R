downloadFiles <- function() {
    system.file("extdata", "data.csv", package = "HMP16SData") %>%
    read_csv()
}
