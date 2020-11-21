<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fsass-in-shiny%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fsass-in-shiny%2Fpackage.json)
<!-- badges: end -->

## Using SASS in Shiny

In this example, learn how to integrate [SASS](https://sass-lang.com) into your Shiny development workflow. To get this example working, you will need to install [node.js](https://nodejs.org/en/) and SASS on your machine. See the [Install SASS guide](https://sass-lang.com/install) for additional instructions. There are two build scripts: one for development and one for production. When you have node installed, you can run these scripts in the command line.

```shell
npm run start   # for development
npm run build   # for production
```

Future applications will demonstrate how to integrate application bundlers and additional plugins, but we will keep things simple for now. For more information, checkout out the accompanying blog post [Shiny and CSS preprocessors: Getting started with SASS in Shiny](https://davidruvolo51.github.io/shinytutorials/tutorials/sass-in-shiny/).

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "sass-in-shiny")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set sass-in-shiny
```

Then you can run the shiny app in your preferred R environment.
