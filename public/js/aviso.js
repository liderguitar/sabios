$(document).ready(function() {



    $(".sabios-mas").click(function() {
        if ($("#email3").hasClass("hide")) {
            $("#email3").removeClass("hide");

        } else {
            $("#email3").addClass("hide");
            $("#email3 input").val("");
        }
    });

    $("#guardar").click(function() {
        $("#alerta-emails").submit();
    });

    $("#alerta-emails").submit(function() {
        var email1 = $("#email1");
        var email2 = $("#email2");
        var error = 0;
        if (email1.val().length > 0 && !email1.valid()) {
            verifyValidNombre($("#email1"));
            error++;
        }
        if (email2.val().length > 0 && !email2.valid()) {
            verifyValidNombre($("#email2"));
            error++;
        }
        if (error > 0) return false;

    });

    $('form#alerta-emails').validate({
        rules: {
            onkeyup: false,
            email1: {
                required: true,
                email: true
            },
            email2: {
                required: false,
                email: true
            },
        },
        errorPlacement: function(error, element) {
            //  error.insertAfter(element);

//            $("#cliente-form #" + element.attr('id')).next(error);
        }
    });



});

function verifyValidNombre(element) {
    element.valid();
    if (element.hasClass("valid"))
        $("." + element.attr('id') + "-error").css("visibility", "hidden");
    else
        $("." + element.attr('id') + "-error").css("visibility", "visible");
}