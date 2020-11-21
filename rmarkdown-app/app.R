#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2018-05-22
#' MODIFIED: 2020-11-20
#' PURPOSE: how to include Rmarkdown files in shiny
#' PACKAGES: app=shiny; rmd=tidyverse, kableExtra
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# data - run `data/data_0_source.R` to pull and clean data from github
librarians <- readRDS("data/librarians_538.RDS")

# define app
shinyApp(

    # ui
    ui = tagList(
        tags$head(
            tags$link(
                type = "text/css",
                rel = "stylesheet",
                href = "css/styles.css"
            )
        ),
        tags$header(
            tags$h1("Using RMarkdown as Shiny UI"),
            tags$p(
                "An example app demonstrating how to use paramaterized ",
                "reports in Rmarkdown"
            )
        ),
        tags$main(
            tags$form(
                tags$legend("Define Parameters for the Report"),
                tags$label(`for` = "state", "Select a State"),
                tags$select(id = "state", HTML(
                        c("Select a State",
                            sapply(
                                sort(unique(librarians$prim_state)),
                                function(x) {
                                    paste0(
                                        "<option value='", x, "'>",
                                        x,
                                        "</option>"
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
    ),

    # server
    server = function(input, output) {

        # set initial ui for htmlOutput
        output$report <- renderUI({
            tagList(
                tags$h2("Get started"),
                tags$p(
                    "This example demonstrates the use of paramaterized ",
                    "reports in shiny. The data used in this example comes ",
                    "from 538's data repository on librarians. See ",
                    tags$a(
                        href = "https://github.com/fivethirtyeight/data/tree/master/librarians",
                        "github repo here"
                    ),
                    "."
                )
            )
        })

        # render report when button clicked
        observeEvent(input$render, {
            librariansDF <- librarians[librarians$prim_state == input$state, ]
            output$report <- renderUI({
                includeHTML(
                    rmarkdown::render(
                        "report_template.Rmd",
                        params = list(
                            selection = input$state,
                            data = librariansDF
                        )
                    )
                )
            })
        })
    }
)