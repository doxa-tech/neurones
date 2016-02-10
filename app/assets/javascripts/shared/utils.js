$(document).ready(function () {

	/* Make a div clickable */
	$(".clickable").click(function(){
     window.location = $(this).find("a").attr("href");
     return false;
	});

	/* for profile more information about gravatar */
  var profile = $('#profil');
	profile.find('.gravatar').find('.link').click(function(){
		profile.find('.more_gravatar').hide().slideDown();
	});

	/* Image url in alert */
	$('#admin_image').find('.url_link').click(function(){
		prompt("Ctrl/Cmd + C pour copier", $(this).data('url')) ;
	});

	/* Update url in web activation */
	$( "#group_url" ).keyup(function() {
  	$('.chosen').html($( "#group_url" ).val());
	});

});
