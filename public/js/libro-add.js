$(document).ready(function() {
    $.ajaxSetup({ scriptCharset: "utf-8" , contentType: "application/json; charset=utf-8"});
    $("#genero").multiSearch("genero","rounded span-16 righty multisearch");
    $("#editorial").multiSearch("editorial","rounded span-16 righty multisearch");
    $("#autor").multiSearch("autor","rounded span-16 righty multisearch");

    $(".checkbox").styly();
    //$('#novedad').styly('check', true);
    $("#multi").hide();
    $("#multiAutor").hide();

    if( $("input[name='oferta'][type='hidden']").val())
		$('#oferta').styly('check', true, false);
	if( $("input[name='novedad'][type='hidden']").val())
		$('#novedad').styly('check', true, false);
	if( $("input[name='destacado'][type='hidden']").val() == "1" ){
		$('#destacado').styly('check', true, false);
	}
	if( $("#mostrarPrecio").attr("checked")){
		$('#mostrarPrecio').styly('check', true);
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