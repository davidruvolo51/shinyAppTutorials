<!-- badges: start -->
![version](https://img.shields.io/badge/dynamic/json?color=%22dd77&label=version&query=version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Flogin-screen%2Fpackage.json)
![status](https://img.shields.io/badge/dynamic/json?color=%3772FF&label=status&query=status&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavidruvolo51%2FshinyAppTutorials%2Fmain%2Flogin-screen%2Fpackage.json)
<!-- badges: end -->

# Custom Log in screen for shinyapps

Implement user authentication into your shiny app. For more information, checkout the blog post [Login Screen: Building a simple password protected shiny app](https://davidruvolo51.github.io/shinytutorials/tutorials/login-screen/).

This method offers some sort of "protection" for your app. I've used this method to create a project management tool to manage daily activities and tasks. It was hosted on department servers and I added this login screen only those with an account could view it. If you have sensitive data, you should follow your organization's guidelines for best practices and security guidelines.```

Test out the app with one of the following accounts.

| type     | Username | password  |
|----------|----------|-----------|
| standard | user     | user1234  |
| admin    | admin    | admin1234 |

## Getting Started

You can run this app locally using the following methods: running within your R environment or cloning this subdirectory.

### Running in your R environment

You can run this app within your R environment using the `runGithub` function. Enter the following command in the console.

```r
shiny::runGitHub(username = "davidruvolo51", repo = "shinyAppTutorials", subdir = "login-screen")
```

### Cloning the subdirectory

You can clone the data editor subdirectory using `git sparse-checkout`.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set login-screen
```

Then you can run the shiny app in your preferred R environment.
