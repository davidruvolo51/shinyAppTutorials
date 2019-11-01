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
                        icon = icon("fa-home"),
                        h1("Some title here"),
                        p("...some cool stuff will go here..."),
                        tags$a("Go to 'other' tab", onclick="customHref('other')", class="btn btn-default")
               ),
               # tab 2 - other 
               tabPanel("Other", 
                        value = "other",
                        h1("Another title here"),
                        p("...some cool stuff will go here..."),
                        tags$a("Go to 'home' tab", onclick="customHref('home')", class="btn btn-default")
               )
    ))

# SERVER
server <- function(input, output, session){
    # do something here    
}

# RUN APP
shinyApp(ui, server)