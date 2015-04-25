<?php
/**
 * AdminController
 * 
 * @author
 * @version 
 */

class AdminController extends Zend_Controller_Action
{
    /**
     * The default action - show the home page
     */
	
	protected $_redirector;
	protected $_usuario;
	protected $_error;
	protected $_baseClass;
	protected $_siteConfiguration;
	
    public function init()
    {
    	// vesion 3
        $this->_redirector = $this->_helper->getHelper('Redirector');
        $this->_usuario = Zend_Auth::getInstance()->getIdentity();
        $this->_siteConfiguration = Doctrine_Core::getTable('SiteConfiguration')->find("1");	
        
        //$result = Doctrine_Core::getTable("SiteConfiguration")->find(1);
        //$this->_baseClass = $result->baseClass;
        //die($result->baseClass);
        
        
    }
    public function addAction ()
    {

    	$this->view->actions = array("cancel", "save", "add", "list" );
    	$objectName = ucwords($this->_request->getParam('object'));
    	$this->view->className = strtolower($objectName);
    	$this->view->messages = $this->_helper->flashMessenger->getMessages();
    	$this->_helper->flashMessenger->clearCurrentMessages();
    	$this->view->form = My_Factory_Form::get($objectName, array('Usuario' => $this->_usuario));
    	if($this->_request->isPost()) {
    		if($this->view->form->isValid($this->_request->getPost())) {
    			$class = My_Factory_Model::get($objectName);

    			$result = $this->save($this->_request->getPost(), $class);
    			if($result) {
    				$this->_helper->flashMessenger->addMessage($objectName . ' grabado correctamente');
    			}
    			else { 
    				$this->_helper->flashMessenger->addMessage( $objectName . ' no grabado. Error: ' . $this->error);
                    $this->clearErrorMessage();
    			}
    			
   			
    			$this->_redirector->gotoRoute(
    											array(
    													'controller' 	=> 	'admin',
    													'action' 	 	=> 	'list', 
    													'object'     	=> 	strtolower($objectName),
    											        'page'          =>  $page
    												)
    											);
    			
    		} else {
    			//Zend_Debug::dump($this->view->form->getValidValues($this->_request->getPost()));die;
    			//Zend_Debug::dump($this->view->form->getErrors());die;
    		}
    	}
    }
    
    public function listAction()
    {

    	$this->view->actions = array( "add" );
    	
    	$data = false;
    	$objectName = ucwords($this->_request->getParam('object'));
    	$this->view->className = strtolower($objectName);
        $this->view->messages = $this->_helper->flashMessenger->getMessages();
        $this->_helper->flashMessenger->clearCurrentMessages();	
    	$objectName = ucwords($this->_request->getParam('object'));
    	$this->view->filterForm = My_Factory_Form::get($objectName . "Filter");
    	
		$this->view->page = $this->_request->getParam('page'); 
    	$objectName = ucwords($this->_request->getParam('object'));
     	$this->view->object = strtolower($objectName);
    	
    	if($this->_request->isPost()) {
    		
    		$data = $this->_request->getPost();
    		$this->view->filterForm->populate($data);
    	}    	
    	
    	$class = My_Factory_Model::get($objectName);   

		$adapter = new My_Paginator($class->getAllQuery($data));
		$paginator =  new Zend_Paginator($adapter);  
		$paginator->setItemCountPerPage(15);	
		$paginator->setCurrentPageNumber($this->view->page);

		$this->view->objects = $paginator;

		

    }
    
    private function save($data, $object)
    {

    	$post = new Post();
        $post->usuarioId = Zend_Auth::getInstance()->getIdentity()->id;
        $date = Zend_Date::now();
        $post->fechaCreacion = $date->toString("yyyy-MM-dd HH:mm:ss");
        $post->borrado = "N";
        $post->save();
        $data['post'] = $post;

        $object->fill($data);
        
        try {
        	$object->save();
        	
        }
        catch (Exception $e)
        {
        	die($e->getMessage());
           	$this->setErrorMessage($e->getMessage());
        	return false;        	
        }
        return true;
    }
    
