#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server_01_handlers.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-07
#' MODIFIED: 2021-05-29
#' PURPOSE: server handlers for passing data from shiny server to UI via js
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: see www/js/index.js for corresponding js handlers
#' ////////////////////////////////////////////////////////////////////////////

#' @title js
#' @description object containing methods for interacting with the client
#' @noRd
js <- list(class = "r-js-client-methods")


#' @title inner_html
#' @description render HTML content inside an existing element
#' @param id a string containing the HTML ID of the output element
#' @param html HTML content serialized
#' @noRd
js$inner_html <- function(id, html) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "inner_html",
        message = list(id = id, html = html)
    )
}

#' @title add_css
#' @description apply one or more CSS classes to an HTML element
#' @param id a string containing the HTML ID of the target element
#' @param css a string containing one or more CSS classes
#' @noRd
js$add_css <- function(id, css) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "add_css",
        message = list(
            id = id,
            css = css
        )
    )
}

#' @title remove_css
#' @description remove a CSS class from an HTML element
#' @param id a string containing the HTML ID of the target element
#' @param css a string containing the CSS classname to remove
#' @noRd
js$remove_css <- function(id, css) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "remove_css",
        message = list(
            id = id,
            css = css
        )
    )
}