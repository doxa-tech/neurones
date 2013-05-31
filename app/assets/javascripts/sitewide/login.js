$(function() {
	if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	$(window).on('hashchange', function() {
		if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	});
	$(window).scroll(function(){ 
	  if ($(this).scrollTop() > 119){  
	   // x should be from where you want this to happen from top//
	    //make CSS changes here
	    $('#login .login').css({position: 'relative', top: $(this).scrollTop()-120, right: '0'});
	  } 
	  else{
	    $('#login .login').css({position: 'relative', top: 'inherit', right: 'inherit'});
	  }
	});
});