$(document).ready(function() {

	$('#blog .comments div.more a').click(function() {
    var loading = $(this).parents('.more').find('.loading');
		loading.html('chargement ... <img src="/assets/blog/ajax-loader.gif">');
	});

	/* For login, with a timer */

  var loginLogin = $('#login .login'),
      loginLoading = loginLogin.find('div.loading'),
      loginText = loginLogin.find('.text');

	loginLogin.find('a').click(function() {
		var timer;
		timer && clearTimeout(timer);
		timer = setTimeout(function() {
			loginText.hide();
			loginLoading.html('chargement ... <img src="/assets/header/ajax-loader-header.gif">');
		}, 600);

		$(document).one('ajax:success', function() {
			clearTimeout(timer);
			loginLoading.empty();
			loginText.show();
		});
	});

});
