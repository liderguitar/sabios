<?php
class My_Categoriaspaginator implements Zend_Paginator_Adapter_Interface
{

    protected $_query;
    
    public function __construct($query)
    {
        $this->_query = $query;
    }
    
    public function getItems($offset, $itemsPerPage)
    { 
        return array_slice($this->_query, $offset, $itemsPerPage);
        
    }
    
    public function count()
    { 
        return count($this->_query);
    }
    
}