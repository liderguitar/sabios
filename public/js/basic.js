$(document).ready(function() {


    setInterval(mostrarTiempo, 1000);
    $("#categorias").mouseenter(function() {

        $(".menu-genero").fadeIn();
        $(".genero-arrow").fadeIn();

    });
    $(".menu-genero").mouseleave(function() {

        $(".menu-genero").fadeOut();
        $(".genero-arrow").fadeOut();

    });
    $(".sabios-row.tb-close").click(function() {
        $.unblockUI();
    });
    $(".tb-close").click(function() {
        $.unblockUI();
    });

    $(".action-button").bind('click', function() {
        $.blockUI({css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            }, message: 'Cargando...'});
    });
    $("#filter").bind('click', function() {
        $.blockUI({css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            }, message: 'Cargando...'});
        return true;
    });
    $(".ui-icon-pencil").bind('click', function() {
        $.blockUI({css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            }, message: 'Cargando...'});
        return true;
    });
    if ($("#id").val())
        $("a.action-button.cancel").attr("href", $("a.action-button.cancel").attr("href") + "/" + $("#page").val() + "/" + $("#id").val());

    $('#filtro_titulo').bind('click', function() {
        $(this).attr('value', '');
    });


    $.each($(".stock-container"), function() {


        //

        $(this).click(function() {
            var productoId = $(this).attr("productoid");
            if ($(this).hasClass("editing"))
                return true;
            $(".sabios-table-tr.table-row").block({message: null});
            $(this).parent().parent().unblock();
            $this = $(this);
            $.each($this.find(".talle-stock"), function() {
                $(this).hide();
                $(this).parent().find("#stock\\[\\]").show();
            });
            $(this).addClass("editing");

            Sabios.bloquearProducto(productoId);
            $(this).find(".actions").fadeIn();

        });

    });

    // close
    $(".actions i.fa.fa-times").click(function(e) {


        e.stopPropagation();
        var stockContainer = $(this).parent().parent();
        var productoId = stockContainer.attr("productoid");

        stockContainer.find(".talle-stock").show();
        stockContainer.find("#stock\\[\\]").hide();
        $(".sabios-table-tr.table-row").unblock();
        $(this).parent().parent().removeClass("editing");
        $(this).parent().fadeOut();

        // desbloquear

        Sabios.desbloquearProducto(productoId);

    });


    // save

    $(".actions i.fa-floppy-o").click(function(e) {


        e.stopPropagation();

        var stockContainer = $(this).parent().parent();
        var productoId = stockContainer.attr("productoid");
        var talles = [];
        $.each(stockContainer.find(".box_talle.talle-list"), function() {
            var stock = $(this).find("#stock\\[\\]").val();
            var id_talle = $(this).find("#id_talle\\[\\]").val();
            var talle = {"id_talle": id_talle, "stock": stock};
            talles.push(talle);
        });

        $.ajax({
            data: {id: productoId, "talles": talles},
            url: '/productotextil/savestock',
            type: 'post',
            success: function(response) {
                if (response !== "1")
                    alert("Error al grabar datos");
            }
        });

        // igualar los numeros de los input con lo de los labels
        $.each(stockContainer.find(".box_talle"), function() {
            $(this).find(".talle-stock").html($(this).find(".talle-input").val());
        });

        stockContainer.find(".talle-stock").show();
        stockContainer.find("#stock\\[\\]").hide();
        $(".sabios-table-tr.table-row").unblock();
        $(this).parent().parent().removeClass("editing");
        $(this).parent().fadeOut();



        Sabios.desbloquearProducto(productoId);
        $.growlUI('Grabaci&oacute;n de Stock', 'Se ha grabado correctamente.');

    });



//    $(document).keyup(function(e) {
//        if (e.keyCode === 27) {
//            $.each($(".talle-stock"), function() {
//                $(this).show();
//                $(this).parent().find("#stock\\[\\]").hide();
//                $(this).parent().parent().parent().parent().unblock();
//            });
//        }
//    });





//
//
//    $.each($(".talle-stock"), function() {
//        $this = $(this);
//
//        $(this).click(function() {
//            $.each($(".talle-stock"), function() {
//                $(this).show();
//                $(this).parent().find("#stock\\[\\]").hide();
//                $(this).parent().parent().parent().parent().block({ message: null });                
//            });
//            $(this).hide();
//            $(this).parent().find("#stock\\[\\]").show();
//            $(this).parent().find("#stock\\[\\]").focus();
//            $(this).parent().parent().parent().parent().unblock();
//
//        });
//
//    });
//    $(document).keyup(function(e) {
//        if (e.keyCode === 27) {
//            $.each($(".talle-stock"), function() {
//                $(this).show();
//                $(this).parent().find("#stock\\[\\]").hide();
//                $(this).parent().parent().parent().parent().unblock();                
//            });
//        }
//    });

    $("a").each(function() {

        var path = window.location.pathname;
        if ($(this).attr('href') === path) {
            $(this).css('color', '#00BFF2 !important');
        }
    });
    $("#menu-principal .ul-container").hide();
    $("#menu-principal ul li").click(function() {

        var selector = $(this).next();
        //  alert($(this));
        if (!selector.hasClass('ul-container'))
            return true;
        if ($(this).hasClass('expandable')) {
            $(this).removeClass('expandable');
            $(this).addClass('collapsable');
        } else {
            $(this).removeClass('collapsable');
            $(this).addClass('expandable');
        }
        if (selector.hasClass('oculto')) {
            selector.removeClass('oculto');
            selector.slideDown('fast');
        } else {
            selector.addClass('oculto');
            selector.slideUp('fast');
        }

        saveMenuTreeArray();

    });
    restoreMenuTree();

});

