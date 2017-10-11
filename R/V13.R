#' 16S rRNA sequencing data for variable regions 1-3
#'
#' 16S rRNA sequencing was performed on samples collected at five major body
#' sites from 300 healthy adults between the ages of 18 and 40
#'
#' @format A SummarizedExperiment with 43,140 features and 2,898 samples:
#' \describe{
#'   \item{sample_id}{an id number given to each sample}
#'   \item{random_subject_identifier}{a random subject identifier}
#'   \item{visit_number}{visit number, between 1 and 3}
#'   \item{sex}{sex at time of enrollment}
#'   \item{run_center}{center where sample collection took place: Baylor College
#'    of Medicine (BCM) or Genome Sequencing Center at Washington University
#'    (WUGC)}
#'   \item{hmp_body_subsite}{body subsite where sample was collected from}
#'   \item{description}{long description providing sample ID number and sex}
#'   \item{consensus_lineage}{the most detailed lineage description shared by
#'   the sequences within an OTU}
#' }
#'
#' @source \url{http://downloads.ihmpdcc.org/data/HMQCP/otu_table_psn_v13.txt.gz}
#' @source \url{http://downloads.ihmpdcc.org/data/HMQCP/v13_map_uniquebyPSN.txt.bz2}
#'
#' @examples V13()
NULL
