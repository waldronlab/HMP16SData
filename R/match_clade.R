#' @importFrom magrittr %<>%
#' @importFrom magrittr %>%
#' @importFrom magrittr extract
#'
#' @keywords internal
match_clade <- function(pattern, text) {
    text %<>%
        strsplit(";") %>%
        unlist()

    text %>%
        grepl(pattern, .) %>%
        extract(text, .) %>%
        sub(pattern, "", .) %>%
        sub("([[:lower:]])([[:upper:]])", "\\1 \\2", .) %>%
        ifelse(length(.) == 0, NA_character_, .) %>%
        as.character()
}
