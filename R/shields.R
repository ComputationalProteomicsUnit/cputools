##' Functions to generate package travis-ci, codecov, Bioconductor
##' build status and Biocondcutor test coverage shields
##'
##' @title Generate the markdown code the a package shields.
##' @param pkg Mandatory \code{character} with the package name(s). If
##'     of length greater than one, then must of of same length as
##'     \code{user} and \code{branch}.
##' @param user Mandatory GitHub username. Default is to retrieve
##'     \code{options()[["GitHubUserName"]]}. Argument is not recycled
##'     of more than one package is provided.
##' @param branch Mandatory branch name. Default is
##'     \code{"master"}. Argument is not recycled of more than one
##'     package is provided. For Bioconductor shields (functions
##'     \code{makeBiocBuildShield} and \code{makeBiocCovrShield}),
##'     branch is one of \code{"devel"} (default) or \code{"release"}.
##' @return A \code{character} with the shield in markdown.
##' @author Laurent Gatto
##' @rdname shields
##' @examples
##' makeTravisShield("pRoloc", user = "lgatto")
##' ## default user
##' options(GitHubUserName = "ComputationalProteomicsUnit")
##' makeCodecovShield("cputools")
makeTravisShield <- function(pkg, user = options()[["GitHubUserName"]],
                             branch = "master") {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(is.character(branch))
    stopifnot(identical(length(pkg), length(user)))
    stopifnot(identical(length(pkg), length(branch)))
    ans <- paste0("[![Build Status](https://travis-ci.org/", user, "/", pkg,
                  ".svg?branch=", branch , ")](https://travis-ci.org/", user,
                  "/", pkg , ")")
    cat(ans, "\n")
}

##' @rdname shields
##' @examples
##' makeCodecovShield("MSnbase", user = "lgatto")
makeCodecovShield <- function(pkg, user = options()[["GitHubUserName"]],
                             branch = "master") {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(is.character(branch))
    stopifnot(identical(length(pkg), length(user)))
    stopifnot(identical(length(pkg), length(branch)))
    ans <- paste0("[![codecov](https://codecov.io/gh/", user, "/", pkg,
                  "/branch/", branch,
                  "/graph/badge.svg)](https://codecov.io/gh/", user, "/",
                  pkg, ")")
    cat(ans, "\n")
}

    
##' @rdname shields
##' @examples
##' makeBiocBuildShield("MSnbase")
##' makeBiocBuildShield("MSnbase", branch = "release")
makeBiocBuildShield <- function(pkg,
                                branch = c("devel", "release")) {
    branch <- match.arg(branch)
    stopifnot(is.character(pkg))
    stopifnot(identical(length(pkg), length(branch)))
    ## assumes software package!
    url <- sprintf("http://bioconductor.org/packages/%s/bioc/html/%s.html",
                   branch, pkg)
    svg <- sprintf("http://bioconductor.org/shields/build/%s/bioc/%s.svg",
                   branch, pkg)
    txt <- paste("Bioconductor", branch, "build status")
    ans <- sprintf("[![%s](%s)](%s)", txt, svg, url)
    cat(ans, "\n")
}

##' @rdname shields
##' @examples
##' makeBiocCovrShield("MSnbase")
##' makeBiocCovrShield("MSnbase", branch = "release")
makeBiocCovrShield <- function(pkg,
                               branch = c("devel", "release")) {
    branch <- match.arg(branch)
    stopifnot(is.character(pkg))
    stopifnot(identical(length(pkg), length(branch)))
    ## assumes software package!
    b <- ifelse(branch == "devel", "master",
                paste0("release-", biocVersions()["release"]))
    url <- sprintf("https://codecov.io/github/Bioconductor-mirror/pkg/branch/master", 
                   b, pkg)
    svg <- sprintf("https://bioconductor.org/shields/coverage/%s/%s.svg",
                   branch, pkg)
    txt <- paste("Bioconductor", branch, "build status")
    ans <- sprintf("[![%s](%s)](%s)", txt, svg, url)
    cat(ans, "\n")
}
