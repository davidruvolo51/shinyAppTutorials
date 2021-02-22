////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-04-28
// MODIFIED: 2021-02-22
// PURPOSE: events for drag and drop elements
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: This script contains a number of events for creating a
// "drag and drop" feature for use in shiny apps. For more information, please
// consult mozilla's Drag and Drop API doc: 
//    https://developer.mozilla.org/en-US/docs/Web/API/HTML_Drag_and_Drop_API
////////////////////////////////////////////////////////////////////////////////

// init variables
// dragged: the html object that is being dragged
// startingY: is the starting Y position of the dragged element
// dropzone: select the dropzone for adding and removing classes
let dragged, startingY, dropzone = document.querySelector(".droparea");


// remove drag and drop highlighting from cards
 function remove_highlighting() {
    var cards = document.querySelectorAll(".card");
    return cards.forEach(elem => elem.classList.remove("highlighting"));
}


// dragstart
// This event is trigged when the user starts dragging an element. When this
// occurs, the element's data needs to be transfered and we should add some
// styling to make the current dragged item more obvious. This event should
// also define/update the variables `dragged` and `startingY`. The variable
// `startingY` is used in the drop event to determine where the element should
// be placed.
document.addEventListener("dragstart", function (event) {

    // set event data transfer
    event.dataTransfer.dropEffect = "move";
    event.dataTransfer.setData("text/html", event.target.outerHTML);

    // add class to dragged item
    event.target.classList.add("drag");

    // update variables
    dragged = event.target;
    startingY = event.pageY;

}, false)


// on drag end
// When the user stops dragging the element (i.e., pause, drop), remove
// the drag class from the dragged element.
document.addEventListener("dragend", function (event) {
    event.target.classList.remove("drag");
}, false)


// on drag over
// When the current dragged element is dragged over another element,
// we should add a css class to that element to highlight that it is
// a potential drop area.
document.addEventListener("dragover", function (event) {
    event.preventDefault();
    if (event.target.closest("div").className === "card") {
        event.target.closest("div.card").classList.add("highlighting");
    }
}, false)


// on drag enter
// This event only applies to the spare `droparea` element. When the
// user drags the element into this space, we should highlight that
// element to make it more obvious that the user can drop the element
// there.
document.addEventListener("dragenter", function (event) {
    if (event.target.className === "droparea") {
        dropzone.classList.add("focus");
    }
}, false)


// on drag leave
// when the user continues to drag an element after passing over another
// draggable element, remove all highlighting and styles from elements.
document.addEventListener("dragleave", function (event) {
    if (event.target.className === "droparea") {
        dropzone.classList.remove("focus");
    }
    remove_highlighting();
}, false)


// on drop
// When the user drops the element, insert the html object into position
// depending on where the element is dropped. If the dragged element is
// dropped into the drop area, then insert the html and remove styles.
// If the dragged element is dropped into a card element, insert the
// dragged element before or after the existing element. Use variable
// `startingY` and `event.pageY` to determine the placement of the 
// dropped element.
document.addEventListener("drop", function (event) {

    // remove any remaining highlighting
    remove_highlighting();
    dropzone.classList.remove("focus");

    // when dropped in droparea
    if (event.target.className === "droparea") {

        dragged.classList.remove("drag");

        // remove dragged element starting point and add before dropzone
        // we want to keep the dropzone for future use.
        dragged.parentNode.removeChild(dragged);
        event.target.insertAdjacentHTML("beforebegin", dragged.outerHTML);
    }

    // when "replacing" card
    if (event.target.closest("div").className == "card") {

        // remove element from document and add to drop position
        dragged.classList.remove("drag");
        dragged.parentNode.removeChild(dragged);

        // if item is moved up, insert the element before the target
        if (event.pageY < startingY) {
            event.target.closest("div.card").insertAdjacentHTML("beforebegin", dragged.outerHTML);
        }

        // if item is moved down, insert the element after the target
        if (event.pageY >= startingY) {
            event.target.closest("div.card").insertAdjacentHTML("afterend", dragged.outerHTML);
        }
    }

}, false)


const btn = document.getElementById("submit");

btn.addEventListener("click", function () {

    let choices = [], elems = document.querySelectorAll(".card");

    elems.forEach(function (elem) {
        choices.push(elem.getAttribute("data-value", "value"))
    })

    alert(`You have reordered the items to: ${choices}`);
})
