$(document).ready(function() {
	$(".action-button.save").bind('click', function() {
			$("form").submit();
			return false;
		}
	);
	$(".action-button.cancel").bind('click', function() {
		window.location.replace("/admin/usuario/cancel" );
		return false;
		}
	);	

});
function confirmDelete(id)
{
	$( "#dialog-confirm" ).dialog({
		resizable: false,
		height:170,
		modal: true,
		buttons: {
			Si: function() {
				usuarioDelete(id);

			},
			No: function() {
				$( this ).dialog( "close" );
			}
		}
	});
}


function usuarioDelete(id)
{
	$.ajax({
		type : "POST",
		url : "/usuario/delete/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {
			
			if(data["result"] == "true") {
				window.location.reload();
			}else
		    	mensajeModal('Mensaje','Problema borrando Usuario');

		}
	}
	);
}