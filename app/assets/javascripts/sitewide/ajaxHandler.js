$(function() {

	$('#blog article .comments div.more a').click(function(){
		id = $(this).data('id');
		el = '#' + id;
		$('#blog article .comments div.more').on('ajax:beforeSend', function(){
			$('#blog ' + el + ' .more .loading').html('chargement ... <img src="/assets/blog/ajax-loader.gif">');
		});
		$('#blog article .comments div.more').on('ajax:success', function(){
			$('#blog ' + el + ' .more').empty();
		});
	});

	/* For login, with a timer */
	$('#login .login a').click(function(){
		var timer;
		$('#login .login').on('ajax:beforeSend', function(){
			timer && clearTimeout(timer);
			timer = setTimeout(
				function(){
					$('#login .login .text').hide();
					$('#login .login div.loading').html('chargement ... <img src="/assets/header/ajax-loader-header.gif">');
				},
				600
			);
		});
		$('#login .login').on('ajax:success', function(){
			clearTimeout(timer);
			$('#login .login div.loading').empty();
			$('#login .login .text').show();
		});
	});

});