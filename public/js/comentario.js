function confirmDelete(id) {
	$("#dialog-confirm").dialog({
		resizable : false,
		height : 170,
		modal : true,
		buttons : {
			Si : function() {
				comentarioDelete(id);

			},
			No : function() {
				$(this).dialog("close");
			}
		}
	});
}

function comentarioDelete(id) {
	$.ajax({
		type : "POST",
		url : "/comentario/delete/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {

			if (data["result"] == "true") {
				window.location.reload();
			} else
				mensajeModal('Mensaje', 'Problema borrando Libro');

		}
	});
}
function confirmPublicar(id) {
	
	
	$("#dialog-confirm-public").dialog({
		resizable : false,
		height : 170,
		modal : true,
		buttons : {
			Si : function() {
				comentarioPublicar(id);

			},
			No : function() {
				$(this).dialog("close");
			}
		}
	});
}

function comentarioPublicar(id) {
	$.ajax({
		type : "POST",
		url : "/comentario/publicar/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {

			if (data["result"] == "true") {
				window.location.reload();
			} else
				mensajeModal('Mensaje', 'Problema publicando Comentario');

		}
	});
}

function comentarioSave(id) {
	var uri=encodeURI("/id/" + id +  "/texto/" + $("#texto_" + id).val());
	$.ajax({
		type : "POST",
		url : "/comentario/update/key/" + id + uri,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		data : { id: "1", details: "text de prueba" },
		success : function(data) {

			if (data["result"] == "true") {
				window.location.reload();
			} else
				mensajeModal('Mensaje', data.message);

		}
	});
}

function editComentario(id) {
	// ocultar el 
	$("#comentarioConteiner_" + id).hide();
	$("#textoContainer_" + id).show();
}

function comentarioCancel(id) {
	// ocultar el 
	$("#comentarioConteiner_" + id).show();
	$("#textoContainer_" + id).hide();
}

$(document).ready(function() {

 
	$(".ui-icon-pencil").unbind('click');
	$(".action-button").hide();
	
});

/*  #### PARA HACER MUCHAS COSAS A LA VEZ (borrar / publicar)


$("input[type=checkbox]").each(function(){

if($(this).attr('checked') )
    alert($(this).attr('id'));

});
*/