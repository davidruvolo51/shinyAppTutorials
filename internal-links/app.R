#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-03-17
#' MODIFIED: 2021-03-26
#' PURPOSE: creating links to other tabs in leaflet maps
#' STATUS: working
#' PACKAGES: shiny, leaflet
#' COMMENTS:
#' developed response to this question:
#' https://groups.google.com/forum/#!topic/shiny-discuss/fZORQAqkKsQ
#'//////////////////////////////////////////////////////////////////////////////


# packages
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(leaflet))

# make sample data
mapdf <- data.frame(
    location = c(
        "Central Park Zoo",
        "Guggenheim Museum",
        "Natural History Museum"
    ),
    lat = c(40.7678014, 40.7829208, 40.7813281),
    lng = c(-73.971908, -73.9590684, -73.974125),
    hrefValue = c("zoo", "guggenheim", "history")
)


# ui
ui <- tagList(
    tags$head(
        tags$script(type = "text/javascript", src = "js/index.js"),
        tags$style(
            "a {
                cursor:pointer;
            }",
            "img {
                display: block;
                max-width: 40%;
            }"
        )
    ),
    navbarPage(
        title = "Internal Links 1 | shinyAppTutorials",
        tabPanel(
            "Home",
            value = "home",
            tags$h1("Shiny Demo: A mini New York tourism map"),
            tags$p(
                "The purpose of this shiny app is to demonstrate how to ",
                "create links to other pages, tabs, panels, etc. in your ",
                "shiny app."
            ),
            leafletOutput("map")
        ),
        tabPanel(
            "Central Park Zoo",
            value = "zoo",
            tags$h1("Central Park Zoo"),
            tags$p("Photo by Fred Heap on Unsplash"),
            tags$p(
                "Would you like to go back? If so click ",
                tags$a(onclick = "customHref('home')", "here")
            ),
            tags$img(
                src = "imgs/tomas-eidsvold-qc9OKXKTETk-unsplash.jpg",
                alt = "a sea lion swimming in the water"
            ),
            tags$cite(
                "Photo by",
                tags$a(
                    href = "https://unsplash.com/@eidsvold",
                    "@eidsvold"
                ),
                "on unsplash."
            )
        ),
        tabPanel(
            "Guggenheim",
            value = "guggenheim",
            tags$h1("Guggenheim Museum"),
            tags$p(
                "Would you like to go back? If so click ",
                tags$a(onclick = "customHref('home')", "here")
            ),
            tags$img(
                src = "imgs/hector-arguello-canals-2x6vURol6cM-unsplash.jpg",
                alt = "high-top photography of building interior"
            ),
            tags$cite(
                "Photo by",
                tags$a(
                    href = "https://unsplash.com/@harguello",
                    "@harguello"
                ),
                "on unsplash."
            )
        ),
        tabPanel(
            "Natural History Museum",
            value = "history",
            tags$h1("Natural History Museum"),
            tags$p(
                "Would you like to go back? If so click ",
                tags$a(onclick = "customHref('home')", "here")
            ),
            tags$img(
                src = "imgs/aditya-vyas-BLkamCbE-so-unsplash.jpg",
                alt = "people standing besides dinosaur skeletons"
            ),
            tags$cite(
                "Photo by",
                tags$a(
                    href = "https://unsplash.com/@aditya1702",
                    "@aditya1702"
                ),
                "on unsplash."
            )
        )
    )
)

# server
server <- function(input, output) {
    output$map <- renderLeaflet({
        leaflet(data = mapdf) %>%
            setView(lat = 40.7752739,  lng = -73.9688518, zoom = 14) %>%
            addTiles() %>%
            addMarkers(
                lng = ~lng,
                lat = ~lat,
                popup = paste0(
                    "Learn more about the ",
                    "<a onclick=", "customHref('", mapdf$hrefValue, "')>",
                    mapdf$location,
                    "</a>"
                    )
                )
    })
}


shinyApp(ui, server)