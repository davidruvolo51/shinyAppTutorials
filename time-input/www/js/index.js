////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-17
// MODIFIED: 2019-11-18
// PURPOSE: js functions for application
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: 
//     The purpose of this file is to handle two events:
//          1. write text to an element of our choice (innerHTML)
//          2. when a value is entered into the time input, we get shiny to
//             read it
//     Additionaly, we will write a function that resets the value of the input
//     element
////////////////////////////////////////////////////////////////////////////////
// BEGIN
(function () {

    // write text to named inner html
    function innerHTML(elem, string){
        document.querySelectorAll(elem)[0].innerHTML = string;
    }

    // update inner html
    Shiny.addCustomMessageHandler("innerHTML", function (value) {
        innerHTML(value[0], value[1])
    });

    // update input value
    const time = document.getElementById("time");
    time.addEventListener("input", function(){
        console.log("input:", time.value)
        Shiny.onInputChange("time", time.value)
    });

    Shiny.addCustomMessageHandler("resetForm", function(event){
        time.value = "12:00";
    })

})();