<?php
    class My_Login_AuthAdapterDoctrine implements Zend_Auth_Adapter_Interface  
    {  
      
        /** 
         * @var Doctrine_Table 
         */  
        private $_table;  
      
        /** 
         * The field name which will be the identifier (username...) 
         * 
         * @var string 
         */  
        private $_identityCol;  
      
        /** 
         * The field name which will be used for credentials (password...) 
         * 
         * @var string 
         */  
        private $_credentialCol;  
      
        /** 
         * Actual identity value (my_all_known_username) 
         * 
         * @var string 
         */  
        private $_identity;  
      
        /** 
         * Actual credential value (my_secret_password) 
         * 
         * @var string 
         */  
        private $_credential;  
        
      
        public function  __construct($data)  
        {  
        	$this->_identity = $data['nick'];
        	$this->_credential = md5($data['password']);
        	$this->_identityCol = "email";
        	$this->_credentialCol = "password";

        }  
      
        /** 
         * @param string $i 
         */  
        public function setIdentity($i)  
        {  
            $this->_identity = $i;  
        }  
      
        /** 
         * @param string $c 
         */  
        public function setCredential($c)  
        {  
            $this->_credential = $c;  
        }  
      
        /** 
         * @return Zend_Auth_Result 
         */  
        public function authenticate()  
        {  
      	
        	$result = Doctrine_Query::create()
                ->select('u.*')
                ->from("Usuario u")
                ->where("{$this->_credentialCol} = '" . $this->_credential . "'")  
                ->andWhere("{$this->_identityCol} = '" . $this->_identity ."'")
                ->andWhere("blockeado = 'N'")
                ->andWhere("app_id='".APPLICATION_ID."'")
                ->execute();  
                return new Zend_Auth_Result(  
                $result[0]->id ? Zend_Auth_Result::SUCCESS : Zend_Auth_Result::FAILURE,   
                $result[0]->id ? $result[0] : null  
            ); 
        }  
    }  