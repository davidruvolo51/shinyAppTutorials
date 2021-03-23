#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-11-27
#' MODIFIED: 2021-03-23
#' PURPOSE: demonstration how to create links to other tabs in shiny
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: using index.js file located in www/js
#'//////////////////////////////////////////////////////////////////////////////


suppressPackageStartupMessages(library(shiny))

ui <- tagList(
    tags$head(
        tags$script(type = "text/javascript", src = "js/index.js"),
        tags$style(type = "text/css", "a {cursor:pointer;}")
    ),
    navbarPage(
        title = "Internal Links Demo",
        tabPanel(
            "Home",
            value = "home",
            h1("Home"),
            tags$a("Go to 'about' page", onclick = "customHref('about')")
        ),
        tabPanel(
            "About",
            value = "about",
            h1("About"),
            tags$a("Go to 'contact me' page", onclick = "customHref('contact')")
        ),
        tabPanel("Contact Me", value = "contact",
            tags$h1("Contact Me"),
            tags$a("Go to 'home' page", onclick = "customHref('home')")
        )
    )
)


server <- function(input, output, session) {
}


shinyApp(ui, server)