#'//////////////////////////////////////////////////////////////////////////////
#' FILE: datatable.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2020-01-13
#' PURPOSE: build datatable function and helpers
#' STATUS: working
#' PACKAGES: htmltools
#' COMMENTS:
#'      The datatable function generates an html table from a dataset.
#'      This func returns a shiny tagList object which can be used in shiny
#'      applications, markdown documents, or written to an html file. The
#'      datatable function takes the following arguments.
#'
#'      ARGUMENTS:
#'      - data: the input dataset
#'      - id: an identifier for the table ideal for styling specific tables
#'            or for use in js
#'      - caption: a title for the table (recommended for accessible tables)
#'      - options:
#'          - responsive: a logical arg for turning on/off the rendering of
#'                      additional elements for responsive tables (i.e., span).
#'                      (Default = FALSE)
#'          - rowHeaders: a bool that renders the first cell of every row
#'              as a row header. This is useful for datasets where all data
#'              in a row is related, e.g., patient data. If set to TRUE,
#'              the data must be organized so that the row header is the
#'              first column.
#'          - `asHTML`: a logical argument used to render cell text as html
#'               elements (default = FALSE)
#'
#'      ABOUT:
#'      The datatable function requires two helper functions: 1) to generate the
#'      table header and another used 2) to generate the table body. The func
#'      build_header() renders the <thead> element according to the input data.
#'      The build_body functions renders the table's <tbody> based on the input
#'      and the options. This function uses a nested lapplys to iterate each row
#'      and cell. If the responsive opt is TRUE, then the function will return
#'      a <span> element with the current cell's column name. <span> has
#'      the class `hidden-colname` that hides/shows the element based on screen
#'      size (see datatable.css). Role attributes are added in the event
#'      the display properties are altered in css.
#'//////////////////////////////////////////////////////////////////////////////

# ~ 1 ~
# DEFINE HELPER FUNCTIONS
datatable_helpers <- list()

# ~ a ~
# FUNCTION: build_header
datatable_helpers$build_header <- function(data, options) {
    columns <- colnames(data)
    cells <- lapply(1:length(columns), function(n) {

        # define cell content: as html or text
        if (isTRUE(options$asHTML)) {
            cell_value <- htmltools::HTML(columns[n])
        } else {
            cell_value <- columns[n]
        }

        # build header
        cell <- htmltools::tags$th(scope = "col", cell_value)
        cell
    })

    # return header
    htmltools::tags$thead(
        htmltools::tags$tr(role = "row", cells)
    )
}

# ~ b ~
# FUNCTION: build_body
datatable_helpers$build_body <- function(data, options) {
    body <- lapply(1:NROW(data), function(row) {
        cells <- lapply(1:NCOL(data), function(col) {

            # process options: render as html or escape?
            if (isTRUE(options$asHTML)) {
                cell_value <- htmltools::HTML(data[row, col])
            } else {
                cell_value <- data[row, col]
            }

            # process options$rowHeaders (this generates the cell)
            if (isTRUE(options$rowHeaders) && col == 1) {
                cell <- htmltools::tags$th(role = "rowheader")
            } else {
                cell <- htmltools::tags$td(role = "cell")
            }

            # process options: responsive and rowHeaders
            if (isTRUE(options$responsive)) {
                cell$children <- list(
                    htmltools::tags$span(
                        class = "hidden-colname",
                        `aria-hidden` = "true",
                        colnames(data)[col]
                    ),
                    cell_value
                )
            } else {
                cell$children <- list(
                    cell_value
                )
            }

            # return cell
            cell
        })

        # return cells in a row
        htmltools::tags$tr(role = "row", cells)
    })

    # return body
    htmltools::tags$tbody(body)
}

#'////////////////////////////////////////

# ~ 2 ~
# FUNCTION: datatable
datatable <- function(data, id = NULL, caption = NULL, options = list(responsive = TRUE, rowHeaders = TRUE, asHTML = FALSE)) {

    # render table and table elements
    tbl <- htmltools::tags$table(class = "datatable",
        datatable_helpers$build_header(data, options),
        datatable_helpers$build_body(data, options)
    )

    # add id
    if (!is.null(id)) {
        tbl$attribs$id <- paste0("datatable-", id)
    }

    # should a caption be rendered?
    if (!is.null(caption)) {
        tbl$children <- list(
            htmltools::tags$caption(caption),
            tbl$children
        )
    }

    # return
    tbl
}