$(document).ready(function() {

	$.ajaxSetup({ scriptCharset: "utf-8" , contentType: "application/json; charset=utf-8"});
    $(".checkbox").styly();
    $("#multi").hide();
    $("#genero").multiSearch("genero","rounded span-10");
    $("#editorial").multiSearch("editorial","rounded span-10");
    $("#autor").multiSearch("autor","rounded span-10");

    
    if($("#oferta").attr("checked")){
		$('#oferta').styly('check', true);
    }
    
	if($("#novedad").attr("checked")){
		$('#novedad').styly('check', true);
	}
	
	if( $("#destacado").attr("checked")){
		$('#destacado').styly('check', true);
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
    

    $("#agregar-button").bind('click', function() {

    	   $("#categoriaSelect option:selected").each(
    			   function() {
                        $("#categoria").append(
                                '<option value=' + $(this).val() + '>'
                                        + $(this).text() + '</option>');
    		            $(this).remove();
    	    		}
    	   	);
	});
    
    $("#container-0 .close").click(function(){
    	$("#container-0 img").hide();
    	$(this).hide();
    	$("#fotoname").val("");
    	$("#foto-0").show();
    });
    
    $("#container-1 .close").click(function(){
    	$("#container-1 img").hide();
    	$("#fotoname2").val("");    	
    	$("#foto-1").show();
    	$(this).hide();    	
    });
    
    $("#container-2 .close").click(function(){
    	$("#container-2 img").hide();
    	$("#fotoname3").val("");    	
    	$("#foto-2").show();
    	$(this).hide();    	
    });
    
    $("#container-3 .close").click(function(){
    	$("#fotoname4").val("");
    	$("#container-3 img").hide();
    	$("#foto-3").show();
    	$(this).hide();    	
    });
    
    $("#container-4 .close").click(function(){
    	$("#fotoname5").val("");
    	$("#container-4 img").hide();
    	$("#foto-4").show();
    	$(this).hide();    	
    });    
    
});