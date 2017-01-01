context("Tesing shields")

test_that("Bioconductor build shields", {    
    mrk0 <- "[![Bioconductor devel build status](http://bioconductor.org/shields/build/devel/bioc/pRoloc.svg)](http://bioconductor.org/packages/devel/bioc/html/pRoloc.html)"
    mrk <- makeBiocBuildShield("pRoloc", branch = "devel")
    expect_identical(mrk, mrk0)
    url <- mrkToUrl(mrk)
    expect_true(validUrl(url))
})


test_that("Bioconductor covr shields", {
    mrk0 <- "[![Bioconductor release build status](https://bioconductor.org/shields/coverage/release/pRoloc.svg)](https://codecov.io/github/Bioconductor-mirror/pRoloc/branch/release-3.4)"
    mrk <- makeBiocCovrShield("pRoloc", branch = "release")
    expect_identical(mrk, mrk0)
    url <- mrkToUrl(mrk)
    expect_true(validUrl(url))
})
