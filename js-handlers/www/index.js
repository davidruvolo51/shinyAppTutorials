////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-09-09
// MODIFIED: 2021-02-22
// PURPOSE: constructors and Shiny bindings
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// init with global var
function handlers() {
    this.defaultTheme = "light";
    this.lastSavedTheme = null;
    this.currentTheme = null;
}

// add css
// @param elem selector for target element
// @param css name of the css class to add
handlers.prototype.addCSS = function (elem, css) {
    var elem = document.querySelector(elem);
    elem.classList.add(css);
}

// add css
// @param elem selector for target element
// @param css name of the css class to remove
handlers.prototype.removeCSS = function (elem, css) {
    var elem = document.querySelector(elem);
    elem.classList.remove(css);
}

// setCurrentTheme
// @param elem selector for target element
handlers.prototype.setCurrentTheme = function (elem) {
    var target = document.querySelector(elem);
    var css = Array.from(target.classList)[0];
    if (typeof css === "undefined" || css === null) {
        this.currentTheme = this.defaultTheme;
    } else {
        this.currentTheme = css;
    }
}

// save option to local storage
handlers.prototype.save = function (value) {
    localStorage.setItem("theme", value);
}

// load option from local storage
handlers.prototype.load = function () {
    return this.lastSavedTheme = localStorage.getItem("theme");
}

// set default theme
// @param elem selector of target element to bind class to
handlers.prototype.setDefault = function (elem) {
    this.load();
    if (typeof this.lastSavedTheme === "undefined" || this.lastSavedTheme === null) {
        this.addCSS(elem, this.defaultTheme);
    } else {
        this.addCSS(elem, this.lastSavedTheme);
    }
}

// set innerHTML of an element
// @param id ID selector of target element
// @param string html string to render
handlers.prototype.setInnerHtmlById = function (id, string) {
    var elem = document.getElementById(id);
    elem.innerHTML = string
}


var h = new handlers();

// create handler that toggles the theme and saves to local storage
Shiny.addCustomMessageHandler("toggleTheme", function (value) {

    h.setCurrentTheme(value);

    if (h.currentTheme === "dark") {
        h.removeCSS(value, "dark");
        h.addCSS(value, "light");
        h.currentTheme = "light";
    } else {
        h.removeCSS(value, "light");
        h.addCSS(value, "dark");
        h.currentTheme = "dark";
    }

    h.setInnerHtmlById("themeStatus", h.currentTheme);
    h.save(h.currentTheme);

});

// create a handler that sets the default theme based on value saved in local storage
Shiny.addCustomMessageHandler("setDefaultTheme", function (value) {
    h.setDefault(value);

    h.setCurrentTheme(value);
    h.setInnerHtmlById("themeStatus", h.currentTheme);
});