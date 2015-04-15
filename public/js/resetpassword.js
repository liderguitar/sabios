$(document).ready(function() {

    $(".error-field.password-error").css("margin-top", "-40px");
    $(".error-field.repitePassword-error").css("margin-top", "105px");

    $("#password").focus();
    $("#password").keyup(function() {
        $(".password-div").css("visibility", "visible");

        passwordStrength($("#password").val());
    });


    $("#password").focus(function() {
        $(".password-div").css("visibility", "visible");
    });
    //registerValidate();
    $('form#reset_password_form').submit(function() {

        var errors = 0;

        var score = passwordStrength($("#password").val());
        if (score < 2) {
            $(".password-div").css("visibility", "visible");

            $(".error-field.password-error").css("visibility", "visible");
            errors++;
        } else {
            $(".error-field.password-error").css("visibility", "hidden");

        }
        if ($("#password").val() !== $("#repitePassword").val()) {
            $(".error-field.repitePassword-error").css("visibility", "visible");
            errors++;

        } else {
            $(".error-field.repitePassword-error").css("visibility", "hidden");


        }

        return errors > 0 ? false : true;


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
        return $("#reset_password_form #password").val() == value;
    }, "Value must not equal arg.");

    $('form#rreset_password_form').validate({
        rules: {
            password: {
                required: true
            },
            repitePassword: {
                required: true,
                valueNotEquals: $("#register-form #repitePassword").val()
            }

        },
        submitHandler: function(form) {


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
            repitePassword: {
                required: 'Debe repetir la contrase&ntilde;a',
                valueNotEquals: 'La Contrase&ntilde;a no coincide'
            },
            password: {
                required: 'Ingrese una contrase&ntilde;a'
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


