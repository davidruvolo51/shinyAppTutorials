////////////////////////////////////////////////////////////////////////////////
// FILE: accordion.js
// AUTHOR: David Ruvolo
// CREATED: 2021-11-11
// MODIFIED: 2021-11-11
// PURPOSE: accordion button input binding
// DEPENDENCIES: Shiny assets
// STATUS: working
// COMMENTS: This input binding toggles all instances of the accordion
// component. This script will create a new constructor that extends the
// Shiny.InputBinding() and adjust the state of the component when the
// toggle is clicked. ARIA attributes will also be adjusted. Return current
// state for use in the server (if needed by the user).
////////////////////////////////////////////////////////////////////////////////

// create new binding
var Accordion = new Shiny.InputBinding();
$.extend(Accordion, {
    
    // find: locate component within scope
    find: function(scope) {
        return $(scope).find(".accordion");
    },

    // initialize: return state if needed in the server (i.e., isOpen)
    initialize: function(el) {
        return $(el).find("button.accordion__toggle").attr("aria-expanded") === true;
    },

    // getValue: return state if needed (i.e., isOpen)
    getValue: function(el) {
        return $(el).find("button.accordion__toggle").attr("aria-expanded") === true;
    },

    // subscribe: create an register DOM events
    subscribe: function(el, callback) {

        // define function that handles state
        function toggleAccordion() {

            // find elements
            var btn = $(el).find(".accordion__toggle");
            var icon = $(el).find(".toggle__icon");
            var section = $(el).find(".accordion__content");

            // toggle: component state + ARIA attributes
            if (btn.attr("aria-expanded") === "false") {
                btn.attr("aria-expanded", "true");
                section.removeAttr("hidden");
                icon.addClass("rotated");
            } else {
                btn.attr("aria-expanded", "false");
                section.attr("hidden", "");
                icon.removeClass("rotated");
            }

            // return state (if needed in the server)
            callback();
        }

        // onFocus
        $(el).on("focusin", function(e) {
            $(el).addClass("accordion__focused");
        });

        // onBlur
        $(el).on("focusout", function(e) {
            $(el).removeClass("accordion__focused");
        });
        
        
        // onClick
        $(el).on("click", "button.accordion__toggle", function(e) {
            toggleAccordion();
        });
    },

    // receiveMessage: triggered by server-side functions
    receiveMessage: function(el, message) {

        // reset accordion to it's default closed state
        if (message === "reset") {
            $(el).find(".accordion__toggle").attr("aria-expanded", "false");
            $(el).find(".accordion__content").attr("hidden", "");
            $(el).find(".toggle__icon").removeClass("rotated");
        }
    },

    // unsubscribe: clean up
    unsubscribe: function(el) {
        $(el).off(".Accordion");
    }
})

// bind
Shiny.inputBindings.register(Accordion)
