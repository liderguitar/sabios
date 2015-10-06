/**
 * 
 */

function clienteValidate() {

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
    jQuery.validator.addMethod("valueNotEquals", function(value, element, arg) {
        return arg != value;
    }, "Value must not equal arg.");

    $('form#cliente-form').validate({
        rules: {
            onkeyup: false,
            nombre: {
                required: true,
                minlength: 4,
                maxlength: 50
            },
            id_categoria_cliente: {
                required: true,
                valueNotEquals: "0"
            },
            telefono1: {
                required: true,
                minlength: 6,
                maxlength: 25

            },
            telefono2: {
                required: true,
                minlength: 6,
                maxlength: 25
            },
            email: {
                required: true,
                email: true
            },
            password: {
                required: false,
                minlength: 3,
                maxlength: 25,
                regex: /^[a-zA-Z0-9]+$/
            },
            sms1: {
                required: false,
                minlength: 9,
                maxlength: 30,
                regex: /^[0-9]+$/
            },
            email1: {
                required: true,
                email: true               
            },
            sms2: {
                required: false,
                minlength: 9,
                maxlength: 30,
                regex: /^[0-9]+$/
                
            },
            email2: {
                required: false,
                email: true               
            },  
            sms3: {
                required: false,
                minlength: 9,
                maxlength: 30,
                regex: /^[0-9]+$/
                
            },
            email4: {
                required: false,
                email: true               
            }           
        },
        errorPlacement: function(error, element) {
          //  error.insertAfter(element);

//            $("#cliente-form #" + element.attr('id')).next(error);
        },
        messages: {
            nombre: {
                required: 'Debe Ingresar un Nombre.',
                minlength: 'Minimo 4 caracteres.',
                maxlength: 'Largo hasta 28 caracteres.'
            },
            telefono1: {
                required: 'Debe ingresar un telefono',
                minlength: 'Minimo 6 caracteres.',
                maxlength: 'Largo hasta 25 caracteres.'
            },
            telefono2: {
                required: 'Debe ingresar un telefono',
                minlength: 'Minimo 6 caracteres.',
                maxlength: 'Largo hasta 25 caracteres.'
            },
            email: {
                required: 'Debe ingresar un Email',
                email: 'no es un email valido'
            },
            password: {
                required: 'Debe ingresar un password',
                minlength: 'Minimo 3 caracteres.',
                maxlength: 'Largo hasta 20 caracteres.',
                regex: 'Solo letras y numeros'
            }

        }
    });


}