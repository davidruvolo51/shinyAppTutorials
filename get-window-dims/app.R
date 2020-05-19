#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-05-18
#' MODIFIED: 2020-05-18
#' PURPOSE: get window dimensions app
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css")
    ),
    tags$main(
        tags$h2("Get Window Dimensions Example"),
        tags$p("Resize the browser."),
        verbatimTextOutput("winSize")
    ),
    tags$script(src = "index.js")
)

# server
server <- function(input, output, session) {
    observeEvent(input$window, {
        d <- jsonlite::fromJSON(input$window)
        output$winSize <- renderPrint({
            d
        })
    })
}


# app
shinyApp(ui, server)