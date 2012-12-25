# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$("#cliente_cpf").mask "999.999.999-99"
	$("#cliente_tel").mask "(99) 9999-9999"
	$("#cliente_cnpj").mask "99.999.999/9999-99"
	$("#cliente_cep").mask "99.999-999"
