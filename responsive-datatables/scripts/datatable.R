#'//////////////////////////////////////////////////////////////////////////////
#' FILE: datatable.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2019-12-06
#' PURPOSE: build datatable function and helpers
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS:
#'     The datatable function uses helper functions build_header and build_body
#'     These functions have a single input argument `data` which is received 
#'     through the main function `datatable`. 
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(shiny))

# ~ 1 ~
# DEFINE HELPER FUNCTIONS
# define a series of helper functions that render specific elements of the
# table

# modularize helper functions
helpers <- list()

# ~ a ~
# FUNCTION: build_header
# define a function that renders input data to <thead> html element
# the scope attribute is used for accessibility; additional attributes
# may be necessary for complex datatables, but it wouldn't apply in 
# this case as this function does not support complex layouts (yet)
helpers$build_header <- function(data){
    columns <- colnames(data)
    cells <- lapply(1:length(columns), function(n){
        cell <- tags$th(columns[n])
        cell$attribs$scope <- "col"
        cell
    })
    tags$thead(tags$tr(cells))
}


# ~ b ~
# FUNCTION: build_body
# define a function that renders input data to <tbody> html element
# attach colnames to each cell for use in css using `data-*` attributes
# update the row name with row n, column 1. This may be useful for
# alternative layouts
helpers$build_body <- function(data){
    body <- lapply(1:NROW(data), function(row){
        cells <- lapply(1:NCOL(data), function(col){
            if(col == 1){
                cell <- tags$th(data[row,col])
                cell$attribs$scope <- "row"
            } else {
                cell <- tags$td(data[row,col])
            }
            cell$attribs$`data-colname` <- colnames(data)[col]
            cell
        })
        tags$tr(cells)
    })
    tags$tbody(body)
}

# If you want to add a more attributes to the row element `tr`, use:
#
#   tags$tr(cells, `data-rowname`=data[row, 1])
#

#'////////////////////////////////////////

# ~ 2 ~
# FUNCTION: datatable
# define a function that builds all elements of the datatable. This
# includes data (the object containing the data you want to use to
# create a table) and caption (a title for the table). Caption is set
# to NULL by default, but a caption should be used for good accessibility
# practices.
datatable <- function(data, id = NULL, caption = NULL){
    
    # render table and table elements
    tbl <- tags$table(class="datatable")
    thead <- helpers$build_header(data)
    tbody <- helpers$build_body(data)
    
    # add id
    if(!is.null(id)){
        tbl$attribs$id <- paste0("datatable-", id)
    }
    
    # should a caption be rendered?
    if(!is.null(caption)){
        captionId <- paste0("datatable-",id,"-caption")
        tbl$attribs$`aria-labelledby` <- captionId
        tbl$children <- list(
            tags$caption(caption, id= captionId),
            thead,
            tbody
        )
    } else {
        tbl$children <- list(thead, tbody)
    }
    
    # return
    tbl
}