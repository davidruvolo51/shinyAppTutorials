#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-11-17
#' MODIFIED: 2019-11-18
#' PURPOSE: single file app for time-input shiny application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))

# app
shinyApp(
    ui = tagList(
        # <head>
        tags$head(
            tags$link(type = "text/css", rel = "stylesheet", href = "css/styles.css"),
            tags$title("Time Input Example")
        ),
        # <body>
        tags$body(
            tags$header(class = "header",
                tags$h1("shinyTutorials: Time Input Example")
            ),
            tags$main(class = "main", 
                tags$section(class="main-section",
                    tags$form(class = "form", `aria-labelledby`="form-legend",
                        tags$legend(id="form-legend","Time Input Example"),
                        tags$label(`for`="time", "Enter a time"),
                        tags$span(class="input-example", "(hh:mm am/pm)"),
                        tags$input(type="time", id="time", class="shiny-bound-input", name="time"),
                        tags$button(type="button", id="submit", class="action-button shiny-bound-input", "Enter")
                    ),
                    tags$label(`for`="output","Time Entered"),
                    tags$output(id="output", class="output", "[ enter a time ]")
                )
            ),
            tags$script(type="text/javascript", src="js/index.js")
        )
    ),
    server = function(input, output, session) {

        # on form submit - explicit conditions
        observeEvent(input$submit, {
            if( is.null(input$time) ){
                session$sendCustomMessage("innerHTML", list(".output", "[ no time entered ]"))
            } else {
                session$sendCustomMessage("innerHTML", list(".output", input$time))
            }
        })
    }
)