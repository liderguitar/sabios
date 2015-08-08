<?php

/**
 * AdminController
 *
 * @author
 * @version
 */
class ConfigController extends My_Controller_Sabios
{

    public function init()
    {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    /**
     * The default action - show the home page
     */

    public function indexAction()
    {

        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];
        $this->view->logo = $app->logo ? "/files/" . $app->logo : '/images/sabbios-logo.png';

        if ($this->_request->isPost()) {

            if (!is_null($this->_request->getParam('fotoname-1', null))) {

                $app->logo = $this->_request->getParam('fotoname-1');
                $this->view->logo = "/files/" . $app->logo;
                @define("APPLICATION_LOGO", $app->logo);

                $app->save();

            }
        }


    }
    public function fondoAction()
    {

        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];
        $this->view->logo = $app->logo ? "/files/" . $app->logo : '/images/sabbios-logo.png';

        if ($this->_request->isPost()) {

            if (!is_null($this->_request->getParam('fotoname-1', null))) {

                $app->logo = $this->_request->getParam('fotoname-1');
                $this->view->logo = "/files/" . $app->logo;
                @define("APPLICATION_LOGO", $app->logo);

                $app->save();

            }
        }
    }
    public function removeAction()
    {

        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];
        $this->view->logo = $app->logo ? $app->logo : 'sabbios-logo.png';
        $app->save();

        $this->_redirect("/config");


    }

}
