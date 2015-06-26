<?php
class Zend_View_Helper_Botonera extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function botonera($options)
    {
    	$this->_html = '<div id="botonera" class="botonera rounded-main">';
		foreach ($options['actions'] as $action) {
			
				$this->_html .= $this->_getHtmlAction($action, $options['object']);
		
		}
        return $this->_html . "</div>";
    }
    
    protected function _getHtmlAction($type, $object)
    {
    	return '<a class="action-button ' . $type . '" title="' . ucwords($type) . '" href="/admin/'.$object.'/'.$type.'"></a>';
    }
}