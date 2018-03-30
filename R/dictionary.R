#' A data dictionary describing dbGaP metadata variables
#'
#' A data dictionary containing descriptions of the metadata variables attached
#' using the \code{\link{attach_dbGaP}} method, as translated from dbGaP
#' \code{XLM} data dictionary files.
#'
#' @format A \code{data.frame} with 789 rows and 8 variables:
#' \describe{
#'   \item{VARIABLE}{The name of the variable as it appears in
#'   \code{SummarizedExperiment} \code{colData}}
#'   \item{DESCRIPTION}{A description of the variable}
#'   \item{TYPE}{The type of variable, as specified by dbGaP}
#'   \item{UNITS}{The units of the variable (e.g. days)}
#'   \item{MINIMUM}{The smallest possible value of the variable}
#'   \item{MAXIMUM}{The largest possible value of the variable}
#'   \item{CODED_VALUES}{The encoding of coded categorical variables, if needed}
#'   \item{COMMENT}{Any comments from dbGaP, most pertain to gated fields}
#' }
#'
#' @source The following dbGaP \code{XLM} data dictionary files were used to
#' construct the data dictionary.
#' @source Data dictionary for data table pht001185.v4.p1:
#' \url{https://tinyurl.com/y7rgelao}. No description provided by dbGaP.
#' @source Data dictionary for data table pht001193.v3.p1:
#' \url{https://tinyurl.com/y7at85tv}. The data table contains subject data with
#' sample information for the Global Trace Screen (GTV). Variables include the
#' specimen type (based on 18 specimens from 6 body sites), nucleic extraction
#' method, and sample administrative information. The Global Trace dataset will
#' be updated when additional visits or subjects have been added.
#' @source Data dictionary for data table pht002157.v1.p1:
#' \url{https://tinyurl.com/y7af3arf}. The Targeted Physical Forms (DTP),
#' Medical History Screening Forms (DHX), and the Visit Documentation Forms
#' (DVD) have been combined into a single data table. The DTP variables include
#' measurements collected for blood pressure, pulse, body weight, height, and
#' BMI. Variables also include physical assessment of areas/systems and the
#' specific details of the abnormalities. Areas/Systems consist of general
#' appearance, HEENT, cardiovascular, pulmonary, abdomen, neurological,
#' musculoskeletal, and extremities. The DHX variables include data that
#' indicate whether the subject noted medical problems in various areas/systems
#' and the indications and specifications of medical problems. Areas/Systems
#' consist of HEENT, cardiovascular, pulmonary, GI, hepatobiliary, renal,
#' neurologic, blood lymphatic, endocrine/metabolic, musculoskeletal,
#' genital/reproductive, dermatologic, allergies, cancer, immunodeficiency,
#' drug or alcohol dependence, and autoimmune disease. Data were also collected
#' for relevant medical or surgical history, medical abnormality with ongoing
#' treatment and presence of acute disease. The DVD variables include education
#' level, insurance status, occupation status, tobacco usage, and visit-specific
#' information. This visit-specific information pertains to subject's oral
#' temperature, pregnancy test results, education level, insurance status,
#' occupation, and if blood and GI specimens were collected. DTP, DHX and DVD
#' data will be collected at each visit though not every variable was collected.
#' @source Data dictionary for data table pht001187.v3.p1:
#' \url{https://tinyurl.com/ych4wywl}. The data table contains data that were
#' collected from the Concomitant Medications Form (DCM). Variables include
#' medication number and code, indication, if the medication is ongoing, and the
#' duration of the medication.
#' @source Data dictionary for data table pht001184.v3.p1:
#' \url{https://tinyurl.com/y9hwfn9e}. The data table contains the subject and
#' consent group information.
#' @source Data dictionary for data table pht002158.v1.p1:
#' \url{https://tinyurl.com/y7jtghxv}. The Demographics Form (DEM) and the
#' Eligibility Checklist (ENR) have been combined into a single data table. The
#' DEM variables include sociodemographic measurements such as gender,
#' ethnicity, race, and place of birth, while the ENR variables include the
#' enrollment/first sampling time of subjects (n=1 variable) and administrative
#' variables (n=4 variables). Both the Medical History and Targeted Physical
#' exams must be completed prior to the completion of the Exclusion Criteria
#' found in the ENR form. Data derived from the Medical History (DHX) and
#' Targeted Physical (DTP) exams can be found in EMMES_HMP_DTP_DHX_DVD dataset.
#' @source Data dictionary for data table pht002156.v1.p1:
#' \url{https://tinyurl.com/y7znjmak}. The data table contains data that were
#' collected from the Suppplemental Questions Form (DSU) upon the completion of
#' HMP study enrollment. Variables include additional health history such as
#' dietary habits, breastfeeding, birthing history, delivery method, and if the
#' subject failed any initial screenings prior to enrollment.
#'
#' @seealso \code{\link{attach_dbGaP}}
#'
#' @examples head(dictionary)
"dictionary"
