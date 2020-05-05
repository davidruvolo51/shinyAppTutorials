#' ////////////////////////////////////////////////////////////////////////////
#' FILE: draggable_card.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-05-05
#' MODIFIED: 2020-05-05
#' PURPOSE: functional component for creating a draggable card
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# functional component for building draggable cards
draggable_card <- function(id, title, text, draggable = TRUE) {

    # validate args
    stopifnot(!is.null(id))
    stopifnot(!is.null(title))
    stopifnot(!is.null(text))
    stopifnot(is.logical(draggable))

    # create <svg> icon
    fill_color <- "#09BC8A"
    line_color <- "#ffffff"
    svg <- tag(
        "svg",
        list(
            "width" = "25",
            "height" = "25",
            "viewBox" = "0 0 25 25",
            "class" = "card-icon",
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
            # vertical: <line>
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
            # horizontal: <line>
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

    # build parent element: <div class="card">
    el <- tags$div(
        id = paste0("card-", id),
        class = "card",
        draggable = tolower(draggable),
        `data-value` = title,
        tags$h2(class = "card-title", title),
        svg,
        tags$p(class = "card-message", text)
    )

    # remove <svg> element if !draggable
    if (!draggable) el$children[[2]] <- NULL

    # return
    return(el)
}