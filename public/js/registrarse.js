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
  //  registerValidate();
    $('form#register-form').submit(function() {
        
        return validarRegistro();
    });

    $("#nombre").blur(function(){
        validarNombre();
    });
    $("#apellido").blur(function(){
        validarApellido();
    });

    $("#repitePassword").blur(function(){
        validarRepitePassword();
    });

    $("#email").blur(function(){
        validarEmaill();
    });
    $("#cuenta").blur(function(){
        validarCuenta();
    });
    $("#password").blur(function(){
        validarPassword();
    });
    $("#web").blur(function(){
        validarWeb();
    });
    $("#responsableemail").blur(function(){
        validarResponsableEmail();
    });
    $("#tipoactividad").blur(function(){
        validarTipoActividad();
    });

});


function validarNombre(){
    var valido = 0;
    if( $("#nombre").val().length < 4 || $("#nombre").val().length > 50 ) {
        setError($("#nombre"));
        valido++;
    }else{
        clearError($("#nombre"));
    }
    return valido;
}

function validarApellido(){
    var valido = 0;
    if( $("#apellido").val().length < 4 || $("#apellido").val().length > 50 ) {
        setError($("#apellido"));
        valido++;
    }else{
        clearError($("#apellido"));
    }
    return valido;
}

function validarEmaill(){
    var valido = 0;
    if (!isValidEmailAddress($("#email").val())) {
        setError($("#email"));
        valido++;
    }else{
        clearError($("#email"));
    }
    return valido;

}

function validarRepitePassword(){
    var valido = 0;

    if ($("#password").val() !== $("#repitePassword").val()){
        setError($("#repitePassword"));
        valido++;
    }else{
        clearError($("#repitePassword"));
    }
    return valido;

}

function validarCuenta(){
    var valido = 0;

    var pattern = new RegExp(/^[a-zA-Z0-9]+$/);
    if( !pattern.test($("#cuenta").val())){
        setError($("#cuenta"));
        valido++;
    }else{
        clearError($("#cuenta"));
    }
    return valido;

}

function validarWeb(){
    var valido = 0;

    if($("#web").val().length) {
        var pattern = new RegExp(/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/);
        if (!pattern.test($("#web").val())) {
            setError($("#web"));
            valido++;
        } else {
            clearError($("#web"));
        }
    }else {
        clearError($("#web"));
    }
    return valido;

}
function validarResponsableEmail(){
    var valido = 0;

    if (!isValidEmailAddress($("#responsableemail").val())) {
        setError($("#responsableemail"));
        valido++;
    }else{
        clearError($("#responsableemail"));
    }
    return valido;

}

function validarTyc(){
    var valido = 0;

    if($("#tyc").val()==="0") {
        $(".tyc-error").css("visibility", "visible");
        valido++;
    } else {
        $(".tyc-error").css("visibility", "hidden");
    }
    return valido;

}

function validarTipoActividad(){
    var valido = 0;

    if($("#tipoactividad").attr("value")==="0") {
        $(".tipodecuenta-error").css("visibility", "visible");
        valido++;
    }  else {
        $(".tipodecuenta-error").css("visibility", "hidden");
    }
    return valido;

}

function validarPassword(){
    var valido = 0;

    if (passwordStrength($("#password").val()) < 2) {
        $(".password-error").css("visibility", "visible");
        $(".password-error").find("span.white").html("Verifica la fortaleza de tu contraseña");
        valido++;
    } else {
        $(".password-error").css("visibility", "hidden");
      }
    return valido;

}



function validarRegistro(){
    var valido = 0;

    valido += validarNombre();
    valido += validarApellido();
    valido += validarEmaill();
    valido += validarCuenta();
    valido += validarRepitePassword();
    valido += validarResponsableEmail();
    valido += validarTipoActividad();
    valido += validarWeb();
    valido += validarPassword();
    valido += validarTyc();
    return valido == 0 ? true : false;
}



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

function setError(element) {
        $("." + element.attr('id') + "-error").css("visibility", "visible");
}

function clearError(element) {
        $("." + element.attr('id') + "-error").css("visibility", "hidden");
}