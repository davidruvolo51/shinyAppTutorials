#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-17
#' MODIFIED: 2019-03-20
#' PURPOSE: single file app for time-input shiny application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))

# source R6
source("time_input.R")

# init new
timeInput <- time$new("20:13")

# app
shinyApp(
    ui = tagList(
        # <head>
        tags$head(
            tags$link(
                type = "text/css",
                rel = "stylesheet",
                href = "css/styles.css"
            ),
            tags$title("Time Input Example")
        ),
        # <body>
        tags$header(class = "header",
            tags$h1("shinyTutorials: Time Input Example 2")
        ),
        tags$main(class = "main",
            tags$section(class = "main-section",
                tags$form(class = "form",
                    tags$legend(id = "form-legend", "Time Input Example 2"),
                    timeInput$input(
                        id = "timeSubmitted",
                        label = "Enter a new time"
                    ),
                    tags$button(
                        id = "submit",
                        class = "action-button shiny-bound-input",
                        "Enter"
                    ),
                    tags$button(
                        id = "reset",
                        class = "action-button shiny-bound-input",
                        "Reset"
                    )
                ),
                tags$label(`for` = "output", "Time in 24 hour Clock"),
                uiOutput("clock")
            )
        )
    ),
    server = function(input, output) {

        # render clock on load
        output$clock <- renderUI(timeInput$displayTime(":", "clock"))

        # on form submit
        observeEvent(input$submit, {
            if (is.null(input$timeSubmitted)) {
                output$clock <- renderUI({
                    timeInput$displayTime("Enter a new time", class = "error")
                })
            }
            if (!is.null(input$timeSubmitted)) {
                timeInput$updateTime(input$timeSubmitted)
                output$clock <- renderUI(timeInput$displayTime(class = "clock"))
            }
        })

        observeEvent(input$reset, {
            timeInput$resetTime()
            output$clock <- renderUI(timeInput$displayTime(class = "clock"))
        })
    }
)