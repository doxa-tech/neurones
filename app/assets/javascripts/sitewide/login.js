$(document).ready(function() {
  var bigForms = $('#login .big-forms'),
      loginLogin = $('#login .login');

	// show the login form if #log
	if(document.location.hash == "#log" && !bigForms.is(':visible')) {
			$.getScript('/login' ) ;
		}
	$(window).on('hashchange', function() {
		if(document.location.hash == "#log" && !bigForms.is(':visible')) {
			$.getScript('/login' ) ;
		}
	});
	// to keep login visible at top
	window.onscroll = function(){

		if (bigForms.is(':visible')) {

			if ($(this).scrollTop() > (119+343)) {
		    loginLogin.css({position: 'fixed', top: '0', right: '0'});
		  } else {
		    loginLogin.css({position: 'relative', top: 'inherit', right: 'inherit'});
		  }

		} else {
			if ($(this).scrollTop() > 119) {
		    loginLogin.css({position: 'fixed', top: '0', right: '0'});
		  } else {
		    loginLogin.css({position: 'relative', top: 'inherit', right: 'inherit'});
		  }
		}
	};
});
