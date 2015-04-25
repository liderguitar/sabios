<?php

class My_Factory_Model {
	
	public static function get($className, $params = null)
	{
		$class = new ReflectionClass($className);
    	return $class->newInstance($params);
	}
}
