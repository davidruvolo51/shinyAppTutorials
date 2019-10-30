# Contributing to the Shiny App Tutorials

Thank you for your interest in this project!

Suggestions, comments, ideas for improvement are always warmly welcomed. If you would like to write a tutorial, you are more than welcome and encouraged to do so. In this guide, you can find more information about the project (both the static site repo and the shiny repo) to make contributing to the project easier. If you have any questions, feel free to get in touch with me.

## Contents

1. Background
    - About the project
    - The structure of the project
2. Contributing

## Background

### About the project

Why did I start this project? In my early days of learning shiny, I kept a document of all my tips and tricks. It worked nicely, but it quickly became too cluttered and scattered. I decided to create this project to organize the material in to a series of practical examples and templates available for the wider R community.

I write tutorials on things that I'm learning on at the moment or if there is something that I'm curious if shiny can do. My interests are in web accessibility, data visualization and communication of results, as well as frontend development and good design practices. Many of these tutorials focus heavily on html, css, and javascript, but I will try to keep things simple and provide links for further reading.

### The structure of the project

There are two repos to this project.

1. [shinyAppTutorials](https://github.com/davidruvolo51/shinyAppTutorials)
2. [shinytutorials](https://github.com/davidruvolo51/shinytutorials)

The `shinyAppTutorials` repo contains all of the shinyapps and examples, as well as all related code discussed in the tutorials (e.g., css, js,  etc.). All written tutorials are stored in the `shinytutorials` repo. The static site is built with [gatsbyjs](https://www.gatsbyjs.org) and all tutorials are written in markdown.


## Contributing 

If you have any ideas to improve the tutorials (either in the code or in the writings), fork the repository, make all the changes, and then open a pull request. Make sure to include a README if you are adding a new app. 

If you would like to write or contribute to a tutorial, then create a fork of the shinytutorials repository. The static site is built using gatsbyJS. All development takes place on the `dev` branch. All tutorials are written in markdown using the following YAML header:

```
---
title: "Some Title"
subtitle: "A Subtitle"
abstract: "A summary of the tutorial"
date: "2019-09-06"
updated: "2019-10-25"
keywords: ["keyword1", "keyword2"]
---
```

The build process can be a bit confusing, so it might be easier to open a pull request from the dev branch.

Take a look at the existing directories and files to see how the projects are structured. Let me know if you have any questions.
