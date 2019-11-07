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