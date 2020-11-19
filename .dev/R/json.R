#'////////////////////////////////////////////////////////////////////////////
#' FILE: json.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2020-11-19
#' PURPOSE: utils for creating package json files
#' STATUS: in.progress
#' PACKAGES: cli; jsonlite
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' create json
#'
#' methods for creating json files
#'
#' @noRd
json <- list(class = "json")


#' init file
#'
#' @param dir the location to create a new `package.json` file
#'
#' @noRd
json$init <- function(dir) {
    if (!dir.exists(dir)) {
        cli::cli_alert_danger("{.path {dir}} does not exist")
    }

    file <- paste0(dir, "/package.json")
    if (file.exists(file)) {
        cli::cli_alert_warning("{.file {file}} already exists. (skipped)")
    } else {
        tryCatch({
            file.create(file)
            cli::cli_alert_success("Created {.file {file}}")
        }, error = function(err) {
            cli::cli_alert_danger("Unable to create {.file {file}}")
        }, warning = function(warn) {
            cli::cli_alert_danger("Unable to create {.file {file}}")
        })
    }
}


#' define data
#'
#' Create standarized data object for subdirs
#'
#' @param name name of the project
#' @param version version number to assign
#' @param description a short description about the project
#' @param author project author
#'
#' @noRd
json$data <- function(name, version, description, author) {
    list(
        name = name,
        version = version,
        description = description,
        author = author,
        repository = list(
            type = "git",
            url = "git+https://github.com/davidruvolo51/shinyAppTutorials.git"
        ),
        keywords = c(
            "r",
            "shiny",
            "tutorials"
        ),
        license = "MIT",
        bugs = list(
            url = "https://github.com/davidruvolo51/shinyAppTutorials/issues"
        ),
        homepage = "https://github.com/davidruvolo51/shinyAppTutorials"
    )
}


#' write data
#'
#' Create list object as json format
#'
#' @param data a list object (output from `json$data`)
#' @param path location of the `package.json` file
#' @param overwrite if TRUE, existing `package.json` will be overwritten
#'
#' @noRd
json$write <- function(data, path, overwrite = TRUE) {
    if (!is.list(data)) {
        cli::cli_alert_danger("{.arg data} must be a list")
    }

    if (overwrite) {
        tryCatch({
            jsonlite::write_json(
                x = data,
                path = path,
                pretty = TRUE,
                auto_unbox = TRUE
            )
            cli::cli_alert_success("Saved {.file {path}}")
        }, error = function(e) {
            cli::cli_alert_danger("Failed to save {.file {path}}:\n{e}")
        }, warning = function(w) {
            cli::cli_alert_danger("Failed to save {.file {path}}:\n{w}")
        })
    } else {
        cli::cli_alert_info("Skipped {.file {path}} to avoid overwriting it")
    }
}