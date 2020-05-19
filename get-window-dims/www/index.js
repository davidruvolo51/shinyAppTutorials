////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-05-18
// MODIFIED: 2020-05-18
// PURPOSE: js handlers for sending data to the shiny server
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// getWindowSize
// define a function that returns window dimensions
function getWindowSize() {
    const isWindow = typeof window !== "undefined";
    return {
        width: isWindow ? window.innerWidth : undefined,
        height: isWindow ? window.innerHeight : undefined
    }
}

// setWindowSize
// define a function that sets window size to a shiny input
function setWindowSize() {
    Shiny.setInputValue("window", JSON.stringify(getWindowSize()));
}

// attach when shiny:connected (need to use jQuery's 'on')
$(document).on("shiny:connected", function() {
    
    // run on shiny:connected (i.e., initial)
    setWindowSize();

    // add listener (i.e., run when window is resized)
    window.addEventListener("resize", setWindowSize);
});