#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-08-02
#' MODIFIED: 2020-08-02
#' PURPOSE: Update example on creating internal links
#' STATUS: in.progress
#' PACKAGES: Shiny
#' COMMENTS: This Shiny app replaces previous example apps as there were
#' accessibility concerns with the previous method. This approach is much
#' easier to use as it uses Shiny Input Bindings rather than inline onclick
#' event declarations.
#'////////////////////////////////////////////////////////////////////////////

# pkgs
library(shiny)


rCode <- paste0(readLines("R/shinyLink.R"), collapse = "\n")
jsCode <- paste0(readLines("www/shinyLink.js"), collapse = "\n")

# ui
ui <- tagList(
    tags$head(
        tags$link(rel = "stylesheet", href = "styles.css"),
        tags$title("Shiny Link Component")
    ),
    navbarPage(
        title = "shinyLink",

        # tab 1 - home
        tabPanel(
            title = "Home",
            value = "home",
            tags$h1("Creating Internal Links"),
            tags$img(
                src = "chain-image.jpg",
                alt = "the ends of two metal chains linked together by a ring"
            ), 
            tags$p(
                "This Shiny app uses a custom input component with a Shiny",
                "input binding to create internal links to other pages in a",
                "shiny application. This is ideal for Shiny apps that use",
                "navbarPage, tabPanel, and tabsetPanel layouts."
            ),
            tags$p(
                "Visit the", shinyLink(to = "code", "Code Page"), "to view",
                "the", shinyLink(to = "r", label = "R Code"), "and the",
                shinyLink(to = "javascript", "JavaScript input binding")
            )
        ),

        # tab 2 - code
        tabPanel(
            title = "Code",
            value = "code",
            tags$h1("Code"),
            tags$p(
                "View the R code and the JavaScript Input Binding for the",
                tags$code("shinyLink"), "component."
            ),
            tabsetPanel(
                tabPanel(
                    title = "R",
                    value = "r",
                    tags$h2("The shinyLink Component"),
                    tags$p(
                        "The", tags$code("shinyLink"), "has two input args",
                        tags$code("to"), "and", tags$code("label"),
                        ". Use", tags$code("to"), "to specify the tab you",
                        "would like to navigate to, and use",
                        tags$code("label"), " to",
                        "describe the link. The value entered for",
                        tags$code("to"),
                        "must match the target tabPanel (i.e., the value",
                        "entered for ", tags$code("title"), " or",
                        tags$code("value"), "."
                    ),
                    tags$p(
                        "It is strongly recommended to structure the tabPanels",
                        "using the", tags$code("value"),
                        "argument. By default, the value",
                        "supplied for", tags$code("title"),
                        "will be used as the tab's value.",
                        "However, if the title has many spaces or characters,",
                        "it is more difficult to find and select elements in",
                        "JavaScript. Instead, use the attribute",
                        tags$code("value"), "and enter",
                        "a concise name without spaces or characters (",
                        "with the exception of underscores or hyphens).",
                        "For example, if the title was 'Data Visualisations",
                        "and Tables', then the value should be 'data' or",
                        "'data-viz'."
                    ),
                    tags$pre(tags$code(rCode)),
                    tags$p(
                        shinyLink(
                            to = "javascript",
                            label = "View JavaScript code"
                        )
                    ),
                    tags$p(
                        shinyLink(
                            to = "home",
                            label = "Go back to the home page"
                        )
                    )
                ),
                tabPanel(
                    title = "JavaScript",
                    value = "javascript",
                    tags$h2("JavaScript"),
                    tags$p(
                        "Here is the shiny input binding for the",
                        tags$code("shinyLink"), "component."
                    ),
                    tags$pre(tags$code(jsCode)),
                    tags$p(
                        shinyLink(
                            to = "r",
                            label = "View R Component"
                        )
                    ),
                    tags$p(
                        shinyLink(
                            to = "home",
                            label = "Go back to the home page"
                        )
                    )
                )
            )
        )
    ),
    tags$script(src = "shinyLink.js")
)


# server
server <- function(input, output) {

}


# app
shinyApp(ui, server)