
# set image urls -- replace with your own files
top_left <- "https://images.unsplash.com/photo-1495834041987-92052c2f2865?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3d771d2cc226047515072dba7a5f03bc&auto=format&fit=crop&w=1050&q=80"
top_right <- "https://images.unsplash.com/photo-1494088391210-792bbadb00f4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a421613e91c8475243ad4630171f4374&auto=format&fit=crop&w=1050&q=80"
bottom_left <- "https://images.unsplash.com/photo-1526411061437-7a7d51ec44c8?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e507916666b43919185fb16cf4e71813&auto=format&fit=crop&w=1050&q=80"
bottom_right <- "https://images.unsplash.com/photo-1525869916826-972885c91c1e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f7cce16b11befb3dc6ed56074727b7b6&auto=format&fit=crop&w=1050&q=80"


# pkgs
library(shiny)

# ui
ui <- tagList(
    
    #'////////////////////////////////////////
    # head + css
    tags$head(
        tags$link(href="app.css", rel="stylesheet", type="text/css")
    ),
    
    #'////////////////////////////////////////
    # UI
    shinyUI(
        
        # layout
        navbarPage(title = 'National Park',
                   
                   
                   # tab 1: landing page
                   tabPanel(title = "Home", 
                            
                            # parent container
                            tags$div(class="landing-wrapper",
                                     
                                     # child element 1: images
                                     tags$div(class="landing-block background-content",
                                              
                                              # top left
                                              img(src=top_left),
                                              
                                              # top right
                                              img(src=top_right),
                                              
                                              # bottom left
                                              img(src=bottom_left), 
                                              
                                              # bottom right
                                              
                                              img(src=bottom_right)
                                              
                                     ),
                                     
                                     # child element 2: content
                                     tags$div(class="landing-block foreground-content",
                                              tags$div(class="foreground-text",
                                                       tags$h1("Welcome"),
                                                       tags$p("This shiny app demonstrates
                                                     how to create a 2 x 2 layout
                                                              using css grid and
                                                              overlaying content."),
                                                       tags$p("Isn't this cool?"),
                                                       tags$p("Yes it is!")
                                              )
                                     )
                            )
                   ),
                   
                   #'////////////////////////////////////////
                   # tab 2: data
                   tabPanel(title = "Data")
        )
    )
)


# server
server <- shinyServer(function(input, output){
    
})


# app
shinyApp(ui, server)

