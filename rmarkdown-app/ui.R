#'//////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 22 May 2018
#' MODIFIED: 22 May 2018
#' PURPOSE: ui
#' PACKAGES: shiny
#' STATUS: working + complete
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

# ui
shinyUI(
    
    # begin ui
    fluidPage(
        
        shinyjs::useShinyjs(),
        
        # panel: title
        titlePanel("Rmarkdown + Shiny Example"),
        
        # sidebar layout
        sidebarLayout(
            
            #'////////////////////////////////////////
            # panel
            sidebarPanel(
                tags$h3("Options"),
                # filter state
                selectInput(inputId = "state",
                            label = "Choose a state",
                            choices = c("Choose a state",
                                        unique(librarians$prim_state)),
                            multiple = FALSE),
                
                # button
                actionButton(inputId = "report",label="View Report")
            ),
            
            
            #'////////////////////////////////////////
            # main
            mainPanel(
                # show loading screen
                shinyjs::hidden(
                    tags$div(id="loading",
                             tags$h1("Loading...")),
                    tags$style("#loading{position:absolute;}")
                ),
                
                # report
                tags$div(id="report-wrapper",
                         tags$style("#report-wrapper p{font-size:14pt;}"),
                         htmlOutput("renderedReport")
                )
            )
        )
    )
)