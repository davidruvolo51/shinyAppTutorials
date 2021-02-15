#' ////////////////////////////////////////////////////////////////////////////
#' FILE: update_readme.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-02-15
#' MODIFIED: 2021-02-15
#' PURPOSE: update tables in readme
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(dplyr))

#' testing locally
#' source("_dev/R/readme.R")

#' //////////////////////////////////////

#' ~ 0 ~
#' Utils

#' ~ 0a ~
# function that gather directories and excludes named dirs
list_dirs <- function(exclude = NULL) {
    dirs <- as.character(
        sapply(list.dirs(recursive = FALSE), function(d) {
            gsub(pattern = "./", replacement = "", x = d)
        })
    )
    if (!is.null(exclude)) dirs <- dirs[!dirs %in% exclude]
    return(dirs)
}

#' ~ 0b ~
#' define a function that reads package.json from each dir
#' and pulls relevant information
pull_data <- function(dirs) {
    out <- data.frame()
    for (d in seq_len(length(dirs))) {
        j <- jsonlite::read_json(paste0(dirs[d], "/package.json"))
        out <- dplyr::bind_rows(
            out,
            data.frame(
                name = j$name,
                version = j$version,
                description = j$description,
                author = j$author,
                status = j$status,
                link = paste0(
                    "https://davidruvolo51.github.io/shinytutorials/tutorials/",
                    dirs[d]
                )
            )
        )
    }
    out
}

#' //////////////////////////////////////


#' ~ 1 ~
#' Compile all subdirectories
# all avilable subdirectories and exclude non-shiny apps

# build data
dirs <- list_dirs(exclude = c("_dev", ".github", ".git", ".vscode"))

# error checking
if (!is.null(dirs)) {
    cli::cli_alert_success("Built list of directories ")
} else {
    cli::cli_alert_danger("Cannot build list of directories")
}


# build tutorials
tutorials <- pull_data(dirs)
if (NROW(tutorials) > 0) {
    cli::cli_alert_success("Build directories dataset")
}


# write 'activeTutorial' tables
tryCatch({
    cli::cli_alert_success(
        "Successfully wrote {.val activeTutorials} in README"
    )
    tutorials %>%
        filter(status == "active") %>%
        readme$as_md_table(data = .) %>%
        readme$write_md_table(
            path = "README.md",
            id = "activeTutorials",
            table = .
        )
}, error = function() {
    cli::cli_alert_danger("Failed to write {.val activeTutorials} in README")
}, warning = function() {
    cli::cli_alert_danger("Failed to write {.val activeTutorials} in README")
})

# write 'archivedTutorials' table
tryCatch({
    cli::cli_alert_success(
        "Successfully wrote {.val archivedTutorials} in README"
    )
    tutorials %>%
        filter(status == "archived") %>%
        readme$as_md_table(data = .) %>%
        readme$write_md_table(
            path = "README.md",
            id = "archivedTutorials",
            table = .
        )
}, error = function() {
    cli::cli_alert_danger("Failed to write {.val archivedTutorials} in README")
}, warning = function() {
    cli::cli_alert_danger("Failed to write {.val archivedTutorials} in README")
})

# save data
tryCatch({
    cli::cli_alert_success(
        "Saved tutorials data as {.file _dev/data/tutorials.csv}"
    )
    readr::write_csv(tutorials, "_dev/data/tutorials.csv")
}, error = function() {
    cli::cli_alert_success(
        "Failed to save tutorials data as {.file _dev/data/tutorials.csv}"
    )
}, warning = function() {
    cli::cli_alert_success(
        "Failed to save tutorials data as {.file _dev/data/tutorials.csv}"
    )
})
