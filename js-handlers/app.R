#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-02-22
#' MODIFIED: 2021-02-22
#' PURPOSE: Shiny app
#' STATUS: working
#' PACKAGES: Shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////


suppressPackageStartupMessages(library(shiny))


ui <- tagList(
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(
            type = "text/css",
            rel = "stylesheet",
            href = "css/styles.css"
        ),
        tags$title("Custom JS Handlers | shinyAppTutorials")
    ),
    tags$header(
        tags$span(
            class = "theme-label",
            "current theme:", tags$output(id = "themeStatus")
        )
    ),
    tags$main(
        tags$section(`aria-labelledby` = "title",
            tags$h1("Custom JS Handlers", id = "title"),
            tags$p(
                "This shiny app demonstrates how to create your own ",
                "javascript functions and register them with shiny ",
                "server. In this example, we created a simple javascript ",
                "that toggles a css class and stores the user's selection to ",
                "local storage, as well as display the selected theme in ",
                "the top right corner. Click the button."
            ),
            tags$button(
                id = "toggle",
                class = "action-button shiny-bound-input",
                "Toggle Theme"
            )
        )
    ),
    tags$script(src = "index.js")
)



server <- function(input, output, session) {

    session$sendCustomMessage(type = "setDefaultTheme", "body")

    observeEvent(input$toggle, {
        session$sendCustomMessage(type = "toggleTheme", "body")
    })
}



shinyApp(ui, server)