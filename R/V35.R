#' HMP 16S rRNA sequencing data for variable regions 3–5
#'
#' The NIH Human Microbiome Project (HMP) was a longitudinal study conducted
#' from 2007 to 2012 across four institutions (Baylor College of Medicine, the
#' Broad Institute, the J. Craig Venter Institute, and Washington University) of
#' healthy adults aged 18 to 40 that produced a comprehensive reference for the
#' composition, diversity, and variation of the healthy human microbiome. This
#' \code{\link[SummarizedExperiment]{SummarizedExperiment-class}} object
#' represents 16S rRNA sequencing data for variable regions 3–5 that was
#' performed on samples collected at five major body sites – available
#' participant metadata as well as phylogenetic trees are included.
#'
#' @usage V35(metadata = FALSE)
#'
#' @param metadata logical; if \code{TRUE} only the metadata is downloaded,
#' rather than the entire resource
#'
#' @format A \code{\link[SummarizedExperiment]{SummarizedExperiment}} with
#' 45,383 features and 4,743 samples:
#' \subsection{colData}{
#'     \describe{
#'         \item{RSID}{a random subject identifier}
#'         \item{VISITNO}{visit number, between 1 and 3}
#'         \item{SEX}{sex, female or male}
#'         \item{RUN_CENTER}{center where sample sequencing took place: Baylor
#'         College of Medicine (BCM), the Broad Institute (BI), the J. Craig
#'         Venter Institute (JCVI), or the Genome Sequencing Center at
#'         Washington University (WUGC)}
#'         \item{HMP_BODY_SITE}{body site where the sample was collected}
#'         \item{HMP_BODY_SUBSITE}{body subsite where the sample was collected}
#'         \item{SRS_SAMPLE_ID}{a sample identifier to be used when comparing
#'         16S rRNA samples to whole metagenome shotgun (WMS) samples}
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
#' @note The "PSN" identifiers were used as the \code{colnames} of the
#' \code{\link[SummarizedExperiment]{SummarizedExperiment}} object, see source
#' for additional information.
#'
#' @source The following source information is derived from the HMP Data
#' Analysis and Coordination Center:
#' @source Following a July 2010 16S data freeze, data was downloaded from NCBI
#' SRA projects SRP002395: Human Microbiome Project 16S rRNA Clinical Production
#' Phase I, and SRP002012: Human Microbiome Project 454 Clinical Production
#' Pilot. This dataset corresponds to over 5,700 samples and over 10,000
#' sequence preps. 16S variable region 3–5 (V35) was sequenced for the entire
#' set of samples, and variable region 1–3 (V13) for a subset of samples.
#' @source The QIIME (Quantitative Insights Into Microbial Ecology) software
#' package was used to process HMP 16S data using an OTU-binning strategy to
#' which taxonomic classification is added.
#' @source Raw 16S sequence and metadata, available through
#' \url{https://tinyurl.com/y7ev836z}, were demultiplexed using QIIME. OTU
#' picking was performed for the V1–3 and V3–5 region sequences using OTUPipe,
#' which includes error correction, chimera checking through UCHIME, and
#' clustering via UCLUST, and postprocessing by picking the optimal
#' representative sequence centroid. Taxonomy was assigned using the RDP
#' classifier version 2.2.
#' @source The resulting OTU tables were checked for mislabeling and
#' contamination, as described in the SOP available through
#' \url{https://tinyurl.com/y7ev836z}. Alpha and beta diversity for each sample
#' and Procrustes analysis were established using QIIME with default parameters.
#' @source All QIIME output files are available through
#' \url{https://tinyurl.com/y7ev836z}, for both the V1–3 and V3–5 variable
#' regions, as well as Procrustes summary data. SOPs and custom scripts are also
#' available through \url{https://tinyurl.com/y7ev836z}.
#' @source If you're interested in joint analysis of 16S and shotgun metagenomic
#' datasets from the HMP, pairing up data from the same microbiome samples can
#' initially seem tricky. The HMP Sample Flow Schematic indicates how these
#' sample IDs are related experimentally, and provides tables joining 16S
#' dataset "SN" and "PSN" identifiers with metagenomic dataset "SRS"
#' identifiers.
#' @source Four files were used to construct this
#' \code{\link[SummarizedExperiment]{SummarizedExperiment-class}} object.
#' @source OTU table file with PSN identifiers:
#' \url{https://tinyurl.com/y9rbpjl7}
#' @source Subject metadata files with PSN identifiers:
#' \url{https://tinyurl.com/yaz35f22}
#' @source Subject metadata files with SRS identifiers:
#' \url{https://tinyurl.com/y9xjqm29}
#' @source Representative sequence phylogenetic trees:
#' \url{https://tinyurl.com/y9exxlgr}
#'
#' @seealso \code{\link{V13}}
#'
#' @examples V35()
"V35"
