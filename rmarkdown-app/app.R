#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2018-05-22
#' MODIFIED: 2021-04-30
#' PURPOSE: how to include Rmarkdown files in shiny
#' PACKAGES: shiny, tidyverse, kableExtra
#' COMMENTS: See `data/data_0_source.R` for data sourcing and procesing steps
#'//////////////////////////////////////////////////////////////////////////////

# install
# install.packages("dplyr")
# install.packages("shiny")
# install.packages("kableExtra")
# install.packages("ggplot2")

# imports
suppressPackageStartupMessages(library(shiny))
librarians <- readRDS("data/librarians_538.RDS")


ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css"),
        tags$title("Rmarkdown + Shiny | shinyAppTutorials")
    ),
    tags$main(
        tags$h1("Rmarkdown and Shiny"),
        tags$p(
            "An example app demonstrating how to use paramaterized ",
            "reports in Rmarkdown"
        ),
        tags$h2("Get started"),
        tags$p(
            "This example demonstrates the use of paramaterized ",
            "reports in shiny. The data used in this example comes ",
            "is available on 538's GitHub data repository. See the",
            tags$a(
                # nolint start
                href = "https://github.com/fivethirtyeight/data/tree/master/librarians",
                # nolint end
                "librarians dataset"
            ),
            "for more information."
        ),
        tags$form(
            tags$legend("Define Parameters for the Report"),
            tags$label(`for` = "state", "Select a State"),
            tags$select(
                id = "state",
                HTML(
                    c("Select a State",
                        sapply(
                            sort(unique(librarians$prim_state)),
                            function(x) {
                                paste0(
                                    "<option value='", x, "'>", x, "</option>"
                                )
                            }
                        )
                    )
                )
            ),
            tags$button(
                id = "render",
                class = "action-button shiny-bound-input",
                "Render"
            )
        ),
        tags$article(
            `aria-label` = "report",
            htmlOutput("report")
        )
    )
)


server <- function(input, output) {
    observeEvent(input$render, {
        librarians_subset <- librarians[librarians$prim_state == input$state, ]
        output$report <- renderUI({
            includeHTML(
                rmarkdown::render(
                    "report_template.Rmd",
                    params = list(
                        selection = input$state,
                        data = librarians_subset
                    )
                )
            )
        })
    })
}


shinyApp(ui, server)