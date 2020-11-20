#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-02-15
#' MODIFIED: 2020-11-20
#' PURPOSE: a data editor app in shiny
#' STATUS: working
#' PACKAGES: shiny, rhandsontable, DT, shinyjs, shinybs
#' COMMENTS:
#' The purpose of this app is to develop a method for editing data
#' within a shiny app. To make this work, there's base file
#' 'nyc_dogs.RDS', which is the primary version. Click the 'edit'
#' button to edit a column, update information, etc, and then click
#' the 'save' button. The observeEvent input$yes checks to see if a
#' current version of the base file ('nyc_dogs.RDS') exists. If return
#' == TRUE, then the version will be renamed with today's date and the
#' modified df will be saved into the base file. Otherwise, the
#' nyc_dogs.RDS will be initiated. This is to add a level of 'security'
#' in the event you need to consult previous versions of the data.
#'//////////////////////////////////////////////////////////////////////////////

#' load packages
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinyBS))

ui <- fluidPage(
    shinyjs::useShinyjs(),

    # dialogue box: 'Are you sure you want to save changes?'
    shinyBS::bsModal(
        id = "savePrompt",
        title = "Do you want to save changes?",
        trigger = "save",
        size = "small",
        wellPanel(
            helpText(
                "Saving will overwrite existing data! This cannot be undone."
            ),
            actionButton(
                inputId = "no",
                label =  "No"
            ),
            actionButton(
                inputId = "yes",
                label = "Yes"
            )
        )
    ),

    # dialogue box: 'Changes were saved'
    shinyBS::bsModal(
        id = "saveSuccess",
        title = "Save was successful!",
        trigger = "yes",
        size = "small",
        wellPanel(
            helpText(
                "Changes were saved successfully. Refresh the page for changes to take effect."
            )
        )
    ),
    titlePanel("Data Editor"),
    sidebarLayout(
        sidebarPanel(
            helpText("What would you like to do?"),

            # buttons: view, edit, cancel, save, refresh
            actionButton("view", label = "view", icon = icon("binoculars")),
            actionButton("edit", label = "edit", icon = icon("pencil")),
            shinyjs::hidden(
                actionButton("cancel", label = "cancel", icon = icon("times")),
                actionButton("save", label = "save", icon = icon("save")),
                actionButton(
                    "refresh",
                    label = "refresh",
                    icon = icon("refresh")
                )
            )
        ),
        mainPanel(
            tags$h2(textOutput("helperText")),
            DT::dataTableOutput("dt_view"),
            rhandsontable::rHandsontableOutput("dt_edit")
        )
    )
)

# server
server <- function(input, output, session) {

    # load data
    nycDogs <- readRDS("data/nyc_dogs.RDS")

    #'////////////////////////////////////////
    # SET APP DEFAULTS

    # orientation text: mode - view vs edit
    output$helperText <- renderText("View Mode")

    # datatable default render
    output$dt_view <- DT::renderDataTable({
        DT::datatable(nycDogs, selection = "none")
    })

    # initiate values for edits
    values <- reactiveValues()

    # define refresh
    observeEvent(input$refresh, {
        shinyjs::runjs("history.go(0)")
    })

    #'////////////////////////////////////////

    ## when view or cancel, when present, is clicked
    observeEvent({
        input$view
        input$cancel
        }, {
        shinyjs::show("view")
        shinyjs::show("edit")
        shinyjs::hide("cancel")
        shinyjs::hide("save")
        shinyjs::show("dt_view")
        shinyjs::hide("dt_edit")

        # modifying header text
        output$helperText <- renderText("View Mode")
    })

    ## when edit is clicked
    observeEvent(input$edit, {
        shinyjs::hide("view")
        shinyjs::hide("edit")
        shinyjs::show("cancel")
        shinyjs::show("save")
        shinyjs::hide("dt_view")
        shinyjs::show("dt_edit")

        # update the helperText: "You are now in edit mode"
        output$helperText <- renderText("Edit Mode")

        # make dataframe of edits
        data <- reactive({
            if (!is.null(input$dt_edit)) {
                DF <- rhandsontable::hot_to_r(input$dt_edit)
            } else {
                if(is.null(values[["DF"]])) {
                    DF <- data.frame(nycDogs)
                } else {
                    DF <- values[["DF"]]
                }
            }
            values[["DF"]] <- DF
            DF
        })

        # render table
        output$dt_edit <- rhandsontable::renderRHandsontable({
            DF <- data()
            if (!is.null(DF)) {
                rhandsontable::rhandsontable(DF, stretchH = "all")
            }
        })
    })

    #' onclick: yes
    #' when `yes` is clicked, do the following
    #'   - close the modal
    #'   - isolate changes
    #'   - if file exists, create an archived version
    #'   - or save new file
    #'   - hide buttons
    observeEvent(input$yes, {
        shinyBS::toggleModal(session, modalId = "savePrompt", toggle = "close")

        # isoloate changes and assign to new object,
        # and then the original df
        out <- isolate(values[["DF"]])

        # save to RDS, but backup previous versions
        if (file.exists("data/nyc_dogs.RDS")) {
            file.rename(
                from = "data/nyc_dogs.RDS",
                to = paste0(
                    "data/archive/nyc_dogs_",
                    format(Sys.time(), "%Y%m%d-%H%M%S"),
                    ".RDS"
                )
            )
            saveRDS(out, "data/nyc_dogs.RDS")
        } else {
            saveRDS(out, "data/nyc_dogs.RDS")
        }

        # closing: hide save buttons
        shinyjs::hide("save")
        shinyjs::hide("cancel")
        shinyjs::show("refresh")
    })
}

# app
shinyApp(ui, server)
