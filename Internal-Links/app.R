#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-03-17
#' MODIFIED: 2019-11-01
#' PURPOSE: creating links to other tabs in leaflet maps
#' STATUS: working
#' PACKAGES: shiny, leaflet
#' COMMENTS:
#'  In response to this question: https://groups.google.com/forum/#!topic/shiny-discuss/fZORQAqkKsQ
#'//////////////////////////////////////////////////////////////////////////////
#' OPTIONS
options(stringsAsFactors = FALSE)

# packages
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(leaflet))

# make df for leaflet
mapDF <- data.frame(
    location = c("Central Park Zoo", "Guggenheim Museum", "Natural History Museum"),
    lat = c(40.7678014, 40.7829208, 40.7813281),
    lng = c(-73.971908, -73.9590684, -73.974125),
    hrefValue = c("zoo", "guggenheim", "history")
)

# app
ui <- tagList(
    
    # head
    tags$head(
        
        # javascript
        tags$script(type="text/javascript", src="js/index.js"),
        
        # css
        tags$style(
            "a{cursor:pointer;}",
            "img{ display: block; max-width: 60%; }"
        )
    ),
    
    # UI
    navbarPage(
        title = "Shiny Demo",
        #///////////////////////////////////////////////
        # Home
        tabPanel("Home",value ="home",
                 tags$h1("Shiny Demo: A mini New York tourism map"),
                 p("The purpose of this shiny app is to demonstrate how to create links to other pages, tabs, panels, etc. in your shiny app."),
                 leafletOutput("map")
        ),
        #///////////////////////////////////////////////
        # Central Park Zoo
        tabPanel("Central Park Zoo",value="zoo",
                 tags$h1("Central Park Zoo"),
                 tags$p("Photo by Fred Heap on Unsplash"),
                 tags$p("Would you like to go back? If so click ", HTML("<a onclick=","customHref('home')" ,">","here","</a>")),
                 tags$img(src="https://images.unsplash.com/photo-1525125804400-4b77d2bc5ada?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1137&q=80", alt="a sea lion swimming in the water")
        ),
        
        #///////////////////////////////////////////////
        # Guggenheim
        tabPanel("Guggenheim",value="guggenheim",
                 tags$h1("Guggenheim Museum"),
                 tags$p("Photo by Leslie Holder on Unsplash"),
                 tags$p("Would you like to go back? If so click ", HTML("<a onclick=","customHref('home')" ,">","here","</a>")),
                 tags$img(src="https://images.unsplash.com/photo-1518418360632-725a012d9c3d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80", alt="high-top photography of building interior")
        ),
        
        #///////////////////////////////////////////////
        # American Museum of Natural History
        tabPanel("Natural History Museum",value="history",
                 tags$h1("Natural History Museum"),
                 tags$p("Photo by Aditya Vyas on Unsplash"),
                 tags$p("Would you like to go back? If so click ", HTML("<a onclick=","customHref('home')" ,">", "here","</a>")),
                 tags$img(src="https://images.unsplash.com/photo-1539233487784-1a29074b0f57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80", alt="people standing besides dinosaur skeletons")
        )
    )
)

#'////////////////////////////////////////
# server
server <- function(input, output){
    
    # make map
    output$map <- renderLeaflet({
        leaflet(data = mapDF) %>%
            setView( lat = 40.7752739,  lng = -73.9688518, zoom = 14) %>%
            addTiles() %>%
            addMarkers(lng = ~lng , lat = ~lat, popup = paste0("Learn more about the ", "<a onclick=","customHref('",mapDF$hrefValue,"')>", mapDF$location,"</a>"))
    })
}

# run app
shinyApp(ui, server)