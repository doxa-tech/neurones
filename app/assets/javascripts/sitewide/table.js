$(document).ready(function() {
  
  // server tables

  var editLink = $('.table .edit'),
  		deleteLink = $('.table .delete'),
  		addLink = $('.table .add');
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

	$('.tables tbody').on("click", "tr", function(e) {
  	if ( $(this).hasClass('row_selected') ) {
      $(this).removeClass('row_selected');
      editLink.attr('href', '#').css('background', '#aaa');
      deleteLink.attr('href', '#').removeAttr('data-method').removeAttr('rel').css('background', '#aaa');
    }
    else {
      $('tr.row_selected').removeClass('row_selected');
      $(this).addClass('row_selected');
      editLink.attr('href', window.location.pathname + '/' + $('td:first', this).text() + '/edition').css('background', '#7f72f5');
      deleteLink.attr('href', window.location.pathname + '/' + $('td:first', this).text() + '').attr('data-method', 'delete').attr('rel', 'nofollow').css('background', '#7f72f5');
    }
	});

  // ownership

  $('.user_table').dataTable( {
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('.user_table').data('source'),
    sScrollX: "100%",
    oLanguage: {
      sUrl: "/datatables/datatables.fr.txt"
    }
  });

  $('.parent_table').dataTable( {
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('.parent_table').data('source'),
    sScrollX: "100%",
    oLanguage: {
      sUrl: "/datatables/datatables.fr.txt"
    }
  });

  // client tables

  $('.client_tables').dataTable({
    bJQueryUI: true,
    sPaginationType: "full_numbers",

    oLanguage: {
      sUrl: "/datatables/datatables.fr.txt"
    }
  });

});