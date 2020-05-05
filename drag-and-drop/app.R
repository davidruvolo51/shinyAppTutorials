#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-04-24
#' MODIFIED: 2020-05-05
#' PURPOSE: example application for creating drag/drop elements
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))


# functional component for building draggable cards
draggable_card <- function(id, title, text) {

    # validate props
    stopifnot(!is.null(id))
    stopifnot(!is.null(title))
    stopifnot(!is.null(text))

    # set defaults
    fill_color <- "#09BC8A"
    line_color <- "#ffffff"

    # build card element
    el <- tags$div(
        id = paste0("card-", id),
        class = "card",
        draggable = "true",
        `data-value` = title,
        tags$h2(
            class = "card-title",
            title
        ),
        tags$button(
            id = id,
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