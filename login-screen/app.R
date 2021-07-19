#' ////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2016-07-01
#' MODIFIED: 2021-07-19
#' PURPOSE: login screen example
#' STATUS: working
#' PACKAGES: shiny; sodium
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

suppressPackageStartupMessages(library(shiny))

# define users - ideally stored in a database
users <- data.frame(
    "username" = c("koala", "kangaroo"),
    "password" = sapply(c("8888", "9999"), sodium::password_store),
    "emoji" = c("🐨", "🦘")
)


ui <- tagList(
    tags$head(
        tags$link(type = "text/css", rel = "stylesheet", href = "styles.css")
    ),
    uiOutput("app"),
    tags$script(src = "index.js")
)


server <- function(input, output, session) {

    userdata <- reactiveVal(NA)
    logged <- reactiveVal(FALSE)

    signin_server("signin", users, userdata, logged)
    main_ui_server("app", logged)

    observe({
        if (logged()) {
            output$app <- renderUI(main_ui("app", userdata()))
        } else {
            output$app <- renderUI(signin_ui("signin"))
        }
    })
}


shinyApp(ui, server)