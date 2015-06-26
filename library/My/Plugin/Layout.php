<?php

class My_Plugin_Layout extends Zend_Controller_Plugin_Abstract {

    protected $_estado;
    protected $_redirector;

    protected function init() {
        $configuration = Doctrine_Core::getTable('SiteConfiguration')->find("1");
        $this->_estado = $configuration->estado;
        $this->_redirector = Zend_Controller_Action_HelperBroker::getStaticHelper('redirector');
    }

    public function __construct() {
        $this->init();
    }

    public function preDispatch(Zend_Controller_Request_Abstract $request) {
        $auth = Zend_Auth::getInstance();
        $resource = $request->getControllerName();
        $privilegio = $request->getActionName();
       //d ie();
        if($resource == 'home') {
                Zend_Layout::startMvc(array(
                'layoutPath' => APPLICATION_PATH .
                DIRECTORY_SEPARATOR . "layouts" .
                DIRECTORY_SEPARATOR . "scripts",
                'layout' => 'layout'
                    )
            );
                return;
        }

        if($resource == 'usuario' ) {
            Zend_Layout::startMvc(array(
                    'layoutPath' => APPLICATION_PATH .
                        DIRECTORY_SEPARATOR . "layouts" .
                        DIRECTORY_SEPARATOR . "scripts",
                    'layout' => 'layout2'
                )
            );
            return;
        }


        if (!$auth->hasIdentity()) {

            Zend_Layout::startMvc(array(
                'layoutPath' => APPLICATION_PATH .
                DIRECTORY_SEPARATOR . "layouts" .
                DIRECTORY_SEPARATOR . "scripts",
                'layout' => 'catalogo'
                    )
            );
        } else {

            $layout = ($resource == 'catalogo' || $resource == 'error') ? 'catalogo' : 'frontpage';
            if ($resource == 'error') {
                $layout = 'error';
            }
            Zend_Layout::startMvc(array(
                'layoutPath' => APPLICATION_PATH .
                DIRECTORY_SEPARATOR . "layouts" .
                DIRECTORY_SEPARATOR . "scripts",
                'layout' => $layout
                    )
            );
        }
    }

}