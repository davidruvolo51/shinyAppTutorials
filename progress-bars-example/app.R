#' ////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-28
#' MODIFIED: 2021-04-28
#' PURPOSE: example app demonstrating progress bars
#' STATUS: working
#' PACKAGES: shiny; R6
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# install
# install.packages("shiny")
# install.packages("R6")

# pkgs
suppressPackageStartupMessages(library(shiny))

# init new progress bar
app_progress <- progressbar(min = 0, start = 0, max = 6)

# ui
ui <- tagList(
    browsertools::use_browsertools(),
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css")
    ),
    app_progress$bar(
        inputId = "appProgress",
        fill = "#299996",
        fixed = TRUE,
        text = "page {value} of {max}"
    ),
    tags$main(
        id = "main",
        class = "main",
        tags$section(
            tags$h2("Lorem Ipsum"),
            uiOutput("page")
        ),
        tags$script(src = "index.js")
    )
)

# server
server <- function(input, output, session) {

    # set default page
    page_counter <- reactiveVal(1)
    app_progress$increase()
    observe({
        output$page <- renderUI({
            pages[[page_counter()]]
        })
    })

    # event for next page
    observeEvent(input$nextPage, {
        page_counter(page_counter() + 1)
        app_progress$increase()
    })

    # # event for previous page
    observeEvent(input$previousPage, {
        page_counter(page_counter() - 1)
        app_progress$decrease()
    })
}

# app
shinyApp(ui, server)
