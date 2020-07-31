////////////////////////////////////////////////////////////////////////////////
// FILE: time_input.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-31
// MODIFIED: 2020-07-31
// PURPOSE: input binding for time inputs
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// init new binding
var timeInput = new Shiny.InputBinding();


// extend class
$.extend(timeInput, {

    // locate instance of input[type='time']
    find: function(scope) {
        return $(scope).find("input.time__input");
    },

    // return value at render; otherwise input will be NULL
    initialize: function(el) {
        return el.value;
    },

    // callback function: when called, return the input value
    getValue: function(el) {
        return el.value;
    },

    // events: when input is changed, return the value
    subscribe: function(el, callback) {
        $(el).on("change", function(e) {
            callback();
        });
    },

    // clean up
    unsubscribe: function(el) {
        $(el).off(".timeInput");
    }
});


// register
Shiny.inputBindings.register(timeInput)