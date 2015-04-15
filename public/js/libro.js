function confirmDelete(id) {
	$("#dialog-confirm").dialog({
		resizable : false,
		height : 170,
		modal : true,
		buttons : {
			Si : function() {
				libroDelete(id);

			},
			No : function() {
				$(this).dialog("close");
			}
		}
	});
}

function libroDelete(id) {
	$.ajax({
		type : "POST",
		url : "/libro/delete/key/" + id,
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
				libroPublicar(id);

			},
			No : function() {
				$(this).dialog("close");
			}
		}
	});
}

function libroPublicar(id) {
	$.ajax({
		type : "POST",
		url : "/libro/publicar/key/" + id,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(data) {

			if (data["result"] == "true") {
				window.location.reload();
			} else
				mensajeModal('Mensaje', 'Problema publicando Libro');

		}
	});
}

$(document).ready(function() {

 
    
    
	$("#foto-0").live('change', function() {
		$.ajaxFileUpload
		(
			{
				url:'/browser/ajax-upload/',
				secureuri:false,
				fileElementId:'foto-0',
				dataType: 'json',
				beforeSend:function()
				{
					$("#loading").show();
				},
				complete:function()
				{
					$("#loading").hide();
				},				
				success: function (data, status)
				{
					if(typeof(data.message) != 'undefined')
					{
						if(data.success)
						{
						
							$("#foto-0").after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>" );
							$("#foto-0").hide();
							$("#fotoname").val(data.fileName);
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		);
	});
	$("#foto-1").live('change', function() {
		$.ajaxFileUpload
		(
			{
				url:'/browser/ajax-upload/',
				secureuri:false,
				fileElementId:'foto-1',
				dataType: 'json',
				beforeSend:function()
				{
					$("#loading").show();
				},
				complete:function()
				{
					$("#loading").hide();
				},				
				success: function (data, status)
				{
					if(typeof(data.message) != 'undefined')
					{
						if(data.success)
						{
						
							$("#foto-1").after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>" );
							$("#foto-1").hide();
							$("#fotoname2").val(data.fileName);
							
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		);
	});
	$("#foto-2").live('change', function() {
		$.ajaxFileUpload
		(
			{
				url:'/browser/ajax-upload/',
				secureuri:false,
				fileElementId:'foto-2',
				dataType: 'json',
				beforeSend:function()
				{
					$("#loading").show();
				},
				complete:function()
				{
					$("#loading").hide();
				},				
				success: function (data, status)
				{
					if(typeof(data.message) != 'undefined')
					{
						if(data.success)
						{
						
							$("#foto-2").after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>" );
							$("#foto-2").hide();
							$("#fotoname3").val(data.fileName);
							
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		);
	});
	$("#foto-3").live('change', function() {
		$.ajaxFileUpload
		(
			{
				url:'/browser/ajax-upload/',
				secureuri:false,
				fileElementId:'foto-3',
				dataType: 'json',
				beforeSend:function()
				{
					$("#loading").show();
				},
				complete:function()
				{
					$("#loading").hide();
				},				
				success: function (data, status)
				{
					if(typeof(data.message) != 'undefined')
					{
						if(data.success)
						{
						
							$("#foto-3").after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>" );
							$("#foto-3").hide();
							$("#fotoname4").val(data.fileName);
							
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		);
	});
	$("#foto-4").live('change', function() {
		$.ajaxFileUpload
		(
			{
				url:'/browser/ajax-upload/',
				secureuri:false,
				fileElementId:'foto-4',
				dataType: 'json',
				beforeSend:function()
				{
					$("#loading").show();
				},
				complete:function()
				{
					$("#loading").hide();
				},				
				success: function (data, status)
				{
					if(typeof(data.message) != 'undefined')
					{
						if(data.success)
						{
						
							$("#foto-4").after("<div class='close'></div><img width='100px' src='" + data.publicFolder + "/" + data.fileName + "'/>" );
							$("#foto-4").hide();
							$("#fotoname5").val(data.fileName);
							
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)
				{
					alert(e);
				}
			}
		);
	});	
    $("#container-0 .close").live('click', function(){
    	$("#container-0 img").hide();
    	$(this).hide();
    	$("#fotoname").val("");
    	$("#foto-0").val("");
    	$("#foto-0").show();
    });
    
    $("#container-1 .close").live('click',function(){
    	$("#container-1 img").hide();
    	$("#fotoname2").val("");    
    	$("#foto-1").val("");    	
    	$("#foto-1").show();
    	$(this).hide();    	
    });
    
    $("#container-2 .close").live('click',function(){
    	$("#container-2 img").hide();
    	$("#fotoname3").val("");    	
    	$("#foto-2").show();
    	$("#foto-2").val("");    	
    	$(this).hide();    	
    });
    
    $("#container-3 .close").live('click',function(){
    	$("#fotoname4").val("");
    	$("#container-3 img").hide();
    	$("#foto-3").show();
    	$("#foto-3").val("");    	
    	$(this).hide();    	
    });
    
    $("#container-4 .close").live('click',function(){
    	$("#fotoname5").val("");
    	$("#container-4 img").hide();
    	$("#foto-4").show();
    	$("#foto-4").val("");    	
    	$(this).hide();    	
    });    	
	
});

/*  #### PARA HACER MUCHAS COSAS A LA VEZ (borrar / publicar)


$("input[type=checkbox]").each(function(){

if($(this).attr('checked') )
    alert($(this).attr('id'));

});
*/