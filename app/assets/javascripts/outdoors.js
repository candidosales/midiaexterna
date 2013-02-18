

$('#outdoor_valor_veiculacao, #outdoor_valor_impressao').priceFormat({
	prefix: 'R$ ',
	centsSeparator: ',',
	thousandsSeparator: '.'
});


 $('input[id^=outdoor_foto_outdoors_attributes]').each(function(){

  	var buscar = $(this).attr('id').replace(/file/g,'id');

	var parent = $(this).parents('.fileupload');

  	if($('#'+buscar).val()){
  		var val = $('#'+buscar).val();
  		
  		console.log('existe: sim  parentClass: '+ parent.attr('class') +' buscar: '+ buscar);

  		parent.find('span.fileupload-new').css({'display':'none'});
  		parent.find('span.fileupload-exists').css({'display':'inline'});
  		parent.find('a.fileupload-exists').css({'display':'inline'});
  	}
  });
  


  