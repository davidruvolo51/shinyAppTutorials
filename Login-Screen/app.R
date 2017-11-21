#'=====================================
#' FILE: shiny_custom_login.R
#' AUTHOR: David Ruvolo
#' CREATED: July 2016
#' PURPOSE: Quick and dirty login screen
#'          for non-shiny pro users
#' REFS: Adapted from https://stackoverflow.com/questions/28987622/starting-shiny-app-after-password-input
#'=====================================
library(shiny)
#===========
## FUNCTIONS
#===========
## SIMPLE GREETING
good_time <- function(){
    
    ## LOAD PACKAGE
    require(lubridate, quietly = T)
    
    ## ISOLATE currHour
    currhour = hour(now())
    
    ## RUN LOGIC
    if(currhour < 12){
        return("good morning")
    } 
    else if(currhour >= 12 & currhour < 17){
        return("good afternoon")
    }
    else if( currhour >= 17){
        return("good evening")
    }
}

#==============
## DEFINE USERS
#==============
## Insert googlesheets reference here, if applicable
users <- data.frame("User" = c("user", "admin", "test"),
                    "Password" = c("password", "admin", "test"))

## STARTING LOGGED VALUE; LET'S CHANGE THAT!
Logged = FALSE;

#====
# UI
#====
## make login screen
ui1 <- function(){
    tagList(
        div(id="container",
            div(id = "login",
                # make login panel
                wellPanel(id="well",
                          HTML(paste0('
                                <h2>
                                Hello, ', good_time(),
                                      '</h2>',
                                      '<h3>
                                <br>Sign in to your account.
                                </h3>')
                          ),
                          br(),
                          textInput("userName", "Username"),
                          passwordInput("passwd", "Password")
                ),
                # button
                actionButton("Login", "Log in"),
                # login error message
                uiOutput("message")
            )
        ),
        # css for container
        tags$style(type = "text/css", 
                   "#container{
                   display: flex;
                   justify-content: center;
                   margin-top: 150px;
                   }"),
        # css for login well panel
        tags$style(type="text/css", "
                   #login{
                   font-size:14px; 
                   width: 360px;}"),
        # well panel
        tags$style(type="text/css",
                   "#well{
                    background: #ffffff;
                   border: none;
                   box-shadow: none;}"),
        # welcome text css
        tags$style(type = 'text/css',
                   "h2, h3{
                   color: #525252;}"),
        # input fields
        tags$style(type="text/css",
                   "#userName, #passwd{
                        box-shadow: none;
                        outline:none;
                        border: none;
                        padding-left: 0;
                        border-bottom: 2px solid #0A81D1;
                        border-radius: 0;
                   }
                   #userName:focus, #passwd:focus{
                   box-shadow: 0px 10px 10px -5px lightgray;
                   }"),
        # button css
        tags$style(type='text/css',
                   "#Login{
                    outline: none;
                   margin-left: 240px;
                   width: 100px;
                   font-size: 12pt;
                   background: transparent;
                   border: 2px solid #0A81D1;
                   color: #0A81D1;
                   border-radius: 10px;
                   transition: 0.8s ease-in-out;
                   }
                   #Login:hover{
                   background: rgb(10,129,209);
                   color: white;}"),
        # error box - fadeOut animation
        tags$style(type="text/css",
                   "@-webkit-keyframes fadeOut {
                        from {
                            opacity: 1;
                        }
                        to {
                            opacity: 0;
                        }
                    }
                    @keyframes fadeOut {
                        from {
                            opacity: 1;
                        }
                        to {
                            opacity: 0;
                        }
                    }"),
        tags$style(type="text/css",
                   "#error-box{
                   margin-top: 20px;
                   margin-left: 20px;
                   padding: 5px 10px 5px 10px;
                   text-align: center;
                   width: 325px;
                   color: white;
                   background: #ef3b2c;
                   border: 1px solid #ef3b2c;
                   border-radius: 5px;
                   -webkit-animation: fadeOut;
                   animation: fadeOut;
                   opacity: 0;
                   animation-duration: 7.5s;}")
    )
}

#=========
# PRINT UI
#=========
ui = (uiOutput("page"))

#========
# SERVER
#========
server = shinyServer(function(input, output,session){
    
    ## BEGIN BUILD LOG IN SCREEN
    USER <- reactiveValues(Logged = Logged)
    
    ## ERROR CHECKING
    observeEvent(input$Login,{
        
        ## output error message
        output$message <- renderUI({
            if(!is.null(input$Login)){
                my_username <- length(users$User[grep(pattern = input$userName, x = users$User)])
                my_password <- length(users$User[grep(pattern = input$passwd, x = users$Password)])
                if(input$Login > 0){
                    if(my_username < 1 ||  my_password < 1){
                        HTML("<div id='error-box'>
                             Sorry, that's not the right username or password. Please, 
                             try again. If you continue to have problems, contact
                             <a href='#'>
                             <u>helpdesk@yoursupport.com</u></a>
                             </div>")
                    }
                }
            }
        })
        
        ## CHECK INPUT
        if (USER$Logged == FALSE) {
            if (!is.null(input$Login)) {
                if (input$Login > 0) {
                    Username <- isolate(input$userName)
                    Password <- isolate(input$passwd)
                    Id.username <- which(users$User == Username)
                    Id.password <- which(users$Password == Password)
                    if (length(Id.username) > 0 & length(Id.password) > 0) {
                        if (Id.username %in% Id.password) {
                            USER$Logged <- TRUE
                        }
                    }
                }
            }
        }
    })
    
    ## Make UI
    observe({
        # What to do when logged = F
        if (USER$Logged == FALSE) {
            
            output$page <- renderUI({
                div(class="outer",do.call(bootstrapPage,c("",ui1())))
            })
        }
        
        # Render UI when logged = T
        if (USER$Logged == TRUE) 
        {
            ## get the current user's authorization level 
            user_log <- toupper(input$userName)
            
            # if admin
            if(user_log == "ADMIN"){
                output$page <- renderUI({
                    fluidPage(style="margin: 0; padding: 0;",
                              div(class="jumbotron",
                                  h1("Welcome!", style="margin-top: 20%;"), 
                                  h3("You've made it."),
                                  p("You are signed in as an admin. 
                                    Refresh the app to sign in as a different user."), 
                                  style="height:100vh; 
                                  width:100v;
                                  background: #BE7C4D; 
                                  color: white;
                                  border-radius: 0;
                                  overflow-x:none; 
                                  overflow-y:none;")
                    )
                })
            }
            
            # if standard user
            else{
                output$page <- renderUI({
                    fluidPage(style="margin: 0; padding: 0;",
                        # title
                        div(class="jumbotron",
                            h1("Welcome!", style="margin-top: 20%;"), 
                            h3("You've made it."),
                            p("You are signed in as a regular user.
                              Refresh the app to sign in as a different user."), 
                            style="height:100vh; 
                            width:100v;
                            background: #0A81D1; 
                            color: white;
                            border-radius: 0;
                            overflow-x:none;
                            overflow-y:none;")
                    )
                })
            }
        }
    })
}) # END SHINYAPP

#======
# RUN
#======
shinyApp(ui = ui, server = server)
