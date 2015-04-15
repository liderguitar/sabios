$(document).ready(function() {

    Sabios.sabiosSelect(".cliente-tipo");

    $("#cliente-form").submit(function() {

        var errors = 0;

        if ($("#nombre").val().length < 3) {
            $(".nombre-error").css("visibility", "visible");
            errors++;

        } else {
            $(".nombre-error").css("visibility", "hidden");
        }

        if ($("#tipo_cliente_id").val() === "0") {
            $(".tipocliente-error").css("visibility", "visible");
            errors++;
        } else {
            $(".tipocliente-error").css("visibility", "hidden");

        }

        if (!isValidEmailAddress($("#email").val())) {
            $(".email-error").css("visibility", "visible");
            errors++;
        } else {
            $(".email-error").css("visibility", "hidden");

        }

        if ($("#password_").val().length < 5) {
            $(".password-error").css("visibility", "visible");
            errors++;

        } else {
            $(".password-error").css("visibility", "hidden");
        }

        if ($("#password_").val() !== $("#repite_password").val()) {
            $(".repite-password-error .white").html("Las contrase&ntilde;as no coinciden.");
            $(".repite-password-error").css("visibility", "visible");
            errors++;

        } else {
            $(".password-error").css("visibility", "hidden");
        }
        
        $.ajax({
            url: '/catalogo/validaremail?email=' + $("#email").val(),
            type: 'get',
            dataType: 'json',
            async: false,
            success: function(response) {
                if (response.success) {
                } else {
                    $(".email-error .white").html("Email ya registrado.");
                    $(".email-error").css("visibility", "visible");
                    errors++;
                }
            }
        });

        if (errors) {
            window.scrollTo(0, 0);
            return false;
        }

    });


});