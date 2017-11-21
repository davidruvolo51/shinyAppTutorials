library(shiny)

# UI
ui <- tagList(
    # link js
    tags$head((includeScript("app.js"))),
    tags$head(tags$style("a{cursor:pointer;}")),
    # BODY
    navbarPage(title = "Internal Links Demo",
               # tab 1 - home
               tabPanel("Home", value = "home", 
                        icon = icon("fa-home"),
                        h1("Some title here"),
                        p("...some cool stuff will go here..."),
                        tags$a("Go to 'other' tab", 
                               onclick="customHref('other')", 
                               class="btn btn-default")
               ),
               # tab 2 - other 
               tabPanel("Other", 
                        value = "other",
                        h1("Another title here"),
                        p("...some cool stuff will go here..."),
                        tags$a("Go to 'home' tab", 
                               onclick="customHref('home')", 
                               class="btn btn-default")
               )
    ))

# SERVER
server <- function(input, output, session){
    
}

# RUN APP
shinyApp(ui, server)