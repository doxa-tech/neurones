$(document).ready(function() {
    $("#message").fadeIn("slow");
    $("#message a.close-notify").click(function() {
        $("#message").fadeOut("slow");
        return false;
    });
});