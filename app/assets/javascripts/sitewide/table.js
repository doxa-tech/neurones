$(document).ready(function() {

  // retutn a datatable config
  function config(element) {
    var config = {
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sScrollX: "100%",
      sAjaxSource: element.data('source'),
      oLanguage: {
        sUrl: "/datatables/datatables.fr.txt"
      }
    };
    return config
  }

  // init server tables

  $('.tables').dataTable( config($('.tables') ) );

  $('.user_table').dataTable( config($('.user_table') ) ); //ownership

  $('.parent_table').dataTable( config($('.parent_table')) ); //ownership

  // init client tables

  $('.client_tables').dataTable({
    bJQueryUI: true,
    sPaginationType: "full_numbers",

    oLanguage: {
      sUrl: "/datatables/datatables.fr.txt"
    }
  });

  // make a row clickable && handel the buttons

  var editLinkOn = $('.table').find('a[class="edit on"]'),
      deleteLinkOn = $('.table').find('a[class="delete on"]'),
      editLinkOff = $('.table').find('a[class="edit off"]'),
      deleteLinkOff = $('.table').find('a[class="delete off"]'),
      newRelationOn = $('.table').find('a[class="new_relation on"]'),
      newRelationOff = $('.table').find('a[class="new_relation off"]'),
      newOwnershipOn = $('.table').find('a[class="new_ownership on"]'),
      newOwnershipOff = $('.table').find('a[class="new_ownership off"]');

	$('.tables tbody, .client_tables tbody').on("click", "tr", function(e) {
    var id = $(this).children(':first').text() ;
  	if ( $(this).hasClass('row_selected') ) {
      $(this).removeClass('row_selected');
      deleteLinkOn.add(editLinkOn).hide();
      deleteLinkOff.add(editLinkOff).show();
    }
    else {
      $('tr.row_selected').removeClass('row_selected');
      $(this).addClass('row_selected');
      deleteLinkOff.add(editLinkOff).hide();
      editLinkOn.attr('href', window.location.pathname + '/' + id + '/edition').show();
      deleteLinkOn.attr('href', window.location.pathname + '/' + id).show();
    }
	});

  // specific for users table

  $('.user_table tbody').on("click", "tr", function(e) {
    var id = $(this).children(':first').text() ;
    if ( $(this).hasClass('row_selected') ) {
      $(this).removeClass('row_selected');
      newRelationOn.add(newOwnershipOn).hide();
      newRelationOff.add(newOwnershipOff).show();
    }
    else {
      $('tr.row_selected').removeClass('row_selected');
      $(this).addClass('row_selected');
      newRelationOff.add(newOwnershipOff).hide();
      newRelationOn.attr('href', '/admin/parents/nouveau?user_id=' + id).show();
      newOwnershipOn.attr('href', '/admin/ownerships/nouveau?user_id=' + id).show();
    }
  });
});