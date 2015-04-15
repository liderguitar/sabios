$(document).ready(function() {

    $("#carrito-fdp").live('change', function() {
        saveFdp($(this).val());
        $.ajax({
            url: '/catalogo/getcarrito',
            type: 'get',
            dataType: "json",
            cache: false,
            success: function(response) {
                if (!response.success) {
                    alert(response.message);
                    return false;
                }
                // dibujar el carrito
                renderCarrito(response.data);
            }
        });
    });



    $.ajax({
        url: '/catalogo/getcarrito',
        type: 'get',
        dataType: "json",
        cache: false,
        success: function(response) {
            if (!response.success) {
                alert(response.message);
                return false;
            }
            // dibujar el carrito
            renderCarrito(response.data);
        }
    });

    $.each($(".prod-mas"), function() {
        $(this).click(function() {
            var cant = $(this).parent().find("input").val();
            var max = $(this).parent().find("input").attr("max");
            if (parseInt(cant) + 1 > parseInt(max)) {
                alert("no hay suficiente Stock!");
                return false;
            }
            $(this).parent().find("input").val(parseInt(cant) + 1);
        });


    });


    $.each($(".prod-menos"), function() {
        $(this).click(function() {
            var cant = $(this).parent().find("input").val();
            if (parseInt(cant) - 1 < 0) {
                return false;
            }
            $(this).parent().find("input").val(parseInt(cant) - 1);
        });


    });

    // carrito
    $("#carrito-submit").click(function() {

        var detalle = [];

        var stock = [];
        $.each($(".stock-item-input"), function() {
            if ($(this).val() > 0) {
                stock.push({"talle": {"id": $(this).attr("data"), "nombre": $(this).attr("nombre")}, "stock": $(this).val()});
            }
        });
        detalle.push(
                {
                    "id": $("#productoTextilId").val(),
                    "stock": stock,
                    "nombre": $("#nombre").val(),
                    "codigo": $("#codigo").val(),
                    "precio": $("#precio").val()

                }
        );
        if (stock.length) {

            $.ajax({
                data: {data: detalle},
                url: '/catalogo/carrito',
                type: 'post',
                dataType: "json",
                cache: false,
                success: function(response) {
                    if (!response.success) {
                        alert("error al guardar carrito");
                        return false;
                    }
                    // dibujar el carrito
                    renderCarrito(response.data);
                }
            });


        } else
            alert("No hay nada q agregar al carrito.");

    });

    $(".borrarcarrito").live('click', function() {

        sabiosConfirm('Esta Seguro?',
                'Desea borrar el producto del pedido?',
                $(this).attr("prodid"),
                function(prodid) {

                    $.ajax({
                        data: {id: prodid},
                        url: '/catalogo/borrarcarrito',
                        type: 'post',
                        dataType: "json",
                        cache: false,
                        success: function(response) {
                            if (!response.success) {
                                alert("error al borrar carrito");
                                return false;
                            }
                            // dibujar el carrito
                            renderCarrito(response.data);
                        }
                    });

                });
    });


    $("#carrito-confirm").live('click', function() {
        $.blockUI({
            css: {
                width: "436px",
                border: 'none',
                padding: '0px',
                opacity: "1",
                backgroundColor: '#FFF',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px'
            },
            message: $("#carrito-confirm-dialog"),
            overlayCSS: {
                backgroundColor: '#FFF',
                opacity: 0,
                cursor: 'wait'
            }
        }
        );
        $("#carrito-confirm-dialog .option-no").click(function() {
            $.unblockUI();
            return false;
        });
        $("#carrito-confirm-dialog .option-yes").click(function() {
            $.unblockUI();
            // aqui confirmar pedido.

            $.ajax({
                data: {fdp: $("#fdp").val()},
                url: '/catalogo/confirmarcarrito',
                type: 'post',
                dataType: "json",
                cache: false,
                success: function(response) {
                    if (!response.success) {
                        alert("error al guardar carrito");
                        return false;
                    }
                    alert(response.message);

                    // dibujar el carrito
                    location.reload(true);
                }
            });


        });
    });
    



});
var renderCarrito = function(data) {

    if (!data) {
        $("#carrito-container").html("");
        $(".divconfirm").hide();
        return false;
    }
    var tpl = $("#carrito-tpl").html();
    var row = "";
    var contador = 0;
    var totalcarrito = 0;
    var tp = getFdp();
    $.each(data, function(i, v) {

        var grey = contador % 2 ? 'grey' : '';
        var talles = "";
        var totalcant = 0;

        $.each(v.stock, function(i, v) {

            var cant = v.stock;
            var talle = v.talle.nombre;
            totalcant += parseInt(cant);
            talles = talles + talle + ":" + cant + " / ";
        });
        talles = talles + " Total:" + totalcant;
        if (tp === "false") {
            
            var precio = "ELIJA PRECIO";
            var preciototal = 0;

        } else {
            var precio = parseFloat(v.precio * pagostipo[tp]).toFixed(2);
            var preciototal = totalcant * precio;
            totalcarrito = totalcarrito + preciototal;

        }

        var fila = $("#row-carrito").html();

        fila = fila.replace(/%codigo/, v.codigo);
        fila = fila.replace(/%nombre/, v.nombre);
        fila = fila.replace(/%precio/, precio);
        fila = fila.replace(/%talles/, talles);
        fila = fila.replace(/%total/, preciototal.toFixed(2));
        fila = fila.replace(/%clase/, grey);
        fila = fila.replace(/%id/, i);
        fila = fila.replace(/%id/, i);
        row = row + fila;
        contador++;


    });
    tpl = tpl.replace(/%tr/, row);
    tpl = tpl.replace(/%totalcarrito/, totalcarrito.toFixed(2));

    $("#carrito-container").html(tpl);
    $("#carrito-fdp").val(tp);
    $(".divconfirm").show();


};