#'//////////////////////////////////////////////////////////////////////////////
#' FILE: datatable.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-05
#' MODIFIED: 2021-05-01
#' PURPOSE: build datatable function and helpers
#' STATUS: working
#' PACKAGES: htmltools
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

#' datatable_helpers
datatable_helpers <- list()

#' @name build_helder
#' @description generate the HTML markup for the table header element
#' @param data input dataset
#' @param options internal configuration object
#' @return Shiny tag object
datatable_helpers$build_header <- function(data, options) {
    columns <- colnames(data)
    cells <- lapply(seq_len(length(columns)), function(n) {
        if (isTRUE(options$asHTML)) {
            cell_value <- htmltools::HTML(columns[n])
        } else {
            cell_value <- columns[n]
        }
        cell <- htmltools::tags$th(scope = "col", cell_value)
        cell
    })
    htmltools::tags$thead(htmltools::tags$tr(role = "row", cells))
}

#' @name build_body
#' @description generate the HTML markup for the table body element
#' @param data input dataset
#' @param options internal configuration object
#' @return Shiny tag object
datatable_helpers$build_body <- function(data, options) {
    body <- lapply(seq_len(NROW(data)), function(row) {
        cells <- lapply(seq_len(NCOL(data)), function(col) {

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
            cell
        })
        htmltools::tags$tr(role = "row", cells)
    })
    htmltools::tags$tbody(body)
}

#' @name datatable
#' @description generate an HTML table from a dataset
#' @param data input dataset
#' @param id a unique ID for the table to render as the `id` attribute (optional)
#' @param caption an optional caption for the table
#' @param options optional arguments for customizing the table
#'
#' @section Optional Arguments
#' - responsive: If TRUE, table will be rendered as a responsive table
#' - rowHeaders: It TRUE, the first cell in each row will be rendered as
#'      header element
#' - asHTML: if TRUE, values will be rendered as HTML
#'
#' @return Shiny tag object
datatable <- function(
    data,
    id = NULL,
    caption = NULL,
    options = list(
        responsive = TRUE,
        rowHeaders = TRUE,
        asHTML = FALSE
    )
) {

    # render table and table elements
    tbl <- htmltools::tags$table(class = "datatable",
        datatable_helpers$build_header(data, options),
        datatable_helpers$build_body(data, options)
    )

    # add id
    if (!is.null(id)) tbl$attribs$id <- id

    # should a caption be rendered?
    if (!is.null(caption)) {
        tbl$children <- list(
            htmltools::tags$caption(caption),
            tbl$children
        )
    }

    return(tbl)
}