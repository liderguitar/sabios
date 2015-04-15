<?php
class Zend_View_Helper_MensajeModal extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function mensajeModal($mensaje)
    {

    	$this->_html = "
    	<script>
			$(document).ready(function(){	
					mensajeModal('Mensaje','" . htmlentities($mensaje) ."', 'mensaje'); 
    		});
		</script>";

        return $this->_html;
    }
    
}