#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-17
#' MODIFIED: 2020-08-01
#' PURPOSE: single file app for time-input shiny application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
library(shiny)

# source component
source("time_input.R")

# app
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "time_input.css"),
        tags$style(
            "html, body {
                font-family: Helvetica;
                font-size: 16pt;
            }",
            "main {
                width: 90%;
                max-width: 912px;
                margin: 0 auto;
                padding: 32px;
            }",
            "#timeOutput {
                background-color: #353535;
                color: #f1f1f1;
                box-sizing: content-box;
                padding: 12px;
            }"
        ),
        tags$title("shinyAppTutorials | Time Input Example")
    ),
    tags$main(
        tags$h1("Time Input Example"),
        tags$form(
            time_input(
                inputId = "take_away",
                label = "What time would you like to pick up your order?",
                caption = "We are open everyday from 11:00 to 18:00",
                value = "12:00",
                min = "11:00",
                max = "18:00"
            ),
            tags$h2("Time Selected"),
            verbatimTextOutput("timeOutput")
        )
    ),
    tags$script(src = "time_input.js")
)

# server
server <- function(input, output, session) {
    output$timeOutput <- renderPrint({
        input$take_away
    })
}

# app
shinyApp(ui, server)