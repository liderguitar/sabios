<?php
class Zend_View_Helper_MenuGenero extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function menuGenero($cantidad = 9999)
    {
    	$generos = Genero::getLibrosPorGenero();
        //var_dump($generos);die;
    	$this->_html = '<div class="menu-genero"><div style="float: left; width: 160px;"><ul>';
        
        $list = array();
    	$count = 1;
    	$categoriesCount = floor (count($generos)/2);
        //die($categoriesCount."dfdff");

        foreach ($generos as $genero) {
    
                $index = $count < ( $categoriesCount) ? 0 : 1;
	    	$list[$index][] .= '<li><a href="/search/genero/'. $genero['id'] .'">'
	    	. utf8_encode($genero['nombre']) . ' (' . $genero['cantidad'] . ')' .
	        '</a></li>';     	
	    	
	    	if ($cantidad == $count)
	    		break;
	    		
	    	$count++;
        }
      // var_dump($list);die;
        foreach ($list[0] as $value) {
             $this->_html .= $value;
        }
        $this->_html .= '</ul></div><ul>';
         foreach ($list[1] as $value) {
             $this->_html .= $value;
        }
        $this->_html .= '</ul></div></div>';
        
        
        //var_dump($this->_html);die;
        return  $this->_html;
    }
    
}