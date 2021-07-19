#'////////////////////////////////////////////////////////////////////////////
#' FILE: main_ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-05-29
#' MODIFIED: 2021-07-10
#' PURPOSE: main screen to be rendered on successful login attempt
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' Main UI
#' @param userdata object containing username and user emoji
#' @noRd
main_ui <- function(id, userdata) {
    ns <- NS(id)
    tags$main(
        class = "main",
        tags$div(
            class = "header",
            tags$h1(
                "Welcome,",
                tags$span(userdata$username),
                tags$span(userdata$emoji),
                "!"
            ),
            tags$p("You are now signed in."),
            actionButton(inputId = ns("signout"), "Sign out")
        )
    )
}


#' Main UI Server
#' Process Logging out
#' @param id module instance ID
#' @param logged a global reactive value for managing login state
#' @noRd
main_ui_server <- function(id, logged) {
    moduleServer(
        id,
        function(input, output, session) {
            observeEvent(input$signout, logged(FALSE))
        }
    )
}