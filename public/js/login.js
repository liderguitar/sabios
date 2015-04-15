$(document).ready(function() {



    loginValidate();
    $('form#login-form').submit(function() {

        var valido = true;
        verifyValidNombre($("#nick"));
        verifyValidNombre($("#password"));
        return valido;
    });

});
function loginValidate() {


    $('form#login-form').validate({
        rules: {
            nick: {
                required: true,
                email: true
                
            },
            password: {
                required: true
            }
        },
        submitHandler: function(form) {

   


            if ($("#login-form").valid()) {
                $("#login-form").submit();
            }


            return false;
        },
        errorPlacement: function(error, element) {
            $("." + element.attr('id') + "-error").find("span.white").html(error.html());
            $("#register-form #" + element.attr('id')).next(error);
            element.focus();
        },
        messages: {
            nick: {
                required: 'Debe Ingresar un Email.',
                email: 'No es una direcci&oacute;n de Email v&aacute;lida'
            },
            password: {
                required: 'Debe Ingresar un password.',
                minlength: 'Minimo 4 caracteres.'
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



