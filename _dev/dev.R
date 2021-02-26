#'////////////////////////////////////////////////////////////////////////////
#' FILE: dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-11-19
#' MODIFIED: 2021-02-26
#' PURPOSE: repo management
#' STATUS: working; ongoing
#' PACKAGES: see below
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' init r 'package'
#' create a R package-like repo structure, so that we can run GitHub Actions
#' more efficiently
usethis::create_project(path = ".")
usethis::use_description(check_name = FALSE) # this isn't a real pkg!
usethis::use_namespace()

#' pkgs
#' make sure these packages are installed
usethis::use_package("cli")
usethis::use_package("jsonlite")
usethis::use_package("dplyr")
usethis::use_package("knitr")
usethis::use_package("readr")

#' source utils
#' source("_dev/R/json.R")
#' source("_dev/R/readme.R")

#' ~ 2 ~
#' Subdir Management
#' Badges
#' You can create badges for subdirectories by using the
#' method: `json$add_readme_badges`. Always use set the value of branch to
#' 'main' unless you know exactly what you are doing!

#' json$add_readme_badges(
#'     dir = "progress-bars-example",
#'     branch = "main"
#' )

# save changes
#' jsonlite::write_json(
#'     x = d,
#'     path = "_dev/data/tutorials.json",
#'     pretty = TRUE,
#'     auto_unbox = TRUE
#' )
