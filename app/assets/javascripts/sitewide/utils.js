$(function() {
	/* Make a div clickable */
	$(".clickable").click(function(){
	     window.location=$(this).find("a").attr("href"); 
	     return false;
	});

	/* Hide subcomments forms #article */
	$('.new_subcomments').hide();
});