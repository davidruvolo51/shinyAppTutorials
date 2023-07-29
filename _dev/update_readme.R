#' ////////////////////////////////////////////////////////////////////////////
#' FILE: update_readme.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-02-15
#' MODIFIED: 2023-07-29
#' PURPOSE: update tables in readme
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

msg <- function(text) message("[", Sys.time(), "] ", text)
msg("Starting workflow")

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

msg("Building subdirectory list")
dirs <- list_dirs(
    exclude = c(
        "_dev",
        "renv",
        ".github",
        ".git",
        ".vscode"
    )
)

# error checking
if (!is.null(dirs)) {
    msg(paste0("Build directory data (n = ", length(dirs), ")"))
} else {
    msg("Failed to compile data")
}


# build tutorials
tutorials <- pull_data(dirs)
if (NROW(tutorials) > 0) {
    msg("Collated subdirectory data")
} else {
    msg("Failed to collate subdirectory data")
}

msg("Generating markdown tables")

# write 'activeTutorial' tables
msg("Writing 'active' table")
tutorials %>%
    filter(status == "active") %>%
    readme$as_md_table(data = .) %>%
    readme$write_md_table(
        path = "README.md",
        id = "activeTutorials",
        table = .
    )

# write 'archivedTutorials' table
msg("Writing 'archived' table")
tutorials %>%
    filter(status == "archived") %>%
    readme$as_md_table(data = .) %>%
    readme$write_md_table(
        path = "README.md",
        id = "archivedTutorials",
        table = .
    )

# save data
msg("Writing data to '_dev/data/tutorials.csv'")
readr::write_csv(tutorials, "_dev/data/tutorials.csv")
