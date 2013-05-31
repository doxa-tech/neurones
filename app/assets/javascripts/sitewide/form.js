$(document).ready(function() {

	// user form
	if($('select:first option:selected').text() == 'group') {
		$('#user_password').attr('disabled', true) ;
		$('#user_password_confirmation').attr('disabled', true) ;
		$('#user_email').attr('disabled', true) ;
		$('#user_password').attr('disabled', true) ;
		$('#user_parents_attributes_0_parent_id').attr('disabled', true) ;
	}
	$('select:first').change(function(){
		if($('select:first option:selected').text() == 'group') {
			$('#user_password').attr('disabled', true) ;
			$('#user_password_confirmation').attr('disabled', true) ;
			$('#user_email').attr('disabled', true) ;
			$('#user_password').attr('disabled', true) ;
			$('#user_parents_attributes_0_parent_id').attr('disabled', true) ;
		} else {
			$('#user_password').attr('disabled', false) ;
			$('#user_password_confirmation').attr('disabled', false) ;
			$('#user_email').attr('disabled', false) ;
			$('#user_password').attr('disabled', false) ;
			$('#user_parents_attributes_0_parent_id').attr('disabled', false) ;
		}
	})


});