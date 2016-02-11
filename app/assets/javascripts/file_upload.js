$(document).ready(function() {
  var fileUpload = $('#fileupload');
  var url = fileUpload.attr('data-url'),
      thumbs = $('#thumbs'),
      consoleEl = $('.console'),
      progressVal = $('.progress .progress-val'),
      progressIn = $('.progress .progress-in'),
      progressMessage = consoleEl.find('.progress-message');

  fileUpload.fileupload({
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    dataType: 'json',
    url: url,
    done: function (e, data) {
      $.each(data.result, function(index, file) {
        $('<img src="' + file.thumbnail_url + '">').appendTo(thumbs);
      });
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100 - 1, 10);
      progressIn.css('width', progress + '%');
      progressVal.text(progress + '%');
    },
    start: function (e, data) {
      progressMessage.show();
    },
    stop: function (e, data) {
      progressVal.text('100% chargement terminé');
      progressMessage.hide()
    }
  });
});
