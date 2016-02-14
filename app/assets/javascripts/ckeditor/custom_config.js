CKEDITOR.editorConfig = function( config )
{
	config.extraPlugins = 'mediaembed,sourcedialog';
	config.filebrowserBrowseUrl = '/admin/images';
  config.uiColor = '#ffae00';

  // config.enterMode = config.ENTER_BR;
  // config.fillEmptyBlocks = false;
  // config.autoParagraph = false;

  config.toolbar = 'Full';

  //config.stylesSet = [];
  config.stylesSet = 'my_styles:styles/my_styles.js';

	config.toolbar_Full =
	[
		{ name: 'document', items : ['Sourcedialog','-','NewPage','DocProps','Preview','Print','-','Templates']},
		{ name: 'clipboard', items : ['Cut','Copy','Paste','PasteText','-','Undo','Redo','-','SpellChecker','Scayt']},
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','BidiLtr','BidiRtl' ] },
		{ name: 'links', items : [ 'Link','Unlink'] },
		{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar', 'MediaEmbed' ] },
		'/',
    { name: 'basicstyles', items : ['Bold','Italic','Underline','Strike','-','Subscript','Superscript','-','RemoveFormat']},
    { name: 'alignement', items: ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock']},
		{ name: 'styles', items : ['CreateDiv', 'Format','Font','FontSize']},
		{ name: 'colors', items : ['TextColor','BGColor' ]},
		{ name: 'tools', items : ['Maximize', 'ShowBlocks','-','About']}
	];
};


/* backup
config.toolbar_Full =
	[
		{ name: 'document', items : [ 'Sourcedialog','-','NewPage','DocProps','Preview','Print','-','Templates' ] },
		{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
		{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
		{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton' ] },
		'/',
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
		'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
		{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
		{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe', 'MediaEmbed' ] },
		'/',
		{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
		{ name: 'colors', items : [ 'TextColor','BGColor' ] },
		{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
	];
	*/
