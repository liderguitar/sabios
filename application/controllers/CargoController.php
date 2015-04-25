<?php

class CargoController extends My_Controller_Rest {

    public function indexAction() {

        //all
        $this->_success = true;
        $this->_message = '';
        $this->_responseCode = 200;

        $data = Doctrine_Core::getTable('Cargo')
                    ->findByDql("borrado='N' 
                        and app_id='" . APPLICATION_ID . "'"
                    )->toArray();
        if (count($data)) {
            $this->_message = 'ok';
            $this->_success = true;
            $this->_data = $data;
        } else {
            $this->_message = 'No data';
            $this->_success = false;
        }    
        

        $this->_setResponse();
    }

    public function deleteAction() {
        
        $id = $this->_request->getParam('id');
        $rec = Doctrine_Core::getTable('Cargo')->findByDql("id='" . $id . "' and app_id='" . APPLICATION_ID . "'");
        if (!count($rec)) {
            $this->_responseCode = 204;
            $this->_success = false;
        } else {

            $cat = $rec[0];
            if ($cat->borrado == 'N') {
                $cat->borrado = 'Y';
                $cat->save();
                $this->_responseCode = 200;
                $this->_success = true;
                $this->_message = 'Cargo borrado';
                $this->saveAuditoria($id);
            } else {
                $this->_success = false;
                $this->_message = 'Cargo ya borrado';
                $this->_responseCode = 204;
            }
        }

        $this->_setResponse();


        /*
         * $.ajax({
          type: "DELETE",
          dataType : 'json',
          url: 'http://127.0.0.1:8380/categoria/1',
          beforeSend: function(xhr){
          xhr.setRequestHeader("apikey", '04f50f7dfc94e524e2fc6ce675663c1d');
          xhr.setRequestHeader("user_id", '999');
          },
          success: function(response){
          console.log(response);

          },
          statusCode: {
          403: function() {
          alert( "Api Incorrect" );
          }
          }

          });
         */
    }

    public function getAction() {

        $id = $this->_request->getParam('id');
        if (!isset($id)) {
            $this->_message = 'falta datos';
            $this->_success = false;
        }

        $data = Doctrine_Core::getTable('Cargo')
                        ->findByDql("id='" . $id . "' 
                            and borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
                        )->toArray();

        if (count($data)) {
            $this->_message = 'ok';
            $this->_success = true;
            $this->_data = $data;
        } else {
            $this->_message = 'Wrong Id';
            $this->_success = false;
        }

        $this->_setResponse();
    }

    public function putAction() {

        $nombre = $this->_request->getParam('nombre', null);

        $id = $this->_request->getParam('id', null);
        $this->_success = true;
        $this->_message = 'Cargo Modificada';

        if (is_null($nombre) || is_null($id)) {
            $this->_success = false;
            $this->_message = 'Falta de datos';
        } else {
            $rec = Doctrine_Core::getTable('Cargo')
                    ->findByDql("id='" . $id . "' and borrado='N' and app_id='" . APPLICATION_ID . "'");

            if (!count($rec)) {
                $this->_success = false;
                $this->_message = 'Cargo no existente';
            } else {
                $this->_success = true;
                $this->_message = 'Cargo modificada';
                $cat = $rec[0];
                $dataOld = $cat->toArray();
                $cat->nombre = $nombre;
                $cat->save();
                $this->saveAuditoria($id, $cat->toArray(), $dataOld);
            }
        }

        $this->_setResponse();
    }

    public function postAction() {

        $nombre = $this->_request->getParam('nombre');

        $this->_success = true;
        $this->_message = 'Cargo Insertada';
        $rec = Doctrine_Core::getTable('Cargo')
                ->findByDql("nombre='" . $nombre . "' and app_id='" . APPLICATION_ID . "'");
        if (!count($rec)) {
            $cat = new Cargo();
            $cat->app_id = APPLICATION_ID;
            $cat->nombre = $nombre;
            $cat->save();
            $this->saveAuditoria($cat->id);
        } else {
            if ($rec->borrado == 'Y') {
                $rec->borrado = 'N';
                $rec->save();
                $this->saveAuditoria($rec->id);
            } else {
                $this->_message = 'Cargo ya existente';
                $this->_success = false;
            }
        }
        $this->_setResponse();
    }

}