#'////////////////////////////////////////////////////////////////////////////
#' FILE: time_input.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-20
#' MODIFIED: 2020-03-20
#' PURPOSE: R6 Class for Creating a Time Input Elemen
#' STATUS: working
#' PACKAGES: R6, shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# install pkgs
#' install.packages("R6")

# define class
time <- R6::R6Class(
    classname = "time_input",
    public = list(

        # init class values
        default = NULL,
        value = NULL,

        # initialize function
        initialize = function(x = "00:00") {
            self$default <- x
            self$value <- x
        },

        # generate ui
        input = function(id, label, value = self$value) {

            # validate args
            stopifnot(!is.null(id))
            stopifnot(!is.null(label))
            stopifnot(!is.null(value))

            # create html
            label <- shiny::tags$label(`for` = id, label)
            input <- shiny::tags$input(
                class = "shiny-bound-input",
                type = "time",
                id = id,
                value = value
            )

            # attach js script
            script <- private$listener(id, value)

            # return
            return(shiny::tagList(label, input, script))
        },

        # time output ui
        displayTime = function(value = self$value, class = NULL) {
            e <- shiny::tags$output(class = "output", value)
            if (length(class) > 0) {
                e$attribs$class <- paste(e$attribs$class, class)
            }
            return(e)
        },

        # update state
        updateTime = function(value) {
            self$value <- value
        },

        # reset
        resetTime = function(value = self$default) {
            self$value <- value
            session <- shiny::getDefaultReactiveDomain()
            session$sendCustomMessage("reset", "")
        }
    ),
    private = list(
        # js listener that updates input element
        listener = function(id, default) {
            stopifnot(!is.null(id))
            js <- shiny::tags$script(
                paste0(
                "(function() {",
                "const opts = {hour: 'numeric', minute: 'numeric', timeZone: 'UTC'};",
                "const ", id, " = document.getElementById('", id, "');",
                id, ".value='", default, "';",
                id, ".addEventListener('input',function(event) {",
                "let input = event.target.valueAsDate;",
                "let value = input.toLocaleString('en-gb', opts);",
                "console.log('user input:', value);",
                "Shiny.setInputValue('", id, "', value);",
                "});",
                "Shiny.addCustomMessageHandler('reset', function(value) {",
                id, ".value='", default, "';",
                "Shiny.setInputValue('", id, "', '", default, "');",
                "})",
                "})();"
                )
            )
            return(js)
        }
    )
)