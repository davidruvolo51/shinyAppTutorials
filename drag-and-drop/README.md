# Drag and Drop

This shiny app demonstrates how to create a basic drag and drop area in shiny applications using the drag and drop javascript API (native in browsers). There is some logic that highlights dragged elements and potential "drop areas". There is some basic support for determining if the a card should be placed before or after a new card.

In the example, you can reorder the cards (generated using a functional component `draggable_card`) anyway you like (i.e, by cases, by group name, reverse order, etc.). You can run this example from the R console using the following command.

```r
shiny::runGitHub(
    repo = "shinyAppTutorials",
    username = "davidruvolo51",
    subdir = "drag-and-drop"
)
```