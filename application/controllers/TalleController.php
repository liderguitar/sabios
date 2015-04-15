<?php

class TalleController extends My_Controller_Sabios {

    public function addAction() {
        $tp = Doctrine_Core::getTable('TalleTipo')
                ->findByDql("borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
        );
        $this->view->tipoTalles = $tp;


        if ($this->_request->isPost()) {
            $talle = new Talle();
            $talle->app_id = APPLICATION_ID;
            $talle->talle = $this->_request->getParam('nombre');
            $talle->id_tipo_talle = $this->_request->getParam('id_tipo_talle', 0);
            $talle->prioridad = $this->_request->getParam('prioridad', 0);


            try {
                $talle->save();
            } catch (Exception $e) {
                die($e->getMessage());
            }
            return $this->_redirect("/categoria/list");
        }
    }

    public function editAction() {

        $id = $this->_request->getParam('id');
        $tp = Doctrine_Core::getTable('TalleTipo')
                ->findByDql("borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
        );
        $this->view->tipoTalles = $tp;
        if ($this->_request->isPost()) {
            $cat = Doctrine_Core::getTable('Talle')
                    ->findByDql("id='" . $id . "' 
                            and borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
            );
            $talle = $cat[0];
            $talle->talle = $this->_request->getParam('nombre');
            $talle->id_tipo_talle = $this->_request->getParam('id_tipo_talle', 0);
            $talle->prioridad = $this->_request->getParam('prioridad', 0);
            $talle->save();
            return $this->_redirect("/categoria/list");
        } else {
            try {
                $data = Doctrine_Query::create()->select()
                                ->from('Talle t')
                                ->leftJoin('t.TalleTipo tt')
                                ->where('t.id=' . $id)
                                ->andWhere("t.app_id='" . APPLICATION_ID . "'")
                                ->andWhere("t.borrado='N'")->execute();
            } catch (Exception $e) {
                die($e->getMessage());
            }
            $this->view->talle = $data[0];
            // var_dump($this->view->talle->TalleTipo->toArray());die;
        }
    }

    public function listAction() {
        $tp = Doctrine_Core::getTable('TalleTipo')
                ->findByDql("borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
        );

        $this->view->TalleTipos = $tp;
        // die("llego");
        $nombre = $this->_request->getParam('nombre', '');
        $talle_tipo_id = $this->_request->getParam('talle_tipo_id', '');
        $this->view->talle_tipo_id = $talle_tipo_id;

        if ($talle_tipo_id) {
            $talleTipoSql = " and tt.id=".$talle_tipo_id;
            $talletipo = Doctrine_Query::create()->select()
                            ->from('TalleTipo t')
                            ->where('t.id=' . $talle_tipo_id)->execute();
            $this->view->talleTipo = $talletipo[0];
        }
        else
            $talleTipoSql = "";

        $this->view->nombre = $nombre;
        if ($nombre) {
            $nom = " and t.talle like '%$nombre%' ";
        }
        else
            $nom = "";

        $adapter = new My_Paginator(
                Doctrine_Query::create()
                        ->from("Talle t")
                        ->leftJoin("t.TalleTipo tt")
                        ->where("t.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $nom. $talleTipoSql)
                        ->orderBy("tt.id, t.prioridad")
        );


        $this->view->page = $this->_request->getParam('page', 1);


        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
    }

}