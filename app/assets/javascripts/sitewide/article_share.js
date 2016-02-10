/* Used in articles for social share */

$(document).ready(function() {

  var blog = $('#blog');

	/* Facebook */
	blog.find('span.share_facebook').click(function() {
		var sharer = "https://www.facebook.com/sharer/sharer.php?u=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});

	/* Twitter */
	blog.find('span.share_twitter').click(function() {
		var sharer = "http://twitter.com/share?text=Article+sympa+sur+neurones:&url=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});

	/* Facebook */
	blog.find('span.share_gplus').click(function() {
		var sharer = "https://plus.google.com/share?url=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});

});
