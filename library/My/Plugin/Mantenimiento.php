<?php
class My_Plugin_Mantenimiento extends Zend_Controller_Plugin_Abstract
{
    protected $_estado;
    protected $_redirector;

    protected function init()
    {
    	$configuration = Doctrine_Core::getTable('SiteConfiguration')->find("1");	
    	$this->_estado= $configuration->estado;
    	$this->_redirector = Zend_Controller_Action_HelperBroker::getStaticHelper('redirector');
    	

    }
    public function __construct()
    {
		$this->init();

    }

    public function preDispatch(Zend_Controller_Request_Abstract $request)
    {
    	
    	if (
    			$this->_estado <> "ONLINE" 				&& 
    			$request->action <> 'offline' 			&& 
    			$request->controller <> 'mantenimiento' //&& 
    			//$request->controller <> 'admin'
    		)
    	{
    		$this->_redirector->gotoUrl("/mantenimiento/offline");
    	}


    }
    

}