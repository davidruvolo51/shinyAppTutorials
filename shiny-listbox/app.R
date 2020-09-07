#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-29
#' MODIFIED: 2020-09-07
#' PURPOSE: custom select input component example
#' STATUS: working
#' PACKAGES: shiny; rheroicons;
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(`http-quiv` = "x-ua-compatible", content = "ie=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(rel = "stylesheet", href = "css/index.css"),
        tags$link(rel = "stylesheet", href = "css/listbox.css"),
        # tags$style(
        #     "#popularTech .listbox-toggle {
        #         background-color: #2d7ddd;
        #         color: #f1f1f1;
        #     }",
        #     "#popularTech .listbox-option[aria-selected='true'] {
        #         background-color: #2d7ddd;
        #         color: #f1f1f1;
        #     }
        #     "
        # ),
        tags$title("shinyAppTutorials | Listbox Example")
    ),
    tags$main(
        class = "main",
        tags$header(
            class = "header",
            `aria-labelledby` = "header-title",
            tags$h2(
                id = "header-title",
                "Building a Shiny Listbox Component"
            ),
            tags$p(
                "This example shiny app demonstrates how to create a custom",
                "listbox widget. Listboxes are a good alternative to select",
                "inputs as select inputs have limited modifiable CSS",
                "properties. To get listbox components working in shiny, you",
                "will need a function that generates the HTML markup from",
                "a data object, a CSS file that defines the base appearance",
                "of the listbox element, and a javascript input binding that",
                "registers our component with shiny. The following example",
                "uses the Top 10 Technologies from the",
                tags$a(
                    href = "https://insights.stackoverflow.com/survey/2020#most-popular-technologies",
                    "StackOverflow 2020 Survey"
                ), ". Use the mouse to make a selection or use keyboard to",
                "navigation the listbox (up, down, escape, enter)."
            )
        ),
        tags$form(
            class = "form",
            `aria-labelledby` = "popularTech__title",
            listbox(
                inputId = "popularTech",
                title = "Most Popular Technologies",
                label = "Select a technology",
                options = c(
                    "JavaScript",
                    "HTML/CSS",
                    "SQL",
                    "Python",
                    "Java",
                    "Bash/Shell/Powershell",
                    "C#",
                    "PHP",
                    "Typescript",
                    "C++"
                )
            )
        ),
        verbatimTextOutput("result")
    ),
    tags$script(src = "js/listbox.js")
)


# server
server <- function(input, output) {
    output$result <- renderText(
        paste0("You selected: ", input$popularTech)
    )
}


# app
shinyApp(ui, server)