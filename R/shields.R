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
##'     \code{"masker"}. Argument is not recycled of more than one
##'     package is provided.
##' @return A \code{character} with the shield in markdown.
##' @author Laurent Gatto
##' @rdname shields
##' @examples
##' makeTravisShield("pRoloc")
makeTravisShield <- function(pkg, user = options()[["GitHubUserName"]],
                             branch = "master") {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(is.character(branch))
    stopifnot(identical(length(pkg), length(user)))
    stopifnot(identical(length(pkg), length(branch)))
    paste0("[![Build Status](https://travis-ci.org/", user, "/", pkg,
           ".svg?branch=", branch , ")](https://travis-ci.org/", user,
           "/", pkg , ")")
}

##' @rdname shields
##' makeCodecovShield("MSnbase")
makeCodecovShield <- function(pkg, user = options()[["GitHubUserName"]],
                             branch = "master") {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(is.character(branch))
    stopifnot(identical(length(pkg), length(user)))
    stopifnot(identical(length(pkg), length(branch)))
    paste0("[![codecov](https://codecov.io/gh/", user, "/", pkg,
           "/branch/", branch,
           "/graph/badge.svg)](https://codecov.io/gh/", user, "/",
           pkg, ")")
}

    
makeBiocBuildShield <- function()

makeBiocCovrShield <- function()
