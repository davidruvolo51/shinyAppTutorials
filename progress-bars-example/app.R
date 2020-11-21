#' ////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-28
#' MODIFIED: 2020-11-21
#' PURPOSE: example app demonstrating progress bars
#' STATUS: working
#' PACKAGES: shiny; R6
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# init new progress bar
mybar <- shiny_progress$new(now = 1, min = 1, max = 10)

# ui
ui <- tagList(
    browsertools::use_browsertools(),
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css")
    ),
    mybar$ui(id = "mybar", fill = "#299996"),
    # mybar$ui(id = "mybar", fixed = TRUE, position = "bottom", fill = "#299996"),
    tags$main(
        id = "main",
        class = "main",
        tags$section(
            tags$h2("Lorem Ipsum"),
            uiOutput("page"),
            tags$button(
                id = "previousPage",
                class = "action-button shiny-bound-input secondary",
                "Previous"
            ),
            tags$button(
                id = "nextPage",
                class = "action-button shiny-bound-input primary",
                "Next"
            )
        ),
        tags$script(src = "index.js")
    )
)

# server
server <- function(input, output, session) {

    # use reset if there is a browser refresh
    mybar$reset()
    mybar$init()

    # set default page
    output$page <- renderUI({
        pages[[mybar$now]]
    })

    # event for next page
    observeEvent(input$nextPage, {
        mybar$increase()
        output$page <- renderUI({
            pages[[mybar$now]]
        })
    })

    # event for previous page
    observeEvent(input$previousPage, {
        mybar$decrease()
        output$page <- renderUI({
            pages[[mybar$now]]
        })
    })
}

# app
shinyApp(ui, server)
