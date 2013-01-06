# Place all the behaviors and hooks related to the matching controller here.
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
    jQuery ->
            $( "#inicio_periodo" ).datepicker
                defaultDate: "+1w",
                numberOfMonths: 2,
                onClose: ( selectedDate ) ->
                     $( "#termino_periodo" ).datepicker "option", "minDate", selectedDate 
                
            $( "#termino_periodo" ).datepicker
                defaultDate: "+1w",
                numberOfMonths: 2,
                onClose: ( selectedDate ) ->
                    $( "#inicio_periodo" ).datepicker "option", "maxDate", selectedDate



            toggleLoading = -> $("#loading").toggle()


            $('form[data-update-target]').bind 'submit change',  ->   
                target = $(this).data 'update-target'
                $.ajax({
                    url: $(this).attr('action'), 
                    data: $(this).serialize(),
                    dataType: "HTML",
                    type: "POST"
                })
                .complete ->
                    toggleLoading
                .success (data)->
                    $('#'+target).html data
                    $('#reserva_inicio_reserva').val($('#inicio_periodo').val())
                    $('#reserva_termino_reserva').val($('#termino_periodo').val()) 
                false

            $("input[type='checkbox']").live 'click', ->
                somaCheckbox($(this))


            somaCheckbox = (x) ->
                total = 0;
                $("input[type='checkbox']:checked").each ->
                    id = $(this).attr('id')
                    val = $("label[for='"+id+"']").find('span.valor').html()
                    total+=parseInt(val)
       
                $("#valor").html 'R$ '+total+',00' 
                $('#reserva_valor').val total
                true

            somaCheckbox()