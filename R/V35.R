#' publicly available 16S data from the Human Microbiome Project, Variable region 3-5
#'
#' 16S rRNA and metagenomic sequencing was performed on samples collected from
#' 300 healthy adult men and women between the ages of 18 and 40
#'
#' @format An ExpressionSet with 45383 features and 4743 samples:
#' \describe{
#'   \item{sample_id}{the sample_id number given to each sample}
#'   \item{random_subject_identifier}{a random subject identifier given for obsfication}
#'   \item{visit_number}{human participant being sampled over one to three visits}
#'   \item{sex}{biological sex, male or female, at time of enrollment}
#'   \item{run_center}{location where the clinal sample trials took place; Baylor College of Medicine (BCM), Genome Sequencing Center at Washington University (WUGC)}
#'   \item{hmp_body_subsite}{samples were collected in a non-invasive manner from five major body sites, with a total of 15 or 18 specific body sites}
#'   \item{description}{a path providing the sample ID number along with the specification of male or female}
#'   \item{consensus_lineage}{the most detailed lineage description shared by the sequences within the OTU}
#' }
"V35"
