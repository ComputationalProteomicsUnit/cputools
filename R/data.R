##' Look at head and tail in one go.
##'
##' @title head and tail
##' @param x An object for which  \code{head}/\code{tail} are defined.
##' @param ... Additional parameters passed to \code{head} and \code{tail}.
##' @return Invisibly returns \code{NULL}.
##' @author Laurent Gatto
##' @examples
##' ht(letters)
##' ht(freeny.x, n = 3)
ht <- function(x, ...) {
    print(head(x, ...))
    cat("...\n")
    print(tail(x, ...))
    invisible(NULL)
}
