$(function() {
	if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	$(window).on('hashchange', function() {
		if(document.location.hash == "#log" && !$('#login .big-forms').is(':visible')) {
			$.getScript('login' ) ;
		}
	})
});