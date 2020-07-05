////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-06-29
// MODIFIED: 2020-07-01
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
        var firstChild = $(el).find("li.select-input-list-option").first();
        var firstValue = {
            id: firstChild.attr("id"),
            value: firstChild.attr("data-value"),
            text: firstChild.text().trim()
        }
        
        // // set firstChild's values to elements
        firstChild.attr("aria-selected", true);
        $(el).find(".select-input-list").attr("aria-activedescendant", firstValue.id);
        $(el).find("span.toggle-text").text(firstValue.text);
        $(el).attr("data-value", firstValue.value);
        
    },
    getValue: function(el) {
        return $(el).attr("data-value");
    },
    subscribe: function(el, callback) {
        
        // select primary elements
        var inputGroup = $(el);
        var currentInputValue = inputGroup.find("span.toggle-text");
        var inputGroupToggle = inputGroup.find(".select-list-toggle");
        var inputList = inputGroup.find("ul.select-input-list");
        var inputListOptions = inputGroup.find("[role='option']");

        // focus first item
        function focusFirstItem(options = inputListOptions) {
            var firstItem = options[0];
            firstItem.focus();
        }

        // focus last item
        function focusLastItem(options = inputListOptions) {
            var lastItem = options[options.length - 1];
            lastItem.focus()
        }

        // function for close Menu
        function closeMenu(group = inputGroup, list = inputList, toggle = inputGroupToggle) {
            group.addClass("hidden");
            toggle.attr("aria-expanded", "false");
            list.attr("aria-hidden", "true");
        }

        // function for opening menu
        function openMenu(group = inputGroup, list = inputList, toggle = inputGroupToggle) {
            group.removeClass("hidden");
            toggle.attr("aria-expanded", "true");
            list.removeAttr("aria-hidden");
            list.scrollTop(0);
            focusFirstItem();
        }

        // define a function that opens/closes menu
        // @param group receives `el`
        // @param list <ul> element
        // @param toggle <button> that toggles the input list (i.e., all <li> elems)
        function toggleMenu(group = inputGroup, list = inputList, toggle = inputGroupToggle) {
            if (group.hasClass("hidden")) {
                openMenu();
            } else {
                closeMenu();
            }
        }

        // define a function that writes inputList selections
        // make sure <li> is selected (in case <span> is clicked)
        // @param elem the newly selected option
        // @param list <ul> element
        // @param output <span> object to write the selected value into
        // @param group receives $(el)
        function updateInputValue(elem, list = inputList, output = currentInputValue, group = inputGroup) {
            var selectedElem = elem.closest("li[role='option']");
            var newValues = {
                id: selectedElem.id,
                value: selectedElem.data("value"),
                text: selectedElem.text().trim()
            }

            // update attributes
            list.find("li").removeAttr("aria-selected");
            selectedElem.attr("aria-selected", "true");
            list.attr("aria-activedescendant", newValues.id);
            group.attr("data-value", newValues.value);
            output.text(newValues.text);

            // run callback
            callback();
        } 

        // define event that open/closes the input list
        inputGroup.on("click", "button.select-list-toggle", function(e){
            toggleMenu();
        });

        // event for keydown
        inputGroupToggle.keydown(function(e) {
            switch (e.key) {
                // when escape, only close menu
                case "Escape":
                    closeMenu();
                    break;
                
                // when space, toggle menu
                case "Space":
                    toggleMenu();
                    break;
            }
        });

        // event for focus and blur of child elements
        // like the previous event, this event extends keyboard navigation to
        // the child elements. If a child button is focused (i.e., tabbed),
        // then the menu must remain open. If the last child element is exited,
        // then the menu must close.
        inputListOptions.each(function(n) {
            var option = $(inputListOptions[n]);

            // click
            option.on("click", function(e) {
                updateInputValue($(e.target))
                toggleMenu();
            });

            option.on("focus", function(e) {
                console.log("focusing", e.target);
            })

            // keydown events
            option.keydown(function(e) {
                e.preventDefault();
                console.log(e.key)
                switch (e.key) {

                    // if keydown is enter
                    case "Enter":
                        updateInputValue($(e.target));
                        toggleMenu();
                        break;

                    // if up arrow
                    case "ArrowUp":
                        var previousChildIndex = inputListOptions.index(e.target) - 1;
                        
                        // focus previous element
                        if (previousChildIndex > -1) {
                            updateInputValue($(e.target));
                            var previousElem = inputListOptions[previousChildIndex];
                            previousElem.focus();
                        }

                        // close menu
                        if (previousChildIndex === -1) {
                            inputGroupToggle.focus();
                            toggleMenu();
                        }
                        break;
                        
                    // if down arrow
                    case "ArrowDown":

                        // find the index of the next item
                        var nextChildIndex = inputListOptions.index(e.target) + 1;
                        if (nextChildIndex < inputListOptions.length) {
                            var nextElement = inputListOptions[nextChildIndex]
                            nextElement.focus();
                        }
                        break;

                    // if home
                    case "Home" :
                        focusFirstItem();
                        break;
                }
            });
        })
    },
    unsubscribe: function(el) {
        $(el).off(".selectInput");
    }
});


// register
Shiny.inputBindings.register(selectInput);