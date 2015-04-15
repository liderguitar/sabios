<?php

class CategoriaController extends My_Controller_Sabios {

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

    public function editAction() {

        $id = $this->_request->getParam('id');
        //   var_dump($id);die;

        $this->view->categorias = My_Function_Function::getCategoriaCombo();
        if ($this->_request->isPost()) {
            $cat = Doctrine_Core::getTable('Categoria')
                    ->findByDql("id='" . $id . "' 
                            and borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
            );
            $categoria = $cat[0];
            $categoria->nombre = $this->_request->getParam('nombre');
            $categoria->parent_id = $this->_request->getParam('parent_id', 0);
            $categoria->save();
            return $this->_redirect("/categoria/list");
        } else {
            $cat = Doctrine_Core::getTable('Categoria')
                    ->findByDql("id='" . $id . "' 
                            and borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
            );


            $this->view->categoria = $cat[0];
            if ($this->view->categoria->parent_id <> 0) {
                $cat = Doctrine_Core::getTable('Categoria')
                        ->findByDql("id='" . $this->view->categoria->parent_id . "' 
                            and borrado='N' 
                            and app_id='" . APPLICATION_ID . "'"
                );
                $this->view->parentCategoria = $cat[0]->nombre;
            } else {
                $this->view->parentCategoria = "";
            }
        }
    }

    public function listAction() {

        $this->view->page = $this->_request->getParam('page');
        $this->view->nombre = $this->_request->getParam('nombre','');
        //die("nombre:".$this->view->nombre);
        $categorias = $this->filterCategorias($this->view->nombre, My_Function_Function::getCategoriaCombo());
       //die;
        $adapter = new My_CategoriasPaginator($categorias);

        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(8);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->categorias = $paginator;

    }
    
    private function filterCategorias($search="", $array){
        
        if(!$search)
            return $array;
        $filteredArray = array();
        foreach ($array as $value) {
            if(strstr(strtolower($value['categoria']), strtolower($search)))
                $filteredArray[] = $value;
        }
        return $filteredArray;
    }

}