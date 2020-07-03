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
        var inputListOptions = inputGroup.find("li.select-input-list-option");


        // define a function that opens/closes menu
        // @param group receives `el`
        // @param list <ul> element
        // @param toggle <button> that toggles the input list (i.e., all <li> elems)
        function toggleMenu(group = inputGroup, list = inputList, toggle = inputGroupToggle) {
            if (group.hasClass("hidden")) {
                group.removeClass("hidden");
                toggle.attr("aria-expanded", "true");
                list.removeAttr("aria-hidden");
                list.scrollTop(0);
            } else {
                group.addClass("hidden");
                toggle.attr("aria-expanded", "false");
                list.attr("aria-hidden", "true");
            }
        }

        // define a function that writes inputList selections
        // make sure <li> is selected (in case <span> is clicked)
        // @param elem the newly selected option
        // @param list <ul> element
        // @param output <span> object to write the selected value into
        // @param group receives $(el)
        function updateInputValue(elem, list = inputList, output = currentInputValue, group = inputGroup) {
            var selectedElem = elem.closest(".select-input-list-option");
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

        // event for focus
        // the purpose of this event is to add support for keyboard navigation
        // if the user toggles (via TAB) and lands on the select input element,
        // then this component must open (i.e., display list)
        inputGroup.on("focus", "button.select-list-toggle", function(e) {
            toggleMenu();
        });

        // event for blur
        inputGroup.keydown(function(e) {
            if (e.key === "Escape") {
                toggleMenu();
            }
        });

        // focus
        inputList.on("focus", function(e) {
            toggleMenu();
        })

        // blur
        inputList.on("blur", function(e) {
            toggleMenu();
        })

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

            // keydown events
            option.keydown(function(e) {
                console.log(e.key);
                // when enter is pressed
                if (e.key === "Enter") {
                    updateInputValue($(e.target));
                    toggleMenu();
                }

                // when up arrow is pressed
                if (e.key === "ArrowUp") {
                    var previousChildIndex = inputListOptions.index(e.target) - 1;
                    if (previousChildIndex > -1) {
                        var previousElem = inputListOptions[previousChildIndex];
                        previousElem.focus();
                    }
                }

                // when down arrow is pressed
                if (e.key === "ArrowDown") {
                    var nextChildIndex = inputListOptions.index(e.target) + 1;
                    if (nextChildIndex < inputListOptions.length) {
                        var nextElement = inputListOptions[nextChildIndex]
                        nextElement.focus();
                    }
                }

                // when escape is pressed
                if (e.key === "Escape" || e.key === "13") {
                    console.log("escape pressed")
                    toggleMenu();
                }
            })
        })
    },
    unsubscribe: function(el) {
        $(el).off(".selectInput");
    }
});


// register
Shiny.inputBindings.register(selectInput);