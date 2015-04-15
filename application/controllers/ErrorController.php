<?php

class ErrorController extends Zend_Controller_Action
{

    public function errorAction()
    {
        $error = $this->_getParam('error_handler');
        $message = $this->_getParam('message', 'Por Favor intenta mas tarde');
        $this->view->exception =  isset($error->exception) ? $error->exception->getMessage() : $message;
//        $this->_helper->layout()->disableLayout();
//        $this->_helper->viewRenderer->setNoRender(true);
       // $this->getResponse()->setHttpResponseCode(403);
        //$this->getResponse()->outputBody();

        

    }

    public function getLog()
    {
        $bootstrap = $this->getInvokeArg('bootstrap');
        if (!$bootstrap->hasResource('Log')) {
            return false;
        }
        $log = $bootstrap->getResource('Log');
        return $log;
    }


}

