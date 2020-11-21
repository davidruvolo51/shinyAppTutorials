<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Frmarkdown-app%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Frmarkdown-app%2Fpackage.json)
<!-- badges: end -->

# Using Rmarkdown in Shiny

This shiny app was created in response to this [post](https://community.rstudio.com/t/generating-markdown-reports-from-shiny/8676). In this example, the app allows users to make a selection, render a report (Rmarkdown file) based on the selection, and then display the rendered document in shiny. The Tutorial is now available on my shiny tutorials site: [Building your UI with Rmarkdown Reports](https://davidruvolo51.github.io/shinytutorials/tutorials/rmarkdown-shiny/)

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "rmarkdown-app")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set rmarkdown-app
```

Then you can run the shiny app in your preferred R environment.
