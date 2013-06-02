$(document).ready(function() {

	// user form
	var attributes = $('#user_password, #user_password_confirmation, #user_email, #user_parents_attributes_0_parent_id');
	if($('select:first option:selected').text() == 'group') {
		attributes.attr('disabled', true) ;
	}
	$('select:first').change(function(){
		if($('select:first option:selected').text() == 'group') {
			attributes.attr('disabled', true) ;
		} else {
			attributes.attr('disabled', false) ;
		}
	})

});