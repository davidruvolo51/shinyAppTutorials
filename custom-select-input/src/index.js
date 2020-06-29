////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-06-29
// MODIFIED: 2020-06-29
// PURPOSE: compile js and scss
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

import "./scss/index.scss"

////////////////////////////////////////

// input binding
var selectInput = new Shiny.InputBinding();
$.extend(selectInput, {
    find: function(scope) {
        return $(scope).find(".select-input-group");
    },
    initialize: function(el) {

        // get the value of the first option
        var firstChild = $(el).find("button.input-button").first();
        var firstValue = {
            value: firstChild.data("value"),
            text: firstChild.text()
        }
        
        // set firstChild's values to elements
        firstChild.addClass("selected");
        $(el).find("span.toggle-text").text(firstValue.text);
        $(el).data("value", firstValue.value);
        
    },
    getValue: function(el) {
        return $(el).data("value");
    },
    subscribe: function(el, callback) {
        
        // select primary elements
        var selectText = $(el).find("span.toggle-text");
        var selectMenu = $(el);
        var menuList = $(el).find("ol.select-input-list");
        var menuIsOpen = menuList.attr("aria-hidden") === "false";

        // define event that open/closes the input list
        selectMenu.on("click", "button.select-list-toggle", function(e){

            // toggle menu state
            selectMenu.toggleClass("hidden");

            // adjust select Input List; scroll, aria
            menuList.scrollTop(0);
            menuIsOpen = !menuIsOpen
            menuList.attr("aria-hidden", menuIsOpen);

            // if the menu is open, set selected text to a default message
            if (!selectMenu.hasClass("hidden")) {
                selectText.text("Select an item");
            }
        });

        // define event that updates el's input value
        // this event finds the clicked element, extract's it's data (i.e.,
        // text and value), and then updates the corresponding elements.
        selectMenu.on("click", "button.input-button", function(e) {

            // remove selected class
            selectMenu.find("button.input-button").removeClass("selected");

            // select click element + extract data
            var newElem = $(e.target);
            var newValue = {
                value: newElem.data("value"),
                text: newElem.text()
            };
            
            // add class to new selection
            newElem.addClass("selected");

            // update el's input value
            selectMenu.data("value", newValue.value);

            // update select input toggle text and close menu
            selectText.text(newValue.text);
            selectMenu.toggleClass("hidden");

            // adjust select Input List; scroll, aria
            menuList.scrollTop(0);
            menuIsOpen = !menuIsOpen
            menuList.attr("aria-hidden", menuIsOpen);

            // run callback
            callback();
        });

        // event for focus
        // the purpose of this event is to add support for keyboard navigation
        // if the user toggles (via TAB) and lands on the select input element,
        // then this component must open (i.e., display list)
        selectMenu.on("focus", "button.select-list-toggle", function(e) {
            selectMenu.toggleClass("hidden");

            // adjust select Input List; scroll, aria
            menuList.scrollTop(0);
            menuIsOpen = !menuIsOpen
            menuList.attr("aria-hidden", menuIsOpen);
        })

        // event for focus and blur of child elements
        // like the previous event, this event extends keyboard navigation to
        // the child elements. If a child button is focused (i.e., tabbed),
        // then the menu must remain open. If the last child element is exited,
        // then the menu must close.
        var btns = selectMenu.find("button.input-button");
        $(btns).on("focus", function(e) {

            // make sure menu is open
            selectMenu.removeClass("hidden");

            // prep for final element blur (i.e., exited from focus)
            var lastIndex = btns.length = - 1;
            var lastBtn = btns[lastIndex];
            if (e.target.nextSibling) {
                $(lastBtn).on("blur", function(e) {

                    // close menu
                    selectMenu.addClass("hidden");

                    // adjust select Input List; scroll, aria
                    menuList.scrollTop(0);
                    menuIsOpen = !menuIsOpen
                    menuList.attr("aria-hidden", menuIsOpen);
                });
            }
        });
    },
    unsubscribe: function(el) {
        $(el).off(".selectInput");
    }
});

Shiny.inputBindings.register(selectInput);