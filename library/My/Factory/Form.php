<?php

class My_Factory_Form {
	
	public static function get($className, $params = null)
	{
		try {
			$class = new ReflectionClass( 'Form_' . $className);
		}
		catch (Exception $e)
		{
			return false;
		}
		
    	return $class->newInstance($params);
	}
}