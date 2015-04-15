$(document).ready(function() {
 
    $(".checkbox").styly();

    if($("#oferta").attr("checked")){
		$('#oferta').styly('check', true);
    }
    
	if($("#novedad").attr("checked")){
		$('#novedad').styly('check', true);
	}
	
	if( $("#destacado").attr("checked")){
		$('#destacado').styly('check', true);
	}

    $("form").bind(
    		'submit', function(){
    			if($('.check-styly[for="oferta"]').hasClass("check-checked"))
    			    $("input[name='oferta']").val(1);
    			if($('.check-styly[for="destacado"]').hasClass("check-checked"))
    			    $("input[name='destacado']").val(1);
    			if($('.check-styly[for="novedad"]').hasClass("check-checked"))
    			    $("input[name='novedad']").val(1);
    			if($('.check-styly[for="mostrarPrecio"]').hasClass("check-checked"))
    			    $("input[name='mostrarPrecio']").val(1);    			
    		}
    );

});