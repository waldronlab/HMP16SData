<!--
changes to "README.md" are made in "vignettes/HMP16SData.Rmd"
-->
![fa-linux](http://fa2png.io/media/icons/font-awesome/4-7-0/linux/20/0/2c3e50_none.png) [![Travis-CI Linux Build Status](https://travis-matrix-badges.herokuapp.com/repos/waldronlab/HMP16SData/branches/master/1)](https://travis-ci.org/waldronlab/HMP16SData)

*[HMP16SData](http://bioconductor.org/packages/HMP16SData)* is a Bioconductor ExperimentHub package of the Human Microbiome Project (HMP) 16S rRNA sequencing data for variable regions 1-3 and 3-5. The raw data files are provided in the package as downloaded from the HMP Data Analysis and Coordination Center website. Processed data is provided as SummarizedExperiment objects via ExperimentHub.

*[HMP16SData](http://bioconductor.org/packages/HMP16SData)* can be installed using *[BiocInstaller](http://bioconductor.org/packages/BiocInstaller)* as follows:

``` r
BiocInstaller::biocLite("HMP16SData")
```

Once installed, *[HMP16SData](http://bioconductor.org/packages/HMP16SData)* provides two functions to access data – one for variable region 1-3 and another for variable region 3-5. When called as follows the functions will download data from an *[ExperimentHub](http://bioconductor.org/packages/ExperimentHub)* AWS S3 bucket over https. Of couse, it is necessary to load the package first.

``` r
library(HMP16SData)
V13()
V35()
```

The two datasets are represented as `SummarizedExperiment` objects, a standard Bioconductor class that is amenable to subsetting and analysis. To maintain breveity, details of the `SummarizedExperiment` class are not outlined here but the *[SummarizedExperiment](http://bioconductor.org/packages/SummarizedExperiment)* package provides an excellent vignette. Similarly, analysis of microbiome data is better outlined elsewhere and the *[phyloseq](http://bioconductor.org/packages/phyloseq)* package provides excellent tools for the task.

However, analysis using the *[phyloseq](http://bioconductor.org/packages/phyloseq)* package requires objects of `phyloseq` class. At present, there is ongoing discussion regarding a coercion function and a `SummarizedExperiment2phyloseq` method will be provided eminently. Similarly, a function to attach protected metadata from dbGaP is currently under development and will be added shortly.
