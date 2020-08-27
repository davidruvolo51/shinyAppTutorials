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

        // select list (ul) and first item in the list (li)
        var list = $(el).find("ul[role='listbox']");
        var first = $(el).find("li[role='option']").first();

        // update ARIA attributes
        list.attr("aria-activedescendant", first.attr("id"))
        first.attr("aria-selected", "true");

        // add the value of the first item to the parent container (i.e., <fieldset>)
        // to a custom data attribute
        $(el).attr("data-value", first.attr("id"));

        // update displayed text
        $(el).find(".toggle-text").text(first.attr("data-value"));
    },

    // when callback is triggered, get the value of the element
    // with the attribute `aria-selected`
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

        // update component and selected item
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

            // run callback (i.e., getValue)
            callback();
            
        }

        // event: when menu toggle is clicked
        $(el).on("click", "button.listbox-toggle", function(e) {
            toggleMenu();
        });

        // event: watch for keydowns
        $(el).on("keydown", "ul[role='listbox']", function(e) {
            switch(e.keyCode) {

                // on keydown: ArrowUp - code 38
                case 38:
                    var current = $(el).find("li[aria-selected='true']");
                    if (current.prev().length) {
                        var newElem = current.prev();
                        current.removeAttr("aria-selected");
                        updateInput(newElem);
                    }
                    break;

                // on keydown: ArrowDown - code 40
                case 40:
                    var current = $(el).find("li[aria-selected='true']");
                    if (current.next().length) {
                        var newElem = current.next();
                        current.removeAttr("aria-selected");
                        updateInput(newElem);
                    }
                    break;

                // on keydown: Home - code 36
                case 36:
                    var current = $(el).find("li[aria-selected='true']");
                    var first = $(el).find("li[role='option']").first();
                    current.removeAttr("aria-selected");
                    updateInput(first);
                    break;

                // on keydown: End - code 35
                case 35:
                    var current = $(el).find("li[aria-selected='true']");
                    var last = $(el).find("li[role='option']").last();
                    current.removeAttr("aria-selected");
                    updateInput(last);
                    break;
                
                // on keydown: Escape - code 27
                case 27:
                    closeMenu();
                    break;

                // on keydown: Enter - code 13
                case 13:
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