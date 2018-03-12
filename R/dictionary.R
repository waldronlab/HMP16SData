#' A data dictionary describing dbGaP metadata variables
#'
#' A data dictionary containing descriptions of the variables attached using the
#' \code{\link{attach_dbGaP}} function, as translated from dbGaP XLM data
#' dictionary files.
#'
#' @format A \code{\link[base]{data.frame}} with 789 rows and 8 variables:
#' \describe{
#'   \item{Variable}{the name of the variable as it appears in
#'   \code{\link[SummarizedExperiment]{SummarizedExperiment}} objects}
#'   \item{Description}{a description of the variable}
#'   \item{Type}{the type of variable, as specified by dbGaP}
#'   \item{Units}{the units of the variable (e.g. days)}
#'   \item{Minimum}{the smallest possible value of the variable}
#'   \item{Maximum}{the largest possible value of the variable}
#'   \item{Coded values}{the encoding of coded categorical variables, if needed}
#'   \item{Comment}{any comments from dbGaP, most pertain to gated fields}
#' }
#'
#' @source \url{https://tinyurl.com/y7rgelao}
#' @source \url{https://tinyurl.com/y7at85tv}
#' @source \url{https://tinyurl.com/y7af3arf}
#' @source \url{https://tinyurl.com/ych4wywl}
#' @source \url{https://tinyurl.com/y9hwfn9e}
#' @source \url{https://tinyurl.com/y7jtghxv}
#' @source \url{https://tinyurl.com/y7znjmak}
#'
#' @seealso \code{\link{attach_dbGaP}}
#'
#' @examples data("dictionary")
"dictionary"
