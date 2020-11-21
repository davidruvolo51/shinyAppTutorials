#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-15
#' MODIFIED: 2020-11-20
#' PURPOSE: setting modifying global attributes
#' STATUS: working
#' PACKAGES: Shiny
#' COMMENTS: This example provides a way of setting the document attributes,
#' for example language and direction. Use this function to add other
#' important `<head>` elements.
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    set_html_attribs(),
    tags$h2("Setting HTML Attributes"),
    tags$p(
        "Use 'view page source' to see where the html attributes were added."
    ),
    tags$script(src = "set_html_attribs.js")
)


# server
server <- function(input, output) {

}


# app
shinyApp(ui, server)