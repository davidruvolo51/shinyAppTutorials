#'//////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 22 May 2018
#' MODIFIED: 22 May 2018
#' PURPOSE: control script
#' PACKAGES: see below
#' STATUS: complete
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

# pkgs
library(shiny)
library(shinyjs)
library(tidyverse)
library(rmarkdown)
library(kableExtra)

# data - run `scripts/source_data.R` to pull and clean data from github
librarians <- readRDS("data/librarians_538.RDS")
