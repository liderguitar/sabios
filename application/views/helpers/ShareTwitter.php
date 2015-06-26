<?php
class Zend_View_Helper_ShareTwitter extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function shareTwitter($libro)
    {
    	
   		$twitterChain = "http://twitter.com/home?status=%s+%s";
    	return sprintf($twitterChain, 
    								$libro->titulo,
    								"http://mejorunlibro.com/libro/" . $libro->urlCode
    				
    	);

    }
    
}