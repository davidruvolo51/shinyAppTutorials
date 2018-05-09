# Creating internal hrefs in shiny apps - Demo App

Creating hrefs to tabs in shiny is tricky as the href in `<a href='target-page'>...</a>` generates new links on each `runApp()`. To accomplish this, you must target the `value` in `tabPanel()` using javascript. 

This app demonstrates how to structure the app and load the script. Read more about this method [here](https://davidruvolo51.github.io/shinyAppTutorials/).

### How can I run this app?

To run this app locally, open up R and paste the following code into the console, and then press enter.

```r
shiny::runGitHub(
    username="davidruvolo51",
    repo="shinyAppTutorials", 
    subdir = "Internal-Links-Demo"
)
```


