#'//////////////////////////////////////////////////////////////////////////////
#' FILE: server_01_handlers.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-07
#' MODIFIED: 2019-11-07
#' PURPOSE: server handlers for passing data from shiny server to UI via js
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: see www/js/index.js for corresponding js handlers
#'//////////////////////////////////////////////////////////////////////////////

# ~ 0 ~
# session handler for update innerHTML
innerHTML <- function(id, string){
    session$sendCustomMessage(type="innerHTML", list(id, string))
}

# ~ 1 ~
# session handler for addCSS
addCSS <- function(id, css){
    session$sendCustomMessage(type="addCSS", list(id, css))
}

# ~ 2 ~
# session handler for removeCSS
removeCSS <- function(id, css){
    session$sendCustomMessage(type="removeCSS", list(id, css))
}
