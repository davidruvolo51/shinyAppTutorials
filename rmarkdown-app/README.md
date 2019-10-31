# Using Rmarkdown in Shiny

> The Tutorial is now available on my shiny tutorials site: [Building your UI with Rmarkdown Reports](https://davidruvolo51.github.io/shinytutorials/tutorials/rmarkdown-shiny/)


This shiny app was created in response to this [post](https://community.rstudio.com/t/generating-markdown-reports-from-shiny/8676). In this example, the app allows users to make a selection, render a report (Rmarkdown file) based on the selection, and then display the rendered document in shiny.

You can run this demo by cloning the github repository and opening the Rproject file in rmarkdown-app directory. Alternatively, you can run the app through the console using:

```r
install.packages(shiny)
shiny::runGithub(repo="shinyAppTutorials", username="davidruvolo51", subdir="rmarkdown-app")
```

