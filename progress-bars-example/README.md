<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fprogress-bars-example%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fprogress-bars-example%2Fpackage.json)
<!-- badges: end -->

# R6 Progressbars

This application demonstrates how to create a progress bar for using in Shiny apps using R6 classes. The accompanying blog post is in progress.

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "progress-bars-examples")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set progress-bars-example
```

Then you can run the shiny app in your preferred R environment.
