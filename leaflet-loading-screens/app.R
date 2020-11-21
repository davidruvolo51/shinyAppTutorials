#'/////////////////////////////////////////////////////////////////////////////
#' FILE: leaflet-on-render-app.R (generic loading)
#' AUTHOR: @dcruvolo
#' CREATED: 2020-04-01
#' MODIFIED: 2020-11-20
#' PACKAGES: shiny, leaflet
#' STATUS: working
#' PURPOSE: creating busy screens for leaflet maps in shiny
#' COMMENTS: click `Run App` to view the app in the viewer pane
#'/////////////////////////////////////////////////////////////////////////////

# pkgs
library(shiny)
library(leaflet)
library(htmlwidgets)

# ui
ui <- tagList(
    tags$head(
        tags$link(
            rel = "stylesheet",
            href = "styles.css"
        )
    ),
    tags$main(
        tags$h2("Map Output"),
        tags$button(
            id = "plotbutton",
            class = "action-button shiny-bound-input",
            "Add Markers"
        ),

        # leaflet map inside loading container
        loading_message(
            id = "leafletBusy",
            leafletOutput("map")
        )
    )
)

#'/////////////////////////////////////

# server
server <- function(input, output, session) {
    # render map
    output$map <- renderLeaflet({
        # simulate building
        # build map
        leaflet() %>%
            addTiles() %>%
            setView(-93.65, 42.0285, zoom = 17) %>%
            addPopups(
                lng = -93.65,
                lat = 42.0285,
                popup = "Here is the <b>Department of Statistics</b>, ISU"
            ) %>%
            onRender(., "
                function(el, x, data) {
                    // select map, loader, button
                    var m = this;
                    const elem = document.getElementById('leafletBusy');
                    const b = document.getElementById('plotbutton');

                    // when map is rendered, display loading
                    // adjust delay as needed
                    m.whenReady(function() {
                        elem.classList.remove('visually-hidden');
                        setTimeout(function() {
                            elem.classList.add('visually-hidden');
                        }, 3000)
                    });

                    // click event
                    b.addEventListener('click', function(event) {

                        // show loading element
                        elem.classList.remove('visually-hidden');
                        (new Promise(function(resolve, reject) {

                            // leaflet event: layeradd
                            m.addEventListener('layeradd', function(event) {
                                console.log(event.type)
                                // resolve after a few seconds to ensure all
                                // elements rendered (adjust as needed)
                                // time is in milliseconds
                                setTimeout(function() {
                                    resolve('done');
                                }, 500)
                            })
                        })).then(function(response) {

                            // resolve: hide loading screen
                            console.log('done');
                            elem.classList.add('visually-hidden');

                        }).catch(function(error) {

                            // throw errors
                            console.error(error);
                        });
                    });
                }")
    })

    # add points on render
    observeEvent(input$plotbutton, {
        dlat <- 1 / 111000 * 100 # degrees per metre
        n <- 100
        leafletProxy("map") %>%
            addMarkers(
                lng = -93.65 + (runif(n) * 2 - 1) * dlat * 3,
                lat = 42.0285 + (runif(n) * 2 - 1) * dlat
            )
    })
}

#'/////////////////////////////////////

# app
shinyApp(ui = ui, server = server)