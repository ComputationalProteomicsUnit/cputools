##' @title Generates Github URLs
##' @return A \code{character} with Github URLs.
##' @seealso \code{BiocStyle::Githubpkg}
##' @examples
##' makeGithubUrl("pRoloc", user = "lgatto")
##' makeGithubUrl(c("pRoloc", "MSnbase"), user = c("lgatto", "lgatto"))
##' @rdname pkgs
makeGithubUrl <- function(pkg, user = options()[["GitHubUserName"]]) {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(identical(length(pkg), length(user)))
    baseurl <- paste0("https://github.com/", user)
    ans <- paste(baseurl, pkg, sep = "/")
    names(ans) <- pkg
    ans
}

##' @title Generates Github page URLs
##' @return A \code{character} with Github page URLs.
##' @examples
##' makeGithubPageUrl("pRoloc", user = "lgatto")
##' makeGithubPageUrl(c("pRoloc", "pRolocGUI"), user = c("lgatto", "lgatto"))
##' @rdname pkgs
makeGithubPageUrl <- function(pkg, user = options()[["GitHubUserName"]]) {
    stopifnot(is.character(user))
    stopifnot(is.character(pkg))
    stopifnot(identical(length(pkg), length(user)))
    baseurl <- paste0("https://", user, ".github.io")
    ans <- paste(baseurl, pkg, sep = "/")
    names(ans) <- pkg
    ans
}

##' @title Generates Github issue pages URLs
##' @return A \code{character} with Github page URLs.
##' @examples
##' makeGithubIssuesUrl("pRoloc", user = "lgatto")
##' @rdname pkgs
makeGithubIssuesUrl <- function(pkg, user = options()[["GitHubUserName"]]) {
    ans <- paste0(makeGithubUrl(pkg, user), "/issues")
    names(ans) <- pkg
    ans
}

##' Generates a markdown section on where to ask questions about a
##' package.
##'
##' @title Where to ask for help
##' @param pkg Mandatory \code{character} with the package name. Must
##'     be of length one for code{pkgqsts}. Other functions
##'     \code{makeGithubPageUrl} and \code{makeGithubIssuesUrl} are
##'     vectorised.
##' @param github A \code{logical} (default is \code{TRUE}) defining
##'     whether users can ask questions on GitHub issues.
##' @param bioc A \code{logical} (default is \code{TRUE}) defining
##'     whether users can ask questions on the Bioconductor support
##'     forum.
##' @param level Level for markdown sections. Default is \code{1L} for
##'     \code{#}. Use \code{2L} for \code{##} and so on.
##' @param user Mandatory GitHub username. Default is to retrieve
##'     \code{options()[["GitHubUserName"]]}.
##' @return Invisibly returns \code{NULL}. Used for its side effect.
##' @author Laurent Gatto
##' @rdname pkgs
##' @examples
##' pkgqsts("pRoloc", user = "lgatto")
##' pkgqsts("cputools", bioc = FALSE, user = "lgatto")
##' pkgqsts()
pkgqsts <- function(pkg, github = TRUE, bioc = TRUE,
                    level = 1L,
                    user = options()[["GitHubUserName"]]) {
    if (missing(pkg)) {
        github <- FALSE
    } else {
        stopifnot(is.character(pkg))
        if (length(pkg) > 1) {
            pkg <- pkg[1]
            warning("Using first package.")
        }
    }
    if (!github & !bioc)
        stop("Read the code, Luke.")
    cat(rep("#", level), " Questions and support\n", sep = "")
    cat("To get help:\n")
    if (github)
        cat(" - Open a GitHub [issue](",
            makeGithubIssuesUrl(pkg, user = user) , ")\n",
            sep = "")
    if (bioc)
        cat(" - Post your question on the [Bioconductor support site]",
            "(https://support.bioconductor.org/)\n", sep = "")
}
