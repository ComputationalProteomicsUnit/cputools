
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

##' A simple interface to manually pick colours from
##' \code{colours()}. Uses the current device is none is open.
##'
##' @title A simple colour picker
##' @return A vector of colours.
##' @author Laurent Gatto
colour_picker <- function() {
    n <- length(colours())
    i <- 26
    m <- matrix(c(1:n, rep(NA, (i^2 - n))), ncol = i, nrow = i)
    ## plotting
    image(m, col = colours(),
          xaxt = "n", yaxt = "n")
    k <- seq(0, 1, length.out = i)
    kk <- expand.grid(k, k)
    kk <- kk[1:n, ]
    ## points(kk)
    ## choosing
    identifycol <- function(x, y = NULL, n = length(x), pch = 19) {
        ## from ?identify
        k <- 1
        xy <- xy.coords(x, y); x <- xy$x; y <- xy$y
        sel <- rep(FALSE, length(x)); res <- integer(0)
        while(sum(sel) < n) {
            ans <- identify(x[!sel], y[!sel], n = 1, plot = FALSE)
            if (!length(ans)) break
            ans <- which(!sel)[ans]
            text(x[ans], y[ans], k, cex = 1.5)
            k <- k + 1
            sel[ans] <- TRUE
            res <- c(res, ans)
        }
        res
    }
    ans <- identifycol(kk)
    ans <- col2hcl(colours()[ans])
    return(ans)
}

##' @rdname colour_picker
color_picker <- colour_picker
