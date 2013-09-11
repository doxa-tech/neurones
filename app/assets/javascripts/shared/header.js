$(document).ready(function () {
  $('.submenu').hover(
    function () {
      //show its submenu
      $('ul', this).stop().slideDown(150);
  }, 
  function () {
      //hide its submenu
      $('ul', this).stop().slideUp(200);          
    }
  );
});