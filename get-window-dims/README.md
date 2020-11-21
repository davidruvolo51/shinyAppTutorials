<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fget-window-dims%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fget-window-dims%2Fpackage.json)
<!-- badges: end -->

# Get Window Dimensions

This shiny app demonstrates how to read and use the browser dimensions in the Shiny server. This example is a demonstration on setting up Shiny and JavaScript communication rather than using window height or width for modifying the client (as this should be used on the JS not shiny).

You can find more information about this application in the blog post [get window dimensions](https://davidruvolo51.github.io/shinytutorials/tutorials/get-window-dims/).

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "get-window-dims")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set get-window-dims
```

Then you can run the shiny app in your preferred R environment.
