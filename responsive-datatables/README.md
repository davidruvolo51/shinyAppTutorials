<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=2d7ddd&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fresponsive-datatables%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=success&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fresponsive-datatables%2Fpackage.json)
<!-- badges: end -->

# Responsive Datatables in Shiny

See the longer write up on [responsive datatables](https://davidruvolo51.github.io/shinytutorials/tutorials/responsive-tables/) for more information and usage. The information below serves as a reference for the `datatable` function.

The datatable function generates an html table from a dataset. This func returns a shiny tagList object which can be used in shiny applications, markdown documents, or written to an html file. The datatable function takes the following arguments.

## Arguments

- `data`: the input dataset
- `id`: an identifier for the table ideal for styling specific tables or for use in js
- `caption`: a title for the table (recommended for accessible tables)
- `options`: as a list, i.e., `options = list(...)`
  - `responsive`: a logical argument for turning on/off the rendering of additional elements for responsive tables (i.e., span). (Default = FALSE)
  - `rowHeaders`: a logical argument that renders the first cell of every row as a row header. This is useful for datasets where all data in a row is related, e.g., patient data. If set to TRUE, the data must be organized so that the row header is the first column.
  - `asHTML`: a logical argument used to render cell text as html elements (default = FALSE)

## About
The datatable function requires two helper functions: 1) to generate the table header and another used 2) to generate the table body. The function `build_header()` renders the `<thead>` element according to the input data. The build_body functions renders the table's `<tbody>` based on the input and the options. This function uses a nested lapplys to iterate each row and cell. If the responsive opt is TRUE, then the function will return a `<span>` element with the current cell's column name. `<span>` has the class `hidden-colname` that hides/shows the element based on screen size (see datatable.css). Role attributes are added in the event the display properties are altered in css.

## Examples

From `tests/datatable_tests.R`

```r
# load file
source("R/datatable.R")

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
```

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "responsive-datatables")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set responsive-datatables
```

Then you can run the shiny app in your preferred R environment.
