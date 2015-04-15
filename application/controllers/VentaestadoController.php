<?php

class VentaestadoController extends My_Controller_Sabios {

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    public function indexAction() {

        $this->view->fdps = Doctrine_Query::create()
                ->from("VentaEstado")
                ->where('app_id="' . APPLICATION_ID . '" and borrado="N"')
                ->execute();
    }

    public function addAction() {
        $nombre = $this->_request->getParam('nombre');
        $estado = $this->_request->getParam('devuelveStock', 'N') == 'on' ? 'Y' : 'N';

        $exists = Doctrine_Query::create()
                        ->from("VentaEstado")
                        ->where('app_id="' . APPLICATION_ID . '" and nombre="' . $nombre . '" and borrado="N"')
                        ->execute()->count();

        if ($exists)
            die("ya existe!");

        $fdp = New VentaEstado();
        $fdp->nombre = $nombre;
        $fdp->devuelveStock = $estado;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/ventaestado");
    }

    public function editAction() {

        $nombre = $this->_request->getParam('nombre');
        $estado = $this->_request->getParam('devuelveStock', 'N') == 'on' ? 'Y' : 'N';
        $id = $this->_request->getParam('id', 1);
        $fdp = Doctrine_Query::create()
                ->from("VentaEstado")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        //die("sdfsdf");
        // dump($fdp);
        if (!is_object($fdp))
            die("no existe!");

        $fdp->nombre = $nombre;
        $fdp->devuelveStock = $estado;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/ventaestado");
    }

    public function deleteAction() {

        $id = $this->_request->getParam('id');
         $fdp = Doctrine_Query::create()
                ->from("VentaEstado")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        $fdp->borrado = 'Y';
        $fdp->save();
        return $this->_redirect("/ventaestado");
        
    }

}

