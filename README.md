![the shiny app tutorials project](shinytutorials.png)

# shinyTutorials

This repo contains the code for the examples and demonstrations presented on my shiny tutorials site: [davidruvolo51.github.io/shinytutorials/](https://davidruvolo51.github.io/shinytutorials/).

- [Motivation](#motivation)
- [Tutorials](#tutorials)
  - [Cloning Tutorials](#cloning-tutorials)
  - [Available Tutorias](#available-tutorials)
  - [Archived Tutorias](#archived-tutorials)
- [Resources](#resources)
  - [Communities](#communities)
  - [Courses](#courses)
  - [Web Accessibility](#accessibility)
  - [Web Development](#web-development)
- [Contributing to this project](#contributing-to-this-project)

## Motivation

In my early days of learning shiny, I kept a document of all my tips and tricks. It worked nicely, but it quickly became too cluttered and scattered. I decided to create this project to organize the material in to a series of practical examples and to make it available for the wider R community.

My interests are in web accessibility, data visualization and communication of results, and good design practices. Many of these tutorials focus heavily on HTML, CSS, and JavaScript, but I will try to keep things simple and provide links for further reading. Suggestions, comments, ideas for improvement are always welcome!

## Tutorials

I plan on developing a new Shiny app every now and then. Checkout the issues label `Tutorial Ideas` for examples that I'm currently developing. If you have an idea, feel free to open a new issue.

All *live* examples can be found in the [Available Tutorials](#available-tutorials) table. The *archived* example apps listed in the [Archived Tutorials](#archived-tutorials) section. These examples still work, but the methods are outdated or the example was replaced by a newer one.

### Cloning Tutorials

You can clone the entire repository, but be aware that you will also clone the entire git history. You can either download the files or folders that you want or use `git sparse-checkout`. In the terminal, run the following commands.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set drag-and-drop
```

Switch `drag-and-drop` for the subdirectory(ies) that you wish to checkoout. For more information, checkout the GitHub blog post: [Bring your monorepo down to size with sparse-checkout](https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/). Be aware that this is slightly experimental and these instructions may change.

### Available Tutorials

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
| setting html attributes | define and set values for the `<html>` element | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/setting-html-attributes/)
| shiny landing page | create cool landing pages in shiny | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/landing-page/)
| shiny links | create links to other tabs | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-link/)
| shiny listbox | create a listbox component as an alternative to select inputs | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/listbox-widget/)
| time input | getting started with input bindings | working | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/time-input/)


### Archived Tutorials

The examples listed in the following table are achived. They still work, but they are either outdated or were replaced by a newer example. (I'm a bit hesitant to remove these examples in case some follows a link to a page that doesn't exist.)

| Name | Description | Status | Link |
| :--- | :---------- | :----  | :--- |
| internal links basic example\* | learn how to create a link from one shiny page to another | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-a/)
| internal links demo\* | navigate to a specific tab on another shiny page | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-c/)
| internal links\* | create a link to another tab from a leaflet map | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-b/)
| select input styling | custom styling for inputs | archived | [tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/select-input-styling/)


\* These examples are outdated. Instead, use the `shinyLink` component described in the [Shiny Link](https://github.com/davidruvolo51/shinyAppTutorials/tree/prod/shiny-links) subdirectory. (02 August 2020)

## Resources

Many of the tutorials rely heavily on HTML, CSS and JavaScript to create specific layouts and interactivity. These are good skills to have, and they will come in handy when building custom applications. Throughout the examples, I've tried to keep things simple and provide links to outside sources where applicable. If something isn't clear or you have suggestions for improvement, feel free to open a new issue. 

If you would like to learn more, here are some links that you may find useful.

### Communities

- [Data Visualization Society](https://www.datavisualizationsociety.com)
- [dev.to](https://dev.to)
- [RStudio Community](https://community.rstudio.com)
- [r/rstats](https://www.reddit.com/r/rstats/)
- [r/rshiny](https://www.reddit.com/r/rshiny/)
- [Twitter #rstats](https://twitter.com/hashtag/rstats)

### Courses

- [W3C Online Courses](https://www.edx.org/school/w3cx) (free on [edx.org](https://www.edx.org))

### Web Accessibility

- [a11y project](https://a11yproject.com)
- [Accessibility Developer Guide](https://www.accessibility-developer-guide.com)
- [Mozilla's Learn Accessibility](https://developer.mozilla.org/en-US/docs/Web/Accessibility)
- [macOS Voice Over Commands](https://help.apple.com/voiceover/command-charts/)
- [WAI's Web Accessibility Tutorials](https://www.w3.org/WAI/tutorials/)
- [Web Accessibility Initiative](https://www.w3.org/WAI/)

### Web Development

- [CSS Tricks](https://css-tricks.com)
- [Mozilla's CSS documentation](https://developer.mozilla.org/en-US/docs/Web/CSS)
- [Mozilla's Learn CSS](https://developer.mozilla.org/en-US/docs/Learn/CSS)
- [Mozilla's Learn HTML](https://developer.mozilla.org/en-US/docs/Learn/HTML)
- [Mozilla's Learn JavaScript](https://developer.mozilla.org/en-US/docs/Learn/JavaScript)
- [Resources for Front-End Beginners](https://github.com/thedaviddias/Resources-Front-End-Beginner)

## Contributing to this project

I plan on writing an example once in a while. Check open issues for the label `tutorial ideas`. Comments and suggestions are always welcome. If you would like to add your own tutorial, that would be wonderful! Get in touch with me by opening a new issue and checkout the [Contributing Guidelines](https://github.com/davidruvolo51/shinyAppTutorials/blob/master/CONTRIBUTING.md) for more information.