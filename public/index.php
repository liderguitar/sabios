<?php

function dump($var, $die=true){
    
    echo "<pre>";
    print_r($var);
    echo "</pre>";
    
    if($die) die;
    return;
        
    
}

ini_set('display_errors', 1); 
set_include_path(dirname(__FILE__).'/../library/zendframework' 
        . PATH_SEPARATOR . dirname(__FILE__).'/../library/doctrine'
        . PATH_SEPARATOR . dirname(__FILE__).'/models'
        . PATH_SEPARATOR . dirname(__FILE__).'/models/generated'
        . PATH_SEPARATOR . get_include_path());
		
		
// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    //realpath(APPLICATION_PATH),
    get_include_path(),
)));


//error_reporting(E_ALL|E_STRICT);
ini_set('display_errors', 'on');

/** Zend_Application */
require_once 'Zend/Application.php';

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);
$application->bootstrap()
            ->run();