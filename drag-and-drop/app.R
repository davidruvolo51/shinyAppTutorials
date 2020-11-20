#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-04-24
#' MODIFIED: 2020-11-20
#' PURPOSE: example application for creating drag/drop elements
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css")
    ),
    tags$main(
        tags$h2("Moveable Elements"),
        tags$p(
            "Order the cards by the number of cases or by group.",
            "Drag and drop a card into the drop zone or on top of",
            "another card. Press 'done' when you are finished."
        ),
        tags$div(
            class = "dragarea",

            # primary elements
            draggable_card("groupA", "Group A", "14 cases"),
            draggable_card("groupB", "Group B", "3 cases"),
            draggable_card("groupC", "Group C", "33 cases"),
            draggable_card("groupD", "Group D", "7 cases"),
            draggable_card("groupE", "Group E", "21 cases"),

            # extra drop zone
            tags$div(
                class = "droparea",
                tags$p("Drop here")
            )
        ),
        tags$button(
            id = "submit",
            type = "submit",
            class = "shiny-bound-input action-button",
            "Done"
        )
    ),
    tags$script(src = "index.js")
)

# server
server <- function(input, output, session) {
}

# app
shinyApp(ui, server)