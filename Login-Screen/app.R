#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2016-07-01
#' MODIFIED: 2019-11-04
#' PURPOSE: login screen example
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# GLOBAL OPTS
options(stringsAsFactors=FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(sodium))

#'////////////////////////////////////////
# build users data.frame
# create in a separate file and save users data
# to RDS file; load in outside of server 

# define users
users <- data.frame(
    "username" = c("user", "admin"),
    "password" = c("user1234", "admin1234"),
    stringsAsFactors = FALSE
)

# sodium password
users$password <- sapply(users$password, password_store )


#'////////////////////////////////////////
# Create UIs

# sign in form
signin <- tagList(
    tags$main(class="main signin-screen",

        # create a form
        tags$form(class="signin-form",

            # create a title for the form
            tags$legend("Sign in to your account"),
            tags$output(id="form_status", class="error-message"),

            # inputs
            tags$label(`for`="username", "Enter your username"),
            tags$input(type="text", id="username"),
            tags$output(id="user_status", class="error-message"),
            
            tags$label(`for`="password", "Enter your password"),
            tags$input(type="password", id="password"),

            # submit button
            tags$button(id="submit", type="submit", "Submit", class="action-button shiny-bound-input")
        )
    )
)


# sucess screen
main <- function(username){
    tagList(
        tags$main(class="main",
            tags$header(class="header",
                tags$h1("Welcome,", tags$span(username), "!"),
                tags$p("You are now signed in."),
                actionButton(inputId="signout", "Sign out")
            )
        )
    )
}

#'////////////////////////////////////////
# UI
# the ui is rendered server side
ui <- tagList(

    # <head>
    tags$head(
        tags$link(type="text/css", rel="stylesheet", href="css/styles.css")
    ),

    # app output
    uiOutput("app"),

    # load script
    tags$script(type="text/javascript", src="js/index.js")
)

#'////////////////////////////////////////

# SERVER
server <- function(input, output, session){

    #'////////////////////////////////////////
        
    # session handler for update innerHTML
    innerHTML <- function(id, string){
        session$sendCustomMessage(type="innerHTML", list(id, string))
    }

    # define reactive values
    username <- reactiveVal(NA)
    logged <- reactiveVal(FALSE)

    #'////////////////////////////////////////
    # process input
    observeEvent(input$submit, {

        # reset all form statuses
        innerHTML(id="form_status", "")
        innerHTML(id="user_status", "")

        # search users for match this returns row.index
        # use it to verify password via sodium's password_verify function
        usr <- which(users$username == input$username)
        
        # logic for form validation
        if( input$username == "" || input$password == ""){
            innerHTML(id="form_status","One or more fields are empty. All fields are required.")
        } else if( length(usr) > 0) {

            # validate password
            pwd <- password_verify(users$password[usr], input$password)

            # password logic
            if( pwd ){
                username(input$username)
                logged(TRUE)
            } else {
                innerHTML(id="form_status", string="The username or password was incorrect")
            }
        }  else if( length(usr) == 0 ){
            innerHTML(id="user_status", "The username is incorrect")
        } else {
            innerHTML(id="form_status", "The username or password is incorrect")
        }
    })

    #'////////////////////////////////////////
    # render UIs based on logged status
    observe({
        if( !logged() ){
            output$app <- renderUI(signin)
        } else {
            output$app <- renderUI({
                main(username())
            })
        }
    })
    #'////////////////////////////////////////
    # sign out event
    observeEvent(input$signout, {
        logged(FALSE)
    })


}

# APP
shinyApp(ui, server)