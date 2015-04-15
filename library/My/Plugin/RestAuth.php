<?php
class My_Plugin_RestAuth extends Zend_Controller_Plugin_Abstract
{
    public function preDispatch(Zend_Controller_Request_Abstract $request)
    {
        
        
        if ($this->_request->getControllerName() !== 'index')
        {
            $this->config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/application.ini', 'production');

            $this->getResponse()
                    ->setHeader('Access-Control-Allow-Headers', 'Content-Type');

            $apiKey = $this->_request->getHeader('apikey');

            if ($apiKey !== APPLICATION_ID) {

                $this->getResponse()
                        ->appendBody(json_encode('Invalid api:'.$apiKey))
                        ->sendResponse();
                        die;
                // ->setHttpResponseCode(403);

                $request->setModuleName('default')
                        ->setControllerName('error')
                        ->setActionName('error')
                        ->setDispatched(true);
            } else {
                $this->getResponse()->setHttpResponseCode(200);
            }
        }
    }

}
?>