<?php
class Zend_View_Helper_AgregarCarrito extends Zend_View_Helper_Abstract
{
	protected $_html;
	
    public function agregarCarrito(Libro $libro)
    {
    	//acontent
    	//NombreItem
    	//TipoMoneda
    	//PrecioItem (PUNTO PARA DECIMAL)
    	//NroItem (ID DEL LIBRO)
    	//image_url
    	//DireccionExito
    	//DireccionFracaso
    	//DireccionEnvio
    	//Mensaje
    	//Comercio
    	
    	if ($libro->mostrarPrecio == "Y") {
    	
	    	$this->_html = '
	    	<div title="Agregar al Carrito" class="carrito" onclick="window.open(\'https://argentina.dineromail.com/Carrito/cart.asp?NombreItem=' . utf8_encode($libro->titulo) .
	    	'&amp;TipoMoneda=1&amp;PrecioItem=' .  $libro->precio . 
	    	'&amp;NroItem=' . $libro->id .
	    	'&amp;image_url=' . "http://mejorunlibro.com/public/images/logo_mul_chico.png" . 
	    	'&amp;DireccionExito=' . "http://mejorunlibro.com/articulo/compra-exitosa" .
	    	'&amp;DireccionFracaso=' . "http://mejorunlibro.com/articulo/compra-fallida" .
	    	'&amp;DireccionEnvio=' . "1" . 
	    //	'&amp;Mensaje=' . $options['Mensaje'] . 
	    	'&amp;Comercio=2672506' .  
	    	'\',\'Carrito\',\'width=600,height=320,toolbar=no,location=status=menubar=no,resizable=yes,scrollbars=yes,directories=no\');">' .
	    		'AR$' . $libro->precio  . 
	    	'</div>';
    	} else {
    		$this->_html = '<div class="contactar" onclick="pedirPresupuesto(\''.utf8_encode($libro->titulo).'\')">Pedir Presupuesto</div>';
    	}
        return $this->_html;
    }
    
}