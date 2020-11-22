#'////////////////////////////////////////////////////////////////////////////
#' FILE: readme.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-21
#' MODIFIED: 2020-11-22
#' PURPOSE: tools for updating readme
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' README
#'
#' methods for updating README.md
#'
#' @noRd
readme <- list(class = "readme")

#' fetch package.json data
#'
#' gather specific data from all package json files and update main json
#' file
#'
#' @noRd
readme$as_md_table <- function(data) {
    data %>%
        select(name, description, version, link) %>%
        mutate(
            link = case_when(
                link == "TBD" ~ "TBD",
                TRUE ~ paste0("[tutorial](", link, ")")
            )
        ) %>%
        knitr::kable(.)
}

#' write md table
#'
#' In the markdown file, tables must be wrapped in opening and
#' closing tags: <!-- begin:myTableId --> and <!-- end:myTableId -->
#'
#' @param path path to markdown file
#' @param id internal markdown table id
#' @param table output from `as_md_table`
#'
#' @noRd
readme$write_md_table <- function(path, id, table) {
    md <- readLines(path, warn = FALSE)
    tbl_start <- paste0("<!-- begin:", id, " -->")
    tbl_end <- paste0("<!-- end:", id, " -->")
    status <- stringr::str_detect(md, tbl_start)
    if (length(status[status == TRUE]) > 0) {
        start <- match(tbl_start, md)
        end <- match(tbl_end, md)
        new_md <- c(
            md[1:start],
            "",
            table,
            "",
            md[end:length(md)]
        )
        writeLines(new_md, path)
    } else {
        cli::cli_alert_danger("Unable to locate table {.val {id}}")
    }
}