////////////////////////////////////////////////////////////////////////////////
// FILE: time_input.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-31
// MODIFIED: 2020-08-01
// PURPOSE: input binding for time inputs
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// init new binding
var timeInput = new Shiny.InputBinding();

// extend class
$.extend(timeInput, {

    // locate all instances of input[type='time']
    find: function (scope) {
        return $(scope).find(".time__input");
    },

    // return default value defined by the attribute `value`
    // this will also reset the input to it's default value
    // on page refresh
    initialize: function(el) {
        return el.value = $(el).attr("value");
    },

    // callback function: when called, return the current input value
    getValue: function(el) {
        return el.value;
    },

    // events: when input is changed, return the value
    subscribe: function (el, callback) {
        $(el).on("change", function (e) {

            // callback; i.e., run `getValue`
            callback();
        });
    }
});

// register
Shiny.inputBindings.register(timeInput)


// Alternatives for initialize and getvalue to return value in 12 hour format
// intialize: function (el) {
//     el.value = $(el).attr("value");
//     this.getValue();
// },

// // method: returns time in 12-hour format
// getValue: function (el) {
//     var val = el.valueAsDate;
//     var time = val.toLocaleString("en-us", { hour: "numeric", minute: "numeric" });
//     return time;
// },