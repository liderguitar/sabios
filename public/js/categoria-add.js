$(document).ready(function() {


    Sabios.sabiosSelect(".categoria");

    productoValidate();
    $('form#product-form').submit(function() {

        var valido = true;
        verifyValidNombre($("#codigo"));
        verifyValidNombre($("#nombre"));
        verifyValidNombre($("#precio"));
        verifyValidNombre($("#costo"));

        if ($("#tipotalle").val() === "0") {
            valido = false;
            $(".tipotalle-error").css("visibility", "visible");
        } else {
            $(".tipotalle-error").css("visibility", "hidden");
        }

        if ($("#categoria").val() === "0") {
            valido = false;
            $(".categoria-error").css("visibility", "visible");
        } else {
            $(".categoria-error").css("visibility", "hidden");

        }
        return valido;
    });




  



});
function productoValidate() {

    jQuery.validator.addMethod("regex",
            function(value, element, regexp) {
                var re = new RegExp(regexp);
                return this.optional(element) || re.test(value);
            },
            "");
    jQuery.validator.addMethod("verificarNick",
            function(value, element, value2) {
                var resp = true;
                self = this;
                $.ajax({
                    type: "POST",
                    url: "/usuario/verificar-nick/nick/" + value,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(data) {
                        if (data["result"] === "true") {
                            self.resp = false;
                        } else {
                            self.resp = true;
                        }
                    }
                });

                return this.optional(element) || self.resp;
            },
            "");
    jQuery.validator.addMethod("valueNotEquals", function(value) {
        return $("#register-form #password").val() == value;
    }, "Value must not equal arg.");

    $('form#product-form').validate({
        rules: {
            codigo: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            nombre: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            precio: {
                number: true,
                required: true,
            },
            costo: {
                number: true,
                required: true,
            }
        },
        submitHandler: function(form) {

            if ($("#tyc").val() === "0") {
                $(".tyc-error").css("visibility", "visible");
                return false;
            }

            if (passwordStrength($("#password").val()) < 2) {
                $(".password-error").css("visibility", "visible");
                $(".password-error").find("span.white").html("Verifica la fortaleza de tu contraseña");
                $("#password").focus();
                return false;

            }


            if ($("#register-form").valid()) {
                $("#register-form").submit();
            }


            return false;
        },
        errorPlacement: function(error, element) {
            $("." + element.attr('id') + "-error").find("span.white").html(error.html());
            $("#register-form #" + element.attr('id')).next(error);
            element.focus();
        },
        messages: {
            codigo: {
                required: 'Debe Ingresar un Nombre.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            nombre: {
                required: 'Debe Ingresar un Apellido.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            precio: {
                required: 'Debe ingresar un precio',
                number: 'no es un precio valido'
            },
            costo: {
                required: 'Debe ingresar un costo',
                number: 'no es un costo valido'
            }

        }
    });


}

function verifyValidNombre(element) {
    element.valid();
    if (element.hasClass("valid"))
        $("." + element.attr('id') + "-error").css("visibility", "hidden");
    else
        $("." + element.attr('id') + "-error").css("visibility", "visible");
}



