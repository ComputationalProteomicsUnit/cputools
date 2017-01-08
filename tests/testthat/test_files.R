context("filenames")

test_that("pdf and png", {
    p <- quote({
        plot(1:10)
        points(10:1)
    })
    f <- tempfile()
    pdfpng(p, f)
    expect_true(file.exists(paste0(f, ".pdf")))
    expect_true(file.exists(paste0(f, ".png")))
    unlink(paste0(f, ".pdf"))
    unlink(paste0(f, ".png"))
})

test_that("make[Dat|Fig]Name", {
    expect_identical(makeFigName("foo", date = FALSE), "./Fig-foo.pdf")
    expect_identical(makeDatName("foo", date = FALSE), "./Dat-foo.rda")
})
