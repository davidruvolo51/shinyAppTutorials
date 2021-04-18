#'////////////////////////////////////////////////////////////////////////////
#' FILE: test-datatable.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-04-18
#' MODIFIED: 2021-04-18
#' PURPOSE: unittests
#' STATUS: working
#' PACKAGES: shiny, testthat
#' COMMENTS: usings R/datatable.R
#'////////////////////////////////////////////////////////////////////////////

# pkgs
suppressPackageStartupMessages(library(testthat))
source("../R/datatable.R")

dat <- readRDS("../data/birds_summary.RDS")[1:5, ]

# `datatable` returns standard elements
test_that("required elements are generated", {
    d <- datatable(data = dat, caption = "Birds!!")
    expect_equal(
        object = c(
            d$children[[1]]$name,
            d$children[[2]][[1]]$name,
            d$children[[2]][[2]]$name
        ),
        expected = c("caption", "thead", "tbody"),
        label = "Function does not return basic elements"
    )
})


# `id` is properly assigned
test_that("ID attribute is properly updated", {
    d <- datatable(data = dat, id = "table")
    expect_equal(
        object = d$attribs$id,
        expected = "table",
        label = "ID is not added in the correct place"
    )
})


# option `responsive` does not render span when `FALSE`
test_that("When FALSE, responsive markup is not generated", {
    d <- datatable(data = dat, options = list(responsive = FALSE))
    row <- d$children[[2]]$children[[1]][[1]]
    expect_equal(
        object = length(row$children[[1]][[1]]$children),
        expected = 1,
        label = "Responsive markup is not properly removed when FALSE"
    )
})

# option `rowHeaders` does not render header markdup when `FALSE`
test_that("When FALSE, row headers are not generated", {
    d <- datatable(data = dat, options = list(rowHeaders = FALSE))
    row <- d$children[[2]]$children[[1]][[1]]
    expect_equal(
        object = row$children[[1]][[1]]$name,
        expected = "td",
        label = "Responsive markup is not properly removed when FALSE"
    )
})
