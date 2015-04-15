$(document).ready( function(){


	$(".thumb").click(function(){
	
		var imageSrc =  $("#" + $(this).attr("id") + " img").attr("src");	
		window.opener.CKEDITOR.tools.callFunction('2',imageSrc);
		window.close();
	//alert(    $("#" + $(this).attr("id") + " img").attr("src"));
	   
		
	});
});