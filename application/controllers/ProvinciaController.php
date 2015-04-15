<?php

class ProvinciaController extends My_Controller_Rest {

    public function indexAction() {

        $id = $this->_request->getParam('id');
        $rec = Doctrine_Core::getTable('Provincia')->findByDql("id_pais='" . $id . "' and borrado='N'")->toArray();
        if (count($rec)) {
            $this->_success = true;
            $this->_message = 'ok';
            $this->_data = $rec;
        } else {
            $this->_success = false;
            $this->_message = 'error';
        }

        $this->_setResponse();
    }

    public function deleteAction() {
        $this->message = '';
        $id = $this->_request->getParam('id');
        $rec = Doctrine_Core::getTable('Provincia')->findByDql("id='" . $id . "'");
        if (!count($rec)) {
            $this->responseCode = 204;
            $$this->success = false;
        } else {

            $cat = $rec[0];
            if ($cat->borrado == 'N') {
                $cat->borrado = 'Y';
                $cat->save();
                $this->_responseCode = 200;
                $this->_success = true;
            } else {
                $this->_success = false;
                $this->_message = 'Provincia ya borrada';
                $this->_responseCode = 204;
            }
        }
        $this->_setResponse();
    }

    public function getAction() {

        $id = $this->_request->getParam('id');
        

        if (!isset($id)) {
            $this->_success = false;
            $this->_message = 'falta datos';
        } else {
            $rec = Doctrine_Core::getTable('Provincia')->findByDql("id_pais='" . $id . "' and borrado='N'")->toArray();
            if (count($rec)) {
                $this->_success = true;
                $this->_message = 'ok';
                $this->_data = $rec;
            } else {
                $this->_success = false;
                $this->_message = 'error';
            }
        }

        $this->_setResponse();
    }

    public function putAction() {

        $nombre = $this->_request->getParam('nombre', null);
        $id = $this->_request->getParam('id', null);
        $paisId = $this->_request->getParam('pais_id', null);
        $this->_success = true;
        $this->_message = 'Provincia Modificada';

        $rec = Doctrine_Core::getTable('Provincia')
                ->findByDql("id='" . $id . "' and borrado='N'");
        if (is_null($nombre) || is_null($id)) {
            $this->_success = false;
            $this->_message = 'Falta de datos';

        } else {
            if (!count($rec)) {
                $this->_success = false;
                $this->_message = 'Provincia no exixtente';
            } else {

                $cat = $rec[0];
                $cat->nombre = $nombre;
                $cat->paisId = $paisId;
                $cat->save();
            }
        }

        $this->_setResponse();
    }

    public function postAction() {

        $nombre = $this->_request->getParam('nombre');
        $paisId = $this->_request->getParam('pais_id', null);        
        $this->_success = true;
        $this->_message = 'Provincia Insertada';
        $rec = Doctrine_Core::getTable('Provincia')
                ->findByDql("nombre='" . $nombre . "' and pais_id='".$paisId."' and app_id='" . APPLICATION_ID . "'");
        if (!count($rec)) {
            $cat = new Provincia();
            $cat->app_id = APPLICATION_ID;
            $cat->nombre = $nombre;
            $cat->pais_id = $paisId;
            $cat->save();
        } else {
            if ($rec->borrado == 'Y') {
                $rec->borrado = 'N';
                $rec->save();
            } else {
                $this->_message = 'Provincia ya existente';
                $this->_success = false;
            }
        }

        $this->_setResponse();

    }

}