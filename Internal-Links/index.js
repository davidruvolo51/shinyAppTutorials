// script for custom href
// var customHref = function(tabName) {
//     var dropdownList = document.getElementsByTagName("a");
//     for (var i = 0; i < dropdownList.length; i++) {
//         var link = dropdownList[i];
//         if(link.getAttribute("data-value") == tabName) {
//             link.click();
//         }
//     }
// };

const customHref = function(link){
    const links = document.getElementsByTagName("a");
    console.dir(links)
    // links.forEach( elem => {
    //     if(elem.getAttribute("data-value") === link){
    //         link.click()
    //     }
    // });
}