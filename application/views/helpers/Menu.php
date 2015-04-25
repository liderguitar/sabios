<?php
class Zend_View_Helper_Menu extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function menu($items)
    {
    	$this->_html = "";
    	$this->_html .= '
    	<div id="menu" class="menu">
			<ul class="menu-main">'; 
    	    	
		foreach ($items as $item) {
			
				$text = $item['text'];
				$href = $item['href'];
				$selected = $item['selected'] ? 'selected' : '';
			
				$this->_html .= '<li class="' . $selected . '"><a href="' . $href . '">' . $text . '</a></li>';
		
		}
		$this->_html .= '			</ul>
		</div>';
		
		
        return $this->_html;
    }
        
}