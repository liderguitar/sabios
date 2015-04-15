<?php

class FormadepagoController extends My_Controller_Sabios {

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    public function indexAction() {

        $this->view->fdps = Doctrine_Query::create()
                ->from("PagoTipo")
                ->where('app_id="' . APPLICATION_ID . '" and borrado="N"')
                ->execute();
    }

    public function addAction() {
        $nombre = $this->_request->getParam('nombre');
        $porcentaje = $this->_request->getParam('porcentaje', 0.0);

        $exists = Doctrine_Query::create()
                        ->from("PagoTipo")
                        ->where('app_id="' . APPLICATION_ID . '" and descripcion="' . $nombre . '" and borrado="N"')
                        ->execute()->count();

        if ($exists) {
            //die("ya existe!");
            $this->_helper->flashMessenger->addMessage("Ya existe");

            return $this->_redirect("/formadepago");
        }

        $fdp = New PagoTipo();
        $fdp->descripcion = $nombre;
        $fdp->interes = $porcentaje;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/formadepago");
    }

    public function editAction() {

        $nombre = $this->_request->getParam('nombre');
        $porcentaje = $this->_request->getParam('porcentaje', 0);
        $id = $this->_request->getParam('id');
        if (!$id) {
            $this->_helper->flashMessenger->setNamespace('error')->addMessage("Ha ocurrido un error. Registro no encontrado!");
            return $this->_redirect("/formadepago");
        }        
        
        
        $fdp = Doctrine_Query::create()
                ->from("PagoTipo")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        //die("sdfsdf");
        // dump($fdp);
        if (!is_object($fdp)) {

            $this->_helper->flashMessenger->setNamespace('error')->addMessage("Ha ocurrido un error. Registro no encontrado!");
            return $this->_redirect("/formadepago");
        }

        $fdp->descripcion = $nombre;
        $fdp->interes = $porcentaje;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/formadepago");
    }

    public function deleteAction() {

        $id = $this->_request->getParam('id');
        $fdp = Doctrine_Query::create()
                ->from("PagoTipo")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();
        if (!is_object($fdp)) {

            $this->_helper->flashMessenger->setNamespace('error')->addMessage("Ha ocurrido un error. Registro no encontrado!");
            return $this->_redirect("/formadepago");
        }
        $fdp->borrado = 'Y';
        $fdp->save();
        return $this->_redirect("/formadepago");
    }

}

