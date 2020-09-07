#'////////////////////////////////////////////////////////////////////////////
#' FILE: listbox.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-29
#' MODIFIED: 2020-09-07
#' PURPOSE: UI component for creating a custom select input component
#' STATUS: working
#' PACKAGES: shiny; rheroicons
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' Helper functions
#'
#' Before I begin writing the function that generates the input element, I
#' will start by defining all of the helper functions. These functions will
#' be assigned to a list object.
#'
#' @noRd
helpers <- list()


#' Listbox toggle
#'
#' Render listbox button that displays the selected option and that has an
#' icon that indicates the button shows/hides an expandable list.
#'
#' @param inputId the inputId passed down from the parent function
#' @param titleId ID of the component's title
#'
#' @noRd
helpers$list_toggle <- function(inputId, titleId) {
    buttonId <- paste0(inputId, "__", "toggle")
    buttonLabelId <- paste0(buttonId, "_label")

    tags$button(
        id = buttonId,
        class = "listbox-toggle",
        `data-group` = inputId,
        `aria-haspopup` = "listbox",
        `aria-expanded` = "false",
        `aria-labelledby` = paste0(titleId, " ", buttonLabelId),

        # text element for current selected item
        tags$span(
            id = buttonLabelId,
            class = "toggle-text"
        ),

        # icon
        rheroicons::rheroicon(
            name = "chevron_down",
            type = "solid",
            classnames = "toggle-icon"
        )
    )
}


#' List Options Item
#'
#' This function will render a list item (i.e., <li>) which will have a
#' an svg icon and a text label.
#'
#' @param inputId the inputId passed down from the parent function
#' @param option a title for the input item
#' @param value a value for the input item (if null, will be `option`)
#'
#' @noRd
helpers$input_list_item <- function(inputId, option, value) {
    forId <- paste0(inputId, "__", option)

    # generate html
    tags$li(
        id = forId,
        class = "listbox-option",
        role = "option",
        `data-value` = value,
        `data-group` = inputId,
        `aria-labelledby` = forId,

        # selected icon
        rheroicons::rheroicon(
            name = "check_circle",
            type = "solid",
            classnames = "option-icon"
        ),
        # label
        tags$span(
            id = paste0(forId, "-input-label"),
            class = "option-text",
            option
        )
    )
}


#' List Options
#'
#' This function will generate the list items based on the number of options
#' indicated in the parent function.
#'
#' @param inputId the inputId passed down from the parent function
#' @param titleId Id of the component (generated internally)
#' @param data a list object containing the options and values.
#'
#' @noRd
helpers$input_list <- function(inputId, titleId, data) {

    # generate markup for parent element
    parent <- tags$ul(
        id = paste0(inputId, "__input_list"),
        class = "listbox-list hidden",
        `data-group` = inputId,
        `aria-labelledby` = titleId,
        role = "listbox",
        tabindex = "-1"
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

#' Listbox widget
#'
#' Generate a listbox widget based on user defined options.
#'
#' @param inputId a unique ID for the input element
#' @param title a title that describes the select input component
#' @param label a label that describes what to do (optional)
#' @param options an array used to generate input options
#' @param values an array of values to pass on to each inputs (gets `options`
#'              if argument is NULL)
#'
#' @examples
#' listbox(
#'     inputId = "popularTech",
#'     title = "The Most Popular Technologies",
#'     label = "Select a technology",
#'     options = c(
#'         "JavaScript",
#'         "HTML/CSS",
#'         "SQL",
#'         "Python",
#'         "Java",
#'         "Bash/Shell/Powershell",
#'         "C#",
#'         "PHP",
#'         "Typescript",
#'         "C++"
#'     ),
#'     values = c(
#'         "js",
#'         "html_css",
#'         "sql",
#'         "py",
#'         "java",
#'         "bsh_sh_powershell",
#'         "csharp",
#'         "php",
#'         "typescript",
#'         "cpp"
#'     )
#' )
#'
#' @noRd
listbox <- function(inputId, title, label = NULL, options, values = NULL) {

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

    # build component
    el <- tags$fieldset(
        id = inputId,
        class = "listbox-group hidden",
        `data-group` = inputId,
        `data-value` = "NULL",

        # define title for the input group
        tags$legend(
            id = titleId,
            class = "listbox-title",
            title
        ),

        # generate menu toggle
        helpers$list_toggle(
            inputId = inputId,
            titleId = titleId
        ),

        # generate options list
        helpers$input_list(
            inputId = inputId,
            data = data,
            titleId = titleId
        )
    )

    # append label if present
    if (!is.null(label)) {
        stopifnot(is.character(label))
        el$children <- tagList(
            el$children[1],
            tags$span(
                id = labelId,
                class = "listbox-label",
                label
            ),
            el$children[2],
            el$children[3],
        )
    }

    # return
    return(el)
}