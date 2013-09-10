$(function() {
	$.each($('.input_color'),function(){
		var $target = $(this);
		$(this).css('backgroundColor', $(this).val());
		$(this).ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val(hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			},
			onChange: function (hsb, hex, rgb, el) {
				$target.val('#' + hex).css('backgroundColor', '#' + hex);
			},
		});
	});
		
});