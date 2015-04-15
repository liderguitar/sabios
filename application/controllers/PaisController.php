<?php
/**
 * ArticuloController
 * 
 * @author
 * @version 
 */

class PaisController extends My_Controller_Rest
{
    
  public function indexAction() {
        
        $rec = Doctrine_Core::getTable('Pais')->findByDql("borrado='N'")->toArray();
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
    
   
}