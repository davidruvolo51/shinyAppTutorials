

// css focused module
var styles = (function(){

    // set defaults
    var appDefaultTheme = "light-theme";

    // add css to element
    var addCSS = function (elem, css) {
        var elem = document.querySelector(elem);
        elem.classList.add(css);
    }

    // remove css from element
    var removeCSS = function (elem, css) {
        var elem = document.querySelector(elem);
        elem.classList.remove(css);
    }

    // find current theme of an element
    var findCSS = function (elem) {
        var target = document.querySelector(elem);
        var css = Array.from(target.classList)[0];
        if (typeof css === "undefined" || css === null) {
            return appDefaultTheme;
        } else {
            return css;
        }
    }

    // export functions
    return {
        addCSS          : addCSS,
        appDefaultTheme : appDefaultTheme,
        removeCSS       : removeCSS,
        findCSS         : findCSS
    }

})();


// file focused modules
var file = (function(){

    // save option to local storage
    var save = function (value) {
        localStorage.setItem("theme", value);
    }

    // load option from local storage
    var load = function () {
        return localStorage.getItem("theme");
    }

    // set starting theme based on local storage
    var setDefault = function (elem) {
        var defaultTheme = load();
        if (typeof defaultTheme === "undefined" || defaultTheme === null) {
            styles.addCSS(elem, styles.appDefaultTheme);
        } else {
            styles.addCSS(elem, defaultTheme);
        }
    }

    // export functions
    return {
        save       : save,
        load       : load,
        setDefault : setDefault
    }

})();

// text based modules
var text = (function () {

    // set inner html by id
    var setInnerHtmlById = function (id, string) {
        var elem = document.getElementById(id);
        elem.innerHTML = string
    }

    // export functions
    return {
        setInnerHtmlById : setInnerHtmlById
    }

})();

// create handler that toggles the theme and saves to local storage
Shiny.addCustomMessageHandler("toggleTheme", function (value) {
    
    // find theme and init a var to write the name of the new theme
    var currentTheme = styles.findCSS(value);
    var newTheme = '';

    // run logic
    if (currentTheme === "dark-theme") {
        styles.removeCSS(value, "dark-theme");
        styles.addCSS(value, "light-theme");
        newTheme = "light-theme";
    } else {
        styles.removeCSS(value, "light-theme");
        styles.addCSS(value, "dark-theme");
        newTheme = "dark-theme";
    }

    // save theme and update output element
    text.setInnerHtmlById("themeStatus", newTheme);
    file.save(newTheme);

});

// create a handler that sets the default theme based on value saved in local storage
Shiny.addCustomMessageHandler("setDefaultTheme", function (value) {

    // run our set default function - the value is the name of the element we want to apply our style to
    file.setDefault(value);

    // find the name of the theme applied and update text
    var currentTheme = styles.findCSS(value);
    text.setInnerHtmlById("themeStatus", currentTheme);
});