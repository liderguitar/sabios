$(document).ready(function() {



    $(".close").live('click', function() {

        $(this).parent().find("input").val('');
        $(".foto-file").show();
        $(this).parent().find("img").remove();
        $(this).hide();


    });

    $.each($(".sabios-radio"), function() {
        $(this).click(function() {
            if ($("#opcion").val() == 1) {
                $("#opcion_1.sabios-radio").removeClass("sabios-radio-on").addClass("sabios-radio-off");
                $("#opcion_2.sabios-radio").removeClass("sabios-radio-off").addClass("sabios-radio-on");
                $("#opcion").val(2);
                $("#link").prop('disabled', true);
            } else {
                $("#opcion_2.sabios-radio").removeClass("sabios-radio-on").addClass("sabios-radio-off");
                $("#opcion_1.sabios-radio").removeClass("sabios-radio-off").addClass("sabios-radio-on");
                $("#link").prop('disabled', false);
                $("#opcion").val(1);
            }
        });





    });

    $(".foto-file input").live('change', function() {
        var id = $(this).attr("id");
        $this = $(this);
        $.ajaxFileUpload
                (
                        {
                            url: '/browser/ajaxuploadnovedad/',
                            secureuri: false,
                            fileElementId: id,
                            dataType: 'json',
                            beforeSend: function()
                            {
                                console.log("enviando");
                            },
                            complete: function()
                            {
                                console.log("complete");

                                //$("#loading").hide();
                            },
                            success: function(data, status)
                            {
                                console.log(data);
                                if (typeof(data.message) !== 'undefined')
                                {
                                    if (data.success)
                                    {
                                        console.log(data);
                                        $("#fotoname-1").val(data.fileName);
                                        $("#fotoname-1").after("<div class='close novedad-close'></div><img width='176px' src='" + data.publicFolder + "/thumb_" + data.fileName + "'/>");
                                        $(".foto-file").hide();
                                        $(".error-field.file-error").css('visibility', 'hidden');

                                        alert(data.message);

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




    $("#novedad-form").submit(function() {

        if ($("#fotoname-1").val().length === 0 && $("#imagen").val().length === 0) {
            $(".error-field.file-error").css('visibility', 'visible');
            return false;
        } else
            $(".error-field.file-error").css('visibility', 'hidden');


        if ($("#opcion").val() == "1" && !$("#link").val().length) {
            $(".error-field.link-error").css('visibility', 'visible');
            return false;
        } else
            $(".error-field.link-error").css('visibility', 'hidden');

        var urlPattern = new RegExp('^(https?:\/\/)?' + // protocol
                '((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|' + // domain name
                '((\d{1,3}\.){3}\d{1,3}))' + // OR ip (v4) address
                '(\:\d+)?(\/[-a-z\d%_.~+]*)*' + // port and path
                '(\\?[;&a-z\d%_.~+=-]*)?' + // query string
                '(\#[-a-z\d_]*)?$', 'i'); // fragment locater

        if ($("#opcion").val() == "1" && !urlPattern.test($("#link").val())) {
            $(".error-field.link-error").css('visibility', 'visible');
            return false;

            //do something about it
        }
    });





});




