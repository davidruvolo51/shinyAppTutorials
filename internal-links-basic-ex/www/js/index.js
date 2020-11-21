////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-01
// MODIFIED: 2019-11-01
// PURPOSE: custom href function for use in shiny apps
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: this script was updated to js ES6
////////////////////////////////////////////////////////////////////////////////
// BEGIN
const customHref = function(link){
    const links = document.getElementsByTagName("a");
    Object.entries(links).forEach( (elem, i) => {
        if(elem[1].getAttribute("data-value") === link){
            elem[1].click()
        }
    });
}