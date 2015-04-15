<?php
class My_Adapter_Google implements Zend_Auth_Adapter_Interface
{
    protected $valid = false;
    protected $attributes;
    
    public function __construct()
    {
         $google = new My_Google_Google();
         if(!$google->mode) {
              $google->identity = 'https://www.google.com/accounts/o8/id';
              $google->required = array('namePerson', 'contact/email');
              header('Location: ' . $google->authUrl());
         
         } else { 
            $google->validate();
            $this->identity = $google->identity;
            $this->attributes = $google->getAttributes();
            $this->valid = true;

         }
    }
    public function authenticate()
    {
       if($this->valid) {
            $code = Zend_Auth_Result::SUCCESS;
            $message = array('User '.$this->clearIdentity().' is logged');
	    	$usuario = Usuario::verifyExternalUser('google',  $this->clearIdentity());
            
            return new Zend_Auth_Result($code, array(
                                                     'googleId' => $this->clearIdentity(),
                                                     'email' => $this->attributes['contact/email'])
            , $message);
       } else {
            $code = Zend_Auth_Result::FAILURE;
            $message = array('User is not logged');
            return new Zend_Auth_Result($code, null , $message);        
       }     
    }
    protected function clearIdentity() 
    {
        $params = explode("=", $this->identity);
        return $params[1];
    }
    
    public function isValid()
    {
         return $this->valid;
    }
}   
