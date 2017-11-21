# packages
library(shiny)
library(leaflet)

# make df for leaflet
mapDF <- data.frame(
    location = c("Central Park Zoo", "Guggenheim Museum", "Natural History Museum"),
    lat = c(40.7678014, 40.7829208, 40.7813281),
    lng = c(-73.971908, -73.9590684, -73.974125),
    hrefValue = c("zoo", "guggenheim", "history")
)

# ui
ui <- tagList(
    # link js
    tags$head(tags$link(includeScript("func.js"))),
    tags$head(tags$style("a{cursor:pointer;}")),
    # UI
    navbarPage(
        title = "Shiny Demo",
        #///////////////////////////////////////////////
        # Home
        tabPanel("Home",value ="home",
                 titlePanel("Shiny Demo: A mini New York tourism map"),
                 p("The purpose of this shiny app is to demonstrate how to create links
                   to other pages, tabs, panels, etc. in your shiny app."),
                 leafletOutput("map")
        ),
        #///////////////////////////////////////////////
        # Central Park Zoo
        tabPanel("Central Park Zoo",value="zoo",
                 titlePanel("Central Park Zoo"),
                 tags$a("data-flickr-embed"="true",
                        href="https://www.flickr.com/photos/paulakoala/5889405633/in/album-72157627088736680/",
                        title="Central Park Zoo Entrance",
                        img(src="https://farm7.staticflickr.com/6047/5889405633_11dddf7208_n.jpg",
                            width="640", height="393", alt="Central Park Zoo Entrance")),
                 tags$script("async", src="//embedr.flickr.com/assets/client-code.js", charset="utf-8"),
                 helpText("Would you like to go back? If so click ", 
                          HTML("<a onclick=","customHref('home')" ,">",
                               "here","</a>"))),
        
        #///////////////////////////////////////////////
        # Guggenheim
        tabPanel("Guggenheim",value="guggenheim",
                 titlePanel("Guggenheim Museum"),
                 tags$a("data-flickr-embed" ="true",  
                        href="https://www.flickr.com/photos/88017382@N00/7799729420", 
                        title="The Solomon R. Guggenheim Museum", 
                        img(src="https://farm9.staticflickr.com/8442/7799729420_908211ebc1_n.jpg", 
                            width="640", height="393", alt="The Solomon R. Guggenheim Museum")),
                 tags$script("async", src="//embedr.flickr.com/assets/client-code.js", charset="utf-8"),
                 helpText("Would you like to go back? If so click ", 
                          HTML("<a onclick=","customHref('home')" ,">",
                               "here","</a>"))),
        
        #///////////////////////////////////////////////
        # American Museum of Natural History
        tabPanel("Natural History Museum",value="history",
                 titlePanel("Natural History Museum"),
                 tags$a("data-flickr-embed" = "true",
                        href="https://www.flickr.com/photos/29394931@N06/6123226397/in/photolist-ak68SV-UH51Uq-UH51RQ-V3JdUQ-cFVHcY-U9Lfmz-TLkm2J-QNi6eY-V3SQGW-TLkmfj-V6swR4-W1Ta7o-9vcbAQ-V3JcPo-UH54Ef-TLhceu-T4TkAE-V3SRSm-V3JcgE-UH55pw-UH54eW-V3SSrC-UH55tu-V6AEKV-eeJ18L-V3JapU-TLkkEm-VvNUdd-UH51wG-V3SScj-VeLUDd-97BS9N-UH51p7-rZrMEq-sgS2RQ-ae5Hm7-iFnZRH-sDx51X-nKPZez-6QSYne-V3JbVj-V6stCa-mwNN6E-V3JdrL-9vccqw-UH4Xys-7sTCCL-V6AFmK-V3SR1m-UH53yY",
                        title="American Museum of Natural History, New York",
                        img(src="https://farm7.staticflickr.com/6197/6123226397_f0e03fca6b_n.jpg",
                            width="640", height="393",alt="American Museum of Natural History, New York")),
                 tags$script("async",src="//embedr.flickr.com/assets/client-code.js",charset="utf-8"),
                 helpText("Would you like to go back? If so click ", 
                          HTML("<a onclick=","customHref('home')" ,">",
                               "here","</a>")))
    )
)

# server
server <- function(input, output){
    
    # make map
    output$map <- renderLeaflet({
        leaflet(data = mapDF) %>%
            setView(
                lat = 40.7752739, 
                lng = -73.9688518,
                zoom = 14) %>%
            addTiles() %>%
            addMarkers(lng = ~lng , lat = ~lat,
                       popup = paste0(
                           "Learn more about the ",
                           "<a onclick=","customHref('",mapDF$hrefValue,"')>",
                           mapDF$location,
                           "</a>"
                       ))
    })
}

# launch
shinyApp(ui, server)