#'////////////////////////////////////////////////////////////////////////////
#' FILE: pages.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-28
#' MODIFIED: 2020-11-21
#' PURPOSE: misc pages to demonstate subpages
#' STATUS: working
#' PACKAGES: stringr
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# function to generate lipsum paragraphs
lorem_lipsum <- function(n) {
    paragraphs <- stringi::stri_rand_lipsum(n)
    html <- list()
    lapply(seq_len(length(paragraphs)), function(d) {
        html[[d]] <<- shiny::tagList(
            shiny::tags$p(
                class = "page-num",
                paste0("Page ", d)
            ),
            shiny::tags$p(paragraphs[d])
        )
    })
    return(html)
}

# save data
pages <- lorem_lipsum(n = 10)
