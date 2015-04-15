$(document).ready(function() {
	$("#desde").datetimepicker({ dateFormat: 'yy-mm-dd'});
	$("#hasta").datetimepicker({ dateFormat: 'yy-mm-dd'});
   
 
    
    
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
	    $("#container-0 .close").live('click', function(){
	    	$("#container-0 img").hide();
	    	$(this).hide();
	    	$("#fotoname").val("");
	    	$("#foto-0").val("");
	    	$("#foto-0").show();
	    });
});