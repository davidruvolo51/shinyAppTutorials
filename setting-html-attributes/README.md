<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fsetting-html-attributes%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fsetting-html-attributes%2Fpackage.json)
<!-- badges: end -->

# Setting Html Attributes

When evaluating Shiny applications in terms of web accessibility, assessment tools will always throw an error: 'Document language missing'. Shiny does not set this attribute and others like it by default. In this tutorial, we will learn how to fix this. For more information, see the accompanying blog post [Setting Html Attributes](https://davidruvolo51.github.io/shinytutorials/tutorials/setting-html-attributes/).

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "setting-html-attributes")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set setting-html-attributes
```

Then you can run the shiny app in your preferred R environment.
