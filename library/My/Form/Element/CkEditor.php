<?php

class My_Form_Element_CkEditor extends Zend_Form_Element_Textarea {
	
	protected $height;
	protected $width;
	
	public function __construct($spec, $options = null) {

		if(isset($options['height'])){
			$this->height = $options['height'];
		}
		else
			$this->height = 900;
			
		if(isset($options['width']))
			$this->width = $options['width'];
		else
			$this->width = 960;		
				
		parent::__construct($spec, $options = null);
			
	}
	
	public function render()
	{
		$script = '<script type="text/javascript">
				CKEDITOR.replace( "' . $this->_name. '",
					{ 
					    filebrowserBrowseUrl : "/browser",
        				filebrowserUploadUrl : "/browser/upload",
						height : ' . $this->height . ',
						width : ' . $this->width . ' 
					}
				);
			</script>';
		return parent::render() . $script;
	}
	
	
	
}