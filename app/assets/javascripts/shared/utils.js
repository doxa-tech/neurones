$(function() {
	/* Make a div clickable */
	$(".clickable").click(function(){
	     window.location=$(this).find("a").attr("href"); 
	     return false;
	});

	/* Hide from for subcomments forms #article */
	$('.new_subcomments').hide();

	/* for profile more information about gravatar */
	$('#profil').find('.gravatar').find('.link').click(function(){
		$('#profil').find('.more_gravatar').hide().slideDown();
	});

	/* Image url in alert */
	var image = $('#admin_image') ;
	image.find('.url_link').click(function(){
		prompt("Ctrl/Cmd + C pour copier", image.find('.url').text()) ;
	});

	/* Update url in web activation */
	$( "#group_url" ).keyup(function() {
  	$('.chosen').html($( "#group_url" ).val());
	});
	
});