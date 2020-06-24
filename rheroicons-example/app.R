#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-24
#' MODIFIED: 2020-06-24
#' PURPOSE: rheroicons demo
#' STATUS: in.progress
#' PACKAGES: shiny; rheroicons
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# install
# devtools::install_github("davidruvolo51/rheroicons@prod")

# pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(rheroicons))

# ui
ui <- tagList(
    singleton(
        tags$head(
            tags$meta(charset = "utf-8"),
            tags$meta(`http-quiv` = "x-ua-compatible", content = "ie=edge"),
            tags$meta(
                name = "viewport",
                content = "width=device-width, initial-scale=1"
            ),
            tags$link(
                rel = "stylesheet",
                href = "styles.css"
            ),
            tags$title("rheroicons demo")
        )
    ),
    tags$nav(
        id = "nav",
        class = "navbar",
        tags$ul(
            class = "menu nav-links",
            tags$li(
                class = "menu-item",
                tags$a(
                    class = "menu-link",
                    href = "#",
                    outline$home(aria_hidden = TRUE),
                    "Home"
                )
            ),
            tags$li(
                class = "menu-item",
                tags$a(
                    class = "menu-link",
                    href = "#",
                    outline$book_open(aria_hidden = TRUE),
                    "Blog"
                )
            ),
            tags$li(
                class = "menu-item",
                tags$a(
                    class = "menu-link",
                    href = "#",
                    outline$information_circle(aria_hidden = TRUE),
                    "About"
                )
            ),
            tags$li(
                class = "menu-item",
                tags$a(
                    class = "menu-link",
                    href = "#",
                    outline$mail(aria_hidden = TRUE),
                    "Contact Us"
                )
            )
        ),
        tags$ul(
            class = "menu menu-options",
            tags$li(
                class = "menu-item",
                tags$button(
                    id = "userAccount",
                    class = "shiny-bound-input action-button menu-button",
                    tags$span(
                        class = "visually-hidden",
                        "access user information"
                    ),
                    outline$user_circle()
                )
            ),
            tags$li(
                class = "menu-item",
                tags$button(
                    id = "menuToggle",
                    class = "shiny-bound-input action-button .menu-button",
                    tags$span(class = "visually-hidden", "open and close menu"),
                    outline$dots_vertical()
                )
            )
        )
    ),
    tags$header(
        class = "hero",
        tags$div(
            class = "hero-content",
            tags$h1(
                solid$sparkles(
                    class = "hero-icon",
                    aria_hidden = FALSE
                ),
                "rheroicons"
            ),
            tags$h2(
                "The amazing heroicons library now available for Shiny"
            ),
            tags$a(
                class = "button-link",
                href = "#start",
                "Get Started",
                outline$arrow_circle_right(aria_hidden = TRUE)
            )
        )
    ),
    tags$main(
        id = "main",
        class = "main subpage-container",
        tags$section(
            class = "section",
            tags$h2(
                "Welcome!",
                outline$emoji_happy(aria_hidden = TRUE)
            )
        )
    )
)

# server
server <- function(input, output, session) {

}


# app
shinyApp(ui, server)