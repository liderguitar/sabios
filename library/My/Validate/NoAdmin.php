<?php
class My_Validate_NoAdmin extends Zend_Validate_Abstract
{
    function isValid($value)
    {
        if($value == 'admin')
        {
            $this->_messages = array('la clave no puede ser admin');
            return false;
        }
        return true;
    }
}
