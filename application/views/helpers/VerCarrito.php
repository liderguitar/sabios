<?php
class Zend_View_Helper_VerCarrito extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function verCarrito()
    {
   	
    	$this->_html = '
    	<input title="Ver el Carrito" type="button" class="boton-comprar" onclick="window.open(\'https://argentina.dineromail.com/Carrito/cart.asp?' . 
    	'Comercio=2672506&amp;image_url=http://mejorunlibro.com/public/images/logo_mul_chico.png' . 
    	'\',\'Carrito\',\'width=600,height=320,toolbar=no,location=status=menubar=no,resizable=yes,scrollbars=yes,directories=no\');">';

        return $this->_html;
    }
    
}