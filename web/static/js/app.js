// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(function() {
  $("time.pubdate").each(function() {
    var datetime, offset, self, user, utc;
    self = $(this);
    datetime = self.attr('datetime');
    user = self.data('user');
    utc = new Date(datetime);
    return self.html("" + (utc.getFullYear()) + "-" + (utc.getMonth() + 1) + "-" + (utc.getDate()) + " " + (utc.getHours()) + "点" + (utc.getMinutes()) + "分");
  });
  return $(".topics_pagination").each(function() {
    var path, self;
    self = $(this);
    path = self.data("path");
    return self.pagination({
        total_pages: parseInt(self.data('pages')),
        current_page: parseInt(self.data('page')),
        callback: function(_event, page) {
            return window.location.search = "?page=" + page;
        }
    });
  });
});
