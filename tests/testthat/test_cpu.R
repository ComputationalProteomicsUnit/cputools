context("Computational Proteomics Unit")

test_that("CPU www", {
    x <- cpuwww()
    expect_identical(x,
                     "[Computational Proteomics Unit](http://cpu.sysbiol.cam.ac.uk/)")
    url <- gsub("^.+\\((.+)\\)", "\\1", x)
    got <- httr::GET(url)
    expect_identical(got, httr::stop_for_status(got))
})
