#'////////////////////////////////////////////////////////////////////////////
#' FILE: leaflet_loader.R
#' AUTHOR: @dcruvolo
#' CREATED: 2020-04-02
#' MODIFIED: 2020-04-02
#' PURPOSE: functional component for creating custom loaders for leaflet
#' STATUS: working
#' PACKAGES: shiny(loaded in the app)
#' COMMENTS: css can be found in www/styles.css
#'////////////////////////////////////////////////////////////////////////////

# loading screen functional component: child element
loading_elem <- function(id, text = NULL) {
    stopifnot(!is.null(id))

    # generate element with dots
    el <- tags$div(
        id = id,
        class = "visually-hidden loading-ui loading-dots",
        `aria-hidden` = "true",
        tags$div(
            class = "dots-container",
            tags$span(class = "dots", id = "dot1"),
            tags$span(class = "dots", id = "dot2"),
            tags$span(class = "dots", id = "dot3")
        )
    )

    # add message if specified + update attribs
    if (length(text) > 0) {
        el$attribs$class <- "loading-ui loading-text"
        el$children <- tags$p(
            class = "loading-message",
            as.character(text)
        )
    }

    # return
    return(el)
}

#' loading screen: primary component wrapper around child
#' and leafletOuput
loading_message <- function(..., id, text = NULL) {
    tags$div(
        class = "loading-container",
        tags$span(
            class = "visually-hidden",
            "map is loading"
        ),
        loading_elem(id = id, text = text),
        ...
    )
}