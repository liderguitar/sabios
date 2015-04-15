$(document).ready(function() {

    $("span.sabios-edit").click(function() {
        var id = $(this).attr("value");
        $("#tr-data-" + id).hide();
        $("#tr-form-" + id).show();
    });

    $(".fdp-grabar").click(function() {
        var id = $(this).attr("value");
        var text = $("#tr-form-" + id + " #nombre").val();
        if (!text.length) {
            sabiosMessageBox("Error", "Por favor ingrese un nombre");
             $("#tr-form-" + id + " #nombre").focus();
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
                window.location.href = "/talletipo/delete/" + id;
            });
        });

    });
    $(".sabios-fdp-submit").click(function() {
        $.unblockUI();
    });    

});