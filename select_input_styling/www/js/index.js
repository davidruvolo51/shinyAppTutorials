////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-04
// MODIFIED: 2019-11-04
// PURPOSE: add events to select input
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: 
//      This script removes the select inputs to js
//          - onfocus: this.size = 13 - expand on focus
//          - onblur: this.size = 1 - collapse not focused
//          - onchange: this.size = 1 - collapse on selection
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// select element
const selectInput = document.getElementById("state");

// onfocus
selectInput.addEventListener("onfocus", function (event) {
    this.size = 13;
});

// onblur
selectInput.addEventListener("onblur", function (event) {
    this.size = 1;
});

// onchange
selectInput.addEventListener("onchange", function (event) {
    this.size = 1;
    this.blur();
});