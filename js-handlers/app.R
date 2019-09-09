#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-09-06
#' MODIFIED: 2019-09-06
#' PURPOSE: ui for shiny app
#' PACKAGES: *see global*
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(

    # head
    tags$head(
        tags$meta("charset" ="utf-8"),
        tags$meta("http-equiv" ="X-UA-Compatible", "content" ="IE=edge"),
        tags$meta("name" ="viewport", "content"="width=device-width, initial-scale=1"),
        tags$link(type="text/css", rel="stylesheet", href="css/styles.css"),
        tags$title("Custom JS Handlers")
    ),

    # header
    tags$header(
        tags$output(id="themeStatus")
    ),


    # main content - manually set <main>
    HTML("<main>"),
        tags$section(`aria-labelledby`="title",
            tags$h1("Custom JS Handlers", id="title"),
            tags$p("This shiny app demonstrates how to create your own javascript functions and register them with shiny server. In this example, we created a simple javascript that toggles a css class and stores the user's selection to local storage, as well as display the selected theme in the top right corner. Click the button."),
            tags$button(id="toggle", class="action-button shiny-bound-input", "Toggle Theme")
        ),
    HTML("</main>"),
    
    # surprise for dark theme
    tags$div(class="surprise"),

    # load js
    tags$script(type="text/javascript", src="js/index.js")

)


# SERVER
server <- function(input, output, session){

    # set default theme
    session$sendCustomMessage(type="setDefaultTheme", "body")

    # event when button is clicked
    observeEvent(input$toggle, {
        session$sendCustomMessage(type="toggleTheme", "body")
    })    
}


# APP
shinyApp(ui, server)