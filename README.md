![fa-linux](https://tinyurl.com/yadaat78)
[![ci-linux](https://tinyurl.com/y7wya2kf)](https://tinyurl.com/ybau2brs)

# HMP16SData

*[HMP16SData](http://bioconductor.org/packages/HMP16SData)* is a Bioconductor
ExperimentData package of the Human Microbiome Project (HMP) 16S rRNA sequencing
data for variable regions 1–3 and 3–5. Raw data files are provided in the
package as downloaded from the
[HMP Data Analysis and Coordination Center](https://tinyurl.com/y7ev836z).
Processed data is provided as
*[SummarizedExperiment](http://bioconductor.org/packages/SummarizedExperiment)*
objects via *[ExperimentHub](http://bioconductor.org/packages/ExperimentHub)*.

*[HMP16SData](http://bioconductor.org/packages/HMP16SData)* can be installed
using *[BiocInstaller](http://bioconductor.org/packages/BiocInstaller)* as
follows:

```r
BiocInstaller::biocLite("HMP16SData")
```

Once installed, *[HMP16SData](http://bioconductor.org/packages/HMP16SData)*
provides two functions to access data – one for variable region 1–3 and another
for variable region 3–5. When called, as follows, the functions will download
data from an *[ExperimentHub](http://bioconductor.org/packages/ExperimentHub)*
Amazon S3 (Simple Storage Service) bucket over `https` or load data from a local
cache.

```r
V13()
```

```
## class: SummarizedExperiment
## dim: 43140 2898
## metadata(1): experimentData
## assays(1): 16SrRNA
## rownames(43140): OTU_97.1 OTU_97.10 ... OTU_97.9997 OTU_97.9999
## rowData names(7): CONSENSUS_LINEAGE SUPERKINGDOM ... FAMILY GENUS
## colnames(2898): 700013549 700014386 ... 700114963 700114965
## colData names(5): RSID VISITNO SEX RUN_CENTER HMP_BODY_SUBSITE
```

```r
V35()
```

```
## class: SummarizedExperiment
## dim: 45383 4743
## metadata(1): experimentData
## assays(1): 16SrRNA
## rownames(45383): OTU_97.1 OTU_97.10 ... OTU_97.9998 OTU_97.9999
## rowData names(7): CONSENSUS_LINEAGE SUPERKINGDOM ... FAMILY GENUS
## colnames(4743): 700013549 700014386 ... 700114717 700114750
## colData names(5): RSID VISITNO SEX RUN_CENTER HMP_BODY_SUBSITE
```

The two datasets are represented as `SummarizedExperiment` objects, a standard
Bioconductor class that is amenable to subsetting and analysis. To maintain
breveity, details of the `SummarizedExperiment` class are not outlined here but
the
*[SummarizedExperiment](http://bioconductor.org/packages/SummarizedExperiment)*
package provides an excellent vignette.

For a complete explaination of the features of
*[HMP16SData](http://bioconductor.org/packages/HMP16SData)*, see the
[package vignette](https://tinyurl.com/yaob5n77).
