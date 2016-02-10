/* for flash message */

$(document).ready(function() {
  var message = $("#message");

  message.fadeIn("slow");
  message.find("a.close-notify").click(function() {
    message.fadeOut("slow");
  });
});
