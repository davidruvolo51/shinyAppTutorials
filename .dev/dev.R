#'////////////////////////////////////////////////////////////////////////////
#' FILE: dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2020-11-21
#' PURPOSE: repo management
#' STATUS: in.progress
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

json$add_readme_badges(dir = "progress-bars-example", branch = "main")

#'//////////////////////////////////////

#' ~ 3 ~
#' Update main README.md tables

d <- jsonlite::read_json(path = ".dev/data/tutorials.json", simplifyVector = TRUE)

# inital time only
for (index in seq_len(length(d$active))) {
    path <- paste0(d$active[index, ]$dir, "/package.json")
    json <- jsonlite::read_json(path)
    json$name <- d$active[index, ]$dir
    json$description <- d$active[index, ]$description
    jsonlite::write_json(json, path, pretty = TRUE, auto_unbox = TRUE)
}

for (index in seq_len(length(d$archive))) {
    path <- paste0(d$archive[index, ]$dir, "/package.json")
    json <- jsonlite::read_json(path)
    json$name <- d$archive[index, ]$dir
    json$description <- d$archive[index, ]$description
    jsonlite::write_json(json, path, pretty = TRUE, auto_unbox = TRUE)
}
