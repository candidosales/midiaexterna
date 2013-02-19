
$("#inicio_periodo").datepicker({
  defaultDate: "+1w",
  numberOfMonths: 2,
  onClose: function(selectedDate) {
    $("#termino_periodo").datepicker("option", "minDate", selectedDate);
  }
}); 
$("#termino_periodo").datepicker({
  defaultDate: "+1w",
  numberOfMonths: 2,
  onClose: function(selectedDate) {
    $("#inicio_periodo").datepicker("option", "maxDate", selectedDate);
  }
});

var toggleLoading = function() {
  $("#loading").toggle();
};



$('form[data-update-target]').bind('submit change', function() {
  var target = $(this).data('update-target');
  toggleLoading();
  $.ajax({
    url: $(this).attr('action'),
    data: $(this).serialize(),
    dataType: "HTML",
    type: "POST"
  }).complete(function() {
    toggleLoading();
  }).success(function(data) {

    $('#' + target).html(data);
    $('#reserva_inicio_reserva, #inicio_reserva').val($('#inicio_periodo').val());
    $('#reserva_termino_reserva, #termino_reserva').val($('#termino_periodo').val());
    $('#usuario_id').val($('#reserva_usuario_id').val());

    $("input[type='checkbox']").click(function() {
      somaCheckbox($(this));
    });
    emailAvailableOutdoors();

    $("#total_veiculacao, #total_impressao").change(function() {
     reserva_valor = parseInt($("#total_veiculacao").val()) + parseInt($("#total_impressao").val());
     $('#total').val('R$ ' + reserva_valor + ',00');
     $('#reserva_valor').val(reserva_valor);
   });

  });
});



var somaCheckbox = function(x) {
  var total_veiculacao = 0 , val_veiculacao = 0, total_impressao = 0 , val_impressao = 0, reserva_valor = 0;

  $("input[type='checkbox']:checked").each(function() {
    var id = $(this).attr('id');
    val_veiculacao = $('span.valor_veiculacao' + '-' + id).html();
    val_impressao = $('span.valor_impressao' + '-' + id).html();

    total_veiculacao += parseInt(val_veiculacao);
    total_impressao += parseInt(val_impressao);
  });
  $("#total_veiculacao").val(total_veiculacao);
  $("#total_impressao").val(total_impressao);

  reserva_valor = total_veiculacao + total_impressao;

  $('#total').val('R$ ' + reserva_valor + ',00');
  $('#reserva_valor').val(reserva_valor);
};

somaCheckbox();

var emailAvailableOutdoors = function(x){
 $('select#reserva_cliente_id').on('change', function() {
  var allVals;
  $('input#cliente_id').val($(this).val());
  allVals = [];
  $("input[type='checkbox']").each(function() {
    allVals.push($(this).val());
  });
  $('#outdoors').val(allVals);
});
}



