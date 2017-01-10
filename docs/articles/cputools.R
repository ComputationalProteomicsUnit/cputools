## ----env, echo=FALSE-------------------------------------------------------
suppressPackageStartupMessages(library("BiocStyle"))

## ----lib-------------------------------------------------------------------
library("cputools")

## ----precommithook, eval=FALSE---------------------------------------------
#  devtools::use_git_hook("pre-commit", devtools:::render_template("readme-rmd-pre-commit.sh"))

## --------------------------------------------------------------------------
makeBiocBuildShield("hpar")
makeBiocCovrShield("hpar")

## ---- echo=FALSE, results = "asis"-----------------------------------------
makeBiocBuildShield("hpar")
makeBiocCovrShield("hpar")

## --------------------------------------------------------------------------
makeTravisShield("cputools", user = "ComputationalProteomicsUnit")

## ---- echo=FALSE, results = "asis"-----------------------------------------
makeTravisShield("cputools", user = "ComputationalProteomicsUnit")

## ----pkgqst0, eval=TRUE----------------------------------------------------
pkgqsts("cputools", level = 2L)

## ----pkgqst, eval=TRUE, results='asis'-------------------------------------
pkgqsts("cputools", bioc=FALSE, level = 2L)

## ----si--------------------------------------------------------------------
sessionInfo()

