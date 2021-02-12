#'////////////////////////////////////////////////////////////////////////////
#' FILE: json.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2020-11-21
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
#' @param status indicates app status (e.g., "active", "archived", etc.)
#'
#' @noRd
json$data <- function(name, version, description, author, status) {
    list(
        name = name,
        version = version,
        description = description,
        author = author,
        status = status,
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


#' Create badges
#'
#' create shields inside README.md
#'
#' @param dir directory path
#' @param branch repo branch (main)
#' @param label a label for the badge
#' @param query a package.json property to query
#' @param color a color for the label
#'
#' @noRd
json$add_badge <- function(dir, branch = "main", label, query, color) {

    create_new_badge <- function(dir, branch, label, query, color) {
        endpoint <- paste0(
            "![", label, "]",
            "(",
            "https://img.shields.io/badge/dynamic/json?",
            "color=", color,
            "&label=", label,
            "&query=", query,
            "&url=", paste0(
                "https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51",
                "%2FshinyAppTutorials%2F", branch, "%2F",
                dir,
                "%2Fpackage.json"
            ),
            ")"
        )
    }
    input <- paste0(dir, "/README.md")
    if (!file.exists(input)) {
        cli::cli_alert_danger("No {.file README.md} exists at {.path {dir}}")
    }

    if (file.exists(input)) {
        raw <- readLines(input, warn = FALSE)
        status <- stringr::str_detect(
            string = raw,
            pattern = "<!-- badges: start -->"
        )

        badge <- create_new_badge(
            dir = dir,
            branch = branch,
            label = label,
            query = query,
            color = color
        )

        if (length(status[status == TRUE]) > 0) {
            start <- match("<!-- badges: start -->", status)
            end <- match("<!-- badges: end -->", raw)
            new_md <- c(
                raw[(1:end) - 1],
                badge,
                raw[end:length(raw)]
            )
        }

        if (!length(status[status == TRUE] > 0)) {
            new_md <- c(
                "<!-- badges: start -->",
                badge,
                "<!-- badges: end -->",
                "",
                raw
            )
        }

        tryCatch({
            writeLines(new_md, input)
            cli::cli_alert_success("Added badge to {.file {input}}")
        }, error = function(e) {
            cli::cli_alert_success("Failed to add badge to {.file {input}}")
        }, warning = function(warn) {
            cli::cli_alert_success("Failed to add badge to {.file {input}}")
        })
    }
}

#' create readme badges
#'
#' Create version and status badges in READMEs
#'
#' @param dir path to example
#' @param branch branch to use
#'
#' @noRd
json$add_readme_badges <- function(dir, branch) {
    json$add_badge(
        dir = dir,
        branch = branch,
        label = "version",
        query = "version",
        color = "22dd77"
    )
    json$add_badge(
        dir = dir,
        branch = branch,
        label = "status",
        query = "status",
        color = "3772FF"
    )
}

#' get md5 sum
#'
#' Create md5 sum from package.json files in specific dir
#'
#' @param dir folder to check
#'
#' @noRd
json$get_json_md5 <- function(dir) {
    if (!dir.exists(dir)) {
        cli::cli_alert_danger("{.path {dir}} does not exit")
    }

    if (dir.exists(dir)) {
        sh <- system(paste0("md5 ", dir, "/README.md"), intern = TRUE)
        trimws(strsplit(sh, "=")[[1]][2])
    }
}