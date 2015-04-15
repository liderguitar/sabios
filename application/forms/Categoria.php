<?php

class Form_Categoria extends Zend_Form
{
    public function init()
    {
    	$this->setMethod('post');
        
        $id = new Zend_Form_Element_Hidden('id');
        $this->addElement($id);
        
        $nombre = new Zend_Form_Element_Text('nombre');
        
        $nombre->setLabel('Nombre:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addValidator(new Zend_Validate_StringLength(6, 75), true)
             ->setRequired(true);
		$nombre->class = 'rounded-input span-10';
			
		$this->addElement($nombre);
		$this->_addDecorators('nombre', 'fusasLabel');

		$comentarios = new Zend_Form_Element_Select('comentarios');
		$comentarios->setLabel('Comentarios:');
		
        $comentarios->addMultiOption('Y', 'SI');
        $comentarios->addMultiOption('N', 'NO');

        $comentarios->class="rounded-select";
        $this->addElement($comentarios);
        $this->_addDecorators('comentarios', 'fusasLabel');

        $submit = new Zend_Form_Element_Submit('Agregar');
        $submit->class="form-submit";
        $this->addElement($submit);
    	
    }
    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->addDecorators(array(
                'ViewHelper',
        		'Errors',
        		array('HtmlTag', array('tag' => 'dd', 'class' => "prepend-2 " . $class)),
        		array('Label', array('tag' => 'dt', 'class' => $labelClass)),
        ));;
    	    	
    }    
}