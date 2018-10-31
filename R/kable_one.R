#' Produce a summary HTML table of key demographic variables
#'
#' Sometimes it is desirable to produce a summary of key demographic variables
#' for presentation. The \code{\link{table_one}} and \code{\link{kable_one}}
#' methods are a quick way to do so – they not only summarize key demographic
#' variables from \code{\link[SummarizedExperiment]{SummarizedExperiment-class}}
#' object(s) in the \code{\link{HMP16SData}} package but remove abbreviations
#' and underscores in column and variable names that might otherwise be
#' ambigious. The \code{\link{table_one}} method returns a \emph{tidy} (i.e. one
#' sample observation per line) \code{data.frame} object or a named \code{list}
#' of \emph{tidy} \code{data.frame} objects. The \code{\link{kable_one}} method
#' can then be used to produce a publication-ready \code{HTML} table that could,
#' for example, be pasted into a word processor.
#'
#' @param x A \code{data.frame} object or a named \code{list} of
#' \code{data.frame} objects returned from the \code{\link{table_one}} method
#' @param significant_figures The number of significant figures to be used for
#' decimals in the \code{HTML} table; if no value is specified, the default is 2
#'
#' @return A summary \code{HTML} table of key demographic variables
#' @export
#'
#' @seealso \code{\link{table_one}}
#'
#' @examples
#' V13() %>%
#'     table_one() %>%
#'     kable_one()
#'
#' @importFrom methods is
#' @importFrom magrittr %<>%
#' @importFrom magrittr %>%
#' @importFrom magrittr set_names
#' @importFrom magrittr add
#' @importFrom utils head
#' @importFrom magrittr set_colnames
#' @importFrom kableExtra group_rows
#' @importFrom kableExtra row_spec
#' @importFrom kableExtra kable_styling
#' @importFrom kableExtra add_header_above
kable_one <- function(x, significant_figures = 2) {
    if (is(x, "data.frame")) {
        x %<>%
            list() %>%
            set_names("VXX")
    }

    element_names <-
        names(x) %>%
        as.character()

    element_length <- length(element_names)

    column_names <-
        c("N", "%") %>%
        rep(element_length) %>%
        c("", .)

    row_labels <-
        lapply(x, colnames) %>%
        Reduce(c, .) %>%
        unique()

    labels_n <- seq_along(row_labels)

    row_to <-
        Reduce(join_by_colnames, x) %>%
        count_rows()

    row_from <-
        add(row_to, 1) %>%
        head(-1) %>%
        as.integer() %>%
        c(1, .)

    header_names <-
        element_names %>%
        c(" ", .)

    header_vector <-
        length(element_names) %>%
        rep(2, .) %>%
        c(1, .) %>%
        as.character() %>%
        set_names(header_names)

    x %<>%
        lapply(calculate_n_and_p) %>%
        Reduce(join_n_and_p, .) %>%
        set_colnames(column_names) %>%
        align_kable(significant_figures)

    for (i in labels_n) {
        x %<>%
            group_rows(group_label = row_labels[i], start_row = row_from[i],
                       end_row = row_to[i],
                       label_row_css = "border: none; color: #000000;")
    }

    first_row <- 0

    last_row <- max(row_to)

    all_rows <- seq.int(first_row, last_row)

    x %<>%
        row_spec(all_rows, extra_css = "border: none; color: #000000;") %>%
        row_spec(
            first_row,
            extra_css = "border-bottom: thin solid; text-align: center;"
        ) %>%
        row_spec(last_row, extra_css = "border-bottom: thin solid;") %>%
        kable_styling(bootstrap_options = "condensed", full_width = TRUE)

    if (length(header_vector) > 2) {
        x %<>%
            add_header_above(header = header_vector)
    }

    x
}
