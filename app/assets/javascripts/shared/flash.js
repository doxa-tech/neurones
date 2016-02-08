/* for flash message */
var message = $("#message");

$(document).ready(function() {
  message.fadeIn("slow");
  message.find("a.close-notify").click(function() {
    message.fadeOut("slow");
  });
});
