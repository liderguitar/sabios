<?php

class TalleTipoController extends My_Controller_Sabios {

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    public function indexAction() {

        $this->view->fdps = Doctrine_Query::create()
                ->from("TalleTipo")
                ->where('app_id="' . APPLICATION_ID . '" and borrado="N"')
                ->execute();
    }

    public function addAction() {
        $nombre = $this->_request->getParam('nombre');

        $exists = Doctrine_Query::create()
                        ->from("TalleTipo")
                        ->where('app_id="' . APPLICATION_ID . '" and descripcion="' . $nombre . '" and borrado="N"')
                        ->execute()->count();

        if ($exists){
            $this->_helper->flashMessenger->setNamespace('error')->addMessage('Tipo de talle ya existente');

            return $this->_redirect("/TalleTipo");
            
        }

        $fdp = New TalleTipo();
        $fdp->descripcion = $nombre;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/talletipo");
    }

    public function editAction() {

        $nombre = $this->_request->getParam('nombre');
        $id = $this->_request->getParam('id', 1);
        $fdp = Doctrine_Query::create()
                ->from("TalleTipo")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        //die("sdfsdf");
        // dump($fdp);
        if (!is_object($fdp))
            die("no existe!");

        $fdp->descripcion = $nombre;
        $fdp->app_id = APPLICATION_ID;
        $fdp->save();
        return $this->_redirect("/talletipo");
    }

    public function deleteAction() {
        $id = $this->_request->getParam('id');
        
         $fdp = Doctrine_Query::create()
                ->from("TalleTipo")
                ->where("app_id='" . APPLICATION_ID . "'")
                ->andWhere("id=" . $id)
                ->fetchOne();

        $fdp->borrado = 'Y';
        $fdp->save();
        return $this->_redirect("/talletipo");
        
    }

}

