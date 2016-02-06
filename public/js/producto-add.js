var selectedcoords;

$(document).ready(function() {


    $(document.body).on('click', ".cancelcrop", function(){

        $("#"+$(this).attr("image")).cropper("destroy");
        $(this).parent().animate({width:"200px"},1000)
        $(this).parent().find(".cropper").remove();
        $(this).parent().find(".cancelcrop").remove();


    });

    $(document.body).on('click', ".close",  function() {

        $this = $(this);

        $(function() {
            $( "#dialog-confirm" ).dialog({
                resizable: false,
                height:140,
                modal: true,
                buttons: {
                    "Borrar": function() {

                        $( this ).dialog( "close" );
                        $this.parent().find("img").cropper("destroy");
                        $this.parent().parent().find("input").val('');
                        $this.parent().parent().find(".fotoname").remove();
                        $this.parent().parent().find("input").show();
                        $this.parent().remove();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            data : {path: $this.parent().find("img").attr("src")},
                            url: '/browser/ajaxdeleteimage/',
                            success : function(data) {
                                if(data.success) {
                                    // hacer algo?
                                }
                            }
                        });
                        $this.parent().find("img").remove();
                    },
                    "Cancelar" : function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
        });


    });
    $(document.body).on('click', ".cropper", function(){

        $this=$(this);
        $.ajax({
            type: 'post',
            dataType: 'json',
            url: '/browser/ajaxcrop/',
            data : selectedcoords,
            success : function(data) {
                if(data.success) {
                    $("#image_" + data.number).cropper('destroy');
                    $("#image_" + data.number).attr('src', data.publicFolder + "/" + data.fileName);
                    $("#fotoname-"+ data.number).val(data.fileName);
                    $this.parent().animate({width:"200px"},1000)
                    $this.parent().find(".cancelcrop").remove();
                    $this.parent().find(".cropper").remove();

                } else
                {
                    $("#image_" + data.number).cropper('clear');
                    $this.parent().animate({width:"200px"},1000)


                }
            }
        });
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


    $(document.body).on('change', ".foto-file input", function() {
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
                                        $("#" + id).after("<div class='foto-cont'><div class='close'></div><img id='image_"+number+"' file='"+data.fileName+"' src='" + data.publicFolder + "/" + data.fileName + "'/><input type='button' class='cropper sabios-submit' image='image_"+number+"' value='Guardar Cambios'/><input type='button' class='cancelcrop sabios-submit' image='image_"+number+"' value='Cancelar'/></div>");
                                        $("#" + id).hide();
                                        $("#image_" + number).cropper({
                                            aspectRatio: 4 / 3,
                                            minContainerHeight: 600,
                                            minContainerWidth: 800,
                                            zoomOnWheel: false,
                                            crop: function(e) {

                                                selectedcoords = {
                                                    "imageNumber" : number,
                                                    "imageId" : data.fileName,
                                                    "x": e.x,
                                                    "y": e.y,
                                                    "width": e.width,
                                                    "height": e.height,
                                                    "mime" : e.mime
                                                };

                                                //        $("#data_"+number).val(JSON.stringify(selectedcoords));
                                            }
                                        });

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




