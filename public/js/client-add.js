$(document).ready(function() {

    $("#tabs").tabs();
    Sabios.sabiosSelect(".estado");
    Sabios.sabiosSelect(".viajante");
    Sabios.sabiosSelect(".cliente-tipo");
    Sabios.sabiosSelect(".tipo-iva");
    clienteValidate();

    $("#agregar_personal").click(
            function() {
                var clone = $("#personal-template").html();
                var cant = $("#personal_container .personal").length + 1;
                console.log(cant-1);
                var clone2 = clone.replace(/#/g, cant);
                $("#personal_container").append('<div class="personal" id="personal_'+cant+'"></div>');
                $("#personal_" + cant).append(clone2);
                $("#personal_" + cant + " .personal-label").html('<label>Personal <span>' + cant + '</span></label>');
            });
            
    $("#agregar_sucursal").click(
            function() {
                var clone = $("#sucursal-template").html();
                var cant = $("#sucursal_container .sucursal").length + 1;
                console.log(cant-1);
                
                var clone2 = clone.replace(/#/g, cant);
                $("#sucursal_container").append('<div class="sucursal" id="sucursal_'+cant+'"></div>');
                $("#sucursal_" + cant).append(clone2);
                $("#sucursal_" + cant + " .sucursal-label").html('<label>sucursal <span>' + cant + '</span></label>');
            });
            
    $("#borrar_personal").click(
            function() {
                var cant = $("#personal_container .personal").length;
                if(cant > 0) $("#personal_" + cant).remove();
                //$("#personal_" + cant + " .personal-label").html('<label>Personal <span>' + cant + '</span></label>');
            });
            
    $("#borrar_sucursal").click(
            function() {
                var cant = $("#sucursal_container .sucursal").length;
                if(cant > 0) $("#sucursal_" + cant).remove();
            });


    $('form#cliente-form').submit(function() {

        var valido = true;
        verifyValidNombre($("#nombre"));
        verifyValidNombre($("#telefono1"));
        verifyValidNombre($("#telefono2"));
        verifyValidNombre($("#email"));
        verifyValidNombre($("#password"));
        verifyValidNombre($("#sms1"));
        verifyValidNombre($("#sms2"));
        verifyValidNombre($("#sms3"));
        verifyValidNombre($("#email1"));
        verifyValidNombre($("#email2"));
        verifyValidNombre($("#email3"));

        var tab1IsValid = $('#nombre').valid() && $('#telefono1').valid() && $('#telefono2').valid();

        if ($('#tipo_cliente_id').val() === '0') {
            valido = false;
            $(".tipocliente-error").css("visibility", "visible");
        } else {
            $(".tipocliente-error").css("visibility", "hidden");
        }

        if (tab1IsValid && (!$('#email').valid() || !$('#password').valid())) {
            valido = false;
            $('#ui-id-2').click();
        }

        return valido;

    });


    $('#loadingDiv')
            .hide()  // hide it initially
            .ajaxStart(function() {
        $.blockUI({css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            }, message: 'Cargando...'});
    })
            .ajaxStop(function() {
        $.unblockUI();
    })
            ;



    $('#pais').bind('change', function() {

        var data = {pais_id: $(this).val()};
        this.apiCall('provincia', 'GET', data, function(response) {
            $('#sucursal_id_provincia_1 option').remove();
            $.each(response.data, function(key, value) {
                $('#sucursal_id_provincia_1')
                        .append($("<option></option>")
                        .attr("value", value.id)
                        .text(value.nombre));
            });
        });

    });

    $('#addpersonal').bind('click', function() {
        $("#cliente-form #personal").append($("#templates #personal").html());
    });
    $('#addsucursal').bind('click', function() {
        $("#cliente-form #sucursal").append($("#templates #sucursal").html());
    });

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
        email1: $('#email_aviso1').val(),
        email2: $('#email_aviso2').val(),
        email3: $('#email_aviso3').val(),
        empresa_de_preferencia: $('#empresa_preferencia').val(),
        asegurado: $('#asegurado').val(),
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

function verifyValidNombre(element) {
    element.valid();
    if (element.hasClass("valid"))
        $("." + element.attr('id') + "-error").css("visibility", "hidden");
    else
        $("." + element.attr('id') + "-error").css("visibility", "visible");
}