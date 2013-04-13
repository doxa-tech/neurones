$(document).ready(function () {
  $('#login .login').click(function() {
	  $('#login .big-forms').slideToggle('slow', function() {
	  	$('#login .login a').html(
      	$(this).is(':visible') ? '<i class="foundiconge-up-arrow"></i> Login' : '<i class="foundiconge-down-arrow"></i> Login'
    	);
	  });
	});
});