<?php
class Zend_View_Helper_AutorLink extends Zend_View_Helper_Abstract
{

    public function autorLink($libro)
    {

	      return '<a target="_blank" href="http://es.wikipedia.org/wiki/' . My_Function_Function::autorUrl($libro->Autor->nombre)  . '">' . utf8_encode($libro->Autor->nombre) . '</a>' ;
    }
    
}