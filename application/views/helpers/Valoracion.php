<?php
class Zend_View_Helper_Valoracion extends Zend_View_Helper_Abstract
{

    public function valoracion($libro)
    {
    	if (is_null($libro->valoracion))
    		return "";
	      return '<img src="' . PUBLIC_FOLDER . '/images/valoracion_' . $libro->valoracion  . '.png" />';
    }
    
}