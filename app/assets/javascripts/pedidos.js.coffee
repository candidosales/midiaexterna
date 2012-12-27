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


            $('form[data-update-target]').submit ->   
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
                    $('#outdoors_available').html data 

                false


