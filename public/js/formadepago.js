$(document).ready(function() {

    $("span.sabios-edit").click(function() {
        var id = $(this).attr("value");
        $("#tr-data-" + id).hide();
        $("#tr-form-" + id).show();
    });

    $(".fdp-grabar").click(function() {
        var id = $(this).attr("value");
        var val = $("#tr-form-" + id + " #porcentaje").val();
        var text = $("#tr-form-" + id + " #nombre").val();
        if (!text.length) {
            sabiosMessageBox("Error", "Por favor ingrese un nombre");
            $("#tr-form-" + id + " #nombre").focus();
            return false;
        }
        if (!val.match(/^-?(\d{0,})(\.\d{0,2})$/)) {

            sabiosMessageBox("Error", "Verifique el formato del porcentaje (dos digitos y dos decimales)");
            $("#tr-form-" + id + " #porcentaje").focus();

            return false;
        }
        $("#form-fdp-" + id).submit();
    });
    $(".fdp-cancelar").click(function() {
        var id = $(this).attr("value");
        $("#tr-data-" + id).show();
        $("#tr-form-" + id).hide();
    });

    $.each($(".sabios-delete"), function() {

        var id = $(this).attr("value");
        $(this).click(function() {
            sabiosConfirm("Esta seguro?", "Se borrara el registro. Desea continuar?", id, function(id) {
                window.location.href = "/formadepago/delete/" + id;
            });
        });
    });
    $(".sabios-fdp-submit").click(function() {
        $.unblockUI();
    });

});