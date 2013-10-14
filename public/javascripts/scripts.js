jQuery.noConflict();
jQuery(document).ready(function($) {


	$('#tag_name').keyup(function() {
		$('#recaptcha_widget_div').slideDown('fast'); 
	})

	$('#change_email').keyup(function() {
		$('#recaptcha_widget_div').slideDown('fast'); 
	})

})

