context("Packages functions")

test_that("makeGitHubUrl", {
    url0 <- c(pRoloc = "https://github.com/lgatto/pRoloc")
    url <- makeGithubUrl("pRoloc", user = "lgatto")
    expect_identical(url, url0)
    expect_true(validUrl(url))    
    url2 <- mrkToUrl(BiocStyle::Githubpkg("lgatto/pRoloc"))
    expect_equivalent(url, url2)
    ## vectorised
    urls <- makeGithubUrl(c("pRoloc", "cputools"),
                          user = c("lgatto", "ComputationalProteomicsUnit"))
    expect_identical(urls[1], url)
    expect_identical(urls[2], makeGithubUrl("cputools", user = "ComputationalProteomicsUnit"))
    expect_error(makeGithubUrl(c("pRoloc", "cputools"), user = "lgatto"))
})

test_that("use user from options", {
    url <- makeGithubUrl("foo", user = "bar")
    options(GitHubUserName = "bar")
    url2 <- makeGithubUrl("foo")
    expect_identical(url, url2)
})

test_that("makeGithubPageUrl", {
    url0 <- c(rols = "https://lgatto.github.io/rols")
    url <- makeGithubPageUrl("rols", user = "lgatto")
    expect_identical(url, url0)
    expect_true(validUrl(url))
    ## vectorised
    urls <- makeGithubPageUrl(c("rols", "cputools"),
                          user = c("lgatto", "ComputationalProteomicsUnit"))
    expect_identical(urls[1], url)
    expect_identical(urls[2],
                     makeGithubPageUrl("cputools", user = "ComputationalProteomicsUnit"))
    expect_error(makeGithubPageUrl(c("pRoloc", "cputools"), user = "lgatto"))
})

test_that("makeGithubIssuesUrl", {
    url0 <- c(pRoloc = "https://github.com/lgatto/pRoloc/issues")
    url <- makeGithubIssuesUrl("pRoloc", user = "lgatto")
    expect_identical(url, url0)
    expect_true(validUrl(url))
    urls <- makeGithubIssuesUrl(c("pRoloc", "cputools"),
                                user = c("lgatto", "ComputationalProteomicsUnit"))
    expect_identical(urls[1], url)
    expect_identical(urls[2],
                     makeGithubIssuesUrl("cputools",
                                         user = "ComputationalProteomicsUnit"))
    expect_error(makeGithubIssuesUrl(c("pRoloc", "cputools"), user = "lgatto"))
})

test_that("pkgqsts", {
    ## just running, not much to test
    expect_null(pkgqsts("pRoloc", user = "lgatto"))
    expect_null(pkgqsts("pRoloc", bioc = FALSE, user = "lgatto"))
    expect_null(pkgqsts("pRoloc", github = FALSE))
    expect_null(pkgqsts())
    expect_error(pkgqsts("pRoloc", FALSE, FALSE))
    expect_error(pkgqsts(, FALSE, FALSE))
    expect_warning(pkgqsts(c("pRoloc", "pRoloc")))
})
