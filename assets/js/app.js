// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

var starttime;
$(function () {
    let startbutton = $('#start-timeblock-button');
    let stopbutton = $('#stop-timeblock-button');
    stopbutton.hide();

    startbutton.click((ev) => {
      starttime = new Date();
      startbutton.hide();
      stopbutton.show();
    });
    
    stopbutton.click((ev) => {
        startbutton.show();
        stopbutton.hide();
        let endtime = new Date();
        let taskitem_id = $(ev.target).data('taskitem-id');

        let text = JSON.stringify({
        timeblock: {
            taskitem_id: taskitem_id,
            start_time: starttime,
            end_time: endtime,
        },
        });

        $.ajax("/ajax/timeblocks", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
            $('#timeblock-form').text(`(start time: ${resp.data.starttime})`);
        },
        });
    });


});