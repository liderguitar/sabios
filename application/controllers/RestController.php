<?php
/**
 * ArticuloController
 * 
 * @author
 * @version 
 */

class RestController extends Zend_Rest_Controller
{
    
    public function init() {
        parent::init();
        //header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS');

      	$this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
    }
    public function indexAction() {
        
        //all
        $this->getResponse()
                ->setHttpResponseCode(200)
                ->appendBody(json_encode(array('message' => 'all products')));
    }
    
    
    public function deleteAction() {
        $this->getResponse()
                ->setHttpResponseCode(203)
                ->appendBody(json_encode(array('message' => 'delete')));
    }
    
    public function getAction() {
        //get only one
        ;
    }
    
    public function putAction() {
        //update
        ;
    }
    
    public function postAction() {
        ;
        // create
    }
    
    /*
     * jQuery.ajax({
    type: "GET",
    dataType : 'json',
    url: 'http://127.0.0.1:8380/provincia/10', 
    beforeSend: function(xhr){xhr.setRequestHeader("apikey", '04f50f7dfc94e524e2fc6ce675663c1d');},
    success: function(response){

        console.log( response);
        
    },
    error : function(){alert('error!!!!');},
    statusCode: {
        403: function() {
        alert( "Api Incorrect" );
    }
}
     */
    
}