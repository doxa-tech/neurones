$(document).ready(function() {

  /* Loading subcomments in the blog */

	$('#blog .comments div.more a').click(function() {
    var loading = $(this).parents('.more').find('.loading');
		loading.show()
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
			loginLoading.show();
		}, 600);

		$(document).one('ajax:success', function() {
			clearTimeout(timer);
			loginLoading.hide();
			loginText.show();
		});
	});

});
