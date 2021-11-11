#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-11-11
#' MODIFIED: 2021-11-11
#' PURPOSE: example Shiny app for accordion components
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

suppressPackageStartupMessages(library(shiny))

# define UI
ui <- tagList(
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(`http-quiv` = "x-ua-compatible", content = "ie=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(rel = "stylesheet", href = "css/app.css"),
        tags$link(rel = "stylesheet", href = "css/accordion.css"),
        tags$title("Accordion Component | shinyAppTutorials")
    ),
    tags$main(
        tags$header(
            tags$h1(
                title = "title",
                "Shiny Accordion"
            ),
            tags$h2(
                class = "subtitle",
                "A Shiny component for collapsing HTML elements"
            )
        ),
        tags$section(
            id = "section-example",
            `aria-labelledby` = "section-example-title",
            tags$h2(
                id = "section-example-title",
                "Example Usage"
            ),
            tags$p(
                "The accordion component is useful for creating interfaces",
                "where certain elements on a page can be collapsed.",
                "For example, FAQ pages or visually hidding secondary",
                "information. In this example, I created a simple FAQ page that",
                "demonstrates the functionality of the accordion component."
            )
        ),
        tags$section(
            id = "section-faq",
            `aria-labelledby` = "section-faq-title",
            tags$h2(
                id = "section-faq-title",
                "Frequently Asked Questions"
            ),
            accordion(
                inputId = "what-is-shiny",
                title = "What is Shiny?",
                content = tagList(
                    tags$p(
                        "Shiny is an R package that makes it easy to build",
                        "interactive web apps straight from R. You can host",
                        "standalone apps on a webpage or embed them in R",
                        "Markdown documents or build dashboards. You can also",
                        "extend your Shiny apps with CSS themes, htmlwidgets,",
                        "and JavaScript actions."
                    ),
                    tags$p(
                        "Learn more at",
                        tags$a(
                            href = "https://shiny.rstudio.com/",
                            "shiny.rstudio.com"
                        )
                    ),
                    tags$cite("Rstudio.org")
                )
            ),
            accordion(
                inputId = "what-is-rmarkdown",
                title = "What is R Markdown?",
                content = tagList(
                    tags$p(
                        "R Markdown provides an authoring framework for data",
                        "science. You can use a single R Markdown file to both",
                        tags$ul(
                            tags$li("save and execute code"),
                            tags$li(
                                "generate high quality reports that can be",
                                "shared with an audience"
                            )
                        ),
                        tags$p(
                            "Learn more at",
                            tags$a(
                                href = "https://rmarkdown.rstudio.com/",
                                "rmarkdown.rstudio.com"
                            )
                        ),
                        tags$cite("Rstudio.org")
                    )
                )
            )
        )
    )
)


# define server
server <- function(input, output, session) {

}

# define app and options
shinyApp(ui, server)