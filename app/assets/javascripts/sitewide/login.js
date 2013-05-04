$(function() {
	if(document.location.hash == "#login" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	$(window).on('hashchange', function() {
		if(document.location.hash == "#login" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	})
});