(function(){

    // cacluate data
    function progress_data(el, now, max) {
        const elem = document.getElementById(el);
        const container = elem.parentElement;
        const width = container.getBoundingClientRect().width;
        const bins =  width / max;
        const rate = bins / width
        const transform_value = rate * now;
        return {
            width: width,
            rate: rate,
            transform_value: transform_value
        }
    }

    // init_parent_element
    function init_parent_element(el) {
        const elem = document.getElementById(el);
        const parent = elem.parentElement.parentElement;
        parent.classList.add("progress-bar-parent");
    }

    // update function
    function update_progress_bar(el, now, max) {
        const elem = document.getElementById(el);
        const d = progress_data(el, now, max);
        elem.style.transform = `scaleX(${d.transform_value})`;
    }

    // bind update function
    Shiny.addCustomMessageHandler("update_progress_bar", function(value) {
        update_progress_bar(value[0], value[1], value[2]);
    });

    Shiny.addCustomMessageHandler("init_parent_element", function(value) {
        init_parent_element(value);
    });
})();