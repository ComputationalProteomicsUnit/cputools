context("Computational Proteomics Unit")

test_that("CPU www", {
    x <- cpuwww()
    expect_identical(x,
                     "[Computational Proteomics Unit](http://cpu.sysbiol.cam.ac.uk/)")
})

test_that("cputools", {
    expect_null(cputools())
})

test_that("utils: mrkToUrl", {
    mrk <- "[![blabla](svg)](foobar)"
    expect_identical("foobar", mrkToUrl(mrk))
    expect_identical("foobar", mrkToUrl("[blabla](foobar)"))
})

test_that("utils: validUrl", {
    expect_true(validUrl("http://www.bioconductor.org"))
    expect_true(validUrl("https://www.bioconductor.org"))
    expect_error(validUrl("foo"))
    ## "*[pRoloc](https://github.com/lgatto/pRoloc)*"
    url <- mrkToUrl(BiocStyle::Githubpkg("lgatto/pRoloc"))
    expect_identical(url, "https://github.com/lgatto/pRoloc")
})
