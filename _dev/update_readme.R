#' ////////////////////////////////////////////////////////////////////////////
#' FILE: update_readme.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-02-15
#' MODIFIED: 2021-02-20
#' PURPOSE: update tables in readme
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

cli::cli_div(
    id = "update-readme-workflow",
    theme = list(
        span.info = list(
            color = "lightblue"
        ),
        span.success = list(
            color = "green"
        ),
        span.error = list(
            color = "red"
        ),
        span.warning = list(
            color = "yellow"
        )
    )
)

cli::cli_text("{.info [{Sys.time()}] Starting workflow}")

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
cli::cli_text("{.info [{Sys.time()}] Building subdirectory list}")
dirs <- list_dirs(exclude = c("_dev", ".github", ".git", ".vscode"))

# error checking
if (!is.null(dirs)) {
    cli::cli_text(
        "{.success [{Sys.time()}] Built directory data (n = {length(dirs)})}"
    )
} else {
    cli::cli_text("{.error [{Sys.time()}] Failed to compile data}")
}


# build tutorials
tutorials <- pull_data(dirs)
if (NROW(tutorials) > 0) {
    cli::cli_text("{.success [{Sys.time()}] Collated subdir data}")
} else {
    cli::cli_text("{.error [{Sys.time()}] Failed to collated subdir data}")
}

cli::cli_text("{.info [{Sys.time()}] Generating markdown tables}")

# write 'activeTutorial' tables
tryCatch({
    cli::cli_text(
        "{.success [{Sys.time()}] Wrote 'active' apps}"
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
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write 'active' apps}"
    )
}, warning = function() {
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write 'active' apps}"
    )
})

# write 'archivedTutorials' table
tryCatch({
    cli::cli_text(
        "{.success [{Sys.time()}] Wrote 'archived' apps}"
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
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write 'archived' apps}"
    )
}, warning = function() {
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write 'archived' apps}"
    )
})

# save data
tryCatch({
    cli::cli_text(
        "{.success [{Sys.time()}] Wrote data to '_dev/data/tutorials.csv'}"
    )
    readr::write_csv(tutorials, "_dev/data/tutorials.csv")
}, error = function() {
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write '_dev/data/tutorials.csv'}"
    )
}, warning = function() {
    cli::cli_text(
        "{.error [{Sys.time()}] Failed to write '_dev/data/tutorials.csv'}"
    )
})
