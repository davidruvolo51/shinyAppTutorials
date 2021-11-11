#' \code{accordion}
#'
#' Create an accordion element for use in shiny apps. This function returns
#' a component that expands and collapses user defined content. For example,
#' you can create an FAQ page using this component, create definitions, or
#' hide anything you like. The returned component is a text element (i.e.,
#' title, question, etc.) and an html element (or \code{tagList} containing)
#' two or more html elements.
#'
#' @param inputId a unique ID for the accordion component
#' @param title a text string containing a title for the collapsible section
#' @param content an html element or a list of html elements
#' @param heading_level adjust the HTML heading level; default is "h3". Use
#'      on of the following headings: h1, h2, h3, h4, h5, h6
#'
#' Notes on `heading_level`: By default, the title is rendered into
#' a h3 element. This element may not always work in all
#' situations as it is difficult to determine the markup and
#' context the accordion element is used. This option will allow
#' you to use the accordion element with the document's hierarchy
#' All html heading elements can be used (h1, h2, ..., or h6).
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   ui <- tagList(
#'     tags$head(
#'       tags$style(
#'         "#what-is-shiny {
#'            width: 400px;
#'         }"
#'       )
#'     ),
#'     tags$main(
#'       id = "main",
#'       class = "main",
#'       tags$h2("Frequently Asked Questions Page"),
#'       tags$p("Here are some commonly asked questions"),
#'       accordion(
#'         inputId = "what-is-shiny",
#'         title = "What is Shiny?",
#'         content = tagList(
#'           tags$p(
#'             "Shiny is an R package that makes it easy to build",
#'             "interactive web apps straight from R. You can host",
#'             "standalone apps on a webpage or embed them in R Markdown",
#'             "documents or build dashboards. You can also extend your",
#'             "Shiny apps with CSS themes, htmlwidgets, and JavaScript",
#'             "actions."
#'           ),
#'           tags$cite("Rstudio.org")
#'         )
#'       )
#'     )
#'   )
#'   server <- function(input, output) {}
#'   shinyApp(ui, server)
#' }
#' @keywords iceComponents accordion collapsible content
#' @importFrom htmltools tags tagList
#' @return Create an accordion component
#' @export
accordion <- function(
    inputId,
    title,
    content,
    heading_level = "h3",
    class = NULL
) {

    # validate
    if (!is.character(inputId)) stop("argument 'inputId' must be a string")
    if (!is.character(title)) stop("argument 'title' must be a string")
    if (is.null(content)) stop("argument 'content' cannot be null")

    # validate html headings
    valid_html_headings <- c("h1", "h2", "h3", "h4", "h5", "h6")
    if (!heading_level %in% valid_html_headings) {
        stop(
            paste0(
                "input for 'heading_level' is invalid. ",
                "Select: h1, h2, h3, h4, h5, or h6"
            )
        )
    }

    # define ids
    ids <- accordion_helpers$set_html_ids(inputId = inputId)

    # build child elements
    el <- htmltools::tags$div(
        id = ids$group,
        class = "accordion accordion__default",
        accordion_helpers$heading(
            ids = ids,
            title = title,
            heading_level = heading_level
        ),
        accordion_helpers$content(
            ids = ids,
            content = content
        )
    )

    # append class (if applicable)
    if (!is.null(class)) {
        el$attribs$class <- paste0(
            el$attrib$class, " ", class
        )
    }

    # return
    return(el)
}


#' \code{reset_accordion}
#'
#' A server-side function that resets the accordion component to it's
#' default statue (closed).
#'
#' @param inputId the of of the component to reset
#'
#' @keywords iceComponents accordion reset
#' @export
reset_accordion <- function(inputId) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendInputMessage(
        inputId = inputId,
        message = "reset"
    )
}

#' accordion_helpers
#' Create a series of secondary functions that generate child elements of the
#' accordion and process arguments. These functions are added to a nested list
#' object that is called inthe main function.
#' @noRd
accordion_helpers <- list()


#' set_html_ids
#' Define a function that generates the IDs and data attributes for properly
#' linking elements across helper functions
#' @param inputId a user defined
#' @noRd
accordion_helpers$set_html_ids <- function(inputId) {
    ns <- shiny::NS(namespace = inputId)
    ids <- list(
        group = inputId,
        heading_id = ns("accordionHeading"),
        button_id = ns("accordionBtn"),
        content_id = ns("accordionSection")
    )
    return(ids)
}

#' @name heading
#' Define a function that returns the heading of the accordion section. This
#' function returns a heading element (<h4>) that places the title in a button.
#' The button is used to open and close the hidden section. This function is
#' used in the primary function along with the `content()` function.
#' @param ids a list object generated by set_html_ids
#' @param title user defined title
#' @param props the processed arguments generated from the validate_props func
#' @importFrom htmltools tags tagList
#' @noRd
accordion_helpers$heading <- function(ids, title, heading_level) {
    htmltools::tags[[heading_level]](
        id = ids$heading_id,
        class = "accordion__heading",
        `data-accordion-group` = ids$group,
        htmltools::tags$button(
            id = ids$button_id,
            class = "accordion__toggle",
            `data-accordion-group` = ids$group,
            `aria-controls` = ids$content_id,
            `aria-expanded` = "false",
            htmltools::tags$span(
                class = "toggle__label",
                title
            ),
            rheroicons::rheroicon(
                name = "chevron_down",
                type = "outline",
                class = "toggle__icon"
            )
        )
    )
}

#' \code{content}
#' Define a function that creates the collapsible element in the accordion.
#' This function is used in the primary function along with the `heading()`
#' function.
#' @param ids a list object generated by set_html_ids
#' @param content user defined html element or tagList of elements
#' @noRd
accordion_helpers$content <- function(ids, content) {
    htmltools::tags$section(
        id = ids$content_id,
        class = "accordion__content",
        `aria-labelledby` = ids$heading_id,
        hidden = "",
        content
    )
}