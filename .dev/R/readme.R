#'////////////////////////////////////////////////////////////////////////////
#' FILE: readme.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-21
#' MODIFIED: 2020-11-21
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
readme$get_data <- function() {
    dirs <- list.dirs(full.names = TRUE, recursive = FALSE) %>%
        .[!. %in% c(".dev", ".git", ".github")]

    dat <- data.frame()
    out_json <- jsonlite::read_json(".dev/data/tutorials.json")
    for(d in seq_len(length(dirs))) {
        in_json <- jsonlite::read_json(paste0(dirs[d], "/README.md"))

    }
}