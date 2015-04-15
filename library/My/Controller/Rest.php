<?php

class My_Controller_Rest extends Zend_Controller_Action {

    protected $_auth;
    protected $_success = false;
    protected $_message = '';
    protected $_responseCode = 200;
    protected $_data = array();

    public function init() {
        parent::init();

        $this->_auth = Zend_Auth::getInstance();
        $this->view->user = $this->_auth->getIdentity()->nombre;
        
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
