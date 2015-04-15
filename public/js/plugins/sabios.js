/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var Sabios = {
    baseUrl: settings.app_base_url,
    apiCall: function(entity, type, params, callback) {

        $.ajax({
            type: type,
           // contentType: 'json',
            data: params,
            url: this.baseUrl + '/' + entity,
            disableCaching: false,
            beforeSend: function(xhr) {
                xhr.setRequestHeader("apikey", settings.app_id);
                xhr.setRequestHeader("authtoken", settings.app_auth_token);
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

            },
            success: function(response) {

                callback($.parseJSON(response));

            },
            statusCode: {
                403: function() {
                    alert("Api Incorrect");
                }
            }

        });

    },
    addCliente: function(id) {

        $.Mustache.addFromDom();
        var data;
        if (id === 'undefined')
            data = null;
        else
            data = {id: id};

        this.apiCall('cliente', 'GET', data, function(response) {

            $('#cliente-content').empty();
            $('#cliente-content').append($.Mustache.render('cliente', response.data[0]));
            $.each(paises, function(key, value) {
                $('#pais')
                        .append($("<option></option>")
                        .attr("value", value.id)
                        .html(value.nombre));
            });

            clienteValidate();
            if (id !== 0) {
                $.each(response.data[0].PersonalPorCliente, function(key, value) {
                    $('#personal').append($.Mustache.render('personal', value.Personal));
                });
                $.each(response.data[0].SucursalPorCliente, function(key, value) {
                    $('#sucursal').append($.Mustache.render('sucursal', value.Sucursal));
                });
            }
            $.each(clienteTipo, function(key, value) {
                $('#tipo_cliente_id')
                        .append($("<option></option>")
                        .attr("value", value.id)
                        .html(value.nombre));
            });
        });

    },
    listCliente: function() {
        var data;
        data = null;
        this.apiCall('cliente', 'GET', data, function(response) {
            
            $('#cliente-content').empty();
            $('#cliente-content').append($.Mustache.render('cliente-list', response));
        });


    }
};

