$(document).ready(function() {

    $("a#mostrar").click(function() {
        $("#filtros-div").fadeIn();
    });
    $("a#ocultar").click(function() {
        $("#filtros-div").fadeOut();
    });

    $.each($(".sabios-check"), function() {
        $(this).click(function() {
            if ($(this).hasClass('sabios-edit')) {
                $(this).removeClass('sabios-edit').addClass('sabios-sin-tilde');
                $(this).find("input").val(0);
            } else {
                $(this).removeClass('sabios-sin-tilde').addClass('sabios-edit');
                $(this).find("input").val(1);

            }
        });
    });
    $.each(filtros.estado, function(index, value) {
        $("input[name='estado_mostrar_" + value + "']").val(1);
        $("input[name='estado_mostrar_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');
    });
    $.each(filtros.fdp, function(index, value) {
        $("input[name='fdp_mostrar_" + value + "']").val(1);
        $("input[name='fdp_mostrar_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');
    });
    $.each(filtros.vendedor, function(index, value) {

        $("input[name='vendedor_mostrar_" + value + "']").val(1);
        $("input[name='vendedor_mostrar_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');

    });
    $.each(filtros.estado_st, function(index, value) {
        $("input[name='estado_subtotal_" + value + "']").val(1);
        $("input[name='estado_subtotal_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');
    });
    $.each(filtros.fdp_st, function(index, value) {
        $("input[name='fdp_subtotal_" + value + "']").val(1);
        $("input[name='fdp_subtotal_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');
    });
    $.each(filtros.vendedor_st, function(index, value) {

        $("input[name='vendedor_subtotal_" + value + "']").val(1);
        $("input[name='vendedor_subtotal_" + value + "']").parent().removeClass('sabios-sin-tilde').addClass('sabios-edit');

    });
});