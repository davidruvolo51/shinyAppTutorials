#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-05-18
#' MODIFIED: 2020-11-20
#' PURPOSE: get window dimensions app
#' STATUS: working
#' PACKAGES: shiny; json
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css"),
        tags$title("Get Window Dims | shinyAppTutorials")
    ),
    tags$main(
        tags$h2("Get Window Dimensions Example"),
        tags$p("Resize the browser."),
        verbatimTextOutput("win_size")
    ),
    tags$script(src = "index.js")
)

# server
server <- function(input, output, session) {
    observeEvent(input$window, {
        d <- jsonlite::fromJSON(input$window)
        output$win_size <- renderPrint({
            d
        })
    })
}


# app
shinyApp(ui, server)