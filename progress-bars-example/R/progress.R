#'////////////////////////////////////////////////////////////////////////////
#' FILE: progress.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-28
#' MODIFIED: 2020-03-28
#' PURPOSE: R6 class for creating a progress bar in shiny
#' STATUS: in.progress
#' PACKAGES: R6, htmltools
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
shiny_progress <- R6::R6Class(
    classname = "shiny-progress-bar",

    # public
    public = list(

        # vars
        elem = NULL,
        start = NULL,
        now = NULL,
        min = NULL,
        max = NULL,

        # init function
        initialize = function(now = 0, min = 0, max = 10) {
            stopifnot(is.numeric(now))
            stopifnot(is.numeric(min))
            stopifnot(is.numeric(max))
            self$start <- now
            self$now <- now
            self$min <- min
            self$max <- max
        },

        # component
        ui = function(id = NULL, fixed = FALSE, position = "top", fill = NULL) {
            stopifnot(!is.null(id))
            stopifnot(is.logical(fixed))

            # set id to state
            self$elem <- id

            # add color
            if (length(fill) > 0) {
                style <- paste0("background-color: ", fill, ";")
            }

            # process fixed and position
            css <- "progress-bar-container"
            if (isTRUE(fixed)) {
                css <- paste0(css, " progress-bar-fixed")
                if (!position %in% c("top", "bottom")) {
                    stop("position is invalid. Enter 'top' or 'bottom'")
                } else {
                    css <- paste0(css, " position-", position)
                }
            }

            b <- htmltools::tags$div(
                id = paste0(id, "-container"),
                class = css,
                htmltools::tags$div(
                    id = id,
                    class = "progress-bar",
                    style = style,
                    role = "progressbar",
                    `aria-valuenow` = self$now,
                    `aria-valuemin` = self$min,
                    `aria-valuemax` = self$max,
                    `aria-valuetext` = self$text
                )
            )

            # return
            return(b)
        },

        # start function
        init = function(id = self$elem) {
            private$init_parent_element(id)
            private$update_progress_bar(id, self$now, self$max)
        },

        # increment function
        increase = function(id = self$elem, by = 1) {

            # validate
            stopifnot(!is.null(id))
            stopifnot(is.numeric(by))
            stopifnot(by > 0)

            # check to see if 'by' is out of bounds (only run if inbounds)
            if (!((by + self$now) > self$max)) {
                self$now <- self$now + by

                # update
                private$update_progress_bar(
                    id = id,
                    now = self$now,
                    max = self$max
                )
            }

            # when 'by' is out of bounds, reassign 'now' as 'max'
            if ((by + self$now) > self$max) {
                self$now <- self$max
            }
        },

        # descrease function
        decrease = function(id = self$elem, by = 1) {

            # validate
            stopifnot(!is.null(id))
            stopifnot(is.numeric(by))
            stopifnot(by > 0)

            # check to see if 'by' is out of bounds (only run if inbounds)
            if (!((self$now - by) < self$min)) {
                self$now <- self$now - by

                # update
                private$update_progress_bar(
                    id = id,
                    now = self$now,
                    max = self$max
                )
            }

            # when 'by' is out of bounds, reassign 'now' as 'min'
            if ((self$now - by) < self$min) {
                self$now <- self$min
            }
        },

        # reset function
        reset = function(id = self$elem, to = self$start) {

            # validate
            stopifnot(!is.null(id))
            stopifnot(is.numeric(to))

            # check to see if 'to' is out of bounds
            if (to < self$min) {
                stop("value 'to' is less than the min (", self$min, ")")
            } else if (to > self$max) {
                stop("value 'to' is greater than the max (", self$max, ")")
            } else {
                # reset
                self$now <- to
                # update
                private$update_progress_bar(
                    id = id,
                    now = self$now,
                    max = self$max
                )
            }
        },

        # print function
        print = function() {
            print(
                list(
                    now = self$now,
                    min = self$min,
                    max = self$max
                )
            )
        }
    ),

    # private functions
    private = list(

        # init ui function
        init_parent_element = function(id) {
            session <- shiny::getDefaultReactiveDomain()
            session$sendCustomMessage("init_parent_element", id)
        },

        # send data function
        update_progress_bar = function(id, now, max) {
            session <- shiny::getDefaultReactiveDomain()
            session$sendCustomMessage(
                "update_progress_bar",
                list(id, now, max)
            )
        }
    )
)