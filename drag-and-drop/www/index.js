
let dragged, initY;


// dragstart
// On drag start, start data transfer process (i.e., html format) and make sure
// variables are updated
document.addEventListener("dragstart", function(event) {
    
    // set event data transfer
    event.dataTransfer.dropEffect = "move";
    event.dataTransfer.setData("text/html", event.target.outerHTML);

    // add class to dragged item
    event.target.classList.add("drag");

    // update variables
    dragged = event.target;
    initY = event.pageY;

}, false)

// on end
document.addEventListener("dragend", function(event) {
    event.target.classList.remove("drag");
}, false)

// on over
document.addEventListener("dragover", function(event) {
    event.preventDefault();
}, false)


// on enter
document.addEventListener("dragenter", function(event) {
    if (event.target.className == "droparea") {
        event.target.style.background = "white";
    }
}, false)


// on leave
document.addEventListener("dragleave", function(event) {
    if (event.target.className == "droparea") {
        event.target.style.background = "";
    } 
}, false)

// on drop
document.addEventListener("drop", function(event) {

    // when dropped in droparea
    if (event.target.className == "droparea") {
        event.target.style.background = "";
        dragged.parentNode.removeChild(dragged);
        dragged.classList.remove("drag");
        event.target.insertAdjacentHTML("beforebegin", dragged.outerHTML)
    } 
    
    // when "replacing" card
    if (event.target.closest("div").className == "card") {
        dragged.parentNode.removeChild(dragged);
        dragged.classList.remove("drag");

        // if item is moved up, insert the element before the target
        if (event.pageY < initY) {
            event.target.closest("div.card").insertAdjacentHTML("beforebegin", dragged.outerHTML);
        } 
        
        // if item is moved down, insert the element after the target
        if (event.pageY >= initY ){
            event.target.closest("div.card").insertAdjacentHTML("afterend", dragged.outerHTML);
        }
    }

}, false)