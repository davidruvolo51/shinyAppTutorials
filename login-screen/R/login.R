#'////////////////////////////////////////////////////////////////////////////
#' FILE: login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-05-29
#' MODIFIED: 2021-07-10
#' PURPOSE: shiny module for logging in
#' STATUS: working
#' PACKAGES: shiny, sodium
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' @title Signin UI
#' @description login UI component
#' @param id unique ID for this instance
#' @noRd
signin_ui <- function(id) {
    ns <- NS(id)
    tagList(
        tags$main(
            class = "main signin-screen",
            tags$form(
                class = "signin-form", id = ns("form"),
                tags$legend("Sign in to your account"),
                tags$output(id = ns("form_status"), class = "error-message"),

                # username input
                tags$label(`for` = ns("username"), "Enter your username"),
                tags$input(type = "text", id = ns("username")),
                tags$output(id = ns("user_status"), class = "error-message"),

                # password input
                tags$label(`for` = ns("password"), "Enter your password"),
                tags$input(type = "password", id = ns("password")),
                tags$output(id = ns("password_status"), class = "error-message"),

                # submit button
                tags$button(
                    id = ns("submit"),
                    type = "submit",
                    class = "action-button shiny-bound-input",
                    "Submit",
                )
            )
        )
    )
}

#' signin_server
#' @description Server for signin module
#'      Ideally, the user information should be stored in a secured
#'      database. For the purpose of this example, all information
#'      was stored in the same location
#' @param id required shiny param
#' @param users reference dataset
#' @param username a global reactive object that manages current user
#' @param logged a global reactive object that manages logged state
signin_server <- function(id, users, username, logged) {
    moduleServer(
        id,
        function(input, output, session) {
            observeEvent(input$submit, {

                # reset all form statuses
                js$inner_html(id = paste0(id, "-form_status"), "")
                js$inner_html(id = paste0(id, "-user_status"), "")
                js$inner_html(id = paste0(id, "-password_status"), "")
                js$remove_css(id = paste0(id, "-form"), css = "invalid-all")
                js$remove_css(id = paste0(id, "-form"), css = "invalid-usr")
                js$remove_css(id = paste0(id, "-form"), css = "invalid-pwd")

                # search users for match this returns row.index
                # use it to verify password via sodium's password_verify function
                usr <- which(users$username == input$username)
                tryCatch({
                    pwd <- sodium::password_verify(
                        hash = users$password[usr],
                        password = input$password
                    )

                    if (pwd) {
                        username(input$username)
                        logged(TRUE)
                    } else {
                        stop()
                    }

                }, error = function(e) {
                    signin_form_validiation(id, input$username, input$password)
                }, warning = function(w) {
                    signin_form_validiation(id, input$username, input$password)
                })
            })
        }
    )
}

#' signin_form_validation
#' @description Form validation for client. Only checks missing fields
#' @param id instance ID
#' @param username user entered value
#' @param password user entered value
#' @noRd
signin_form_validiation <- function(id, username, password) {
    throw_usr <- function() {
        js$inner_html(id = paste0(id, "-user_status"), "Username is missing")
        js$add_css(id = paste0(id, "-form"), css = "invalid-usr")
    }

    throw_pwd <- function() {
        js$inner_html(
            id = paste0(id, "-password_status"),
            html = "Password is missing"
        )
        js$add_css(id = paste0(id, "-form"), css = "invalid-pwd")
    }

    if (username == "" && password == "") {
        throw_usr()
        throw_pwd()

    } else if (username == "" && password != "") {
        throw_usr()

    } else if (username != "" && password == "") {
        throw_pwd()

    } else {
        js$inner_html(
            id = paste0(id, "-form_status"),
            html = "Unable to login. Please try again."
        )
        js$add_css(id = paste0(id, "-form"), css = "invalid-all")
    }
}