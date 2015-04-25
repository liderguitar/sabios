<?php
class SuperadminController extends Zend_Controller_Action
{
	public function offlineAction()
	{
		$this->_helper->layout()->disableLayout();
	}

    public function listAction(){

        $nombre = $this->_request->getParam('nombre', '');




        $q= Doctrine_Query::create()->from('Application')->where("app_id not in ('home','admin')");

        if ($nombre) {
            $q->andWhere("nombre like '%$nombre%' ");
        }
        $adapter = new My_Paginator($q);

        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(15);
        $paginator->setCurrentPageNumber($this->view->page);
        $this->view->nombre = $nombre;
        $this->view->objects = $paginator;

    }

    public function updateAction(){

        $id = $this->_request->getParam('id');



        $app = Doctrine_Core::getTable('Application')->find($id);
        $app->estado = $app->estado =="OFFLINE" ? "ONLINE" : "OFFLINE";
        $app->save();
        die;

    }




}