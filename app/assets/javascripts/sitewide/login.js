$(function() {
	if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('/login' ) ;
		}
	$(window).on('hashchange', function() {
		if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('/login' ) ;
		}
	});
	// to keep login visible at top
	window.onscroll = function(){

		if ($('#login .big-forms').is(':visible')) {

			if ($(this).scrollTop() > (119+343)) {  
		    $('#login .login').css({position: 'fixed', top: '0', right: '0'});
		  } else {
		    $('#login .login').css({position: 'relative', top: 'inherit', right: 'inherit'});
		  }

		} else {
			if ($(this).scrollTop() > 119) {  
		    $('#login .login').css({position: 'fixed', top: '0', right: '0'});
		  } else {
		    $('#login .login').css({position: 'relative', top: 'inherit', right: 'inherit'});
		  }
		}
	};
});