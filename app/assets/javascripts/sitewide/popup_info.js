$(function () {
  $('#popup_container').click(function() {
  	$(this).children('#popup').fadeToggle();
  });
  $('#popup_container').mouseleave(function() {
  	if ($(this).children('#popup').is(':visible')) {
  		$(this).children('#popup').fadeToggle();
  	}
  });
});