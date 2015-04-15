$(document).ready(function() {

    $.Mustache.addFromDom();
    $(document).ajaxStart(
            function() {
                $.blockUI({css: {
                        border: 'none',
                        padding: '15px',
                        backgroundColor: '#000',
                        '-webkit-border-radius': '10px',
                        '-moz-border-radius': '10px',
                        'border-radius': '10px',
                        opacity: .5,
                        'font-family': 'helvetica',
                        color: '#fff'
                    }, message: 'Cargando...'});
            });

    $(document).ajaxStop(
            function() {
                $.unblockUI();
            }
    );

    $('#pais').live('change', function() {

        var data = {pais_id: $(this).val()};
        Sabios.apiCall('provincia', 'GET', data, function(response) {

            var resp = jQuery.parseJSON(response);
            $('[name="sucursal_id_provincia\[\]"] option').remove();
            $('[name="sucursal_id_provincia\[\]"]')
                    .append($("<option></option>")
                    .attr("value", 0)
                    .text("Selecciona una provincia"));
            $.each(resp.data, function(key, value) {
                $('[name="sucursal_id_provincia\[\]"]')
                        .append($("<option></option>")
                        .attr("value", value.id)
                        .html(value.nombre));
            });
        });

    });



});
function generateArray(selector, type) {
    var array = {};
    var count = 0;
    $(type + '[name="' + selector + '\[\]"]').each(
            function() {
                array[count] = $(this).val();
                count++;
            }

    );
    return array;
}

function newCliente() {

    $('#cliente-content').empty();
    $('#cliente-content').append($.Mustache.render('cliente-new', {}));
    $.each(paises, function(key, value) {
        $('#pais')
                .append($("<option></option>")
                .attr("value", value.id)
                .html(value.nombre));
    });
    $.each(clienteTipo, function(key, value) {
        $('#tipo_cliente_id')
                .append($("<option></option>")
                .attr("value", value.id)
                .html(value.nombre));
    });
    $.each(vendedores, function(key, value) {
        $('#viajante_id')
                .append($("<option></option>")
                .attr("value", value.id)
                .html(value.nombre));
    });
    
    $('#personal').append($.Mustache.render('personal', {}));
    $('#sucursal').append($.Mustache.render('sucursal', {}));

    $('span#span_personal').each(function() {
        $this = $(this);
        $.each(cargos, function(key, value) {
            $this.find('select[name="personal_cargo\[\]"]')
                    .append($("<option></option>")
                    .attr("value", value.id)
                    .html(value.nombre));
        });
    });
    $.each(paises, function(key, value) {
        $('#pais')
                .append($("<option></option>")
                .attr("value", value.id)
                .html(value.nombre));
    });

    $('#addpersonal').bind('click', function() {
        var html ='<span id="span_personal">' + $('#span_personal').html() + '</span>';
        $('#personal').append(html).hide().fadeIn();
    });
    $('#addsucursal').bind('click', function() {
        $('#sucursal').append('<span id="span_sucursal">' + $('#span_sucursal').html() + '</span>');
    });
    $('#delpersonal').bind('click', function() {
        if($('#personal #span_personal').length > 1)
            $('#personal #span_personal').last().fadeOut().remove();
    });
    $('#delsucursal').bind('click', function() {
        if($('#sucursal #span_sucursal').length > 1)
            $('#sucursal #span_sucursal').last().fadeOut().remove();
    });

    clienteValidate();
}

function submitClientForm() {
    var cantPersonal = $('input[name="personal_nombre\[\]"]').size();
    var cantSucursal = $('input[name="sucursal_nombre\[\]"]').size();

    var personal_nombre = generateArray('personal_nombre', 'input');
    var personal_cargo = generateArray('personal_cargo', 'select');
    var personal_apodo = generateArray('personal_apodo', 'input');
    var personal_tel1 = generateArray('personal_tel1', 'input');
    var personal_tel2 = generateArray('personal_tel2', 'input');
    var personal_email1 = generateArray('personal_email1', 'input');
    var personal_observaciones = generateArray('personal_observaciones', 'textarea');
    var personal_fecha = generateArray('personal_fecha', 'input');

    var sucursal_nombre = generateArray('sucursal_nombre', 'input');
    var sucursal_id_provincia = generateArray('sucursal_id_provincia', 'select');
    var sucursal_direccion = generateArray('sucursal_direccion', 'input');
    var sucursal_encargados = generateArray('sucursal_encargados', 'input');
    var sucursal_tel1 = generateArray('sucursal_tel1', 'input');
    var sucursal_localidad = generateArray('sucursal_localidad', 'input');
    var sucursal_tel2 = generateArray('sucursal_tel2', 'input');
    var sucursal_observaciones = generateArray('sucursal_observaciones', 'textarea');



    var personal = {};
    for (var i = 0; i < cantPersonal; i++) {
        personal[i] = {};
        personal[i]['nombre'] = personal_nombre[i];
        personal[i]['apodo'] = personal_apodo[i];
        personal[i]['cargo_id'] = personal_cargo[i];
        personal[i]['telefono'] = personal_tel1[i];
        personal[i]['movil'] = personal_tel2[i];
        personal[i]['email1'] = personal_email1[i];
        personal[i]['observaciones'] = personal_observaciones[i];
        personal[i]['fecha_nacimiento'] = personal_fecha[i];
    }

    var sucursal = {};
    for (var i = 0; i < cantSucursal; i++) {
        sucursal[i] = {};
        sucursal[i]['numero'] = sucursal_nombre[i];
        sucursal[i]['sucursal_id_provincia'] = sucursal_id_provincia[i];
        sucursal[i]['direccion'] = sucursal_direccion[i];
        sucursal[i]['encargados'] = sucursal_encargados[i];
        sucursal[i]['telefono1'] = sucursal_tel1[i];
        sucursal[i]['telefono2'] = sucursal_tel2[i];
        sucursal[i]['localidad'] = sucursal_localidad[i];
        sucursal[i]['observaciones'] = sucursal_observaciones[i];
    }

    data = {
        nombre: $('#nombre').val(),
        tipo_cliente_id: $('#tipo_cliente_id').val(),
        telefono1: $('#telefono1').val(),
        telefono2: $('#telefono2').val(),
        sms1: $('#sms1').val(),
        sms2: $('#sms2').val(),
        sms3: $('#sms3').val(),
        email1: $('#email1').val(),
        email2: $('#email2').val(),
        email3: $('#email3').val(),
        empresa_de_preferencia: $('#empresa_preferencia').val(),
        asegurado: $('#porcentaje_asegurado').val(),
        direccion_de_envio: $('#direccion_envio').val(),
        enviar_a_nombre_de: $('#enviar_nombres').val(),
        razon_social: $('#razon_social').val(),
        tipo_contribucion: $('#id_responsabilidad').val(),
        cuit: $('#cuit').val(),
        provincia_id: $('#id_provincia').val(),
        localidad: $('#localidad').val(),
        muestra_precio: $('#mostrar_precio').val(),
        aplica_iva: $('#aplica_iva').val(),
        habilita_acceso_pedidos: $('#acceso').val(),
        estado_id: $('#id_estado').val(),
        'personal': personal,
        'sucursal': sucursal
    };


    Sabios.apiCall('cliente', 'POST', data, function(response) {
        alert(response.message);
        console.log(response);
    });
    return false;
}