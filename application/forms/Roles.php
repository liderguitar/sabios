<?php
class Form_Roles extends Zend_Form
{
   
    public function __construct($params=null)
    {
        parent::__construct();
        
        $this->setMethod('post');
        $str = new Zend_Validate_StringLength(4, 50);
        $str->setMessage('El campo debe tener entre 4 y 50 caracteres.',Zend_Validate_StringLength::TOO_SHORT);
        $role = new Zend_Form_Element_Text('role');
        $role->setLabel('New Role:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addFilter(new Zend_Filter_StringToLower())
             ->addValidator($str, true)
             ->setRequired(true);
		
        //$db = Zend_Db_Table_Abstract::getDefaultAdapter();
    	
    	
		$arr = array();    	
		$addedRoles = new Zend_Form_Element_Multiselect('addedroles');
		$addedRoles	->setAttrib('class', 'select-multi')
					->addValidator('NotEmpty', true);
    	foreach ($params as $item){
    		$addedRoles->addMultiOption($item['rol_id'], $item['name']);
    	}
    	
	
					 
        $submit = new Zend_Form_Element_Submit('submit');
        $submit->setLabel('Add');
        
        $this->addElement($role);//, $addedRoles, $submit ));
        $this->addElement($addedRoles);
        $this->addElement($submit);
        
    }
    
}