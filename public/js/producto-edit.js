$(document).ready(function() {



    $(".close").live('click', function(){
        $(this).parent().find("input").val('');
        $(this).parent().find("input").show();
        $(this).parent().find("img").remove();
        $(this).hide();
        var number = $(this).parent().find("input").attr("number");
        $("#fotoname-"+number).remove();
    });

    Sabios.sabiosSelect(".talletipo");
    Sabios.sabiosSelect(".categoria");
   
    //registerValidate();
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

        if ($("#tyc").val() === "0") {
            $(".tyc-error").css("visibility", "visible");
            valido = false;
        } else {
            $(".tyc-error").css("visibility", "hidden");
        }

        if ($("#tipoactividad").attr("value") === "0") {
            $(".tipodecuenta-error").css("visibility", "visible");
            valido = false;
        } else {
            $(".tipodecuenta-error").css("visibility", "hidden");
        }

        return valido;
    });

    $(".add-foto").click(function() {
        addFoto();
    });


    $(".foto-file input").live('change', function() {
        var id = $(this).attr("id");
        $this = $(this);
        $.ajaxFileUpload
                (
                        {
                            url: '/browser/ajaxupload/',
                            secureuri: false,
                            fileElementId: id,
                            dataType: 'json',
                            beforeSend: function()
                            {
                                //
                            },
                            complete: function()
                            {
                                //$("#loading").hide();
                            },
                            success: function(data, status)
                            {
                                console.log(data);
                                if (typeof(data.message) !== 'undefined')
                                {
                                    if (data.success)
                                    {
                                        var number =  $("#" + id).attr("number");
                                        $("#fotoname-" + number).val(data.fileName);
                                        $("#" + id).after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>");
                                        $("#" + id).hide();
                                        //$("#" + id).val(data.fileName);
                                    } else
                                    {
                                        alert(data.message);
                                    }
                                }
                            },
                            error: function(data, status, e)
                            {
                                alert(e);
                            }
                        }
                );
    });



});

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
            responsableemail: {
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
function addFoto() {
    var number = $(".foto-file").length + 1;
    
    if (number > 6)
        return false;
        
    var html = '<div class="foto-file"><label>Foto ' + number + ':&nbsp;</label><input number="' + number + '" id="foto-' + number + '" type="file" name="foto-' + number + '"></div><input class="fotoname" type="hidden" name="fotoname-' + number + '" id="fotoname-' + number + '">';
    $(".foto-container").append(html);  


}




