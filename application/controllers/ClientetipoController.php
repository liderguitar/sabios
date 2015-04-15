<?php

/**
 * ArticuloController
 * 
 * @author
 * @version 
 */
class ClientetipoController extends My_Controller_Sabios {

    public function init() {
        parent::init();

    }

    public function deleteAction() {
        //die($this->_request->getParam('id'));
        $id = $this->_request->getParam('id');
        $rec = Doctrine_Core::getTable('ClienteTipo')->findByDql("id='" . $id . "' and app_id='" . APPLICATION_ID . "'");
        if (!count($rec)) {
            $this->_responseCode = 204;
            $this->_success = false;
        } else {

            $cat = $rec[0];
            if ($cat->borrado == 'N') {
                $cat->borrado = 'Y';
                $cat->save();
                $this->_message = 'Tipo de Cliente borrada';
                $this->_responseCode = 200;
                $this->_success = true;
            } else {
                $this->_success = false;
                $this->_message = 'Clase de Cliente ya borrada';
                $this->_responseCode = 204;
            }
        }

        $this->_setResponse();
    }

    public function addAction() {


        if ($this->_request->isPost()) {

            $nombre = $this->_request->getParam('nombre');
            $this->_success = true;
            $this->_message = 'Tipo de Cliente Insertado';
            $rec = Doctrine_Core::getTable('ClienteTipo')
                    ->findByDql("nombre='" . $nombre . "' and app_id='" . APPLICATION_ID . "'");
            if (!count($rec)) {
                $cat = new ClienteTipo();
                $cat->app_id = APPLICATION_ID;
                $cat->nombre = $nombre;
                $cat->save();
                $this->_helper->flashMessenger->setNamespace('success')->addMessage("Grabado Correctamente!");
                return $this->_redirect("/clientetipo/list");
            } else {

                if ($rec->borrado == 'Y') {
                    $rec->borrado = 'N';
                    $rec->save();
                    $this->_helper->flashMessenger->setNamespace('success')->addMessage("Grabado Correctamente!");
                    return $this->_redirect("/clientetipo/list");
                } else {
                    $this->_helper->flashMessenger->setNamespace('error')->addMessage("Grabado Correctamente!");
                    $this->_helper->flashMessenger->addMessage('Tipo de Cliente ya existente');
                    $this->view->nombre = $nombre;
                    $this->view->errormessages = $this->_helper->flashMessenger->setNamespace('error')->getMessages();
                }
            }
        }
    }

    public function listAction() {

        $nombre = $this->_request->getParam('nombre', '');
        $this->view->nombre = $nombre;

        if ($nombre) {
            $nom = " and c.nombre like '%$nombre%' ";
        }
        else
            $nom = "";

        $adapter = new My_Paginator(
                Doctrine_Query::create()
                        ->from("ClienteTipo c")
                        ->where("c.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $nom)
        );


        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
    }

    public function editAction() {
        $id = $this->_request->getParam('id');
        // die($id);
        $tipoCliente = Doctrine_Query::create()
                        ->from("ClienteTipo c")
                        ->where("c.id = " . $id . " and c.borrado = 'N' and app_id='" . APPLICATION_ID . "'")->execute();
        $tipoCliente = $tipoCliente[0];


        if ($this->_request->isPost()) {
            $nombre = $this->_request->getParam('nombre');
            $tipoCliente->nombre = $nombre;
            $tipoCliente->save();
            $this->_helper->flashMessenger->setNamespace('success')->addMessage("Grabado Correctamente!");
            return $this->_redirect("/clientetipo/list");
        } else {
            $this->view->id = $tipoCliente->id;
            $this->view->nombre = $tipoCliente->nombre;
        }
    }

}