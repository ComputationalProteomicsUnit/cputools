makeFileName <- function(prefix, ext, prefix0, date = TRUE, path) {
    fn <- paste0(prefix0, "-", prefix)
    if (date)
        fn <- paste0(fn, "-", gsub(" ", "-", date()))
    fn <- file.path(path, fn)
    fn <- paste(fn, ext, sep = ".")
    if (file.exists(fn))
        warning("File exists!")
    fn    
}



##' Creates a file name given a prefix and other optional paramters
##' for a figure or data file. Also checks if file exists.
##'
##' TODO: If file exists, create the next increment.
##'
##' @title Create a file name.
##' @param prefix A file specific prefix.
##' @param ext The extension; default is \code{pdf} for a figure and
##' \code{rda} for a data file.
##' @param prefix0 The general prefix for figures. Default is
##' \code{Fig} for a figure and \code{Dat} for a data file.
##' @param date Should the data (as reported by \code{date}) be used
##' as part of the file name? Default is \code{TRUE}.
##' @param path The path to the file. Default is \code{"."}.
##' @return A \code{character} with the figure file name.
##' @author Laurent Gatto
##' @rdname makeFigName
##' @examples
##' makeFigName("foo")
##' makeFigName("foo", date = FALSE)
##' makeDatName("foo", date = FALSE)
##' makeFigName("foo", path = "~/projects/big-project/figs")
##' makeDatName("foo", path = "~/projects/big-project/Data")
makeFigName <- function(prefix, ext = "pdf",
                        prefix0 = "Fig",                        
                        date = TRUE, path = ".") 
    makeFileName(prefix, ext, prefix0, date, path)

    
##' @rdname makeFigName
makeDatName <- function(prefix, ext = "rda",
                        prefix0 = "Dat",
                        date = TRUE, path = ".")
        makeFileName(prefix, ext, prefix0, date, path)

##' Plot to the pdf and png devices at once.
##'
##' @title Plot to pdf and png
##' @param expr A quoted expression that produces the desired plot.
##' @param fn The file name (without extension).
##' @return Produces the files \code{fn.pdf} and \code{fn.png}.
##' @author Laurent Gatto
##' @examples
##' p <- quote({
##'    plot(1:10)
##'    points(10:1)
##' })
##' pdfpng(p, "myfig")
pdfpng <- function(expr, fn) {
    pdf(paste(fn, "pdf", sep = "."))
    eval(expr)
    dev.off()
    png(paste(fn, "png", sep = "."))
    eval(expr)
    dev.off()
}
