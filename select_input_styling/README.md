# Applying CSS Styles to Select Inputs

The purpose of this app is to demonstration how to style the select input widget in shiny apps. This app was created in response to this community rstudio post: [https://community.rstudio.com/t/selectinput-css-customization/12664/](https://community.rstudio.com/t/selectinput-css-customization/12664).

> Before you begin, I would use caution in using this approach as overriding browser defaults can cause things to break or not function properly. Check site such as caniuse.com for browerser support before implementing into your production app.

> Also, the `onfocus` and `onblur` and `onchange` should really be added through javascript listeners. Future updates will correct this and a longer post will be available.

## The Input Widget

The select input is built using `tags$select(...)` rather than using `selectInput()` as this would force us to overwrite a lot of bootstrap styles when it's easier to build our own.

The two things that I'd like to point out are the label and select elements. In the previous post, I mentioned that using tags$select might be a better option for adding custom styling. The structure to create the input using example provided ended up looking like this.

```r
# label
tags$label("for"="state", "Select a State", class="input-label"),

# input
tags$select(id="state","onfocus"='this.size=13;', "onblur"='this.size=1;' ,
            "onchange"='this.size=1; this.blur();',
            
            # default
            tags$option(value = "none", ""),
            
            # east coast
            tags$optgroup("label" = "East Coast",
                          tags$option(value = "NY", "NY"),
                          tags$option(value = "NJ", "NJ"),
                          tags$option(value = "CT", "CT")
            ),
            
            # west coast
            tags$optgroup("label" = "West Coast",
                          tags$option(value = "WA","WA"),
                          tags$option(value = "OR","OR"),
                          tags$option(value = "CA","CA")
            ),
            
            # midwest
            tags$optgroup("label" = "Midwest",
                          tags$option(value = "MN","MN"),
                          tags$option(value = "WI","WI"),
                          tags$option(value = "IA","IA")
            )
)
```

In `tags$select`, the attributes `onfocus`, `onblur`, and `onchange` are event listeners and allow you to define the behaviors when the input is active, inactive, and closed. For example, If you used `"onfocus"='this.size=6;'`, you will only see the first 6 elements (-ish depending on other styling - padding, margins, etc.). onblur sets the number of elements to display after is inactive (no longer focused; e.g., if the menu is opened and the user clicks another part of the page) and onchange sets the number of elements to display once an option is selected.


In order to add styling to the input, I set the -webkit-appearance to none (webkit and moz are vender prefixes for chrome and mozilla's FireFox). I set the width of the input to 90% of the parent element (sidebarPanel). This will allow the input to be resized accordingly when the browser dimensions are changed (resized).

Since we are adding new styles, I wrote a menu button and set it as the background. background-position sets the position of the icon (x = 95%; y = 20px).

```css
/* primary styling for <select> + manually add menu button */
#state{
    -webkit-appearance:none;
    -moz-appearance:none;
    width: 90%;
    padding: 15px;
    font-size: 14pt;
    border-radius: 0;
    outline: none;
    border: 2px solid #3A506B;
    color: #3A506B;
    background: url(menu-chevron-down.svg) no-repeat;
    background-position: 95% 20px;
    background-color: white;
}
```

For the first `<option>` in each `<optgroup>`, set the background to green

For setting the background color, I used descendent selector paths to select the first element in each group. This says within the element with the id of state select the option groups, and then select the first child in each group. (If you wanted the second item in each group, it would be :nth-child(2)).

```css
#state optgroup option:nth-child(1){
    background-color: #31E981 !important;
    color: white;
}
```

