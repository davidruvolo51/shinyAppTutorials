<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-listbox%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-listbox%2Fpackage.json)
<!-- badges: end -->

# Listbox Widget

Create a listbox widget as a customizable, dynamic, and accessible alternative to select input widgets. For more information, see the longer post [listbox widget](https://davidruvolo51.github.io/shinytutorials/tutorials/listbox-widget/).

To use this component, you will need the following files.

```text
my-project/
    R/
        listbox.R
    www/
        css /
            listbox.css
        js/
            listbox.js
    ...
```

I've included the SASS file and build scripts (using Parcel JS) for compiling the CSS file. I would recommend using SASS for larger projects and importing the `listbox.scss` accordingly. If you are using vanilla CSS, then load the `listbox.css` file directly into your app or copy the contents into your app's primary CSS file.

You can use the listbox component in your apps like so.

```r
listbox(
    inputId = "popularTech",
    title = "The Most Popular Technologies",
    label = "Select a technology",
    options = c(
        "JavaScript",
        "HTML/CSS",
        "SQL",
        "Python",
        "Java",
        "Bash/Shell/Powershell",
        "C#",
        "PHP",
        "Typescript",
        "C++"
    ),
    values = c(
        "js",
        "html_css",
        "sql",
        "py",
        "java",
        "bsh_sh_powershell",
        "csharp",
        "php",
        "typescript",
        "cpp"
    )
)
```

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "shiny-listbox")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set shiny-listbox
```

Then you can run the shiny app in your preferred R environment.
