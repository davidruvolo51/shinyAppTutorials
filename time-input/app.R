#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-17
#' MODIFIED: 2021-02-22
#' PURPOSE: single file app for time-input shiny application
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# app
ui <- tagList(
    tags$head(
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "styles.css"
        ),
        tags$link(
            type = "text/css",
            rel = "stylesheet",
            href = "time_input.css"
        ),
        tags$style(
            "#timeOutput {
                background-color: #353535;
                color: #f1f1f1;
                box-sizing: content-box;
                padding: 12px;
            }"
        ),
        tags$title("Time Input Example | shinyAppTutorials ")
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