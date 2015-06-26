<?php
class My_Helper_Botonera extends Zend_View_Helper_Abstract
{
	const ADD = "add";
	const CANCEL = "cancel";
	const SAVE = "save";
	const _LIST = "list";
	
	protected $_html;
	
    public function botonera($options)
    {
    	$this->_html = "";
		foreach ($options as $action) {
			
				$this->_html .= $this->_getHtmlAction($action);
		
		}
        return $this->_html;
    }
    
    protected function _getHtmlAction($type)
    {
    	"<div class=\"action {$type}\"></div>";
    }
}