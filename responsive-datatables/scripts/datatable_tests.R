#'//////////////////////////////////////////////////////////////////////////////
#' FILE: datatable_tests.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-01-13
#' MODIFIED: 2020-01-14
#' PURPOSE: run tests for datatable.R
#' STATUS: working
#' PACKAGES: htmltools
#' COMMENTS: load datatable.R first
#'//////////////////////////////////////////////////////////////////////////////

# load file
source("datatable.R")

# create test data from iris 1st row
df <- iris[1, ]

# run function with default settings & no id/caption
datatable(data = df)  # data only

# with id
datatable(data = df, id = "iris-table")

# with caption
datatable(data = df, caption = "Iris Dataset")

# with responsive + rowHeaders as FALSE
datatable(
    data = df,
    caption = "Iris Dataset",
    options = list(
        responsive = FALSE,
        rowHeaders = FALSE
    )
)

# with responsive as TRUE rowHeaders as FALSE
datatable(
    data = df,
    caption = "Iris Dataset",
    options = list(
        responsive = T,
        rowHeaders = F
    )
)

# with asHTML as TRUE
df$link[1] <- paste0(
    "<a href=",
    "'https://www.rhs.org.uk/Plants/9355/Iris-setosa/Details'",
    ">Read more at the RHS</a>"
)
datatable(
    data = df,
    caption = "Iris Dataset",
    options = list(
        responsive = F,
        rowHeaders = F,
        asHTML = T
    )
)

# with all args + asHTML as false
datatable(
    data = df,
    id = "iris-table",
    caption = "Iris Dataset",
    options = list(
        responsive = TRUE,
        rowHeaders = TRUE,
        asHTML = FALSE
    )
)

#'////////////////////////////////////////

# test helper functions
df <- iris[1, ]
opts <- list(responsive = TRUE, rowHeaders = TRUE, asHTML = TRUE)

# header
datatable_helpers$build_header(df, opts)


# body
datatable_helpers$build_body(df, opts)