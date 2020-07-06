////////////////////////////////////////////////////////////////////////////////
// FILE: listbox.js
// AUTHOR: David Ruvolo
// CREATED: 2020-06-29
// MODIFIED: 2020-07-06
// PURPOSE: listbox input binding
// DEPENDENCIES: Shiny
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// init binding
var listbox = new Shiny.InputBinding();

// define new input binding
$.extend(listbox, {

    // set element to find 
    find: function(scope) {
        return $(scope).find(".listbox-group");
    },

    // on input initialize, select the first option
    initialize: function(el) {

        // select elements
        var list = $(el).find("ul[role='listbox']");
        var first = $(el).find("li[role='option']").first();

        // update attributes
        list.attr("aria-activedescendant", first.attr("id"))
        first.attr("aria-selected", "true");

        // set value to parent container
        $(el).attr("data-value", first.attr("id"));

        // write value to toggle
        $(el).find(".toggle-text").text(first.attr("data-value"));
    },

    // when callback is triggered, get the value 
    getValue: function(el) {
        return $(el).find("li[aria-selected='true']").attr("data-value");
    },

    // subscribe: define all events here
    subscribe: function(el, callback) {
        
        // define function that closes menu
        function closeMenu() {

            // find elements that will be modified on close
            var menu = $(el).find("ul[role='listbox']");
            var toggle = $(el).find("button.listbox-toggle");

            // modify attributes
            menu.addClass("hidden");
            menu.attr("aria-hidden", "true");
            toggle.attr("aria-expanded", "false");
            toggle.find(".toggle-icon").removeClass("rotated");
        }

        // define function that opens menu
        function openMenu() {

            // find elements that will be modified on open
            var menu = $(el).find("ul[role='listbox']");
            var toggle = $(el).find("button.listbox-toggle");
            
            // modify attributes
            menu.removeClass("hidden");
            menu.removeAttr("aria-hidden");
            toggle.attr("aria-expanded", "false");
            toggle.find(".toggle-icon").addClass("rotated");
            
            // focus menu and scroll to selected element
            menu.focus();
        }

        // define function that toggles menu state
        function toggleMenu() {
            var menu = $(el).find("ul[role='listbox']");
            if (menu.hasClass("hidden")) {
                openMenu();
            } else {
                closeMenu();
            }
        }

        // update selected option
        function updateInput(elem) {
            // focus new element
            var newElem = elem;
            newElem.attr("aria-selected", "true");
            newElem.addClass("focus");

            // update menu attribute
            var menu = $(el).find("ul[role='listbox']");
            menu.attr("aria-activedescendant", elem.attr("id"));

            // update component value + display text
            $(el).attr("data-value", elem.attr("data-value"));
            $(el).find(".toggle-text").text(elem.attr("data-value"));

            // run callback
            callback();
            
        }

        // event: when menu toggle is clicked
        $(el).on("click", "button.listbox-toggle", function(e) {
            toggleMenu();
        });

        // event: watch for keydowns
        $(el).on("keydown", "ul[role='listbox']", function(e) {
            switch(e.key) {

                // on keydown: up arrow
                case "ArrowUp":
                    var current = $(el).find("li[aria-selected='true']");
                    if (current.prev().length) {
                        var newElem = current.prev();
                        current.removeAttr("aria-selected");
                        updateInput(newElem);
                    }
                    break;

                // on keydown: down arrow
                case "ArrowDown":
                    var current = $(el).find("li[aria-selected='true']");
                    if (current.next().length) {
                        var newElem = current.next();
                        current.removeAttr("aria-selected");
                        updateInput(newElem);
                    }
                    break;

                // on escape
                case "Escape":
                    closeMenu();
                    break;

                // on enter
                case "Enter":
                    var selected = $(e.target);
                    updateInput(selected);
                    closeMenu();
                    break;
            }
        });


        // on event: when option clicked
        $(el).on("click", "li[role='option']", function(e) {

            // make sure the <li> element is selected
            // this will handle situations when <span> or <icon> is
            // clicked
            $(el).find("li[role='option'][aria-selected='true']").removeAttr("aria-selected");
            var elem = $(e.target).closest("li[role='option']");
            updateInput(elem);
            closeMenu();
        });
    },

    // unsubscribe
    unsubscribe: function(el) {
        $(el).off(".listbox")
    }
});

// register
Shiny.inputBindings.register(listbox);