![the shiny app tutorials project](shinytutorials.png)

<!--- badges: start --->
[![Update README](https://github.com/davidruvolo51/shinyAppTutorials/actions/workflows/update-readme-tables.yml/badge.svg)](https://github.com/davidruvolo51/shinyAppTutorials/actions/workflows/update-readme-tables.yml)
<!--- badges: end --->

# shinyTutorials

This repo contains the code for the examples and demonstrations presented on my site: [davidruvolo51.github.io/shinytutorials/](https://davidruvolo51.github.io/shinytutorials/).

## Contents

<!-- TOC depthFrom:2 -->

- [Contents](#contents)
- [Motivation](#motivation)
- [Tutorials](#tutorials)
    - [Cloning Tutorials](#cloning-tutorials)
    - [Available Tutorials](#available-tutorials)
    - [Archived Tutorials](#archived-tutorials)
- [Resources](#resources)
    - [Communities](#communities)
    - [Courses](#courses)
    - [Web Accessibility](#web-accessibility)
    - [Web Development](#web-development)
- [Contributing to this project](#contributing-to-this-project)

<!-- /TOC -->

## Motivation

In my early days of learning shiny, I kept a document of tips and tricks. It worked nicely, but it quickly became too cluttered and scattered. I decided to create this project to organize the material in to a series of practical examples and to make it available for the wider R community.

I am interested in web accessibility, data visualization and the communication of results, and good design practices. Many of the examples that I developed rely heavily on HTML, CSS, and JavaScript methods. I will try to keep things simple and provide links for further reading.

Suggestions for improvement are always welcome!

## Tutorials

I plan on developing a new Shiny app every now and then. Checkout the issues label `Tutorial Ideas` for examples that I'm currently developing or planning. New ideas are also welcome!

There are two types of examples: available and archived. *Available* examples are regularly maintained and updated. The *archived* examples still work, but the methods are outdated or the example was replaced by a newer one.

### Cloning Tutorials

You can clone the entire repository, but be aware that you will also clone the entire git history. You can either download the files or folders that you want or use `git sparse-checkout`. In the terminal, run the following commands.

```bash
git clone --filter=blob:none --sparse https://github.com/davidruvolo51/shinyAppTutorials
cd shinyAppTutorials
git sparse-checkout init --cone
git sparse-checkout set drag-and-drop
```

Replace `drag-and-drop` for the subdirectory that you wish to checkout locally. For more information, take a look at this GitHub blog post: [Bring your monorepo down to size with sparse-checkout](https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/).

### Available Tutorials

<!-- begin:activeTutorials -->
|name                    |description                                           |version |link                                                                                         |
|:-----------------------|:-----------------------------------------------------|:-------|:--------------------------------------------------------------------------------------------|
|data-editor             |A shiny app for editing dataset in shiny              |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/data-editor)             |
|drag-and-drop           |create a drag and drop component                      |1.0.1   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/drag-and-drop)           |
|get-window-dims         |sending data from javascript                          |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/get-window-dims)         |
|js-handlers             |getting started with custom handlers                  |1.1.1   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/js-handlers)             |
|leaflet-loading-screens |creating a loading screen for leaflet                 |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/leaflet-loading-screens) |
|login-screen            |Adding *basic* user authentication to shiny apps      |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/login-screen)            |
|progress-bars-example   |creating a shiny progressbar using R6 classes         |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/progress-bars-example)   |
|responsive-datatables   |create responsive datatables in R                     |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/responsive-datatables)   |
|rmarkdown-app           |using Rmarkdown as Shiny UI                           |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/rmarkdown-app)           |
|sass-in-shiny           |integrating SASS into your Shiny development workflow |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/sass-in-shiny)           |
|setting-html-attributes |set document attributes                               |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/setting-html-attributes) |
|shiny-landing-page      |create a landing page                                 |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-landing-page)      |
|shiny-links             |a component for within app navigation                 |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-links)             |
|shiny-listbox           |create listbox components in shiny                    |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-listbox)           |
|time-input              |creating a custom time input for use in shiny         |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/time-input)              |
<!-- end:activeTutorials -->

### Archived Tutorials

The examples listed in the following table are achived. They still work, but they are either outdated or were replaced by a newer example. (I'm a bit hesitant to remove these examples in case some follows a link to a page that doesn't exist.)

<!-- begin:archivedTutorials -->
|name                    |description                                        |version |link                                                                                         |
|:-----------------------|:--------------------------------------------------|:-------|:--------------------------------------------------------------------------------------------|
|internal-links          |Create a link from a leaflet popup to a shiny page |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links)          |
|internal-links-basic-ex |Create links from one shiny page to another        |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-basic-ex) |
|internal-links-demo     |Navigate to a specific tab on another page         |1.1.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/internal-links-demo)     |
|select-input-styling    |Style a select input element using CSS             |1.0.0   |[tutorial](https://davidruvolo51.github.io/shinytutorials/tutorials/select-input-styling)    |
<!-- end:archivedTutorials -->

The internal links examples are outdated. Instead, use the `shinyLink` component described in the [Shiny Link](https://github.com/davidruvolo51/shinyAppTutorials/tree/prod/shiny-links) subdirectory (02 August 2020).

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

If you would like to add your own tutorial, that would be wonderful! Get in touch with me by opening a new issue and checkout the [Contributing Guidelines](https://github.com/davidruvolo51/shinyAppTutorials/blob/master/CONTRIBUTING.md).
