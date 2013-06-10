$(document).ready(function() {
  
  var editLink = $('.table .edit'),
  		deleteLink = $('.table .delete'),
  		addLink = $('.table .add');
  // grey out
  addLink.attr('href', window.location.pathname + '/nouveau' );
  
  $('.tables').dataTable( {
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('.tables').data('source'),
    sScrollX: "100%",
    
    
    oLanguage: {
                sUrl: "/datatables/datatables.fr.txt"
            }
  	});

	$('.tables tbody').on("click", "tr", function() {
  	if ( $(this).hasClass('row_selected') ) {
      $(this).removeClass('row_selected');
      // grey out
    }
    else {
      $('tr.row_selected').removeClass('row_selected');
      $(this).addClass('row_selected');
      editLink.attr('href', window.location.pathname + '/' + $('td:first', this).text() + '/edition');
      deleteLink.attr('href', window.location.pathname + '/' + $('td:first', this).text() + '');
      deleteLink.attr('data-method', 'delete');
      deleteLink.attr('rel', 'nofollow');
      // grey out
    }

    // grey out on button update & delete
    $('#profil .content .table a ').css('background', '#7f72f5');
	});
});