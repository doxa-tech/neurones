$(document).ready(function() {
	if( $('textarea[name="editor"]').length ) {
		CKEDITOR.replace( 'editor', {
	  	customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
	if( $('textarea[name="page[title]"]').length ) {
		CKEDITOR.inline( 'page[title]', {
			customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
	if( $('textarea[name="page[content]"]').length ) {
		CKEDITOR.inline( 'page[content]', {
			customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
	if( $('textarea[name="article[content]"]').length ) {
		CKEDITOR.inline( 'article[content]', {
			customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
	if( $('textarea[name="article[title]"]').length ) {
		CKEDITOR.inline( 'article[title]', {
			customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
	if( $('textarea[name="article[subtitle]"]').length ) {
		CKEDITOR.inline( 'article[subtitle]', {
			customConfig: '/assets/ckeditor/custom_config.js'
		});
	};
});