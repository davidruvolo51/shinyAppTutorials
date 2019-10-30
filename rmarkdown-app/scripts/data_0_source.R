#'//////////////////////////////////////////////////////////////////////////////
#' FILE: source_data.R
#' AUTHOR: David Ruvolo
#' CREATED: 22 May 2018
#' MODIFIED: 22 May 2018
#' PURPOSE: source 538's librarians dataset
#' PACKAGES: tidyverse
#' STATUS: working + complete
#' COMMENTS: uses librarian dataset from 538's github repo
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)

# ~ 1 ~
# source
raw <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/librarians/librarians-by-msa.csv", stringsAsFactors = FALSE)

# ~ 2 ~
# quick clean
raw <- raw %>% replace(. == "**",NA)                                  # del asterix
raw[,3:6] <- as.numeric(sapply(raw[,3:6], function(x)as.numeric(x)))  # set cols as num

# ~ 3 ~
# save
saveRDS(raw, "data/librarians_538.RDS")