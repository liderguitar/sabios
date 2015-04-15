function confirmDelete(id)
{
	$( "#dialog-confirm" ).dialog({
		resizable: false,
		height:170,
		modal: true,
		buttons: {
			Si: function() {
				articuloDelete(id);

			},
			No: function() {
				$( this ).dialog( "close" );
			}
		}
	});
}


function articuloDelete(id)
{
	$.ajax({
		type : "POST",
		url : "/articulo/delete/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {
			
			if(data["result"] == "true") {
				window.location.reload();
			}else
		    	mensajeModal('Mensaje','Problema borrando Articulo');

		}
	}
	);
}
function confirmPublicar(id) {
	
	
	$("#dialog-confirm-public").dialog({
		resizable : false,
		height : 170,
		modal : true,
		buttons : {
			Si : function() {
				articuloPublicar(id);

			},
			No : function() {
				$(this).dialog("close");
			}
		}
	});
}

function articuloPublicar(id) {
	$.ajax({
		type : "POST",
		url : "/articulo/publicar/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {

			if (data["result"] === "true") {
				window.location.reload();
			} else
				mensajeModal('Mensaje', 'Problema publicando Libro');

		}
	});
}