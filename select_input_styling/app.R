#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' CREATED: 16 August 2018
#' MODIFIED: 04 November 2019
#' PURPOSE: demo for custom styling of <select> input
#' PACKAGES: shiny
#' STATUS: working + complete;
#' COMMENTS: see comments in www/css/styles.css for information on css
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(shiny))

# app
shinyApp(
    ui = fluidPage(
        
        # head
        tags$head(
            tags$link(type="text/css",href="css/styles.css",rel="stylesheet")
        ),
        
        #'////////////////////////////////////////
        # layout: 1 row X 2 columns
        
        # title
        tags$h1("Customizing", tags$code("<select>")," with CSS"),
        
        # sidebar
        sidebarPanel(
            
            
            # label
            tags$label("for"="state", "Select a State", class="input-label"),
            
            # input
            tags$select(id="state",
                        
                        # default
                        tags$option(value = "none", ""),
                        
                        # east coast
                        tags$optgroup("label" = "East Coast",
                            tags$option(value = "NY", "NY"),
                            tags$option(value = "NJ", "NJ"),
                            tags$option(value = "CT", "CT")
                        ),
                        
                        # west coast
                        tags$optgroup("label" = "West Coast",
                            tags$option(value = "WA","WA"),
                            tags$option(value = "OR","OR"),
                            tags$option(value = "CA","CA")
                        ),
                        
                        # midwest
                        tags$optgroup("label" = "Midwest",
                            tags$option(value = "MN","MN"),
                            tags$option(value = "WI","WI"),
                            tags$option(value = "IA","IA")
                        )
            )
        ),
        
        #'////////////////////////////////////////
        # main panel
        mainPanel(
            # output result
            tags$h2("Your Selection:"),
            textOutput("selection")
        ),

        # load js
        tags$script(type="text/javascript", src="js/index.js")
        
    ),

    # server
    server = function(input, output) {
        
        output$selection <- renderText(
            input$state
        )
        
    },
    
    # run app options
    options = list(launch.browser=TRUE)
)
