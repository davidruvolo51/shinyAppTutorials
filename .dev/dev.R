#'////////////////////////////////////////////////////////////////////////////
#' FILE: dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2020-11-22
#' PURPOSE: repo management
#' STATUS: working; ongoing
#' PACKAGES: cli; jsonlite
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' pkgs
#' make sure these packages are installed
packageVersion("cli")
packageVersion("jsonlite")
packageVersion("dplyr")
suppressPackageStartupMessages(library(dplyr))

#' source utils
source(".dev/R/json.R")
source(".dev/R/readme.R")

#'//////////////////////////////////////

#' ~ 1 ~
#' INITIALIZE
#' For the first time, create `package.json` files where applicable.
#' Set version number to `1.0.0`; `description` will be blank

# compile directories
#' dirs <- list.dirs(recursive = FALSE) %>%
#'     sapply(
#'         .,
#'         function(d) {
#'             gsub(
#'                 pattern = "./",
#'                 replacement = "",
#'                 x = d
#'             )
#'         }
#'     ) %>%
#'     as.character(.) %>%
#'     .[!. %in% c(".dev", ".git", ".github")]

#' init `package.json`
#' system("rm -rf Data-Editor/package.json")  # for testing
#' for (d in seq_len(length(dirs))) {
#'     json$init(dir = dirs[d])
#'     dat <- json$data(
#'         name = dirs[d],
#'         version = "1.0.0",
#'         description = "",
#'         author = "@dcruvolo",
#'         status = "active"
#'     )
#'     json$write(,
#'         data = dat,
#'         path = paste0(dirs[d], "/package.json")
#'     )
#' }

#'//////////////////////////////////////

#' ~ 2 ~
#' Badges

# json$add_readme_badges(dir = "progress-bars-example", branch = "main")

#'//////////////////////////////////////

#' ~ 3 ~
#' Update main README.md tables

# d <- jsonlite::read_json(path = ".dev/data/tutorials.json", simplifyVector = TRUE)

# inital time only
# for (index in seq_len(NROW(d$data))) {

    # populate package.json files with main data
    #' path <- paste0(d$data[index, ]$dir, "/package.json")
    #' json <- jsonlite::read_json(path)
    #' json$name <- d$data[index, ]$dir
    #' json$description <- d$data[index, ]$description
    #' jsonlite::write_json(json, path, pretty = TRUE, auto_unbox = TRUE)

    # add md5 check to main data
    # d$data[index, ]$md5 <- json$get_json_md5(dir = d$data[index, ]$dir)

# }

# jsonlite::write_json(d, ".dev/data/tutorials.json", pretty = TRUE, auto_unbox = TRUE)

# generate table markup
# active_md <- d$data %>%
#     filter(status == "active") %>%
#     readme$as_md_table(.)

# archived_md <- d$data %>%
#     filter(status == "archived") %>%
#     readme$as_md_table(.)

# write tables to markdown file
# readme$write_md_table("README.md", "activeTutorials", active_md)
# readme$write_md_table("README.md", "archivedTutorials", archived_md)


#'//////////////////////////////////////

#' ~ 4 ~
#' Ongoing Management of files

d <- jsonlite::read_json(".dev/data/tutorials.json", simplifyVector = TRUE)
d$data$updated <- as.Date("2020-11-22")

# check files
for (i in seq_len(NROW(d$data))) {
    path <- paste0(d$data[i, ]$dir, "/package.json")
    check <- trimws(
        strsplit(
            x = system(
                paste0("md5 ", path),
                intern = TRUE
            ),
            split = "="
        )[[1]][2]
    )

    if (d$data[i, ]$md5 != check) {
        cli::cli_alert_info("{.path {path}} is newer. Checking properties...")
        new <- jsonlite::read_json(path)
        d$data[i, ]$md5 <- check
        updates <- 0

        # check all props: name, version, description, status
        # check name/dir
        if (d$data[i, ]$dir != new$name) {
            cli::cli_alert_success(
                "Updated property {.val name}: {.val {new$name}}"
            )
            updates <- updates + 1
            d$data[i, ]$dir <- new$name
        }

        # update version
        if (d$data[i, ]$version != new$version) {
            cli::cli_alert_success("Updated version: {.val {new$version}}")
            updates <- updates + 1
            d$data[i, ]$version <- new$version
        }

        # update description
        if (d$data[i, ]$description != new$description) {
            cli::cli_alert_success("Updated description")
            updates <- updates + 1
            d$data[i, ]$description <- new$description
        }

        # update status
        if (d$data[i, ]$status != new$status) {
            cli::cli_alert_success("Updating app status {.val {new$status}}")
            updates <- updates + 1
            d$data[i, ]$status <- new$status
        }

        # check for target changes
        if (updates == 0) {
            cli::cli_alert_info("Target properties haven't changed")
        }

        if (updates > 0) {
            d$data[i, ]$updated <- Sys.Date()
        }
    }
}

# save changes
jsonlite::write_json(d, ".dev/data/tutorials.json", pretty = TRUE, auto_unbox = TRUE)


# generate table markup
active_md <- d$data %>%
    filter(status == "active") %>%
    readme$as_md_table(.)

archived_md <- d$data %>%
    filter(status == "archived") %>%
    readme$as_md_table(.)

# write tables to markdown file
readme$write_md_table("README.md", "activeTutorials", active_md)
readme$write_md_table("README.md", "archivedTutorials", archived_md)
