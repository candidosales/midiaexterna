
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
  var target;
  target = $(this).data('update-target');
  $.ajax({
    url: $(this).attr('action'),
    data: $(this).serialize(),
    dataType: "HTML",
    type: "POST"
  }).complete(function() {
    toggleLoading();
  }).success(function(data) {
    toggleLoading();
    $('#' + target).html(data);
    $('#reserva_inicio_reserva, #inicio_reserva').val($('#inicio_periodo').val());
    $('#reserva_termino_reserva, #termino_reserva').val($('#termino_periodo').val());

    $("input[type='checkbox']").click(function() {
        somaCheckbox($(this));
    });
  });
});

var somaCheckbox = function(x) {
  var total;
  total = 0;
  $("input[type='checkbox']:checked").each(function() {
    var id, val;
    id = $(this).attr('id');
    val = $('span.valor' + '-' + id).html();
    total += parseInt(val);
  });
  $("#valor").val('R$ ' + total + ',00');
  $('#reserva_valor').val(total);
  return true;
};

somaCheckbox();

$('select#reserva_cliente_id').on('change', function() {
  var allVals;
  $('input#cliente_id').val($(this).val());
  allVals = [];
  $("input[type='checkbox']").each(function() {
    allVals.push($(this).val());
  });
    $('#outdoors').val(allVals);
});

