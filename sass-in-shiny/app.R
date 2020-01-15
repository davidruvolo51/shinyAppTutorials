#' ////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-01-15
#' MODIFIED: 2020-01-15
#' PURPOSE: example shiny app using sass
#' STATUS: in.progress
#' PACKAGES: shiny, dplyr, stringr
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(dplyr))

# build ui
ui <- tagList(
    tags$head(
        tags$link(
            type = "text/css",
            rel = "stylesheet",
            href = "css/styles.css"
        ),
        tags$title("SASS in Shiny")
    ),
    tags$body(

        # <header>
        tags$header(
            class = "header",
            tags$h1("shinyTutorials")
        ),

        # <main>
        tags$main(
            class = "main",
            tags$section(
                class = "section",
                tags$h2("Using SASS in shiny"),
                tags$p(
                    "This shiny app recreates the earlier tutorial",
                    tags$a(
                        href = "https://github.com/davidruvolo51/shinyAppTutorials",
                        "Responsive Datatables in Shiny"
                    ),
                    "using SASS. The UI is the same (minus the content).",
                    "Take a look at the other application and then this one",
                    "to compare css and sass outputs. The benefits of writing",
                    "applications with sass is for css specificty, ease of",
                    "writing, and optimizing css for all browsers. This app",
                    "uses the following npm packages: sass and post-css.",
                    "Visit the tutorial for more information."
                ),
                uiOutput("table")
            )
        )
    )
)


# server
server <- function(input, output) {

    # load data and function
    source("scripts/datatable.R", local = TRUE)
    birds <- readRDS("data/birds_summary.RDS")


    # summarize data and build table
    birds2018 <- birds %>%
        filter(Year == "2018") %>%
        arrange(-Count) %>%
        slice(1:10) %>%
        mutate(
            link = paste0(
                "<a href='",
                "https://birdlife.org.au/bird-profile/",
                stringr::str_replace(
                    string = tolower(Common.Name),
                    pattern = "[[:space:]]",
                    replacement = "-"
                ),
                "'>",
                "View on birdlife",
                "</a>"
            )
        )

    # output table
    output$table <- renderUI({
        datatable(
            data = birds2018,
            id = "birds-summary",
            caption = "Top 10 Birds in 2018",
            options = list(
                asHTML = TRUE
            )
        )
    })
}

# app
shinyApp(ui, server)