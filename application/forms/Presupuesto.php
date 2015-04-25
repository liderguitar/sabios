<?php

/*
 * nombre
 * apellido
 * direccion
 * localidad
 * codigo postal
 * provincia
 * telefono
 * horario de consulta
 * email
 * consulta
 * 
 * 
 */
class Form_Presupuesto extends Zend_Form
{
	protected $_roles;
    
    
    public function init()
    {

        
    	$this->setMethod("POST");
    	$this->setAction("/index/contacto");
    	$nombre = new Zend_Form_Element_Text('nombre');    	
        $nombre->setLabel('Nombre:')
             ->addFilter(new Zend_Filter_StringTrim());
		$nombre->class = 'rounded-input span-8';

		$this->addElement($nombre);
		$this->_addDecorators('nombre', 'fusasLabel');
		
    	$apellido = new Zend_Form_Element_Text('apellido');
        
        $apellido->setLabel('Apellido:')
             ->addFilter(new Zend_Filter_StringTrim());
		$apellido->class = 'rounded-input span-8';
		$this->addElement($apellido);
		$this->_addDecorators('apellido', 'fusasLabel');	
		
		
		$direccion = new Zend_Form_Element_Text('direccion');
		$direccion->setLabel('Direccion:')
             ->addFilter(new Zend_Filter_StringTrim());
        $direccion->class = 'rounded-input span-8';
		$this->addElement($direccion);
		$this->_addDecorators('direccion', 'fusasLabel');	

		$localidad = new Zend_Form_Element_Text('localidad');
        $localidad->setLabel('Localidad:')
             ->addFilter(new Zend_Filter_StringTrim());
		$localidad->class = 'rounded-input span-8';

		$this->addElement($localidad);
		$this->_addDecorators('localidad', 'fusasLabel');	

		$codigoPostal = new Zend_Form_Element_Text('codigoPostal');
        $codigoPostal->setLabel('Codigo Postal:')
             ->addFilter(new Zend_Filter_StringTrim());
		$codigoPostal->class = 'rounded-input span-8';

		$this->addElement($codigoPostal);
		$this->_addDecorators('codigoPostal', 'fusasLabel');			
		
		$provincia = new Zend_Form_Element_Text('provincia');
        $provincia->setLabel('Provincia:')
             ->addFilter(new Zend_Filter_StringTrim());
		$provincia->class = 'rounded-input span-8';

		$this->addElement($provincia);
		$this->_addDecorators('provincia', 'fusasLabel');

		$telefono = new Zend_Form_Element_Text('telefono');
        $telefono->setLabel('Telefono:')
             ->addFilter(new Zend_Filter_StringTrim());
		$telefono->class = 'rounded-input span-8';

		$this->addElement($telefono);
		$this->_addDecorators('telefono', 'fusasLabel');		
		
    	$email = new Zend_Form_Element_Text('email');
        
        $email->setLabel('*Email:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$email->class = 'rounded-input span-8';

		$this->addElement($email);
		$this->_addDecorators('email', 'fusasLabel');		

		$consulta = new Zend_Form_Element_Textarea('consulta');
		$consulta->setLabel('*Consulta:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('rows', 3)
             ->setAttrib('cols', 43);
             
		$consulta->class = "rounded-input consulta";
		$this->addElement($consulta);
		
		$this->_addDecorators('consulta', 'fusasLabel');	

        $captcha = new Zend_Form_Element_Text('captcha');    	
        $captcha->setLabel('C&oacute;digo de Seguridad:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
	$captcha->class = 'rounded-input span-2';
	$this->addElement($captcha);
	$this->_addDecorators('captcha', 'fusasLabel');        
                
        $submit = new Zend_Form_Element_Submit('agregar');
        $submit->setDecorators(array('ViewHelper'))->Class = "rounded-input";
        $submit->setLabel("Enviar");
        $submit->Class = "rounded-input contacto-input";
        $this->addElement($submit);
        
        $captchaId = new Zend_Form_Element_Hidden('captchaId');
        $this->addElement($captchaId);
        
		
    }
    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    	
    }  
 public function isValid($data) 
    { 
        $isValid = parent::isValid($data); 
        
        
        $validCaptcha = false;
        $captchaId = $data['captchaId'];
        $captchaInput = $data['captcha'];

        $captchaSession = new Zend_Session_Namespace('Zend_Form_Captcha_' . $captchaId);
        $captchaIterator = $captchaSession->getIterator();
        $captchaWord = $captchaIterator['word'];

        if( $captchaWord ) {
            if( $captchaInput != $captchaWord ){
                $validCaptcha = false;
            } else {
                $validCaptcha = true;
            }
        } else {
            $validCaptcha = false;
        }        
               
              
        return $isValid && $validCaptcha; 
    }     
}
