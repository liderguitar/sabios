<?php

class AlertaemailsController extends My_Controller_Sabios {

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    public function indexAction() {

        $alertaEmails = Doctrine_Query::create()
                ->from("Alertaemails a")
                ->leftJoin("Cliente c")
                ->leftJoin("FormaDePago f")
                ->leftJoin("VentaEstado")
                ->where('app_id="' . APPLICATION_ID . '"')
                ->execute()->toArray();
        
        dump($alertaEmails);
        
        
    }

    public function addAction() {
        $nombre = $this->_request->getParam('nombre');
        $estado = $this->_request->getParam('estado', 'INACTIVO');

        $exists = Doctrine_Query::create()
                        ->from("FormaDePago")
                        ->where('app_id="' . APPLICATION_ID . '" and nombre="' . $nombre . '" and borrado="N"')
                        ->execute()->count();

        if ($exists)
            die("ya existe!");

        $fdp = New Vendedor();
        $fdp->nombre = $nombre;
        $fdp->estado = $estado;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/vendedor");
    }

    public function editAction() {

        
        $nombre = $this->_request->getParam('nombre');
        $estado = $this->_request->getParam('estado', 'INACTIVO');
        $id = $this->_request->getParam('id', 1);
        $fdp = Doctrine_Query::create()
                ->from("Vendedor")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        //die("sdfsdf");
        // dump($fdp);
        if (!is_object($fdp))
            die("no existe!");

        $fdp->nombre = $nombre;
        $fdp->estado = $estado;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/vendedor");
    }

    public function deleteAction() {

        $id = $this->_request->getParam('id');
         $fdp = Doctrine_Query::create()
                ->from("Vendedor")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        $fdp->borrado = 'Y';
        $fdp->save();
        return $this->_redirect("/vendedor");
        
    }

}

