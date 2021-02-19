#'//////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-09
#' MODIFIED: 2021-02-19
#' PURPOSE: single file shiny app
#' PACKAGES: shiny
#' COMMENTS:
#'     - app was built in response to this question:
#'          https://community.rstudio.com/t/background-images-in-shiny/12261/
#'//////////////////////////////////////////////////////////////////////////////

#' imgs can be downloaded from my unsplash collection:
#'  - https://unsplash.com/collections/98323154/shiny-app-demonstrations
#'
#' I strongly recommend using some sort of image optimization. For example,
#' the ImageOptim tool is really nice!
#'
#' In this demo, I will build an object that contains all of the image files
#' located in `www/imgs/`.
imgs <- c(
    "imgs/colton-jones-_ZX2WYM3_BM-unsplash.jpg",
    "imgs/david-tostado-woMvsY6KHac-unsplash.jpg",
    "imgs/hilary-bird-F_aYxIFPnfk-unsplash.jpg",
    "imgs/lloyd-blunk-Sv0xUKiu6ek-unsplash.jpg"
)


# pkgs
suppressPackageStartupMessages(library(shiny))

# ui
ui <- tagList(
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(
            `http-quiv` = "x-ua-compatible",
            content = "ie=edge"
        ),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(
            type = "text/css",
            rel = "stylesheet",
            href = "css/styles.css"
        )
    ),
    shinyUI(
        navbarPage(
            title = "National Park",
            tabPanel(
                title = "Home",
                tags$div(
                    class = "landing-wrapper",
                    # child element 1: images
                    tags$div(
                        class = "landing-block background-content",
                        # images: top -> bottom, left -> right
                        tags$div(tags$img(src = imgs[1])),
                        tags$div(tags$img(src = imgs[2])),
                        tags$div(tags$img(src = imgs[3])),
                        tags$div(tags$img(src = imgs[4]))
                    ),
                    # child element 2: content
                    tags$div(
                        class = "landing-block foreground-content",
                        tags$div(
                            class = "foreground-text",
                            tags$h1("Welcome"),
                            tags$p(
                                "This shiny app demonstrates how to create ",
                                "a 2 x 2 layout using css grid and ",
                                "overlaying content."
                            ),
                            tags$p("Isn't this cool?"),
                            tags$p("Yes it is!")
                        )
                    )
                )
            )
        )
    )
)


# server
server <- function(input, output) {

}

# app
shinyApp(ui, server)
