##' This function returns the current release and devel Bioconductor
##' version numbers by parsing the
##' \code{"http://www.bioconductor.org/js/versions.js"} page.
##'
##' @title Bioconductor version numbers
##' @return A named \code{character} of length two with the
##'     \code{release} and \code{devel} version numbers (in that
##'     order).
##' @author Laurent Gatto
##' @examples
##' biocVersions()
biocVersions <- function() {
    v <- readLines("http://www.bioconductor.org/js/versions.js")[1:2]
    v <- gsub("^.+= *\\\"([[:digit:]]+\\.[[:digit:]]+)\\\";", "\\1", v)
    v <- sort(v)
    names(v) <- c("release", "devel")
    v
}
