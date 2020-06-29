#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-29
#' MODIFIED: 2020-06-29
#' PURPOSE: custom select input component example
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

source("component/select_input.R")

# ui
ui <- tagList(
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(`http-quiv` = "x-ua-compatible", content = "ie=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(rel = "stylesheet", href = "index.min.css"),
        tags$title("shinyAppTutorials | custom select input component")
    ),
    tags$main(
        class = "main",
        tags$h2("Custom Select Input"),
        tags$p(
            "This example app demonstrates how to create a custom select",
            "input component using", tags$code("tags"), ", SCSS, and",
            "JavaScript."
        ),
        tags$form(
            class = "form",
            select_input(
                inputId = "popularTech",
                title = "Most Popular Technologies",
                options = c(
                    "JavaScript",
                    "HTML/CSS",
                    "SQL",
                    "Python",
                    "Java",
                    "Bash/Shell/Powershell",
                    "C#",
                    "PHP",
                    "C++",
                    "Typescript"
                )
            )
        ),
        verbatimTextOutput("result")
    ),
    tags$script(src = "index.min.js")
)


# server
server <- function(input, output) {
    output$result <- renderText(
        paste0("You selected: ", input$popularTech)
    )
}


# app
shinyApp(ui, server)