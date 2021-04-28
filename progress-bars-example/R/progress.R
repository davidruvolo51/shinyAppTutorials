#'////////////////////////////////////////////////////////////////////////////
#' FILE: progress.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-28
#' MODIFIED: 2021-04-28
#' PURPOSE: R6 class for creating a progress bar in shiny
#' STATUS: in.progress
#' PACKAGES: R6, htmltools
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////


#' Progress Bar
#'
#' Create a new progress bar in your shiny app. This progress bar was designed
#' for apps that many pages that are viewed in a given order. This may be
#' useful apps that have a series of instructions screens or that are
#' designed for qualitative data collection (i.e., survey data). For example,
#' let's say that an app has 10 instruction pages. The user is instructed to
#' read through all pages and use the navigation buttons (next and back) to
#' move between pages. The progress bar can be useful in this situation as it
#' visually shows how many pages are left.
#'
#' @param start the starting point for the progress bar
#' @param min the minimum value of the progress bar
#' @param max the maximum value of the progress bar
#'
#' @return an R6 object
#' @noRd
progressbar <- function(start = 0, min = 0, max = 7) {
    stopifnot(
        "`start` must be numeric" = is.numeric(start),
        "`min` must be numeric" = is.numeric(min),
        "`max` must be numeric" = is.numeric(max)
    )
    pbar$new(start = start, min = min, max = max)
}

#' R6 Class for progress bar
#'
#' @description R6 Class for progress bar
pbar <- R6::R6Class(
    classname = "shiny-progress-bar",
    public = list(

        #' @field elem ID of the progress bar defined by \code{bar()}
        elem = NULL,

        #' @field start the starting position for the progress bar
        start = NULL,

        #' @field current the current state of the progress bar
        current = NULL,

        #' @field min the minimum value of the progress bar
        min = NULL,

        #' @field max The maximum value of the progress bar
        max = NULL,

        #' @field text text formula that updates the `aria-valuetext`
        text = "{value} of {max}",

        #' @description
        #'
        #' Create a new progress bar
        #'
        #' @param start the starting progress
        #' @param min the minimum value of the progress bar
        #' @param max the maximum value of the progress bar
        #'
        initialize = function(start = 0, min = 0, max = 7) {
            self$start <- start
            self$current <- start
            self$min <- min
            self$max <- max
        },

        #' @description bar
        #'
        #' Create a new progress bar in the shiny UI
        #'
        #' @param inputId a unique identifier for the progress bar
        #' @param fill color used to style the progress bar
        #' @param fixed If `TRUE`, the progress bar will be fixed to the
        #'      top or bottom of the parent element
        #' @param position If `fixed = TRUE`, then the argument position
        #'      can be used to fix the progress bar to the "top" or "bottom" of
        #'      the parent element.
        #' @param yOffset A CSS value used to adjust the y position of the
        #'       progress bar relative to the parent element
        #' @param text formula for updating the aria text
        #' @param classnames string containing one or more css classes
        #'
        bar = function(
            inputId,
            fill = NULL,
            fixed = FALSE,
            position = "top",
            yOffset = NULL,
            text = "{value} of {max}",
            classnames = NULL
        ) {
            stopifnot("`fixed` must be TRUE or FALSE" = is.logical(fixed))
            self$elem <- inputId

            # process fixed and position
            css <- "progressbar"
            if (isTRUE(fixed)) {
                css <- paste0(css, " progressbar__fixed")
                if (!position %in% c("top", "bottom")) {
                    stop("position is invalid. Enter 'top' or 'bottom'")
                } else {
                    css <- paste0(css, " position__", position)
                }
            }

            if (!is.null(classnames)) {
                css <- paste0(css, " ", classnames)
            }

            self$text <- text
            f <- private$update__ariatext()

            # build progress bar
            pb <- htmltools::tags$div(
                    id = inputId,
                    class = css,
                    role = "progressbar",
                    `aria-valuecurrent` = self$current,
                    `aria-valuemin` = self$min,
                    `aria-valuemax` = self$max,
                    `aria-valuetext` = f,
                    htmltools::tags$div(class = "bar")
            )

            # process background color
            if (length(fill) > 0) {
                pb$children[[1]]$attribs$style <- paste0(
                    "background-color: ", fill, ";"
                )
            }

            # process yOffset
            if (length(yOffset) > 0) {
                htmltools::validateCssUnit(yOffset)
                pb$attribs$style <- paste0(
                    pb$attribs$style,
                    "top: ", yOffset, ";"
                )
            }

            # return
            return(pb)
        },

        #' @description increase
        #'
        #' Increase the progress bar by 1 another number
        #'
        #' @param by a number between the min and max values (default = 1)
        #'
        increase = function(by = 1) {
            stopifnot(is.numeric(by))
            stopifnot(by > 0)

            # check to see if 'by' is out of bounds (only run if inbounds)
            if (!((by + self$current) > self$max)) {
                self$current <- self$current + by
                private$update__progressbar(current = self$current)
            }

            # when 'by' is out of bounds, reassign 'current' as 'max'
            if ((by + self$current) > self$max) {
                self$current <- self$max
            }
        },

        #' @description decrease
        #'
        #' Decrease the progress bar by 1 another number
        #'
        #' @param by A number between min and max values (default = 1)
        #'
        decrease = function(by = 1) {
            stopifnot(is.numeric(by))
            stopifnot(by > 0)

            # check to see if 'by' is out of bounds (only run if inbounds)
            if (!((self$current - by) < self$min)) {
                self$current <- self$current - by
                private$update__progressbar(current = self$current)
            }

            # when 'by' is out of bounds, reassign 'current' as 'min'
            if ((self$current - by) < self$min) {
                self$current <- self$min
            }
        },

        #' @description reset
        #'
        #' resets progress bar to its initial state
        #'
        reset = function() {
            self$current <- self$start
            private$update__progressbar(current = self$current)
        }
    ),

    # private functions
    private = list(

        # @description update aria text
        update__ariatext = function() {
            formula <- self$text
            if (grep("{value} of {max}", formula, fixed = TRUE)) {
                formula <- gsub("{value}", self$current, formula, fixed = TRUE)
                formula <- gsub("{max}", self$max, formula, fixed = TRUE)
            }
            return(formula)
        },

        # @description send data function
        # getDefaultReactiveDomain from shiny
        update__progressbar = function(current) {
            f <- private$update__ariatext()

            session <- getDefaultReactiveDomain()
            session$sendInputMessage(
                inputId = self$elem,
                message = list(
                    current = current,
                    text = f
                )
            )
        }
    )
)