    public function editAction()
    {
    	$this->view->actions = array("cancel", "save", "add", "list" );

       $objectName = ucwords($this->_request->getParam('object'));
       $id = ucwords($this->_request->getParam('id'));
       
       $this->view->className = strtolower($objectName);
       $this->view->messages = $this->_helper->flashMessenger->getMessages();

	   $this->view->page =  $this->_request->getParam('page');
	    
       $this->_helper->flashMessenger->clearCurrentMessages();
       $this->view->form = My_Factory_Form::get($objectName, array('Usuario' => $this->_usuario));
       $object = My_Factory_Model::get($objectName);
       $obj = $object->_getById($id);
       //Zend_Debug::dump($obj->toArray());die;
       
 
       
       
       if($obj->Post->blockUsuarioId != null && $obj->Post->blockUsuarioId <> $this->_usuario->id) {
            $this->_helper->flashMessenger->addMessage($objectName .' blockeado por otro Usuario');
            $this->_redirector->gotoRoute(array('controller' => 'admin' , 'action' => 'list' , 'object' => strtolower($objectName)));
       		
       }
      // Zend_Debug::dump($obj->Post);die;	
       $obj->block($this->_usuario);

       $post = $obj->Post;

	   $post->Usuario = $this->_usuario;
	   $post->save();

       $this->view->form->populate($obj->toArray());

       if($this->_request->isPost()) {
           if($this->view->form->isValid($this->_request->getPost())) {
               $class = My_Factory_Model::get($objectName);
               $result = $this->update($this->_request->getPost(), $obj);
               if($result) {
                   $this->_helper->flashMessenger->addMessage($objectName . ' grabado correctamente');
               }
               else {
                   $this->_helper->flashMessenger->addMessage( $objectName . ' no grabado. Error: ' . $this->error);
                   $this->clearErrorMessage();
               }
               $this->_redirector->gotoRoute(array('controller' => 'admin' , 'action' => 'list' , 'object' => strtolower($objectName)));
               
           }
           else {
    		//	Zend_Debug::dump($this->view->form->getErrors());die;
           	           }
       }
    }
    
	protected function update($data, $object)
    {
            
    	$object->fill($data);
    	try {
           $object->save();
       	}
       	catch (Exception $e)
       	{
           $this->setErrorMessage($e->getMessage());
           return false;
       	}
       	return true;
    }
    public function cancelAction()
    {
		$objectName = ucwords($this->_request->getParam('object'));
    	$this->view->className = strtolower($objectName);
    	$object = My_Factory_Model::get(strtolower($objectName));
    	$this->view->object = strtolower($objectName);
       	$id = ucwords($this->_request->getParam('id'));
       	
		$session = new Zend_Session_Namespace('page'); 
		$this->view->page = $this->_request->getParam('page');    	
       	if (!$id) {
       		$this->_helper->redirector->gotoUrl("/admin/{$this->view->object}/list/" . $this->view->page);
       	}
       	
    	
       	$obj = $object->_getById($id);
       	if(!$obj->cancel())
	    	$this->_helper->flashMessenger->addMessage('Algun Problema ha surgido.');
       	
    	$this->_helper->redirector->gotoUrl("/admin/{$this->view->object}/list/" . $this->view->page);
    	
    }    
    
    protected function clearErrorMessage()
    {
    	$this->_error = null;
    }
    protected function setErrorMessage($message)
    {
    	$this->_error = $message;
    }
    function generateCaptcha() {
        $captcha = new Zend_Captcha_Image();

        $captcha->setTimeout('300')
        ->setWordLen('6')
        ->setHeight('80')
        ->setFont( APPLICATION_PATH . '/fonts')
        ->setImgDir( PUBLIC_FOLDER . '/captcha');

        $captcha->generate();    //command to generate session + create image

        return $captcha->getId();   //returns the ID given to session &amp; image
    }  
    function validateCaptcha($captcha) {
        $captchaId = $captcha['id'];
        $captchaInput = $captcha['input'];

        $captchaSession = new Zend_Session_Namespace('Zend_Form_Captcha_' . $captchaId);
        $captchaIterator = $captchaSession->getIterator();
        $captchaWord = $captchaIterator['word'];

        if( $captchaWord ) {
            if( $captchaInput != $captchaWord ){
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }

    }    
}
