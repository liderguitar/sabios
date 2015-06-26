<?php
class My_Log_Filter_DebugPriority implements Zend_Log_Filter_Interface
{
    public function accept($event)
    {
        return $event['priority'] != Zend_log::DEBUG;
    }
}