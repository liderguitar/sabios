<?php
class MantenimientoController extends Zend_Controller_Action
{
	public function offlineAction()
	{
		$this->_helper->layout()->disableLayout();
	}
}