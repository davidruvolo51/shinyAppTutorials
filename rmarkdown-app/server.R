#'//////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 22 May 2018
#' MODIFIED: 22 May 2018
#' PURPOSE: server
#' PACKAGES: shiny
#' STATUS: working + complete
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

# server
shinyServer(function(input,output){
    
    
    observeEvent(input$report,{
        
        # show/hide divs
        shinyjs::hide(id="report-wrapper")
        shinyjs::show(id="loading")
        
        # apply filter to data
        if(input$state == "Choose a state"){
            
            # if nothing selected return full data
            librariansSubset <- librarians
            
        } else {
            
            # otherwise apply filter
            librariansSubset <- librarians %>% 
                filter(prim_state == input$state)
            
        }
        
        # hide loading
        Sys.sleep(2)   # simulate rendering of larger files
        shinyjs::hide(id="loading",anim = TRUE,animType = "fade",time = .8)
        
        # render report
        output$renderedReport <- renderUI({
            
            includeMarkdown(knitr::knit("report_template.Rmd"))
            
        })
        
        # show report
        shinyjs::show(id="report-wrapper", anim = T, animType = "fade",time=.8)
        
    })
    
})