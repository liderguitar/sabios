var mensajeModal = function ( title, message) {
	$("#dialog").attr("title" , title);
	$("#innerDialog").html("<p>" + message + "</p>");
	$("#dialog").dialog(
			
			{
				modal: true,
				buttons: {
					Continuar: function() {
						$( this ).dialog( "close" );
					}
				}
			}
	
	);
	
};