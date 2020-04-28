#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-04-24
#' MODIFIED: 2020-04-24
#' PURPOSE: example application for creating drag/drop elements
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))


# functional component for building draggable cards
card <- function(id, title, text) {

    # validate props
    stopifnot(!is.null(id))
    stopifnot(!is.null(title))
    stopifnot(!is.null(text))
    ns <- NS(id)

    # set defaults
    fill_color <- "#09BC8A"
    line_color <- "#ffffff"

    # build card element
    el <- tags$div(
        id = paste0("card-", id),
        class = "card",
        draggable = "true",
        tags$h2(
            class = "card-title",
            title
        ),
        tags$button(
            id = ns("button"),
            class = "card-button",
            tag(
                "svg",
                list(
                    "width" = "25",
                    "height" = "25",
                    "viewBox" = "0 0 25 25",
                    "class" = "drag-icon",
                    # <circle>
                    tag(
                        "circle",
                        list(
                            "cx" = "12.5",
                            "cy" = "12.5",
                            "r" = "12.5",
                            "fill" = fill_color
                        )
                    ),
                    # <line>
                    tag(
                        "line",
                        list(
                            "x1" = "12.5",
                            "y1" = "5",
                            "x2" = "12.5",
                            "y2" = "20",
                            "stroke" = line_color,
                            "stroke-width" = "2.5",
                            "stroke-linecap" = "butt"
                        )
                    ),
                    # <line>
                    tag(
                        "line",
                        list(
                            "x1" = "5",
                            "y1" = "12.5",
                            "x2" = "20",
                            "y2" = "12.5",
                            "stroke" = line_color,
                            "stroke-width" = "2.5",
                            "stroke-linecap" = "butt"
                        )
                    )
                )
            )
        ),
        tags$p(
            class = "card-message",
            text
        )
    )

    # return
    return(el)
}

# ui
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css")
    ),
    tags$main(
        class = "main",
        tags$h2("Moveable Elements"),
        tags$p(
            "Order the cards by the number of cases or by group."
        ),
        tags$div(
            class = "dragarea",
            card("group-a", "Group A", "14 cases"),
            card("group-b", "Group B", "3 cases"),
            card("group-c", "Group C", "33 cases"),
            card("group-d", "Group D", "7 cases"),
            card("group-e", "Group E", "21 cases"),
            tags$div(class = "droparea")
        )
    ),
    tags$script(src = "index.js")
)

# server
server <- function(input, output, session) {

}

# app
shinyApp(ui, server)