var sabiosMessageBox = function(title, message) {

    $("#sabios-messagebox .sabios-table-titulo span").html(title);
    $("#sabios-messagebox #description p").html(message);

    $.blockUI({
        css: {
            width: "336px",
            border: 'none',
            padding: '0px',
            opacity: "1",
            backgroundColor: '#FFF',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px'
        },
        message: $("#sabios-messagebox"),
        overlayCSS: {
            backgroundColor: '#FFF',
            opacity: 0,
            cursor: 'wait'
        }
    }
    );

    $('input').keypress(function(e) {
        if (e.which == 13)
            e.preventDefault();
    });



};

var sabiosShowImage = function(image) {

    $("#show_image").html("<img src='/files/"+image+"'/>");


    var h = ($(window).height() - 600) / 2 ; 
    var w = ($(window).width() -800) / 2; 
    
    $.blockUI({
        css: {
            width: "800px",
            top: h+"px",
            left: w+"px",
            border: 'none',
            padding: '0px',
            opacity: "1",
            backgroundColor: '#FFF',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px'
        },
        message: $("#show_image"),
        overlayCSS: {
            backgroundColor: '#CCC',
            opacity: 0.5,
            cursor: 'wait'
        }
    }
    );
    $('body').keypress(function(e) {
        if (e.which == 13)
            $.unblockUI();
    });

    $('body').keypress(function(e) {
        if (e.which == 0)
            $.unblockUI();
    });



};

var sabiosConfirm = function(title, message, id, callback) {

    $("#sabios-confirm .sabios-table-titulo span").html(title);
    $("#sabios-confirm #description p").html(message);

    $.blockUI({
        css: {
            width: "336px",
            border: 'none',
            padding: '0px',
            opacity: "1",
            backgroundColor: '#FFF',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px'
        },
        message: $("#sabios-confirm"),
        overlayCSS: {
            backgroundColor: '#FFF',
            opacity: 0,
            cursor: 'wait'
        }
    }
    );
    $("#sabios-confirm .option-no").click(function() {
        $.unblockUI();
        return false;
    });
    $("#sabios-confirm .option-yes").click(function() {
        $.unblockUI();
        callback(id);
    });



    $('input').keypress(function(e) {
        if (e.which == 13)
            e.preventDefault();
    });

    // calback



};



var mensajeModal = function(title, message, type) {

    $("#dialog").attr("title", title);
    $("#innerDialog").addClass(type);
    $("#innerDialog").html("<p>" + message + "</p>");
    $("#dialog").dialog(
            {
                modal: true,
                resizable: false,
                draggable: false,
                buttons: {
                    Ok: function() {
                        $(this).dialog("close");
                    }
                }
            }

    );
    $('input').keypress(function(e) {
        if (e.which == 13)
            e.preventDefault();
    });

};
var block = function() {
    $.blockUI({css: {
            border: 'none',
            padding: '15px',
            backgroundColor: '#000',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px',
            opacity: .5,
            color: '#fff'
        }, message: 'Cargando...'});
};

var saveMenuTreeArray = function() {

    var array = [];
    $.each($("#menu-principal ul li"), function() {

        if ($(this).attr('menuid')) {
            array.push({menuid: $(this).attr('menuid'), class: $(this).attr('class')});
        }

    });
    $.cookie("menu", JSON.stringify(array), {expires: 365});


};

var restoreMenuTree = function() {

    if (!$.cookie("menu"))
        return false;
    var menutree = JSON.parse($.cookie("menu"));
    for (var i = 0; i < menutree.length; i++) {

        $.each($("#menu-principal ul li"), function() {
            if ($(this).attr('menuid') !== undefined && $(this).attr('menuid') === menutree[i].menuid) {
                $(this).attr('class', menutree[i].class);
                if ($(this).attr('class') === 'collapsable') {
                    $(this).next().removeClass('oculto');
                    $(this).next().show('fast');
                } else {
                    $(this).next().addClass('oculto');
                    $(this).next().hide('fast');
                }
            }

        });

    }

};

var saveFdp = function(fdp){
 
       $.cookie("fdp", fdp, {expires: 365});
       
    
}
var getFdp = function(){
       if (!$.cookie("fdp")){
           $.cookie("fdp", false, {expires: 365});
       }
       
       return $.cookie("fdp");
}

function mostrarTiempo() {
    var tiempo = new Date();
    var minutos = tiempo.getMinutes();
    var segundo = tiempo.getSeconds();

    if (minutos < 10) {
        minutos = "0" + minutos;
    }
    if (segundo < 10) {
        segundo = "0" + segundo;
    }

    var horario = tiempo.getHours() + ":" + minutos + ":" + segundo;
    $("#tiempo").html(horario);
}

var isValidEmailAddress = function(emailAddress) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
};

var validarEmail = function(emailAddress){
            var resp = false;
            $.ajax({
            url: '/catalogo/validaremail?email=' + emailAddress,
            type: 'get',
            datatype : 'json',   
            async: false,
            success: function(response) {
                if (response.success) {
                    resp =  true;
                } else {
                    resp = false;
                }
            }
        });
};
