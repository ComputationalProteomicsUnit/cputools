##' Creates a figure file name given a prefix and other optional
##' paramters. Checks if file exists.
##'
##' TODO: If file exists, create the next increment.
##'
##' @title Create a file name for a figure
##' @param prefix A file specific prefix.
##' @param ext The extension; default is \code{pdf}.
##' @param prefix0 The general prefix for figures. Default is \code{Fig}. 
##' @param date Should the data (as reported by \code{date}) be used
##' as part of the file name? Default is \code{TRUE}. 
##' @param path An optional path to the figure file.
##' @param ... Currently ignored.
##' @return A \code{character} with the figure file name.
##' @author Laurent Gatto
##' @examples
##' makeFigName("foo")
##' makeFigName("foo", date = FALSE)
##' makeFigName("foo", path = "~/projects/big-project/figs")
makeFigName <- function(prefix, ext = "pdf",
                        prefix0 = "Fig-",                        
                        date = TRUE, path, ...) {
    fn <- paste0(prefix0, prefix, "-")
    if (date)
        fn <- paste0(fn, gsub(" ", "-", date()))
    if (!missing(path))
        fn <- file.path(path, fn)
    fn <- paste(fn, ext, sep = ".")
    if (file.exists(fn))
        warning("File exists!")
    fn
}
    
