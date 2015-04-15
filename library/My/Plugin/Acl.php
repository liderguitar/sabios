<?php

class My_Plugin_Acl extends Zend_Controller_Plugin_Abstract {

    protected $_acl = null;

    protected function init() {
        $this->_acl = new Zend_Acl();
        $this->addRoles();
        $this->addResources();
        $this->addPrivileges();
    }

    public function __construct() {
        $this->init();
    }

    public function preDispatch(Zend_Controller_Request_Abstract $request) {
        $message = false;
        $action = $request->getActionName();
        $resource = $request->getControllerName();
        $privilegio = $request->getActionName();

        
        if ($action == "error" && $resource == "error")
            return;

        $auth = Zend_Auth::getInstance();
        if ($auth->hasIdentity()) {
            $perfil = $auth->getIdentity()->perfil;
        } else {
            $perfil = "GUEST";
        }

        if (!$this->_acl->has($resource)) {
            $message = "Recurso: " . $resource . " no agregado a ACL.";
        }

        if ($this->_acl->has($resource)) {
            if (!$this->_acl->isAllowed($perfil, $resource, $privilegio)) {
                
                $message = "$perfil no tiene acceso a $resource ";
              //  die("######".$message);
                
            }
        }
        if ($message) {
            
           // throw new Exception($message);
            $request = $this->getRequest();
            $request->setControllerName('error')
                    ->setActionName('error')
                    ->setParam('message', $message);
        }
    }

    protected function addRoles() {
        $roles = Doctrine::getTable('Perfil')->createQuery('p')->orderBy("orden desc")->fetchArray();
        foreach ($roles as $rol) {
            if ($rol['parent']) {
                $this->_acl->addRole(new Zend_Acl_Role($rol['nombre']), $rol['parent']);
            } else {
                $this->_acl->addRole(new Zend_Acl_Role($rol['nombre']));
            }
        }
    }

    protected function addResources() {
        $recursos = Doctrine::getTable('Recurso')->createQuery('r')->fetchArray();
        foreach ($recursos as $recurso) {
            $this->_acl->addResource(new Zend_Acl_Resource($recurso['nombre']));
        }
    }

    protected function addPrivileges() {
        $privilegios = Doctrine::getTable('RecursosPorPerfil')->createQuery('r')->fetchArray();
        foreach ($privilegios as $privilegio) {
            $this->_acl->allow($privilegio['perfil'], $privilegio['recurso'], $privilegio['privilegio']);
        }
    }

}