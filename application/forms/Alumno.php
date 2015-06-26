<?php
class Form_Alumno extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        
        $id = new Zend_Form_Element_Hidden('id',array('disableLoadDefaultDecorators' => true));
        $this->addElement($id);
        $id->removeDecorator("dt");
        $id->removeDecorator("dd");
        
        $nombre = new Zend_Form_Element_Text('nombre');
        
        $nombre->setLabel('Nombre:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addValidator(new Zend_Validate_StringLength(2, 200), true)
             ->setRequired(true);
		$nombre->class = 'rounded-input span-10';
			
		$this->addElement($nombre);
		$this->_addDecorators('nombre', 'fusasLabel');

        $apellido = new Zend_Form_Element_Text('apellido');
        
        $apellido->setLabel('Apellido:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addValidator(new Zend_Validate_StringLength(2, 200), true)
             ->setRequired(true);
		$apellido->class = 'rounded-input span-10';
			
		$this->addElement($apellido);
		$this->_addDecorators('apellido', 'fusasLabel');
		
		$fechaNacimiento = new Zend_Form_Element_Text('fechaNacimiento');
		
        $fechaNacimiento->setLabel('Fecha Nacimiento:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('readonly', 'readonly');
		$fechaNacimiento->class = 'rounded-input span-3';	
		$this->addElement($fechaNacimiento);
		$this->_addDecorators('fechaNacimiento', 'fusasLabel');		

		$sexo = new Zend_Form_Element_Select('sexo');
		
		$sexo->setLabel('Sexo:');

        $sexo->addMultiOption("M", "Masculino");
		$sexo->addMultiOption("F", "Femenino");        

        $sexo->class="rounded-select";
        $this->addElement($sexo);
        $this->_addDecorators('sexo', 'fusasLabel');
		
        $submit = new Zend_Form_Element_Submit('Agregar');
        $submit->class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only";
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
    public function populate($values)
    {
    	//die("sisi");
    }
    
 }