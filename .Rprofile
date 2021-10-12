#' ////////////////////////////////////////////////////////////////////////////
#' FILE: .Rprofile
#' AUTHOR: David Ruvolo
#' CREATED: 2021-07-29
#' MODIFIED: 2021-10-12
#' PURPOSE: workspace configurations and useful functions for vscode+R env
#' STATUS: working; ongoing
#' PACKAGES: NA
#' COMMENTS: https://github.com/davidruvolo51/rprofile
#' ////////////////////////////////////////////////////////////////////////////

# set options
options(

    # options: shiny
    shiny.port = 8000,
    shiny.launch.browser = FALSE,

    # options: radian
    radian.insert_new_line = FALSE,
    radian.prompt = "\033[0;34m>\033[0m ",

    # options: vscode R
    vsc.use_httpgd = TRUE,
    vsc.helpPanel = "Beside",
    vsc.viewer = "Beside",
    vsc.browser = "Beside",
    vsc.show_object_size = FALSE,

    # options: languageserver
    languageserver.formatting_style = function(options) {
        styler::tidyverse_style(
            start_comments_with_one_space = TRUE,
            indent_by = 4
       )
    }
)


#' @title Clear
#' @name clear
#' @description clear the active terminal
#' @noRD
clear <- function() {
    cmds <- list("unix" = "clear", "windows" = "cls")
    system(cmds[[.Platform$OS.type]])
}


#' @title Quietly Load Package
#' @name library2
#' @description suppress messages when loading a package
#' @param pkg the name of the package
#' @noRd
library2 <- function(pkg) {
    suppressPackageStartupMessages(library(pkg, character.only = TRUE))
}


#' @title Remove2
#' @name rm2
#' @description Force remove all objects from the current environment
#' @param except optional an array of object names to ignore
#' @noRd
rm2 <- function(except = NULL) {
    ignore <- c("clear", "library2", "rm2")
    if (!is.null(except)) ignore <- c(ignore, except)
    rm(list = setdiff(ls(envir = .GlobalEnv), ignore), envir = .GlobalEnv)
}

# start renv: make sure this is always last!
source("renv/activate.R")
