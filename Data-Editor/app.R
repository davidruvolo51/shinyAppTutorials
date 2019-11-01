#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-02-15
#' MODIFIED: 2019-11-01
#' PURPOSE: a data editor app in shiny
#' STATUS: working
#' PACKAGES: shiny, rhandsontable, DT, shinyjs, shinybs
#' COMMENTS: 
#'          The purpose of this app is to develop a method for editing data
#'          within a shiny app. To make this work, there's base file 
#'          'cars_data.RDs', which is the primary version. Click the 'edit'
#'          button to edit a column, update information, etc, and then click
#'          the 'save' button. The observeEvent input$yes checks to see if a
#'          current version of the base file ('cars_data.RDS') exists. If return
#'          == TRUE, then the version will be renamed with today's date and the
#'          modified df will be saved into the base file. Otherwise, the 
#'          cars_data.RDS will be initiated. This is to add a level of 'security'
#'          in the event you need to consult previous versions of the data.
#'//////////////////////////////////////////////////////////////////////////////

#' load packages
library(shiny)
library(rhandsontable)
library(DT)
library(shinyjs)
library(shinyBS)

#' cd = pwd
# setwd(getwd())

#' logic for loading data file
testFile <- "cars_data.rds"                  # primary data file

if(file.exists(testFile)){
    mtcarsDF <- readRDS("cars_data.rds")     # load data
} else {                                     # create new data
    mtcarsDF <- mtcars                       # bypass overwrite messages
    row.names(mtcarsDF) <- NULL              # null rownames and
    mtcarsDF$car <- row.names(mtcars)        # bring them into a new col
    mtcarsDF <- mtcarsDF[,c(12, 1:11)]       # re-order so cars are first
}

#'/////////////////////////////////////////////////////////////////////////////
## MAKE UI
ui <- shinyUI(
    
    # begin page
    fluidPage(
        
        # use shinyjs
        useShinyjs(),
        
        # title
        titlePanel("Data Editor"),
        
        # open sidebar layout - side + main
        sidebarLayout(
            
            # open sidebar panel
            sidebarPanel(
                
                # helper text
                helpText("What would you like to do?"),
                
                # button: view
                actionButton("view",label = "view", icon=icon("binoculars")),
                
                # button: edit
                actionButton("edit",label = "edit", icon=icon("pencil")),
                
                
                # button: cancel
                actionButton("cancel", label = "cancel", icon=icon("times")),
                
                # button: save
                actionButton("save", label = "save", icon=icon("save")),
                
                # button: refresh
                actionButton("refresh", label = "refresh", icon = icon("refresh")),
                
                # dialogue box: 'Are you sure you want to save changes?'
                bsModal(id = "saveChanges", 
                        title = "Do you want to save changes?",
                        trigger =  "save", 
                        size = "small",
                        
                        # inner well panel
                        wellPanel(
                            
                            # helper text
                            helpText("Saving will overwrite existing data! 
                                     This cannot be undone."),
                            
                            # button: no
                            actionButton(inputId = "no",
                                         label =  "No"),
                            
                            # button: yes
                            actionButton(inputId = "yes",
                                         label = "Yes")
                        )
                ),
                
                # dialogue box: 'Changes were saved'
                bsModal(id = "okay", 
                        title = "Save was successful!", 
                        trigger = "yes", 
                        size = "small",
                        
                        # inner content
                        wellPanel(
                            
                            # text
                            helpText("Changes were saved successfully. 
                                     Refresh the page for changes
                                     to take effect.")
                        )
                )
            ),
            
            # main panel
            mainPanel(
                
                # orientation text: current mode - view vs edit
                uiOutput("helperText"),
                hr(),
                
                # table outputs
                dataTableOutput("table"),
                rHandsontableOutput("hot")
            )
        )
    )
)


#'/////////////////////////////////////////////////////////////////////////////
## MAKE SERVER
server <- function(input, output, session){
    
    # orientation text: mode - view vs edit
    output$helperText <- renderUI({
        h3("View Mode")
    })
    
    # datatable: view
    output$table <- DT::renderDataTable({
        DT::datatable(mtcarsDF, selection="none")
    })
    
    # initiate values for edits
    values = reactiveValues()
    
    # by default hide the following buttons
    shinyjs::hide("cancel")
    shinyjs::hide("save")
    shinyjs::hide("refresh")
    
    # define refresh
    observeEvent(input$refresh, {
        shinyjs::runjs("history.go(0)")
    })
    
    ## when view or cancel, when present, is clicked
    observeEvent({
        input$view
        input$cancel
        },{
        shinyjs::show("view")
        shinyjs::show("edit")
        shinyjs::hide("cancel")
        shinyjs::hide("save")
        shinyjs::show("table")
        shinyjs::hide("hot")
        
        # modifying header text
        output$helperText <- renderUI({
            h3("View Mode")
        })
    })
    
    ## when edit is clicked
    observeEvent(input$edit, {
        shinyjs::hide("view")
        shinyjs::hide("edit")
        shinyjs::show("cancel")
        shinyjs::show("save")
        shinyjs::hide("table")
        shinyjs::show("hot")
        
        # update the helperText: "You are now in edit mode"
        output$helperText <- renderUI({
            h3("Data Edit Mode")
        })
        
        # make dataframe of edits
        data = reactive({
            if(!is.null(input$hot)){
                DF = hot_to_r(input$hot)
            } else {
                if(is.null(values[["DF"]])){
                    DF = data.frame(mtcarsDF)
                } else {
                    DF = values[["DF"]]
                }
            }
            
            values[["DF"]] = DF
            DF
            
        })
        
        ## generate HOT
        output$hot <- renderRHandsontable({
            DF = data()
            if (!is.null(DF))
                rhandsontable(DF, stretchH = "all")
        })
    })
    
    # When yes is clicked, save data as RDS
    observeEvent(input$yes,{
        
        # close popup 
        toggleModal(session, modalId = "saveChanges", toggle = "close")
        
        # isoloate changes and assign to new object,
        # and then the original df
        finalDF <- isolate(values[["DF"]])
        mtcarsDF <<- finalDF
        
        # save to RDS, but backup previous versions
        if(file.exists("cars_data.RDS")){
            
            # c = file prefix & date & RDS
            file.rename(from = "cars_data.RDS",
                        to = paste0(
                            # prefix
                            "cars_data_",
                            # system date formatted
                            format(Sys.time(),"%Y%m%d-%H%M%S"),
                            # extension
                            ".RDS")
            )
            
            # replace base file name with latest version
            saveRDS(mtcarsDF, file = "cars_data.RDS")
            
        } else{
            
            # save base file
            saveRDS(mtcarsDF, file = "cars_data.RDS")
        }
        
        # closing: hide save buttons
        shinyjs::hide("save")
        shinyjs::hide("cancel")
        shinyjs::show("refresh")
    })
    
}

#'/////////////////////////////////////////////////////////////////////////////
## RUN APP
shinyApp(ui = ui, server = server)



