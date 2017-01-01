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
    url0 <- "foobar"
    mrk <- "[![blabla](svg)](foobar)"
    expect_identical(url0, mrkToUrl(mrk))
})

test_that("utils: validIrl", {
    expect_true(validUrl("http://www.bioconductor.org"))
    expect_true(validUrl("https://www.bioconductor.org"))
    expect_error(validUrl("foo"))
})
