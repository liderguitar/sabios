<?php
error_reporting(E_ALL | E_STRICT);
ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);
date_default_timezone_set('Europe/Brussels');
 
 
/** Zend_Application */

require_once 'C:/wamp/www/zfcordoba/library/zendframework/Zend/Application.php';

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

/** Zend_Application */

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);


// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);
 

/*
 * Setup libraries & autoloaders
 */
 
 die(dirname(__FILE__).'/../library/zendframework');
set_include_path(dirname(__FILE__).'/../library/zendframework' 
        . PATH_SEPARATOR . dirname(__FILE__).'/../library/doctrine'
        . PATH_SEPARATOR . dirname(__FILE__).'/models'
        . PATH_SEPARATOR . dirname(__FILE__).'/models/generated'
        . PATH_SEPARATOR . get_include_path());
require 'Zend/Loader.php';

$autoLoader = Zend_Loader_Autoloader::getInstance ();
$autoLoader::registerAutoload('Zend_Loader');

 
/*
 * Set super-global data
 */
Doctrine_Manager::connection("mysql://user:pass@localhost/database");
 
/*
 * Configure Doctrine
 */
Zend_Registry::set('doctrine_config', array(
        'data_fixtures_path'  =>  dirname(__FILE__).'/doctrine/data/fixtures',
        'models_path'         =>  dirname(__FILE__).'/models',
        'migrations_path'     =>  dirname(__FILE__).'/doctrine/migrations',
        'sql_path'            =>  dirname(__FILE__).'/doctrine/data/sql',
        'yaml_schema_path'    =>  dirname(__FILE__).'/doctrine/schema'
        ));