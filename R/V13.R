#' 16S rRNA sequencing data for variable regions 1–3
#'
#' 16S rRNA sequencing was performed on samples collected at five major body
#' sites from 300 healthy adults between the ages of 18 and 40
#'
#' @usage V13(metadata = FALSE)
#'
#' @param metadata logical; if \code{TRUE} only the metadata is downloaded,
#' rather than the entire resource
#'
#' @format A \code{\link[SummarizedExperiment]{SummarizedExperiment}} with
#' 43,140 features and 2,898 samples:
#' \subsection{colData}{
#'     \describe{
#'         \item{RSID}{a random subject identifier}
#'         \item{VISITNO}{visit number, between 1 and 3}
#'         \item{SEX}{sex, female or male}
#'         \item{RUN_CENTER}{center where sample sequencing took place: Baylor
#'         College of Medicine (BCM), the Broad Institute (BI), the J. Craig
#'         Venter Institute (JCVI), or the Genome Sequencing Center at
#'         Washington University (WUGC)}
#'         \item{HMP_BODY_SUBSITE}{body subsite where the sample was collected}
#'     }
#' }
#' \subsection{rowData}{
#'     \describe{
#'         \item{CONSENSUS_LINEAGE}{the most detailed lineage description shared
#'         by the sequences within an OTU}
#'         \item{SUPERKINGDOM}{superkingdom taxonomy, assumed to be Bacteria}
#'         \item{PHYLUM}{phylum taxonomy parsed from \code{CONSENSUS_LINEAGE}}
#'         \item{CLASS}{calss taxonomy parsed from \code{CONSENSUS_LINEAGE}}
#'         \item{ORDER}{order taxonomy parsed from \code{CONSENSUS_LINEAGE}}
#'         \item{FAMILY}{family taxonomy parsed from \code{CONSENSUS_LINEAGE}}
#'         \item{GENUS}{genus taxonomy parsed from \code{CONSENSUS_LINEAGE}}
#'     }
#' }
#'
#' @return A \code{\link[SummarizedExperiment]{SummarizedExperiment}} object
#'
#' @source \url{https://tinyurl.com/y74gqpho}
#' @source \url{https://tinyurl.com/y8adlfso}
#'
#' @examples V13()
#'
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
"V13"
