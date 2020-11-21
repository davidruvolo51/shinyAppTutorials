#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server_01_handlers.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-07
#' MODIFIED: 2020-11-20
#' PURPOSE: server handlers for passing data from shiny server to UI via js
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: see www/js/index.js for corresponding js handlers
#' ////////////////////////////////////////////////////////////////////////////

#' create javascript handlers
js <- list(
    innerHTML = function(
        id,
        string,
        session = shiny::getDefaultReactiveDomain()
    ) {
        session$sendCustomMessage(type = "innerHTML", list(id, string))
    },
    addCSS = function(
        id,
        css,
        session = shiny::getDefaultReactiveDomain()
    ) {
        session$sendCustomMessage(type = "addCSS", list(id, css))
    },
    removeCSS = function(
        id,
        css,
        session = shiny::getDefaultReactiveDomain()
    ) {
        session$sendCustomMessage(type = "removeCSS", list(id, css))
    },
    class = "js"
)
