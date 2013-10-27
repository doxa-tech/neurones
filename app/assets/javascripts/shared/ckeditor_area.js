// Initizalize ckeditor's textarea 
$(document).ready(function() {
	$('.inline').each(function(){
    CKEDITOR.inline( $(this).attr('id'), {
    	customConfig: '/assets/ckeditor/custom_config.js'
    });
	});
});