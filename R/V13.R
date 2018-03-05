#' 16S rRNA sequencing data for variable regions 1-3
#'
#' 16S rRNA sequencing was performed on samples collected at five major body
#' sites from 300 healthy adults between the ages of 18 and 40
#'
#' @param metadata logical; if TRUE only the metadata is downloaded, rather than
#' the entire resource
#'
#' @format A SummarizedExperiment with 43,140 features and 2,898 samples:
#' \describe{
#'     \item{random_subject_identifier}{a random subject identifier}
#'     \item{visit_number}{visit number, between 1 and 3}
#'     \item{sex}{sex, female or male}
#'     \item{run_center}{center where sample sequencing took place: Baylor
#'     College of Medicine (BCM), the Broad Institute (BI), the J. Craig Venter
#'     Institute (JCVI), or the Genome Sequencing Center at Washington
#'     University (WUGC)}
#'     \item{hmp_body_subsite}{body subsite where sample was collected}
#'     \item{description}{long description providing a random sample ID number,
#'     a random subject ID number, and sex}
#'     \item{consensus_lineage}{the most detailed lineage description shared by
#'     the sequences within an OTU}
#' }
#'
#' @source \url{http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz}
#' @source \url{http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2}
#'
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
#'
#' @examples V13()
#'
#' @name V13
NULL
