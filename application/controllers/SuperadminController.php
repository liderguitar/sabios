<?php
class SuperadminController extends Zend_Controller_Action
{
	public function offlineAction()
	{
		$this->_helper->layout()->disableLayout();
	}

    public function listAction(){

        $adapter = new My_Paginator(Doctrine_Query::create()->from('Application')->where("app_id not in ('home','admin')"));

        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(15);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;

    }




}