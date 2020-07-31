#'////////////////////////////////////////////////////////////////////////////
#' FILE: time_input.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-31
#' MODIFIED: 2020-07-31
#' PURPOSE: Shiny UI Component for Time Inputs
#' STATUS: in.progress
#' PACKAGES: Shiny
#' COMMENTS: requires JavaScript input binding
#'////////////////////////////////////////////////////////////////////////////

#' time_input
#'
#' Create a time input component for use in Shiny apps. This component
#' generates the markup for input[type=time]. The value for time is always in
#' 24-hour format (hh:mm).
#'
#' @param inputId an unique identifier for an instance of the component
#' @param label text that describes the input element
#' @param value a default value for the time input (hh:mm)
#' @param min the earliest time allowed (hh:mm; deafult: "07:00")
#' @param max the latest time allowed (hh:mm; default: "10:00")
#' @param caption text that provides additional infomration about the input
#'
#'
time_input <- function(
    inputId,
    label,
    value = "13:00",
    min = "07:00",
    max = "10:00",
    caption = NULL
) {

    # generate HTML for label
    lab <- shiny::tags$label(
        class = "time__label",
        `for` = inputId,
        label
    )

    # generate HTML for input
    input <- shiny::tags$input(
        id = inputId,
        name = inputId,
        class = "time__input",
        type = "time",
        min = min,
        max = max,
        value = value
    )

    # evaluate use of arg `caption`
    if (is.null(caption)) out <- shiny::tagList(lab, input)
    if (!is.null(caption)) {
        out <- shiny::tagList(
            lab,
            shiny::tags$span(
                class = "time__caption",
                caption
            ),
            input
        )
    }

    # return
    return(out)
}