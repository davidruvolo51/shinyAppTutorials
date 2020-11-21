#'//////////////////////////////////////////////////////////////////////////////
#' FILE: source_data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2018-05-22
#' MODIFIED: 2020-11-20
#' PURPOSE: source 538's librarians dataset
#' PACKAGES: tidyverse
#' STATUS: working + complete
#' COMMENTS: uses librarian dataset from 538's github repo
#'//////////////////////////////////////////////////////////////////////////////

# source data
raw <- read.csv(
    file = "https://raw.githubusercontent.com/fivethirtyeight/data/master/librarians/librarians-by-msa.csv",
    stringsAsFactors = FALSE
)

# quick clean
raw <- raw %>% replace(. == "**", NA)
raw[, 3:6] <- as.numeric(sapply(raw[, 3:6], function(x)as.numeric(x)))

# save
saveRDS(raw, "data/librarians_538.RDS")