# Creating internal hrefs in shiny apps


> This example is outdated. Instead, use the `shinyLink` component described in the [Shiny Link](https://github.com/davidruvolo51/shinyAppTutorials/tree/prod/shiny-links) subdir. (02 August 2020)


![](internal-links-vis.gif)

Creating hrefs to tabs in shiny is tricky as the href in `<a href='target-page'>...</a>` generates new links on each `runApp()`. To accomplish this, you must target the `value` in `tabPanel()` using javascript. 

Read more about this app here: [davidruvolo51.github.io/shinytutorials/tutorials/internal-links-b/](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-b/).

### How can I run this app?

To run this app locally, open up R and paste the following code into the console, and then press enter.

```
shiny::runGitHub(
    username="davidruvolo51",
    repo="shinyAppTutorials", 
    subdir = "Internal-Links"
)
```


