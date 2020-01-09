#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2020-01-08
#' PURPOSE: create responsive datatables in shiny
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(dplyr))


# load assets
birds <- readRDS("data/birds_summary.RDS")

# client
ui <- tagList(
    tags$head(
        tags$link(type="text/css", rel="stylesheet", href="css/styles.css"),
        tags$title("Responsive Datatables")
    ),
    tags$body(
            
        # <header>
        tags$header(class="header", 
            tags$h1("shinyTutorials")
        ),

        # <main>
        tags$main(class="main", 
            tags$section(class="section",
                tags$h2("Responsive datatables in shiny"),
                tags$p("This application demonstrates how to create response datatables in shiny. The custom function datatable() renders the required table elements and adds data to html elements using `data` attributes. The data attributes can then be used as restructure tables using css pseudo elements. In this example, I'm using data from birdData Australia. The data is the top 25 most commonly reported birds in 2018 Birds in Backyards program. Resize the browser to see this in action!"),
                uiOutput("table")
            )
        )
    )
)

# server
server <- function(input,output, session){

    # source function
    source("scripts/datatable.R")

    # render datatable
    output$table <- renderUI({

        # summarize data and pass to datatable function
        birds2018 <- birds %>% filter(Year == "2018") %>% arrange(-Count) %>% slice(1:25)
        datatable(data = birds2018, caption = "Top 25 Birds in 2018")

    })
}

# app
shinyApp(ui, server)