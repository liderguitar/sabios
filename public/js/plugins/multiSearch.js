$.fn.multiSearch = function(model, classes){

	var originalId = "#" + $(this).attr("id");
	var multiName = 'multi' + model;
	var multi = "#" + multiName;
	var elementModel = "#" + model;
	var modelId = elementModel + "Id";
	$(this).attr("autocomplete","off");	
	
	$(this).after('<select id="' + multiName + '" class="' + classes + '" size="5" name="' + multiName + '" style="display: none;"> </select>');
	var multiName = 'multi' + model; 
    $(this).bind(
            'keyup',
            function() {
               $.ajax(
        		   {
	                    type: "POST",
	                    url: "/" + model + "/search/key/" + $(originalId).val() ,
	                    contentType: "application/json; charset=utf-8",
	                    dataType: "json",
	                    success: function(data) {
	                        
	                        if (
	                        		$(multi).css("display") == 'none' 	&& 
	                        		$(elementModel).val() 				&&
	                        		data.length > 0
	                        	) 
	                        {
	                        	options = {'direction' : 'up', 'mode' : 'show'};
	                            $(multi).effect('slide', options, 500);
	                        } else {
	                        	$(modelId).val(0);
	                        }
	                        
	                        $(multi + " option").remove();
	                        
	                        for ( var i = 0; i < data.length; i++) {
	                            $(multi).append(
	                                    '<option value=' + data[i].id + '>'
	                                            + data[i].nombre + '</option>');
	                        }
	                    
	                    }
        		   }
               );
            }
    );
   $(multi).bind('focusout', function() {
    	$(multi).fadeOut();
    });

    $(multi).bind('click', function() {
           $(originalId).val($(multi + " option:selected").text().trim());
           $(modelId).val($(multi + " option:selected").val());
           $(multi).fadeOut();
    });
    $(multi).bind('keyup', function(event) {
	    if ( event.which == 13 ) {
	        $(originalId).val($(multi + " option:selected").text().trim());
	        $(modelId).val($(multi + " option:selected").val());
	        $(multi).fadeOut();
	     }
	    if ( event.which == 27 ) {
	        $(originalId).val($(multi + " option:selected").text().trim());
	        $(modelId).val($(multi + " option:selected").val());
	        $(multi).fadeOut();
	     }   
    });
    $(originalId).bind('keyup', function(event) {
		if ( event.which == 40 ) {
			$(multi).focus();
	        $(multi + " option:first").attr("selected","selected");

		}
    });  
	
};

