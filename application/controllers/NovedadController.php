<?php

class NovedadController extends My_Controller_Sabios {

    public function addAction() {

        $this->view->categorias = My_Function_Function::getCategoriaCombo();
        if ($this->_request->isPost()) {
            $categoria = new Categoria();
            $categoria->app_id = APPLICATION_ID;
            $categoria->nombre = $this->_request->getParam('nombre');
            $categoria->parent_id = $this->_request->getParam('parent_id', 0);
            $categoria->save();
            return $this->_redirect("/categoria/list");
        }
    }

    public function adminAction() {

        $novedades = Doctrine_Query::create()
                        ->from("Novedad n")
                        ->where("n.borrado = 'N' and n.app_id='" . APPLICATION_ID . "'")->execute()->toArray();


        $positions = array(1, 2, 3, 4, 5, 6, 7, 8, 9);
        $novedadesview = array();
        foreach ($positions as $pos) {
            foreach ($novedades as $nov) {
                if ($nov['posicion'] == $pos) {
                    $novedadesview[$pos] = $nov;
                }
            }
        }
        $this->view->novedades = $novedadesview;
    }

    public function listAction() {

        $novedades = Doctrine_Query::create()
                        ->from("Novedad n")
                        ->where("n.borrado = 'N' and n.app_id='" . APPLICATION_ID . "'")->execute()->toArray();


        $positions = array(1, 2, 3, 4, 5, 6, 7, 8, 9);
        $novedadesview = array();
        foreach ($positions as $pos) {
            foreach ($novedades as $nov) {
                if ($nov['posicion'] == $pos) {
                    $novedadesview[$pos] = $nov;
                }
            }
        }
        $this->view->novedades = $novedadesview;
    }

    public function editAction() {

        $this->view->id = $this->_request->getParam('id', false);
        if($this->view->id < 1 || $this->view->id > 9 || !$this->view->id){
            throw new Exception("Las novedades son del 1 al 9");
        }
        
        $novedad = Doctrine_Query::create()
                        ->from("Novedad n")
                        ->where("n.borrado = 'N' and n.app_id='" . APPLICATION_ID . "' and posicion=" . $this->_request->getParam('id', false))->execute();
        
        $this->view->novedad = count($novedad) ?  $novedad[0] : false;
        
        if ($this->_request->isPost()) {
            $id = $this->_request->getParam('id', false);

            // var_dump($this->_request->getPost());
            //die;
            $novedad = Doctrine_Query::create()
                            ->from("Novedad n")
                            ->where("n.borrado = 'N' and n.app_id='" . APPLICATION_ID . "' and posicion=" . $id)->execute();

            if (count($novedad)) {
                $nov = $novedad[0];
                $nov->imagen = $this->_request->getParam('imagen');
                $nov->url = $this->_request->getParam('link');
                $nov->save();
            } else {
                // die("nueva");
                $nov = new Novedad();
                $nov->app_id = APPLICATION_ID;
                $nov->imagen = $this->_request->getParam('imagen');
                $nov->url = $this->_request->getParam('link');
                $nov->posicion = $id;
                // var_dump($nov->toArray());die;
                $nov->save();
            }
            return $this->_redirect("/novedad/admin");
        }
    }

}