# Creating internal hrefs in shiny apps - Demo App

> This example is outdated. Instead, use the `shinyLink` component described in the [Shiny Link](https://github.com/davidruvolo51/shinyAppTutorials/tree/prod/shiny-links) subdir. (02 August 2020)

Creating hrefs to tabs in shiny is tricky as the href in `<a href='target-page'>...</a>` generates new links on each `runApp()`. To accomplish this, you must target the `value` in `tabPanel()` using javascript. 

This app was built to debug an issue in [this r community thread](https://community.rstudio.com/t/link-tabs-in-navbarpage/7092/9). This app demonstrates how to structure each page and load the script. Read more about this method here [davidruvolo51.github.io/pages/shinytutorials/tutorials/internal-links-c.html](https://davidruvolo51.github.io/pages/shinytutorials/tutorials/internal-links-c.html).

### How can I run this app?

To run this app locally, open up R and paste the following code into the console, and then press enter.

```r
shiny::runGitHub(
    username="davidruvolo51",
    repo="shinyAppTutorials", 
    subdir = "Internal-Links-Demo"
)
```


### Other Resources

Check out the longer write-up and other demos here: [https://davidruvolo51.github.io/pages/shinytutorials/tutorials/internal-links-c.html](https://davidruvolo51.github.io/pages/shinytutorials/tutorials/internal-links-c.html).