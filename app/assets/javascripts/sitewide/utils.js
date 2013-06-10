/* Make a div clickable */
$(function() {
	$(".clickable").click(function(){
	     window.location=$(this).find("a").attr("href"); 
	     return false;
	});
});