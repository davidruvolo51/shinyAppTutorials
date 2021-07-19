////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-07
// MODIFIED: 2021-05-29
// PURPOSE: main index file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: see R/handlers.R
////////////////////////////////////////////////////////////////////////////////

// define methods for receiving data from R
const utils = (function(){

    function inner_html(id, html) {
        document.getElementById(id).innerHTML = html;
    }

    function add_css(id, css){
        document.getElementById(id).classList.add(css);
    }

    function remove_css(id, css){
        document.getElementById(id).classList.remove(css);
    }

    return {
        add_css    : add_css,
        remove_css : remove_css,
        inner_html : inner_html
    }

})();

// bind
Shiny.addCustomMessageHandler("add_css", (value) => utils.add_css(value.id, value.css));
Shiny.addCustomMessageHandler("remove_css", (value) => utils.remove_css(value.id, value.css));
Shiny.addCustomMessageHandler("inner_html", (value) => utils.inner_html(value.id, value.html))