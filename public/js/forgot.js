$(document).ready(function() {

    Sabios.sabiosSelect(".cliente-tipo");

    $("#forgot_password_form").submit(function() {

        var errors =0;

        if (!isValidEmailAddress($("#email").val())) {
            $(".email-error").css("visibility", "visible");
            errors++;
        } else {
            $(".email-error").css("visibility", "hidden");

        }

        if (errors) {
            window.scrollTo(0, 0);
            return false;
        }

    });


});