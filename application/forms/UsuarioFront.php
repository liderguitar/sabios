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
class Form_UsuarioFront extends Zend_Form
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
        $this->setAction("/usuario/register");

        
        $postId = new Zend_Form_Element_Hidden('postId');
        $postId->setDecorators(array('ViewHelper'));
        $this->addElement($postId); 

        
    	$nick = new Zend_Form_Element_Text('nick');
        
        $nick->setLabel('Nombre Usuario:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$nick->class = 'rounded-input span-6';

		$this->addElement($nick);
		$this->_addDecorators('nick', 'fusasLabel'); 
		   	

    	$nombre = new Zend_Form_Element_Text('nombre');    	
        $nombre->setLabel('Nombre:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$nombre->class = 'rounded-input span-6';

		$this->addElement($nombre);
		$this->_addDecorators('nombre', 'fusasLabel');
		
    	$apellido = new Zend_Form_Element_Text('apellido');
        
        $apellido->setLabel('Apellido:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$apellido->class = 'rounded-input span-6';

		$this->addElement($apellido);
		$this->_addDecorators('apellido', 'fusasLabel');	
			
    	$password = new Zend_Form_Element_Password('clave');
        
        $password->setLabel('Password:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$password->class = 'rounded-input span-6';

		$this->addElement($password);
		$this->_addDecorators('clave', 'fusasLabel');	

    	$repitePassword = new Zend_Form_Element_Password('repitePassword');
		$repitePassword->setLabel('Repite Password:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$repitePassword->class = 'rounded-input span-6';

		$this->addElement($repitePassword);
		$this->_addDecorators('repitePassword', 'fusasLabel');		
		
    	$email = new Zend_Form_Element_Text('email');
        
        $email->setLabel('Email:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$email->class = 'rounded-input span-6';

		$this->addElement($email);
		$this->_addDecorators('email', 'fusasLabel');		

        $submit = new Zend_Form_Element_Submit('Registrar');
        $submit->setLabel("Enviar");
        $submit->setDecorators(array('ViewHelper'))->Class = "rounded-input register-button";
        $this->addElement($submit);
        
		
    }
    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    	
    }   
}
