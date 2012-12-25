# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$("#outdoor_numero").mask "999"
	$('#outdoor_valor').priceFormat    prefix: 'R$ ',  centsSeparator: ',',  thousandsSeparator: '.'