<?php
class Zend_View_Helper_ShareFacebook extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function shareFacebook($libro)
    {
   		$facebookChain = "http://www.facebook.com/sharer.php?s=100&p[title]=%s&p[url]=%s&p[summary]=%s&p[images][0]=%s";
    	return sprintf($facebookChain, 
    								 utf8_encode($libro->titulo),
    								"http://mejorunlibro.com/libro/" . $libro->urlCode,
    								utf8_encode(My_Function_Function::word_trim($libro->descripcion, 50, true)),
    								"http://mejorunlibro.com/" . PUBLIC_FOLDER . "/files/" . $libro->foto
    				
    	);

    }
    
}