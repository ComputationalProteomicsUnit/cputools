context("colours")

test_that("", {
    expect_identical(x <- darken("red"), "#B60000")
    expect_identical(lighten(x), "#FE0000")
})
