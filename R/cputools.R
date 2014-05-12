##' Print all available (exported) cputools functions.
##'
##' @title Available cputools functions
##' @return Used for its side effect of print a list of available
##' helper functions.
##' @author Laurent Gatto
##' @examples
##' cputools()
cputools <- function() {
    cat("cputools functions:\n")
    for (f in sort(ls("package:cputools")))
        cat(" ", f, "\n", sep = "")
}
