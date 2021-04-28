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
lorem_lipsum <- function(n, max) {
    paragraphs <- stringi::stri_rand_lipsum(n)
    html <- list()
    lapply(seq_len(length(paragraphs)), function(d) {
        page <- shiny::tagList(
            shiny::tags$p(
                class = "page-num",
                paste0("Page ", d, " of ", max)
            ),
            shiny::tags$p(paragraphs[d])
        )
        if (d > 1) {
            page$children <- tagList(
                page$children,
                tags$button(
                    id = "previousPage",
                    class = "action-button shiny-bound-input secondary",
                    "Previous"
                )
            )
        }
        if (d < max) {
            page$children <- tagList(
                page$children,
                tags$button(
                    id = "nextPage",
                    class = "action-button shiny-bound-input primary",
                    "Next"
                )
            )
        }
        html[[d]] <<- page
    })
    return(html)
}

# save data
pages <- lorem_lipsum(n = 6, max = 6)
