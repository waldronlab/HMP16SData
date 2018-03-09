#' @keywords internal
#'
#' @importFrom magrittr %<>%
#' @importFrom magrittr %>%
#' @importFrom magrittr extract
match_clade <- function(text, pattern) {
    text %<>%
        strsplit(";") %>%
        unlist()

    text %>%
        grepl(pattern, .) %>%
        extract(text, .) %>%
        sub(pattern, "", .) %>%
        gsub("\\.", "\\. ", .) %>%
        gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", .) %>%
        ifelse(length(.) == 0, NA_character_, .) %>%
        ifelse(nchar(.) == 0, NA_character_, .)
}
