
##' Light and dark colours
##'
##' From \url{https://gist.github.com/Jfortin1/72ef064469d1703c6b30}.
##' 
##' @title darken and lighten colours
##' @param color Colour name.
##' @param factor Lightening/darkening factory.
##' @return A new rgb colour
##' @examples
##' darkFirebrick <- darken("firebrick")
##' lightFirebrick <- lighten("firebrick")
##' plot(c(1.5, 2, 2.5), c(1, 1.25, 1),
##'      pch = 19, cex = 150,
##'      col = c(darkFirebrick, "firebrick", lightFirebrick))
darken <- function(color, factor=1.4){
    col <- col2rgb(color)
    col <- col / factor
    col <- rgb(t(col), maxColorValue=255)
    col
}
 
##' @rdname darken 
lighten <- function(color, factor=1.4){
    col <- col2rgb(color)
    col <- col * factor
    col <- rgb(t(col), maxColorValue=255)
    col
}
