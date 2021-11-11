<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=2d7ddd&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-accordion%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=success&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-accordion%2Fpackage.json)
<!-- badges: end -->

# Shiny Accordion

A shiny component for collapsing HTML elements.

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "shiny-accordion")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/
shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set shiny-accordion
```

Then you can run the shiny app in your preferred R environment.
