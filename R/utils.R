mrkToUrl <- function(x)
    gsub("^.+\\((.+)\\)", "\\1", x)

validUrl <- function(x) {
        got <- httr::GET(x)
        httr::stop_for_status(got)
        TRUE
}
