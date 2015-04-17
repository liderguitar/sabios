<?php
class SuperadminController extends Zend_Controller_Action
{
	public function offlineAction()
	{
		$this->_helper->layout()->disableLayout();
	}
}