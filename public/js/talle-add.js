$(document).ready(function() {


    Sabios.sabiosSelect(".talle");
    Sabios.sabiosSelect(".prioridad");

    talleValidate();
    $('form#talle-form').submit(function() {

        var valido = true;
        verifyValidNombre($("#nombre"));

        if ($("#id_tipo_talle").val() === "0") {
            valido = false;
            $(".tipo-talle-error").css("visibility", "visible");
        } else {
            $(".tipo-talle-error").css("visibility", "hidden");
        }

        if ($("#prioridad").val() === "0") {
            valido = false;
            $(".prioridad-error").css("visibility", "visible");
        } else {
            $(".prioridad-error").css("visibility", "hidden");
        }

        return valido;
    });


});
function talleValidate() {

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

    $('form#talle-form').validate({
        rules: {
            nombre: {
                required: true,
                minlength: 1,
                maxlength: 50
            }
        },
        submitHandler: function(form) {

             $(form).submit();
        },
        errorPlacement: function(error, element) {
            $("." + element.attr('id') + "-error").find("span.white").html(error.html());
            $("#register-form #" + element.attr('id')).next(error);
            element.focus();
        },
        messages: {

            nombre: {
                required: 'Debe Ingresar un Apellido.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
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



