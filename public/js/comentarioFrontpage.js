function comentarioSave(id) {
	var uri=encodeURI("/id/" + id +  "/texto/" + $("#texto_" + id).val());
	$.ajax({
		type : "POST",
		url : "/comentario/save/key/" + id + uri,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		data : { id: "1", details: "text de prueba" },
		success : function(data) {

			if (data["result"] == "true") {
				$('#nuevoComment').hide();
				$("#nuevoComentario").show();
				$("#texto_54").val('');
				mensajeModal('Mensaje', 'El comentario ser&aacute; moderado y publicado. Gracias');
			} else
				mensajeModal('Mensaje', data.message);

		}
	});
}

$(document).ready(function() {

 
	$("#nuevoComentario").bind("click", function(){

		$(this).hide();
		$("#nuevoComment").show();



		});
	$("#cancelEdit").bind("click", function(){

		$("#nuevoComentario").show();
		$("#nuevoComment").hide();



		});
	
});

/*  #### PARA HACER MUCHAS COSAS A LA VEZ (borrar / publicar)


$("input[type=checkbox]").each(function(){

if($(this).attr('checked') )
    alert($(this).attr('id'));

});
*/