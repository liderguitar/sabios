$(document).ready(function() {
    $("#tipodecuenta").click(function() {
        $(".select-container").fadeIn();
    });
    
    if($("#tipoactividad").val() !== "0") {
        $("#tipodecuenta span").html($("#tipoactividad").val());
    }
    
    $(".sabios-option").click(function() {
        $("#tipodecuenta span").html($(this).html());
        $(".select-container").fadeOut();
        $("#tipoactividad").val($(this).attr("value"));
    });

    $("#password").keyup(function() {
        passwordStrength($("#password").val());
    });
    $(".check").click(function() {
        if ($(this).hasClass("checked")) {

            $(this).removeClass("checked");
            $(this).addClass("unchecked");
            $("#tyc").val(0);

        } else {

            $(".tyc-error").css("visibility", "hidden");
            $(this).removeClass("unchecked");
            $(this).addClass("checked");
            $("#tyc").val(1);

        }
    });

    $("#password").focus(function() {
        $(".password-div").css("visibility", "visible");
    });
    registerValidate();
    $('form#register-form').submit(function() {
        
        var valido = true;
        verifyValidNombre($("#nombre"));
        verifyValidNombre($("#apellido"));
        verifyValidNombre($("#email"));
        verifyValidNombre($("#repitePassword"));
        verifyValidNombre($("#password"));
        verifyValidNombre($("#cuenta"));
        verifyValidNombre($("#web"));
        verifyValidNombre($("#responsableemail"));
        
        if($("#tyc").val()==="0") {
             $(".tyc-error").css("visibility", "visible");
             valido =  false;
        } else {
             $(".tyc-error").css("visibility", "hidden");
        }
        
        if($("#tipoactividad").attr("value")==="0") {
             $(".tipodecuenta-error").css("visibility", "visible");
             valido = false;
        }  else {
             $(".tipodecuenta-error").css("visibility", "hidden");
        }     
        
        return valido;
    });





});
function passwordStrength(password)
{
    var desc = new Array(),
            texto = new Array();
    desc[0] = "muy-debil";
    desc[1] = "debil";
    desc[2] = "media";
    desc[3] = "buena";
    desc[4] = "fuerte";
    desc[5] = "fuerte";

    texto[0] = "Muy Débil";
    texto[1] = "Débil";
    texto[2] = "Media";
    texto[3] = "Buena";
    texto[4] = "Fuerte";
    texto[5] = "Fuerte";


    var score = 0;

    //if password bigger than 6 give 1 point
    if (password.length > 6)
        score++;

    //if password has both lower and uppercase characters give 1 point	
    if ((password.match(/[a-z]/)) && (password.match(/[A-Z]/)))
        score++;

    //if password has at least one number give 1 point
    if (password.match(/\d+/))
        score++;

    //if password has at least one special caracther give 1 point
    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/))
        score++;

    //if password bigger than 12 give another 1 point
    if (password.length > 12)
        score++;

    $(".strenght > span").html(texto[score]);
    $(".fortaleza").removeClass().addClass("fortaleza " + desc[score]);
    $("#desc-container > div").each(function() {
        $(this).hide();
    });
    $(".desc-" + desc[score]).show();

    return score;

}
function registerValidate() {

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

    $('form#register-form').validate({
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
            password: {
                required: true
            },
            repitePassword: {
                required: true,
                valueNotEquals: $("#register-form #repitePassword").val()
            },
            cuenta: {
                required: true,
                regex: /^[a-zA-Z0-9]+$/
            },
            web: {
                regex: /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/
            },
            responsableemail:{
                required: true,
                email: true
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
            repitePassword: {
                required: 'Debe repetir la contrase&ntilde;a',
                valueNotEquals: 'La Contrase&ntilde;a no coincide'
            },
            password: {
                required: 'Ingrese una contrase&ntilde;a'
            },
            cuenta: {
                required: 'Ingrese un nombre de cuenta',
                regex: 'solo letras y numeros'
            },
            web: {
                required: 'Ingrese un nombre de cuenta',
                regex: 'solo letras y numeros'
            },
            responsableemail: {
                required: 'Debe ingresar un Email',
                email: 'no es un email valido'
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


