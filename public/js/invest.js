$(document).ready(function() {

    $(".sabios-row.tb-close").click(function(){
        $.unblockUI();
    });
    registerInvest();
    
    $("#nombre").keyup(function() {
        verifyValidNombre($(this));
    });
    $("#nombre").focusout(function() {
        verifyValidNombre($(this));
    });
    $("#apellido").keyup(function() {
        verifyValidNombre($(this));
    });
    $("#apellido").focusout(function() {
        verifyValidNombre($(this));
    });
    $("#email").keyup(function() {
        verifyValidNombre($(this));
    });
    $("#email").focusout(function() {
        verifyValidNombre($(this));
    });    
    $("#intereses").keyup(function() {
        verifyValidNombre($(this));
    });
    $("#intereses").focusout(function() {
        verifyValidNombre($(this));
    });
    $("#preguntas").keyup(function() {
        verifyValidNombre($(this));
    });
    $("#preguntas").focusout(function() {
        verifyValidNombre($(this));
    });
});
function registerInvest() {

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
        return $("#contact-form #password").val() == value;
    }, "Value must not equal arg.");

    $('form#invest-form').validate({
        rules: {
            nombre: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            apellido: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            email: {
                required: true,
                email: true
            },            
            intereses: {
                required: true,
                minlength: 20
            },
            preguntas: {
                required: true,
                minlength: 20
            }
        },
        submitHandler: function(form) {

             if ($("#invest-form").valid()) {
                $("#invest-form").submit();    
            }

            return false;
        },
        errorPlacement: function(error, element) {
            $("." + element.attr('id') + "-error").find("span.white").html(error.html());
            $("#register-form #" + element.attr('id')).next(error);
            element.focus();
        },
        messages: {
            nombre: {
                required: 'Debe Ingresar un Nombre.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            apellido: {
                required: 'Debe Ingresar un Apellido.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            email: {
                required: 'Debe ingresar un Email',
                email: 'no es un email valido'
            },    
            intereses: {
                required: 'Por favor ingrese una respuesta.',
                minlength: 'Minimo 20 caracteres.'
            },
            preguntas: {
                required: 'Por favor ingrese una respuesta.',
                minlength: 'Minimo 20 caracteres.'            
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


