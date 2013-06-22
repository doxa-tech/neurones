$(function() {
	/* Make a div clickable */
	$(".clickable").click(function(){
	     window.location=$(this).find("a").attr("href"); 
	     return false;
	});

	/* Hide subcomments forms #article */
	$('.new_subcomments').hide();

	/* for profile more information about gravatar */
	$('#profil').find('.gravatar').find('.link').click(function(){
		$('#profil').find('.more_gravatar').hide().slideDown();
	});
	
});