<?php
class Form_Login extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        $this->setAction("/usuario/login?type=local");
        $nick = new Zend_Form_Element_Text('nick');
        $nick->setLabel('Nick:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addFilter(new Zend_Filter_StringToLower())
             ->addValidator(new Zend_Validate_StringLength(6, 75), true)
             ->setRequired(true);
		$nick->class = 'rounded-input span-5';
        $this->addElement($nick);
		$this->_addDecorators('nick', 'fusasLabel');
		
        $password = new Zend_Form_Element_Password('password');
        $password->setlabel('Password:');
		$password->class = 'rounded-input span-5';
        $this->addElement($password);
		
		$this->_addDecorators('password', 'fusasLabel');
		
//                 ->addValidator(new My_Validate_NoAdmin());
        
            //->setRequired(true);

        $submit = new Zend_Form_Element_Submit('submit');
        $submit->setLabel('Entrar');
		$this->addElement( $submit);        
        $submit->setDecorators(array('ViewHelper'))->Class = "rounded-input login-input";
        
        
    }
    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    	
    } 
}