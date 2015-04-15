<?php
class Zend_View_Helper_MyUrl extends Zend_View_Helper_Abstract
{
    public function myUrl($url, $name, $title = null)
    {
        return sprintf('<a href="%s" title="%s">%s</a>', $url, $title, $name);
    }
}