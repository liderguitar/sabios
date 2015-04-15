$(document).ready(function() {



    $(".close").live('click', function() {

        $(this).parent().find("input").val('');
        $(this).parent().find("input").show();
        $(this).parent().find("img").remove();
        $(this).hide();


    });

    Sabios.sabiosSelect(".talletipo");
    Sabios.sabiosSelect(".categoria");

    productoValidate();
    $('form#product-form').submit(function() {

        var valido = true;
        verifyValidNombre($("#codigo"));
        verifyValidNombre($("#nombre"));
        verifyValidNombre($("#precio"));
        verifyValidNombre($("#costo"));

        if ($("#tipotalle").val() === "0") {
            valido = false;
            $(".tipotalle-error").css("visibility", "visible");
        } else {
            $(".tipotalle-error").css("visibility", "hidden");
        }

        if ($("#categoria").val() === "0") {
            valido = false;
            $(".categoria-error").css("visibility", "visible");
        } else {
            $(".categoria-error").css("visibility", "hidden");

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
                                if (typeof(data.message) !== 'undefined')
                                {
                                    if (data.success)
                                    {
                                        var number = $("#" + id).attr("number");
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

function productoValidate() {

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

    $('form#product-form').validate({
        rules: {
            codigo: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            nombre: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            precio: {
                number: true,
                required: true
            },
            costo: {
                number: true,
                required: true
            }
        },
        
        
        errorPlacement: function(error, element) {
            $("." + element.attr('id') + "-error").find("span.white").html(error.html());
            $("#register-form #" + element.attr('id')).next(error);
            element.focus();
        },
        messages: {
            codigo: {
                required: 'Debe Ingresar un Nombre.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            nombre: {
                required: 'Debe Ingresar un Apellido.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            precio: {
                required: 'Debe ingresar un precio',
                number: 'no es un precio valido'
            },
            costo: {
                required: 'Debe ingresar un costo',
                number: 'no es un costo valido'
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




