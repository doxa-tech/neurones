/* Used in articles for social share */

$(document).ready(function() {
	/* Facebook */
	$('#blog article div.right p.infos a.share_facebook').click(function() {
		var sharer = "https://www.facebook.com/sharer/sharer.php?u=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});

	/* Twitter */
	$('#blog article div.right p.infos a.share_twitter').click(function() {
		var sharer = "http://twitter.com/share?text=Article+sympa+sur+neurones:&url=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});

	/* Facebook */
	$('#blog article div.right p.infos a.share_gplus').click(function() {
		var sharer = "https://plus.google.com/share?url=";
		window.open(sharer + $(this).data('link'), 'sharer', 'width=626,height=436');
	});
});