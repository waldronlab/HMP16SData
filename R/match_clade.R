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
        grepl(pattern, x = .) %>%
        extract(text, .) %>%
        sub(pattern, "", x = .) %>%
        gsub("\\.", "\\. ", x = .) %>%
        gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", x = .) %>%
        ifelse(length(.) == 0, NA_character_, .) %>%
        ifelse(nchar(.) == 0, NA_character_, .)
}
