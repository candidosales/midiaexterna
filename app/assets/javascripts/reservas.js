
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

    $('input[type=checkbox].checkbox').change(function(){
      $(this).closest('tr').removeClass('success');
      if($(this).prop('checked')){
       $(this).closest('tr').addClass('success');
     }
    });

    $('#form-email').submit(function(){
      console.log('form-email');
      outdoorsAvailable();
    });

    $('.editor').wysihtml5({locale: "pt-BR","stylesheets": [""]});

    $('#nova-reserva a:last').tab('show');

    //Autocomplete e-mails
    $('#emails').magicSuggest({
      width: 400
    });

    $('#exampleDTB-1').dataTable({
                        oLanguage: {
                                sSearch: "Buscar",
                                sZeroRecords: 'Nada foi encontrado <button class="btn btn-danger resetTable">Resetar a buscar</button>',
                                 "oPaginate": {
                                      "sFirst":    "Primeiro",
                                      "sPrevious": "Anterior",
                                      "sNext":     "Seguinte",
                                      "sLast":     "Último"
                                  },
                                "sProcessing":   "Processando...",
                                "sLengthMenu":   "Mostrar _MENU_ registros",
                                "sInfo":         "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                                "sInfoEmpty":    "Mostrando de 0 até 0 de 0 registros",
                                "sInfoFiltered": "(filtrado de _MAX_ registros no total)",
                        },
                        iDisplayLength: 3,
                        aaSorting: [
                                [1, 'asc']
                        ],
                        aoColumnDefs: [{
                                "aTargets": [2],
                                'sClass': 'hidden-phone'
                        }, {
                                "aTargets": [3],
                                'sClass': 'hidden-phone hidden-tablet'
                        }, {
                                "aTargets": [4],
                                'sType': 'eu_date'
                        }],
                        sPaginationType: 'full_numbers',
                        sDom: "<'row-fluid' <'widget-header' <'span4'l> <'span8'<'table-reset-wrapper'>f<'table-tool-wrapper'> > > >  rt <'row-fluid' <'widget-footer' <'span12'p> >",
                });
                //* inject  to datatable DTB
                $('#exampleDTB-1_wrapper .table-global-filter input')
                        .attr("placeholder", "enter search terms");
                $('#exampleDTB-1_wrapper .table-tool-wrapper')
                        .html($('.DTB_toolBar')
                        .html());
                $('#exampleDTB-1_wrapper .table-reset-wrapper')
                        .html($('.DTB_resetTable')
                        .html());
        $('#exampleDTB-1_length select').select2({
            minimumResultsForSearch: 6,
            width: "off"
        });
  });
});



var somaCheckbox = function(x) {
  var total_veiculacao = 0 , val_veiculacao = 0, total_impressao = 0 , val_impressao = 0, reserva_valor = 0;

  $(".checkbox:checked").each(function() {
    var id = $(this).attr('id');
    val_veiculacao = $('span.valor_veiculacao' + '-' + id).html();
    val_impressao = $('span.valor_impressao' + '-' + id).html();
    console.log('impressao: '+val_impressao+' veiculacao: '+val_veiculacao);

    total_veiculacao += parseInt(val_veiculacao);
    total_impressao += parseInt(val_impressao);
    console.log('t_impressao: '+total_impressao+' t_veiculacao: '+total_veiculacao);
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
  outdoorsAvailable();
});
}

function outdoorsAvailable(){
  var allVals = [];
  $("input[type='checkbox'].outdoor").each(function() {
    if($(this).is(':checked')){
      allVals.push($(this).val());
    }
  });
  $('#outdoors').val(allVals);
}




