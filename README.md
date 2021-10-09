
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HMP16SData

<!-- badges: start -->
<!-- badges: end -->

*[HMP16SData](https://bioconductor.org/packages/release/HMP16SData)* is a
Bioconductor ExperimentData package of the Human Microbiome Project
(HMP) 16S rRNA sequencing data for variable regions 1–3 and 3–5. Raw
data files are provided in the package as downloaded from the [HMP Data
Analysis and Coordination Center](https://tinyurl.com/y7ev836z).
Processed data is provided as `SummarizedExperiment` class objects via
*[ExperimentHub](https://bioconductor.org/packages/release/ExperimentHub)*.

*[HMP16SData](https://bioconductor.org/packages/release/HMP16SData)* can be
installed using
*[BiocManager](https://CRAN.R-project.org/package=BiocManager)* as
follows.

``` r
BiocManager::install("HMP16SData")
```

Once installed,
*[HMP16SData](https://bioconductor.org/packages/release/HMP16SData)*
provides two functions to access data – one for variable region 1–3 and
another for variable region 3–5. When called, as follows, the functions
will download data from an
*[ExperimentHub](https://bioconductor.org/packages/release/ExperimentHub)*
Amazon S3 (Simple Storage Service) bucket over `https` or load data from
a local cache.

``` r
V13()
```

    ## class: SummarizedExperiment 
    ## dim: 43140 2898 
    ## metadata(2): experimentData phylogeneticTree
    ## assays(1): 16SrRNA
    ## rownames(43140): OTU_97.1 OTU_97.10 ... OTU_97.9997 OTU_97.9999
    ## rowData names(7): CONSENSUS_LINEAGE SUPERKINGDOM ... FAMILY GENUS
    ## colnames(2898): 700013549 700014386 ... 700114963 700114965
    ## colData names(7): RSID VISITNO ... HMP_BODY_SUBSITE SRS_SAMPLE_ID

``` r
V35()
```

    ## class: SummarizedExperiment 
    ## dim: 45383 4743 
    ## metadata(2): experimentData phylogeneticTree
    ## assays(1): 16SrRNA
    ## rownames(45383): OTU_97.1 OTU_97.10 ... OTU_97.9998 OTU_97.9999
    ## rowData names(7): CONSENSUS_LINEAGE SUPERKINGDOM ... FAMILY GENUS
    ## colnames(4743): 700013549 700014386 ... 700114717 700114750
    ## colData names(7): RSID VISITNO ... HMP_BODY_SUBSITE SRS_SAMPLE_ID

The two data sets are represented as `SummarizedExperiment` objects, a
standard Bioconductor class that is amenable to subsetting and analysis.
To maintain brevity, details of the `SummarizedExperiment` class are not
outlined here but the
*[SummarizedExperiment](https://bioconductor.org/packages/release/SummarizedExperiment)*
package provides an excellent vignette.

For a complete explanation of the features of
*[HMP16SData](https://bioconductor.org/packages/release/HMP16SData)*, see
the [package vignette](https://tinyurl.com/yaob5n77) or read the
[American Journal of Epidemiology
article](https://tinyurl.com/y2o9x257).

------------------------------------------------------------------------

Schiffer, L. *et al.* HMP16SData: Efficient Access to the Human
Microbiome Project through Bioconductor. *Am. J. Epidemiol.* (2019).

Griffith, J. C. & Morgan, X. C. Invited Commentary: Improving
accessibility of the Human Microbiome Project data through integration
with R/Bioconductor. *Am. J. Epidemiol.* (2019).

Waldron, L. *et al.* Improving Accessibility of the Human Microbiome
Project Data Through Integration With R/Bioconductor. *Am. J.
Epidemiol.* (2019).
