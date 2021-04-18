#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2021-04-18
#' PURPOSE: create responsive datatables in shiny
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS:
#' The datatable function can be found here: R/datatable.R. The
#' re-orgranizing of content is handled by css (see www/css/*.css for info).
#'//////////////////////////////////////////////////////////////////////////////

# tests
# testthat::test_file("tests/test-datatable.R")

# pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(dplyr))

# load assets
birds <- readRDS("data/birds_summary.RDS")

# client
ui <- tagList(
    tags$head(
        tags$link(
            type = "text/css",
            rel = "stylesheet",
            href = "css/styles.css"
        ),
        tags$title("Responsive Datatables | shinyAppTutorials")
    ),
    tags$body(
        tags$header(
            class = "header",
            tags$h1("shinyTutorials")
        ),
        tags$main(
            class = "main",
            tags$section(
                class = "section",
                tags$h2("Responsive datatables in shiny"),
                tags$p(
                    "This application demonstrates how to create responsive ",
                    "and accessible datatables in shiny. The custom function ",
                    "datatable() renders the required table elements from ",
                    "your dataset and adds visually hidden and displayed ",
                    "elements when the screen is resized or if accessed on ",
                    "mobile. In this example, a datatable is generated using ",
                    "data from birdData Australia. The data is the top 25 ",
                    "most commonly reported birds in 2018 Birds in Backyards ",
                    "program. Resize the browser to see how the table ",
                    "visually changes and examine the code to see how the ",
                    "table is rendered."
                ),
                uiOutput("table")
            )
        )
    )
)

# server
server <- function(input, output, session) {
    output$table <- renderUI({
        birds2018 <- birds %>%
            filter(Year == "2018") %>%
            arrange(-Count) %>%
            slice(1:25)
        datatable(data = birds2018, caption = "Top 25 Birds in 2018")

    })
}

# app
shinyApp(ui, server)
