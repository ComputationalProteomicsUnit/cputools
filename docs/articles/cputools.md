---
title: "Standardising R package development"
author: 
- name: Laurent Gatto
  affiliation: Computational Proteomics Unit, Cambridge, UK
package: cputools
abstract: >
  The *[cputools](https://github.com/ComputationalProteomicsUnit/cputools)*
  package provides a set of helper functions and guidelines to
  streamline and standardise package development and data analysis
  reporting for the [Computational Proteomics Unit](http://cpu.sysbiol.cam.ac.uk/) group.  
output:
  BiocStyle::html_document2:
    toc_float: true
vignette: >
  %\VignetteIndexEntry{Standardising R package development}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteKeywords{Infrastructure}
  %\VignetteEncoding{UTF-8}
---



> This is work in progress.

# Introduction

This vignette summarises some *good practice* for R programming and
package development. I tend to follow these myself and advise my
collaborators to use them when we work on projects together.



```r
library("cputools")
```

See also the
[CPU wiki](https://github.com/ComputationalProteomicsUnit/cputools/wiki)
for a non-exhaustive list. 

## GitHub user

Several function in the `cputools` package require a GitHub user name
to generate correct links to the software's page using
`makeGithubUrl`, for example. The user name, when not provided
explicitly, is fetched from the session options with
`options("GitHubUserName")`, which can be set in your `.Rprofile`
using


```r
options(GitHubUserName = "ComputationalProteomicsUnit")
```

If set, one can just call this function above with 


```r
makeGithubUrl("cputools")
```

Otherwise, the user can be specified explicitly with 


```r
makeGithubUrl("cputools", user = "ComputationalProteomicsUnit")
```

# Credibility

Demonstrate good programming skills by writing clean and maintainable
code, provide good documentation and follow good community practice. I
would recommend to follow the
[Bioconductor guidelines](https://bioconductor.org/developers/package-guidelines/)
for package development and submission, in particular good
documentation, vignettes and unit testing. I would also add continous
integration (see below) to this.

An essential aspect is to officially release the package. This can be
done by submitting it to a public package repository such as CRAN or
Biocondcutor. For any package related to high throughput biology,
acceptance to Bioconductor is becoming, in my opinion, a
requirement. It doesn't mean that there aren't any good
biology-related packages that are not in Bioconductor, or that all
packages in Bioconductor are first class packages, but any serious
package developer should ideally develope a package that matches
Bioconductor standards and review. A package that is only available on
a personal web page might not be reagarded positively in a first
instance; a package that has passed a well defined and formal review
process (and has been looked at by an experience R developer, which is
probably more that most of the bioinformatics tools available out
there), shows that the authors cared enough about his work to polish
it to Bioconductor standards.

If the package is not to be submitted to Bioconductor (in particular
if it doesn't fall into the project's remit), then the developer
should implement their own continous integration system (see below) to
demonstrate that the package successfully builds/checks on a
third-party infrastructure, ideally on different systems.

# DESCRIPTION 

> Use `Authors@R` to define authors and their respective roles. 

This is a requirement to generate package webpages with 
*[pkgdown](https://github.com/pkgdown)* later on.


# README files

`README` files are important for any software project, as they provide
an obvious first entry point to read more about the package. On
github, using markdown makes them visually appealing. Using R markdown
enables to include dynamically generated content. Finally, as we will
see below, they can be used to easily produce a compelling and useful
webpage for the R package.

> Create a `README.Rmd` file.

The default pipeline will this be to *knit* the `REAMDE.Rmd` file to
`READEM.md` using the `knitr::knit` function. To avoid the two file to
come out of sync when forgetting to `knit`. To avoid this, one can set
up a git hook, more specifically a `pre-commit` hook, that will check
that the `Rmd` file is not more recent than the `md` file.


The simplest is to use `devtools::use_readme_rmd()` to create the
`README.Rmd` template (see
[*Important files*](http://r-pkgs.had.co.nz/release.html#important-files))
in the *Advanced R* book. This pre-commit hook
`./.git/hooks/pre-commit` will contain 

```sh
#!/bin/bash
README=($(git diff --cached --name-only | grep -Ei '^README\.[R]?md$'))
MSG="use 'git commit --no-verify' to override this check"

if [[ ${#README[@]} == 0 ]]; then
  exit 0
fi

if [[ README.Rmd -nt README.md ]]; then
  echo -e "README.md is out of date; please re-knit README.Rmd\n$MSG"
  exit 1
elif [[ ${#README[@]} -lt 2 ]]; then
  echo -e "README.Rmd and README.md should be both staged\n$MSG"
  exit 1
fi
```

To create the hook if you already have a `README.Rmd` file, use
`devtools::use_git_hook`:


```r
devtools::use_git_hook("pre-commit", devtools:::render_template("readme-rmd-pre-commit.sh"))
```

See `?use_git_hook` for details.

> Add a `pre-commit hook`

# Code versioning, dissemination and issues



# Continous integration

- Suggest travis. Explain how to set up.
- If want to use another system, please document it here.

- Biocondcutor packages are testing on all platforms. Not necessary to
  have additional third-pary CI.


# Adding status

Status shields provide quick visual information regarding the
build/check status of your package and it's testing coverage. 

## Bioconductor shields

If the package is on Biocondcutor, then the build/check status and
testing coverage will be provided by them and the shields can be
directly generated with the `makeBiocBuildShield` and
`makeBiocCovrShield`. Below is an example for the `hpar` package.



```r
makeBiocBuildShield("hpar")
```

[![Bioconductor devel build status](http://bioconductor.org/shields/build/devel/bioc/hpar.svg)](http://bioconductor.org/packages/devel/bioc/html/hpar.html) 

```r
makeBiocCovrShield("hpar")
```

[![Bioconductor devel build status](https://bioconductor.org/shields/coverage/devel/hpar.svg)](https://codecov.io/github/Bioconductor-mirror/hpar/branch/master) 

By default, the shields for the devel branch are produced. Use `branch
= "release"` to use the release branch.

> If your package is on Bioconductor, display the build and coverage
> shields.

## Travis shield

If the package is not on Bioconductor, you'll have to set up a
continuous integration server that automatically builds and checks
your package. I recommend [travis-ci](https://travis-ci.org/) for
linux (and OSX, although I haven't successfully used that myself) and
appveyor for windows to build/check the package and 
*[covr](http://cran.fhcrc.org/web/packages/covr/index.html)* and [codecov](https://codecov.io/) for test coverage.



```r
makeTravisShield("cputools", user = "ComputationalProteomicsUnit")
```

[![Build Status](https://travis-ci.org/ComputationalProteomicsUnit/cputools.svg?branch=master)](https://travis-ci.org/ComputationalProteomicsUnit/cputools) 

> Add a travis build/check shield, unless there's already a
> Bioconductor shield.

Note: I haven't looked up how to automatically generate the code for a
codecov shield yet, so that one will have to be cut and pasted
manually.

## Bioc and/or travis

# Asking for help

It is important to provide a venue for users to ask for help and
report bugs. I tend to use two channels for that, namely GitHub issues
and, for Bioconductor package, the Bioconductor support site. The
`pkgqsts` function will create a default section (level 2 below,
default is 1):


```r
pkgqsts("cputools", level = 2L, user = "ComputationalProteomicsUnit")
```

```
## ## Questions and support
## To get help:
##  - Open a GitHub [issue](https://github.com/ComputationalProteomicsUnit/cputools/issues)
##  - Post your question on the [Bioconductor support site](https://support.bioconductor.org/)
```

As this package is not on Bioconductor, the Bioconductor support site
is disables with `bioc = FALSE` and rendered as shown below.


```r
pkgqsts("cputools", bioc=FALSE, level = 2L, user = "ComputationalProteomicsUnit")
```

## Questions and support
To get help:
 - Open a GitHub [issue](https://github.com/ComputationalProteomicsUnit/cputools/issues)

> Add a *Questions and support* section.

Note that this section can be added to the `README.Rmd` file and in
the package vignette.



Asking a question is not a straightforward thing. Here are some
resources to guide users: 

- Think carefully where to ask you question, where you'll reach the
  people most qualified to answer it:
  [Bioconductor support](https://support.bioconductor.org/) forum,
  [Stackoverflow](https://stackoverflow.com/),
  [Stackoverflow with `r` tag](https://stackoverflow.com/questions/tagged/r),
  Bioc-devel mailing list, specific Github repositories, ...
- Don't cross-post.
- Always provide your `sessionInfo()`
- Jenny Bryans's [`reprex`](https://github.com/jennybc/reprex) package.
- [How to write a reproducible example](http://adv-r.had.co.nz/Reproducibility.html)

To update or discuss this, please use this
issue^[https://github.com/ComputationalProteomicsUnit/cputools/issues/3]
or send directly a pull request.

# Testing coverage

# Package webpage

# Session information


```r
sessionInfo()
```

```
## R Under development (unstable) (2016-12-09 r71771)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 14.04.5 LTS
## 
## locale:
##  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
##  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
##  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] cputools_0.2.0   BiocStyle_2.3.28
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.8.3    msdata_0.15.0    digest_0.6.11    rprojroot_1.1   
##  [5] plyr_1.8.4       backports_1.0.4  magrittr_1.5     evaluate_0.10   
##  [9] scales_0.4.1     stringi_1.1.2    rmarkdown_1.3    tools_3.4.0     
## [13] stringr_1.1.0    munsell_0.4.3    yaml_2.1.14      compiler_3.4.0  
## [17] colorspace_1.3-2 htmltools_0.3.5  knitr_1.15.1
```

