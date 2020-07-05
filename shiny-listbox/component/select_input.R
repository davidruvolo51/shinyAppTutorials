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
#' @param labelId ID of the component's input label
#' @importFrom rheroicons solid$chevron_down
helpers$list_toggle <- function(inputId, labelId) {
    buttonId <- paste0(inputId, "__", "toggle")
    buttonLabelId <- paste0(buttonId, "_label")
    tags$button(
        id = buttonId,
        class = "select-list-toggle",
        `data-group` = inputId,
        `aria-haspopup` = "listbox",
        `aria-expanded` = "false",
        `aria-labelledby` = paste0(labelId, " ", buttonLabelId),

        # text element for current selected item
        tags$span(
            id = buttonLabelId,
            class = "toggle-text"
        ),

        # icon
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
    forId <- paste0(inputId, "__", option)

    # generate html
    tags$li(
        id = forId,
        class = "select-input-list-option",
        role = "option",
        `data-value` = value,
        `data-group` = inputId,
        `aria-labelledby` = forId,
        tabIndex = "0",

        # selected icon
        rheroicons::solid$check_circle(
            aria_hidden = TRUE,
            class = "input-icon"
        ),
        # label
        tags$span(
            id = paste0(forId, "-input-label"),
            class = "input-text",
            option
        )
    )
}


#' ~ 1c ~
#' Select Input List
#' This function will generate the list items based on the number of options
#' indicated in the parent function.
#' @param inputId the inputId passed down from the parent function
#' @param labelId Id of the component (generated internally)
#' @param data a list object containing the options and values.
helpers$input_list <- function(inputId, labelId, data) {

    # generate markup for parent element
    parent <- tags$ul(
        id = paste0(inputId, "__input_list"),
        class = "select-input-list",
        `data-group` = inputId,
        `aria-hidden` = "false",
        `aria-labelledby` = labelId,
        role = "listbox",
        tabIndex = "0"
    )

    # generate markup for child (<li>) elements
    children <- lapply(seq_len(length(data$options)), function(i) {
        helpers$input_list_item(
            inputId = inputId,
            option = data$options[[i]],
            value = data$values[[i]]
        )
    })

    # bind to parent (you can add blank option here)
    parent$children <- children

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
#' @param label a label that describes what to do
#' @param options an array used to generate input options
#' @param values an array of values to pass on to each inputs (gets `options`
#'              if argument is NULL)
select_input <- function(inputId, title, label = NULL, options, values = NULL) {

    # validate
    stopifnot(is.character(inputId))
    stopifnot(is.character(title))
    stopifnot(!is.null(options))

    # process options + values
    data <- list(options = options, values = options)
    if (!is.null(values)) data$values <- values

    # set ID of text elements (for aria attributes)
    titleId <- paste0(inputId, "__title")
    labelId <- paste0(inputId, "__label")

    # set default label
    if (!is.null(label)) {
        stopifnot(is.character(label))
        lab <- label
    } else {
        lab <- "Select an option"
    }

    # build component
    el <- tags$fieldset(
        id = inputId,
        class = "select-input-group hidden",
        `data-group` = inputId,
        `data-value` = "NULL",

        # define title for the input group
        tags$legend(
            id = titleId,
            class = "select-input-title",
            title
        ),

        # define label for menu
        tags$span(
            id = labelId,
            class = "select-input-label",
            lab
        ),

        # generate menu toggle
        helpers$list_toggle(
            inputId = inputId,
            labelId = labelId
        ),

        # generate options list
        helpers$input_list(
            inputId = inputId,
            data = data,
            labelId = labelId
        )
    )

    # return
    return(el)
}