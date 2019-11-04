# Applying CSS Styles to Select Inputs

The purpose of this app is to demonstration how to style the select input widget in shiny apps. This app was created in response to this community rstudio post: [https://community.rstudio.com/t/selectinput-css-customization/12664/](https://community.rstudio.com/t/selectinput-css-customization/12664).

> Before you begin, I would use caution in using this approach as overriding browser defaults can cause things to break or not function properly. Check site such as caniuse.com for browerser support before implementing into your production app.

> Also, the `onfocus` and `onblur` and `onchange` should really be added through javascript listeners. Future updates will correct this and a longer post will be available.

You can run this demo by cloning the [github repository](https://github.com/davidruvolo51/shinyAppTutorials) and opening the Rproject file in `select_input_styling` directory. Alternatively, you can run the app through the console using:

```r
install.packages(shiny)
shiny::runGithub(repo="shinyAppTutorials", username="davidruvolo51", subdir="select_input_styling")
```

