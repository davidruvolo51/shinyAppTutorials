#'////////////////////////////////////////////////////////////////////////////
#' FILE: init.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2021-02-13
#' PURPOSE: init subdir files
#' STATUS: working
#' PACKAGES: see below
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' source utils
source("_dev/R/json.R")
source("_dev/R/readme.R")

#' ~ 1 ~
#' INITIALIZE
#' For the first time, create `package.json` files where applicable.
#' Set version number to `1.0.0`; `description` will be blank

# compile directories
dirs <- list.dirs(recursive = FALSE) %>%
    sapply(
        .,
        function(d) {
            gsub(
                pattern = "./",
                replacement = "",
                x = d
            )
        }
    ) %>%
    as.character(.) %>%
    .[!. %in% c(".dev", ".git", ".github")]

#' init `package.json`
#' system("rm -rf Data-Editor/package.json")  # for testing
for (d in seq_len(length(dirs))) {
    json$init(dir = dirs[d])
    dat <- json$data(
        name = dirs[d],
        version = "1.0.0",
        description = "",
        author = "@dcruvolo",
        status = "active"
    )
    json$write(,
        data = dat,
        path = paste0(dirs[d], "/package.json")
    )
}