var Sabios = {
    sabiosSelect: function(selector) {
        $(selector).find(".sabios-select").click(function() {
            $(selector).find(".select-container").fadeIn();
            $(selector).find(".sabios-select").addClass("sabios-select-open");
        });

        if ($(selector).find(".input-field").val() !== "0") {
           // $(selector).find(".sabios-select span").html($(selector).find(".input-field").attr("text"));
            var text = $(selector).find(".sabios-option[value='"+$(selector).find(".input-field").val()+"']").text();
            $(selector).find(".sabios-select span").html(text);           
        }

        $(selector).find(".sabios-option").click(function() {
            $(selector).find(".sabios-select span").html($(this).html());
            $(selector).find(".select-container").fadeOut();
            $(selector).find(".input-field").val($(this).attr("value"));
            $(selector).find(".sabios-select").removeClass("sabios-select-open");



        });

        $(selector).find(".sabios-option:first").addClass("first-option");
        $(selector).find(".sabios-option:last").addClass("last-option");
        $(document).mouseup(function(e)
        {
            var container = $(selector).find(".select-container");

            if (!container.is(e.target) // if the target of the click isn't the container...
                    && container.has(e.target).length === 0) // ... nor a descendant of the container
            {
                $(selector).find(".sabios-select").removeClass("sabios-select-open");
                container.fadeOut();
            }
        });

    },
    bloquearProducto: function(productoId) {
        $.ajax({
            data: {id: productoId},
            url: '/productotextil/bloquear?id=' + productoId,
            type: 'post',
            success: function(response) {
                if (response !== "1") {
                    alert(response);
                    alert("error al bloquear producto");
                    return false;
                }
            }
        });
    },
    desbloquearProducto: function(productoId) {
        $.ajax({
            data: {id: productoId},
            url: '/productotextil/desbloquear?id=' + productoId,
            type: 'post',
            success: function(response) {
                if (response !== "1") {
                    alert("error al bloquear producto");
                    return false;
                }
            }
        });

    },
    savestock: function(params) {
        $.ajax({
            data: params,
            url: '/productotextil/savestock',
            type: 'post',
            success: function(response) {
                if (response !== "1") {
                    alert("error al bloquear producto");
                    return false;
                }
            }
        });

    }

};