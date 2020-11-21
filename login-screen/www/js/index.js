////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-07
// MODIFIED: 2019-11-07
// PURPOSE: main index file for app
// DEPENDENCIES: using Shiny.js
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// custom handler for sending outputs from shiny server to the ui
Shiny.addCustomMessageHandler('innerHTML', function(value){
    document.getElementById(value[0]).innerHTML = value[1]
}) 

// add and remove classes on form
const utils = (function(){

    // add class
    function addCSS(id, css){
        document.getElementById(id).classList.add(css);
    }

    // remove class
    function removeCSS(id, css){
        document.getElementById(id).classList.remove(css);
    }


    // export
    return {
        addCSS    : addCSS,
        removeCSS : removeCSS
    }

})();

// register add and remove with shiny
Shiny.addCustomMessageHandler("addCSS", function(value){
    utils.addCSS(value[0], value[1]);
});

Shiny.addCustomMessageHandler("removeCSS", function(value){
    utils.removeCSS(value[0], value[1]);
});