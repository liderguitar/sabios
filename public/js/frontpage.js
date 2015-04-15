$(document).ready(function() {

	
	// OFERTAS
    $('#slideshowHolder').jqFancyTransitions({ width: 630, height: 325, titleOpacity: 0 });
	
	    
    // RANKING 
    if ($.browser.safari) {
      	window.api = $("#browsable")
  		.scrollable({ hoverClass: 'hover', clickable: false })
  		.mousewheel()
  		.autoscroll({
		        steps: 1,
		        interval: 2000,
		        api: true
  				}
  		);     	
    	
    } else {
      	window.api = $("#browsable")
  		.scrollable({ hoverClass: 'hover', clickable: false })
  		.circular()
  		.mousewheel()
  		.autoscroll({
		        steps: 1,
		        interval: 2000,
		        api: true
  				}
  		);     	
    	
    }

  	
  	$("#entrar").click(function() { 
        $.blockUI({ message: $('#loginForm'),
        css: {
			height: "360px",
			width: "400px",	
			'border-radius': '6px 6px 6px 6px',
            top:  ($(window).height() - 360) /2 + 'px', 
            left: ($(window).width() - 400) /2 + 'px' 

        }

        });
  	});
  	$("#register").click(function() { 
        $.blockUI({ message: $('#registerForm'),
        css: {
			height: "500px",
			width: "400px",	
			'border-radius': '6px 6px 6px 6px',
            top:  ($(window).height() - 500) /2 + 'px', 
            left: ($(window).width() - 400) /2 + 'px' 

        }

        });
  	});  
  	
	
  	$('body').live('keyup', function(e){
  		//alert(e.which);
  	    if(e.which == '27'){
  	    	$("body").unblock();
  	    }
  	});
  	
  	$('.cerrar').live('click', function(e){
	    $("body").unblock();
  	}); 
  	
  	$("#consultas").bind('click', function(){
  		
        $.blockUI({ message: $('#presupuestoForm'),
	        css: {
				height: "560px",
				width: "500px",	
				'border-radius': '6px 6px 6px 6px',
	            top:  ($(window).height() - 560) /2 + 'px', 
	            left: ($(window).width() - 500) /2 + 'px' 
	
	        }
        });
  		
  		
  	});
  	

		  	
  	
});

var totalCompras = 0; 

function addCarrito(monto) {
	totalCompras += monto;
	$(".div-comprar").html("$AR " + parseFloat(totalCompras).toFixed(2));
	return true;
}

function pedirPresupuesto(titulo) {
		$("#consulta").text("Consulta de precio del Libro: " + titulo);
        $.blockUI({ message: $('#presupuestoForm'),
	        css: {
				height: "536px",
				width: "500px",	
				'border-radius': '6px 6px 6px 6px',
	            top:  ($(window).height() - 536) /2 + 'px', 
	            left: ($(window).width() - 500) /2 + 'px' 
	
	        }
        });
}

function forgotPass() {
	
	if ($("#loginForm #nick").val() == "") {
		alert("Ingresa tu usuario");
		$("#loginForm #nick").focus();
		return false;
	}
		
	window.location.replace("/resetear-clave/nick/" + $("#loginForm #nick").val() + "/hash");

	
}

function activateForgotPassForm()
{
    $.blockUI({ message: $('#resetpass'),
        css: {
			height: "250px",
			width: "360px",	
			'border-radius': '6px 6px 6px 6px',
            top:  ($(window).height() - 250) /2 + 'px', 
            left: ($(window).width() - 360) /2 + 'px' 

        }
	});
		

}
