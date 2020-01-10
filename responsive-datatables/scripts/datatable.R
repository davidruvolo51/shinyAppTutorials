#'//////////////////////////////////////////////////////////////////////////////
#' FILE: datatable.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2020-01-10
#' PURPOSE: build datatable function and helpers
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS:
#'      The datatable function generates an html table from a dataset. 
#'      This function returns a shiny tagList object which can be used in shiny 
#'      applications, markdown documents, or written to an html file. The 
#'      datatable function takes the following arguments.
#' 
#'      ARGUMENTS:
#'      - data: the input dataset
#'      - id: an unique identifier for the table ideal for styling specific tables
#'            or for selecting tables in js (e.g., "summary_table", "resultsTable")
#'      - caption: a title for the table (recommended for accessible tables)
#'      - options: a list of configurations that control the rendering of the table
#'          - responsive: a logical argument for turning on/off the rendering of 
#'                        additional elements for responsive tables (i.e., span).
#'                        (Default = FALSE)
#' 
#'      ABOUT:
#'      The datatable function requires two helper functions: 1) to generate the
#'      table header and another used 2) to generate the table body. The function
#'      build_header() renders the <thead> element according to the input dataset.
#'      The build_body functions renders the table's <tbody> based on the input
#'      and the options. This function uses a nested lapplys to iterate each row
#'      and cell. If the responsive option is TRUE, then the function will return
#'      a <span> element with the current cell's column name. The span element has
#'      the class `hidden-colname` which hides or shows the element based on screen
#'      size (see datatable.css). Role attributes are added by default in the event
#'      the display properties are altered.
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

#'////////////////////////////////////////

# ~ 1 ~
# DEFINE HELPER FUNCTIONS
datatable_helpers <- list()

# ~ a ~
# FUNCTION: build_header
datatable_helpers$build_header <- function(data){
    columns <- colnames(data)
    cells <- lapply(1:length(columns), function(n){
        cell <- tags$th(scope="col",columns[n])
        cell
    })
    tags$thead(tags$tr(cells))
}

# ~ b ~
# FUNCTION: build_body
datatable_helpers$build_body <- function(data, options){
    body <- lapply(1:NROW(data), function(row){
        cells <- lapply(1:NCOL(data), function(col){
            if(isTRUE(options$responsive)){
                if(col == 1 & isTRUE(options$rowHeaders)){
                    cell <- tags$th(role="rowheader", scope="row")
                } else {
                    cell <- tags$td(role="cell")
                }
                cell$children <- list(
                    tags$span(class="hidden-colname", `aria-hidden`="true", colnames(data)[col]),
                    data[row,col]
                )
                cell
            } else {
                cell <- tags$td(role="cell", data[row,col])
            }
            cell
        })
        tags$tr(role="row", cells)
    })
    tags$tbody(body)
}

#'////////////////////////////////////////

# ~ 2 ~
# FUNCTION: datatable
datatable <- function(data, id = NULL, caption = NULL, options = list(responsive = TRUE, rowHeaders = TRUE)){
    
    # render table and table elements
    tbl <- tags$table(class="datatable")
    thead <- datatable_helpers$build_header(data)
    tbody <- datatable_helpers$build_body(data, options)
    
    # add id
    if(!is.null(id)){
        tbl$attribs$id <- paste0("datatable-", id)
    }
    
    # should a caption be rendered?
    if(!is.null(caption)){
        tbl$children <- list(
            tags$caption(caption),
            thead,
            tbody
        )
    } else {
        tbl$children <- list(thead, tbody)
    }
    
    # return
    tbl
}