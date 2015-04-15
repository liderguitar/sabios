function ajaxFileUpload()
		{
			$("#loading")
			.ajaxStart(function(){
				$(this).show();
			})
			.ajaxComplete(function(){
				$(this).hide();
			});

			$.ajaxFileUpload
			(
				{
					url:'/uploader/upload',
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:{name:'logan', id:'id'},
					success: function (data, status)
					{
						$("#image").html(
								
						'<img src="' + data.path + '"/>'
						
						
						); 
						if(typeof(data.error) != 'undefined')
						{
							if(data.error != '')
							{
								alert(data.error);
							}
						}
					},
					error: function (data, status, e)
					{
						alert(e);
					}
				}
			)
			
			return false;

		}	
$(document).ready(
function() {
		$( "#fechaNacimiento" ).datepicker({ dateFormat: 'yy-mm-dd',  changeYear: true, changeMonth: true, yearRange: '1900:2050' });
		$("INPUT.spin-button").SpinButton({min:0});
		$("#subirFoto").click(function(){
			
			ajaxFileUpload();
		
		});
		$("#dialog").dialog();
			
});