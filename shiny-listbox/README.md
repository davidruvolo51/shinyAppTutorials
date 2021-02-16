<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=2d7ddd&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-listbox%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=success&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Fshiny-listbox%2Fpackage.json)
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

### Clone the `shiny-listbox` subdirectory

You can clone the entire repository if you like. However, doing so will clone the entire history to your local machine. I would recommend using `git sparse-checkout` to clone the repository locally.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set shiny-listbox
```

Then you can run the shiny app in your preferred R environment.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "shiny-listbox")
```

## Developing Locally

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### 1. Install Node and NPM

Make sure [Node and NPM](https://nodejs.org/en/) are installed on your machine. You may also use [Yarn](https://yarnpkg.com/en/). To test the installation or to see if these tools are already installed on your machine, run the following commands in the terminal.

```shell
node -v
npm -v
```

### 2. Clone the `shiny-listbox` subdirectory

See the section [Clone the shiny-listbox subdirectory](clone-the-shiny-listbox-subdirectory) for more information.

### 3. Install dependencies

Next, install the npm packages that are required to run the app locally. I have decided to use [pnpm](https://github.com/pnpm/pnpm) to manage packages on my machine and across projects. To install `pnpm`, run the following command.

```shell
npm install -g pnpm
```

You will need to install the dependencies in the `shiny-listbox` subdirectory.

```shell
cd shiny-listbox
pnpm install
```

If you prefer to use `npm`, use the following.

```shell
cd shiny-listbox
npm install
```

### 4. Start the development servers

When everything is install, navigate back to the main directory and start the development server. This will start the client at port `localhost:8000` and the API at `localhost:5000`.

```shell
npm run start
```
