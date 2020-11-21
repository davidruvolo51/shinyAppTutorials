#'////////////////////////////////////////////////////////////////////////////
#' FILE: set_html_attribs.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-15
#' MODIFIED: 2020-07-15
#' PURPOSE: function to set document attributes
#' STATUS: working; complete
#' PACKAGES: Shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' set_html_attribs
#' Define the global attributes of the HTML Document
#' @param lang the language code of the page content (default: "en")
#' @param dir the direction the content should be read (default: "ltr")
#'
#' About `lang`
#' Depending on the language of your app, you may need to a subtag for
#' specificity. See https://r12a.github.io/app-subtags/ for the appropriate
#' langage tags and subtags, as well as using scripts for specifying inter-
#' language codes.
#'
#' About `dir`
#' Depending on the language of your app, you may need to specify the
#' direction of the page content. This is not done automatically. You can use
#' either `ltr` (left to right), `rtl` (right to left), or `auto`. In this
#' example, I've set the default to "ltr" as the language is "en".
#'
#' @examples
#' set_html_attribs()
#' set_html_attribs(lang = "fr")   # sets lang as French
#' set_html_attribs(lang = "nl")   # sets lang as Dutch
#' set_html_attribs(lang = "de")   # sets lang as German
#' set_html_attribs(lang = "es")   # sets lang as Spanish
set_html_attribs <- function(lang = "en", dir = "ltr") {

    # validate
    if (!is.character(lang)) stop("argument 'lang' must be a character")
    if (!is.character(dir)) stop("argument 'dir' must be a character")
    if (!dir %in% c("ltr", "rtl", "auto")) {
        stop("value for 'dir' is invalid. Use 'ltr', 'rtl', or 'dir'.")
    }

    # render hidden inline <span> element
    tags$span(
        id = "shiny__html_attribs",
        style = "display: none;",
        `data-html-lang` = lang,
        `data-html-dir` = dir
    )
}