$(document).ready(function() {


    $('form#login-form').submit(function() {
        var errors =0;

        if (!isValidEmailAddress($("#nick").val())) {
            $(".nick-error").css("visibility", "visible");
            errors++;
        } else {
            $(".nick-error").css("visibility", "hidden");

        }

        if (!$("#password").val().length) {
            $(".password-error").css("visibility", "visible");
            errors++;
        } else {
            $(".password-error").css("visibility", "hidden");

        }

        if (errors) {
            window.scrollTo(0, 0);
            return false;
        }

    });

});

