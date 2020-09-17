![the shiny app tutorials project](shinytutorials.png)

# shinyTutorials

This repo contains the code for the examples and demonstrations presented on my shiny tutorials site: [davidruvolo51.github.io/shinytutorials/](https://davidruvolo51.github.io/shinytutorials/). 

## Motivation

In my early days of learning shiny, I kept a document of all my tips and tricks. It worked nicely, but it quickly became too cluttered and scattered. I decided to create this project to organize the material in to a series of practical examples and to make it available for the wider R community.

My interests are in web accessibility, data visualization and communication of results, and good design practices. Many of these tutorials focus heavily on HTML, CSS, and JavaScript, but I will try to keep things simple and provide links for further reading. Suggestions, comments, ideas for improvement are always welcome!

## Tutorials

| Name | Description | Status | Link |
| :--- | :---------- | :----  | :--- |
| data editor | edit a dataset in shiny | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/data-editor/)
| drag and drop | a shinyapp with elements that can be dragged and dropped | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/drag-and-drop/)
| get window dimensions | how to use window dimensions in a Shiny app: an example on sending data from javascript | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/get-window-dims/)
| js handlers | learn how to create a theme switcher through custom js handlers | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/js-handlers/)
| leaflet loading screens | create a busy element during leaflet rendering | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/leaflet-loading-screens/)
| login screen | demo for creating a log in screen with "admin rights" | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/login-screen/)
| progress bar R6 | example app to create a progress bar while clicking through screens | working | tbd
| responsive datatables | creating datatables that look good on all screens | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/responsive-tables/)
| rmarkdown app | Write content in an RMD file and use it as the UI | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/rmarkdown-shiny/)
| sass in shiny | setting up sass for use in shiny apps | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/sass-in-shiny/)
| select input styling | custom styling for inputs | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/select-input-styling/)
| setting html attributes | define and set values for the `<html>` element | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/setting-html-attributes/)
| shiny landing page | create cool landing pages in shiny | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/landing-page/)
| shiny links | create links to other tabs | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-link/)
| shiny listbox | create a listbox component as an alternative to select inputs | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/listbox-widget/)
| time input | getting started with input bindings | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/time-input/)


### Archived Examples

The examples listed in the following table are achived. They still work, but they are either outdated or were replaced by a newer example.

| Name | Description | Status | Link |
| :--- | :---------- | :----  | :--- |
| internal links basic example\* | learn how to create a link from one shiny page to another | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-a/)
| internal links demo\* | navigate to a specific tab on another shiny page | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-c/)
| internal links\* | create a link to another tab from a leaflet map | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-b/)


\* These examples are outdated. Instead, use the `shinyLink` component described in the [Shiny Link](https://github.com/davidruvolo51/shinyAppTutorials/tree/prod/shiny-links) subdir. (02 August 2020)

## Resources

Many of the tutorials use CSS and JavaScript, as well as HTML to create specific layouts and custom designs rather than ShinyUI functions (e.g., fluidPage, navbarPage, etc.). These are good skills to have, and they will come in handy when building custom shiny applications. Here are some links that you may find useful.

### Web Development

- [CSS Tricks](https://css-tricks.com)
- [Mozilla's CSS documentation](https://developer.mozilla.org/en-US/docs/Web/CSS)
- [Mozilla's Learn CSS](https://developer.mozilla.org/en-US/docs/Learn/CSS)
- [Mozilla's Learn HTML](https://developer.mozilla.org/en-US/docs/Learn/HTML)
- [Mozilla's Learn JavaScript](https://developer.mozilla.org/en-US/docs/Learn/JavaScript)
- [Resources for Front-End Beginners](https://github.com/thedaviddias/Resources-Front-End-Beginner)

### Accessibility

- [a11y project](https://a11yproject.com)
- [Accessibility Developer Guide](https://www.accessibility-developer-guide.com)
- [Mozilla's Learn Accessibility](https://developer.mozilla.org/en-US/docs/Web/Accessibility)
- [macOS Voice Over Commands](https://help.apple.com/voiceover/command-charts/)
- [WAI's Web Accessibility Tutorials](https://www.w3.org/WAI/tutorials/)
- [Web Accessibility Initiative](https://www.w3.org/WAI/)

### Communities

- [Data Visualization Society](https://www.datavisualizationsociety.com)
- [dev.to](https://dev.to)
- [RStudio Community](https://community.rstudio.com)


### Courses

- [W3C Online Courses](https://www.edx.org/school/w3cx) (free on [edx.org](https://www.edx.org))

## Contributing to this project

I plan on writing an example once in a while. Check open issues for the label `tutorial ideas`. Comments and suggestions are always welcome. If you would like to add your own tutorial, that would be wonderful! Get in touch with me by opening a new issue and checkout the [Contributing Guidelines](https://github.com/davidruvolo51/shinyAppTutorials/blob/master/CONTRIBUTING.md) for more information.