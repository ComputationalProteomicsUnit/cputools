test_that("cputools", {
    v <- biocVersions()
    ## update me for every new release
    v0 <- c("3.4", "3.5")
    names(v0) <- c("release", "devel")
    expect_identical(v, v0)
})
