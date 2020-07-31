#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-17
#' MODIFIED: 2020-07-31
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
    tags$h1("Time Input Example"),
    tags$form(
        time_input(
            inputId = "take_away",
            label = "Select time you would like to pick up your order",
            caption = "We are open everyday from 11:00 to 18:00",
            value = "12:00",
            min = "11:00",
            max = "18:00"
        ),
        tags$h2("Time Selected"),
        verbatimTextOutput("timeOutput")
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