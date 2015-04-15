<?php

class My_Controller_Sabios extends Zend_Controller_Action {

    protected $_user_id;
    
    public function init() {

        $this->_auth = Zend_Auth::getInstance();
        $this->view->user = isset($this->_auth->getIdentity()->nombre) ? $this->_auth->getIdentity()->nombre :false;
        $this->_user_id = isset($this->_auth->getIdentity()->id) ? $this->_auth->getIdentity()->id : false;
        $this->view->isLogged = isset($this->_auth->getIdentity()->id) ? true : false;
        $this->view->messages = $this->_helper->flashMessenger->setNamespace('success')->getMessages();
        $this->view->errormessages = $this->_helper->flashMessenger->setNamespace('error')->getMessages();        
    }


    protected function saveAuditoria($id, $dataNew = array(), $dataOld = array()) {
        $audit = new Auditoria();
        $audit->app_id = APPLICATION_ID;
        $audit->id_usuario = $this->_user_id;
        $audit->entidad = $this->_request->getControllerName();
        $audit->id_entidad = $id;
        $audit->operacion = $this->_request->getActionName();
        $fecha = new Zend_Date();
        $audit->fecha = $fecha->get('yyyy-MM-dd HH:mm:ss');
        $audit->data_new = json_encode($dataNew);
        $audit->data_old = json_encode($dataOld);
        $audit->save();
    }

}

?>
