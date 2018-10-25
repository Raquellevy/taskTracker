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

window.createTimeBlock = (ev) => {
    let taskitem_id = $(ev).data('taskitem-id');
    let starttime = $("#startnew-timeblock").val();
    let endtime = $("#endnew-timeblock").val();

    if(starttime != "" && endtime != "") {
    let text = JSON.stringify({
        timeblock: {
            taskitem_id: taskitem_id,
            start_time: new Date(starttime),
            end_time: new Date(endtime),
        },
        });

    $.ajax("/ajax/timeblocks", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
            location.reload();
        },
    });
    } else {
        location.reload();
    }

}
window.deleteTimeBlock = (ev) => {
    let timeblock_id = $(ev).data('timeblock-id');
    
    console.log("deleting timeblock")
    $.ajax("/ajax/timeblocks/" + timeblock_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    success: (resp) => {
        location.reload();
    },
    });
}

window.editTimeBlock = (ev) => {
    let savebutton_id = $(ev).data('timeblock-id') + "-savebutton";
    let editbutton_id = $(ev).data('timeblock-id') + "-editbutton";
    let td_start_id = $(ev).data('timeblock-id') + "-start";
    let td_end_id = $(ev).data('timeblock-id') + "-end";

    $("#" + savebutton_id).show();
    $("#" + editbutton_id).hide();

    $("#" + td_start_id + "input").show();
    $("#" + td_end_id + "input").show();
    $("#" + td_start_id + "time").hide();
    $("#" + td_end_id + "time").hide();
}

window.saveTimeBlock = (ev) => {
        
    let taskitem_id = $(ev).data('taskitem-id');

    let timeblock_id = $(ev).data('timeblock-id');

    let savebutton_id = $(ev).data('timeblock-id') + "-savebutton";
    let editbutton_id = $(ev).data('timeblock-id') + "-editbutton";

    let td_start_id = $(ev).data('timeblock-id') + "-start";
    let td_end_id = $(ev).data('timeblock-id') + "-end";
    let newStart = $("#" + td_start_id + "input").val();
    let newEnd = $("#" + td_end_id + "input").val();
    
    if(newStart != "" && newEnd != "") {
        $("#" + savebutton_id).hide();
        $("#" + editbutton_id).show();

        let text = JSON.stringify({
            timeblock: {
                taskitem_id: taskitem_id,
                start_time: new Date(newStart),
                end_time: new Date(newEnd),
            },
            });
    
        $.ajax("/ajax/timeblocks/"+ timeblock_id, {
            method: "put",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                location.reload();
            },
        });
    } else {
        location.reload();
    }
}

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
            location.reload();
        },
        });
    });

});