#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' CREATED: 2018-08-16
#' MODIFIED: 2021-05-29
#' PURPOSE: demo for custom styling of <select> input
#' PACKAGES: shiny
#' STATUS: working + complete;
#' COMMENTS: see comments in www/css/styles.css for information on css
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

ui <- tagList(
    tags$head(
        tags$link(type = "text/css", href = "css/styles.css", rel = "stylesheet")
    ),
    fluidPage(
        tags$h1("Customizing", tags$code("<select>"), " with CSS"),
        sidebarPanel(
            tags$label(`for` = "state", "Select a State", class = "input-label"),
            tags$select(
                id = "state",
                tags$option(value = "none", ""),
                tags$optgroup(
                    label = "East Coast",
                    tags$option(value = "NY", "NY"),
                    tags$option(value = "NJ", "NJ"),
                    tags$option(value = "CT", "CT")
                ),
                tags$optgroup(
                    label = "West Coast",
                    tags$option(value = "WA", "WA"),
                    tags$option(value = "OR", "OR"),
                    tags$option(value = "CA", "CA")
                ),
                tags$optgroup(
                    label = "Midwest",
                    tags$option(value = "MN", "MN"),
                    tags$option(value = "WI", "WI"),
                    tags$option(value = "IA", "IA")
                )
            )
        ),
        mainPanel(
            tags$h2("Your Selection:"),
            textOutput("selection")
        )
    )
)


server <- function(input, output) {
        output$selection <- renderText(input$state)
}


shinyApp(ui, server)