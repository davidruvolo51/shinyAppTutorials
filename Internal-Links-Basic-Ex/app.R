#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-11-27
#' MODIFIED: 2019-11-01
#' PURPOSE: demonstration how to create links to other tabs in shiny
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: using index.js file located in www/js
#'//////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))

#'////////////////////////////////////////
# UI
ui <- tagList(
    
    # define <head>
    tags$head(

        # source js
        tags$script(type="text/javascript", src = "js/index.js"),

        # css
        tags$style(
            "a{cursor:pointer;}"
        )
    ),

    # define layout + content
    navbarPage(title = "Internal Links Demo",

               # tab 1 - home
               tabPanel("Home", value = "home", 
                        h1("Home"),
                        tags$a("Go to 'about' page", onclick="customHref('about')")
               ),
               # tab 2 - about 
               tabPanel("About", value = "about",
                        h1("About"),
                        tags$a("Go to 'contact me' page", onclick="customHref('contact')")
               ),
               
               # tab 3 - contact me
               tabPanel("Contact Me", value="contact",
                        tags$h1("Contact Me"),
                        tags$a("Go to 'home' page", onclick="customHref('home')")
                )
    ))

# SERVER
server <- function(input, output, session){
    # do something here    
}

# RUN APP
shinyApp(ui, server)