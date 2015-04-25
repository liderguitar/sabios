<?php

/*
 * nombre
 * apellido
 * nick
 * password
 * email
 * perfil
 * 
 * 
 */
class Form_Resetpassword extends Zend_Form
{
	protected $_roles;
    
    public function __construct($options)
    {
    	// usuario para dar solo permisos que pueda

    	
  		if($options['Usuario']) {
  			$usuario = $options['Usuario'];
    		$this->_roles = $usuario->getUserRoles();
  		}
    			
  		parent::__construct($options);    	
    }
    
    public function init()
    {
        $id = new Zend_Form_Element_Hidden('id');
        $id->setDecorators(array('ViewHelper'));
        $this->addElement($id);
        $this->setAction("/index/reset");
	
        $nick = new Zend_Form_Element_Text('nick');
        $nick->setLabel('Nick:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addFilter(new Zend_Filter_StringToLower())
             ->addValidator(new Zend_Validate_StringLength(6, 75), true)
             ->setRequired(true)
             ->setAttrib('readonly', "readonly");
             
		$nick->class = 'rounded-input span-4';
        $this->addElement($nick);
		$this->_addDecorators('nick', 'fusasLabel');
        
    	$password = new Zend_Form_Element_Password('clave');
        
        $password->setLabel('Password:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)->setLabel('Nueva Clave:');
		$password->class = 'rounded-input span-4';

		$this->addElement($password);
		$this->_addDecorators('clave', 'fusasLabel');	

    	$repitePassword = new Zend_Form_Element_Password('repitePassword');
		$repitePassword->setLabel('Repite Password:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)->setLabel('Repetir Clave:');;
		$repitePassword->class = 'rounded-input span-4';

		$this->addElement($repitePassword);
		$this->_addDecorators('repitePassword', 'fusasLabel');		
		
 
        $submit = new Zend_Form_Element_Submit('Registrar');
        $submit->setLabel("Cambiar");
        $submit->setDecorators(array('ViewHelper'))->Class = "rounded-input pass-button";
        $this->addElement($submit);
        
		
    }
    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    	
    }   
}
