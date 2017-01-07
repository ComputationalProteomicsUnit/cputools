context("data")

test_that("ht: head and tail", {
    expect_null(ht(letters))
    expect_null(ht(mtcars))
})
