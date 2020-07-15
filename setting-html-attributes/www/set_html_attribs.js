////////////////////////////////////////////////////////////////////////////////
// FILE: set_html_attribs.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-15
// MODIFIED: 2020-07-15
// PURPOSE: find and update <html> attributes
// DEPENDENCIES: NA
// STATUS: working; complete
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// set_html_attributes
// Find hidden html element and extract data attributes, and add then append
// them to the <html> tag.
function set_html_attribs() {
    const targetElem = document.getElementsByTagName("html")[0];
    const refElem = document.getElementById("shiny__html_attribs");
    targetElem.lang = refElem.getAttribute("data-html-lang");
    targetElem.dir = refElem.getAttribute("data-html-dir");
}

// run set_html_attribs only when DOMContentLoaded, and then remove
window.addEventListener("DOMContentLoaded", function(e) {
    set_html_attribs();
}, { once: true });
