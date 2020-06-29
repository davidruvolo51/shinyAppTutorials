#'////////////////////////////////////////////////////////////////////////////
#' FILE: select_input.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-29
#' MODIFIED: 2020-06-29
#' PURPOSE: UI component for creating a custom select input component
#' STATUS: in.progress
#' PACKAGES: shiny; rheroicons
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////


#' ~ 1 ~
#' define helpers
#' Before I begin writing the function that generates the input element, I
#' will start by defining all of the helper functions. These functions will
#' be assigned to a list object.
helpers <- list()


#' ~ 1a ~
#' Select Input Toggle
#' Define a function that returns component toggle. This button, when clicked,
#' will open and close the menu (i.e., list of options)
#' @param inputId the inputId passed down from the parent function
#' @importFrom rheroicons solid$chevron_down
helpers$list_toggle <- function(inputId) {
    ns <- NS(inputId)
    tags$button(
        id = ns("toggle"),
        class = "select-list-toggle",
        `data-group` = inputId,
        `aria-expanded` = "false",
        tags$span(class = "toggle-text", "Select an item"),
        rheroicons::solid$chevron_down(
            aria_hidden = TRUE,
            class = "toggle-icon"
        )
    )
}


#' ~ 1b ~
#' Select Input List Item
#' This component works by creating an ordered list of buttons. Each button
#' is assigned an option/value. When clicked, the button's value will be
#' set as the value of the parent element. This will allow you to call
#' `input$mySelectInput`. This function will render a list item (i.e., <li>)
#' which will have a button, an svg icon, and a text label.
#' @param inputId the inputId passed down from the parent function
#' @param option a title for the input item
#' @param value a value for the input item (if null, will be `option`)
#' @importFrom rheroicons outline$check_circle
helpers$input_list_item <- function(inputId, option, value) {
    ns <- NS(value)
    tags$li(
        class = "select-input-list-item",
        tags$button(
            id = ns("input-option"),
            class = "input-button",
            `data-value` = value,
            `data-group` = inputId,
            rheroicons::solid$check_circle(
                aria_hidden = TRUE,
                class = "input-icon"
            ),
            tags$span(class = "input-text", option)
        )
    )
}


#' ~ 1c ~
#' Select Input List
#' This function will generate the list items based on the number of options
#' indicated in the parent function.
#' @param inputId the inputId passed down from the parent function
#' @param data a list object containing the options and values.
helpers$input_list <- function(inputId, data) {

    # generate markup for parent (<ol>) element
    parent <- tags$ol(
        class = "select-input-list",
        `data-group` = inputId,
        `aria-hidden` = "false"
    )

    # generate markup for child (<li>) elements
    children <- lapply(seq_len(length(data$options)), function(i) {
        helpers$input_list_item(
            inputId = inputId,
            option = data$options[[i]],
            value = data$values[[i]]
        )
    })

    # bind to parent and add blank option
    parent$children <- tagList(
        helpers$input_list_item(
            inputId = inputId,
            option = "Select an item",
            value = "NA"
        ),
        children
    )

    # return
    return(parent)
}


#'//////////////////////////////////////

#' ~ 2 ~
#' Define Primary Function
#' This function calls all helpers and returns the markup for the custom select
#' component.
#' @param inputId a unique ID for the input element
#' @param title a title that describes the select input component
#' @param options an array used to generate input options
#' @param values an array of values to pass on to each inputs (gets `options`
#'              if argument is NULL)
select_input <- function(inputId, title, options, values = NULL) {

    # validate
    stopifnot(is.character(inputId))
    stopifnot(is.character(title))
    stopifnot(!is.null(options))

    # process options + values
    data <- list(options = options, values = options)
    if (!is.null(values)) data$values <- values

    # build component
    el <- tags$fieldset(
        id = inputId,
        class = "select-input-group hidden",
        `data-group` = inputId,
        `data-value` = "NULL",
        tags$legend(class = "select-input-title", title),
        helpers$list_toggle(inputId = inputId),
        helpers$input_list(inputId = inputId, data = data)
    )

    # return
    return(el)
}