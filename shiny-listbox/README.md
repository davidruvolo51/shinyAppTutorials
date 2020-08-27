# Shiny Listbox Component

Create a listbox widget as a customizable, dynamic, and accessible alternative to select input widgets. For more information, see the longer post [listbox component](https://davidruvolo51.github.io/shinytutorials/tutorials/listbox-component/).

To use this component, you will need the following files.

```
my-project/
    R/
        listbox.R
    www/
        css / 
            listbox.css
        js/
            listbox.js
    ...
```

I've included the SASS file and build scripts (using Parcel JS) for compiling the CSS file. I would recommend using SASS for larger projects and importing the `listbox.scss` accordingly. If you are using vanilla CSS, then load the `listbox.css` file directly into your app or copy the contents into your app's primary CSS file.

You can use the listbox component in your apps like so.

```
listbox(
    inputId = "popularTech",
    title = "The Most Popular Technologies",
    label = "Select a technology",
    options = c(
        "JavaScript",
        "HTML/CSS",
        "SQL",
        "Python",
        "Java",
        "Bash/Shell/Powershell",
        "C#",
        "PHP",
        "Typescript",
        "C++"
    ),
    values = c(
        "js",
        "html_css",
        "sql",
        "py",
        "java",
        "bsh_sh_powershell",
        "csharp",
        "php",
        "typescript",
        "cpp"
    )
)
```