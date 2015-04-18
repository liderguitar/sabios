<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap {

    protected $layout;
    protected $configuration;
    protected $config;

    public function _initTimeZone() {
        date_default_timezone_set("America/Sao_Paulo");
    }

    protected function _initRouter() {

        $frontController = Zend_Controller_Front::getInstance();
        $config = new Zend_Config_Ini(APPLICATION_PATH . DIRECTORY_SEPARATOR . 'configs' . DIRECTORY_SEPARATOR . 'routes.ini');
        $router = $frontController->getRouter();
        $router->addConfig($config, 'routes');
    }

    /*
      protected function _initErrorHandlers()
      {
      $front = Zend_Controller_Front::getInstance();
      $front->registerPlugin(new Zend_Controller_Plugin_ErrorHandler());

      }
     */

    public function _initRegistry() {

        // Define application environment
        defined('APPLICATION_ENV') || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

        //die(APPLICATION_ENV);
        Zend_Registry::set('siteName', 'Sabios');
        $this->config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/application.ini', APPLICATION_ENV);
        //die($this->config->sabios->baseUrl);
    }

    public function _initAutoload() {
        Zend_Registry::set('doctrine_config', array(
            'data_fixtures_path' => dirname(__FILE__) . '/doctrine/data/fixtures',
            'models_path' => dirname(__FILE__) . '/models',
            'migrations_path' => dirname(__FILE__) . '/doctrine/migrations',
            'sql_path' => dirname(__FILE__) . '/doctrine/data/sql',
            'yaml_schema_path' => dirname(__FILE__) . '/doctrine/schema'
        ));

        $autoLoader = Zend_Loader_Autoloader::getInstance();
        $autoLoader->setFallbackAutoloader(true);
        $autoLoader->registerNamespace('Clases_');

        $resourceLoader = new Zend_Loader_Autoloader_Resource(
                array(
            'basePath' => APPLICATION_PATH,
            'namespace' => '',
            'resourceTypes' =>
            array(
                'forms' =>
                array(
                    'path' => 'forms',
                    'namespace' => 'Form_'
                ),
                'My' =>
                array(
                    'path' => '../library/My',
                    'namespace' => 'My_'
                ),
                'models' =>
                array(
                    'path' => 'models',
                    'namespace' => 'Model_'
                )
            )
                )
        );


        Doctrine_Core::loadModels(dirname(__FILE__) . '/models/generated');
        return $autoLoader;
    }

    protected function _initDoctrine() {

        $doctrineConfig = Zend_Registry::get('doctrine_config');
        Doctrine_Core::loadModels($doctrineConfig['models_path']);
        $conn = Doctrine_Manager::connection($this->_getDBConnectionString(), 'doctrine');
        $conn->setAttribute(Doctrine::ATTR_USE_NATIVE_ENUM, true);
        Zend_Registry::set('conn', $conn);

        return $conn;
    }

    public function _initSite() {

        $domains = split('\.', $_SERVER['SERVER_NAME']);
        //    dump($domains);
//        if (APPLICATION_ENV == 'production') {
        if ($domains[0] == 'www' || $domains[0] == 'sabiosweb') {
            // header('location: /home');
            $this->configuration = Doctrine_Core::getTable('Application')->find(4);
            define("PUBLIC_FOLDER", $this->configuration->publicFolder);
            define("APPLICATION_ID", $this->configuration->app_id);
            define("APPLICATION_SECRET", $this->configuration->app_secret);
            define("APPLICATION_LOGO", $this->configuration->logo);
            define("APPLICATION_NAME", $this->configuration->nombre);
        } else {
//            
            $this->configuration = Doctrine_Core::getTable('Application')->findByDql("subdominio='" . $domains[0] . "'");
            if (count($this->configuration)) {
                $this->configuration = $this->configuration[0];
                define("PUBLIC_FOLDER", $this->configuration->publicFolder);
                define("APPLICATION_ID", $this->configuration->app_id);
                define("APPLICATION_SECRET", $this->configuration->app_secret);
                define("APPLICATION_LOGO", $this->configuration->logo);
                define("APPLICATION_NAME", $this->configuration->nombre);
                if($this->configuration->estado == 'OFFLINE') {
                    header('location: http://www.sabbios.com/home');
                }
            } else {
                if (APPLICATION_ENV == 'production') {
                    header('location: http://www.sabbios.com/home');
                    die;
                } else {
                    header('location: http://www.sabbios.com/home');

                    die('sin autorizacion');
                }
            }
        }
    }

    public function _initView() {
        $this->view = new Zend_View ( );
        $this->view->doctype('XHTML1_STRICT');
        $this->view->setEncoding('UTF-8');
        $viewRenderer = Zend_Controller_Action_HelperBroker::getStaticHelper('ViewRenderer');
        $viewRenderer->setView($this->view);
        $this->view->headTitle($this->configuration->nombre)
                ->setSeparator(' :: ');

        return $this->view;
    }

    public function _initAcl() {
        $fc = Zend_Controller_Front::getInstance();
        $fc->registerPlugin(new My_Plugin_Acl());
    }

    public function _initLayoutPlugin() {
        $fc = Zend_Controller_Front::getInstance();
        $fc->registerPlugin(new My_Plugin_Layout());
    }

    public function _initBasicStyles() {

        // $this->view->headLink()->offsetSetStylesheet(100, $this->configuration->publicFolder .'/css/' . $this->configuration->template . '/style.css');
    }

    public function _initStyles() {
        $this->view->headLink()->offsetSetStylesheet(600, $this->configuration->publicFolder . '/css/screen.css');
        $this->view->headLink()->offsetSetStylesheet(200, $this->configuration->publicFolder . '/css/jquery-ui-1.8.16.custom.css');
        $this->view->headLink()->offsetSetStylesheet(201, $this->configuration->publicFolder . '/css/smoothness/jquery-ui.css');
        $this->view->headLink()->offsetSetStylesheet(650, $this->configuration->publicFolder . '/css/estilos.css');
        $this->view->headLink()->offsetSetStylesheet(653, $this->configuration->publicFolder . '/css/font-awesome.min.css');
        $this->view->headLink()->offsetSetStylesheet(654, $this->configuration->publicFolder . '/css/jquery.dataTables.css');
        $this->view->headLink()->offsetSetStylesheet(655, $this->configuration->publicFolder . '/css/jquery.dataTables_themeroller.css');
        $this->view->headLink()->offsetSetStylesheet(656, $this->configuration->publicFolder . '/css/select2.css');
        //  $this->view->headLink()->offsetSetStylesheet(657, $this->configuration->publicFolder . '/css/estilos_home.css');
    }

    public function _initJS() {

        $this->view->headScript()->offsetSetFile(100, $this->configuration->publicFolder . '/js/jquery-1.8.3.min.js');
        $this->view->headScript()->offsetSetFile(200, $this->configuration->publicFolder . '/js/jquery-ui-1.10.4.custom.min.js');
        $this->view->headScript()->offsetSetFile(300, $this->configuration->publicFolder . '/js/jquery.styly.min.js');

        $this->view->headScript()->offsetSetFile(960, $this->configuration->publicFolder . '/js/blockUI.js');
        $this->view->headScript()->offsetSetFile(970, $this->configuration->publicFolder . '/js/basic.js');
        $this->view->headScript()->offsetSetFile(971, $this->configuration->publicFolder . '/js/sabios.js');
        $this->view->headScript()->offsetSetFile(990, $this->configuration->publicFolder . '/js/plugins/multiSearch.js');
        $this->view->headScript()->offsetSetFile(995, $this->configuration->publicFolder . '/js/plugins/ajaxfileupload.js');
        $this->view->headScript()->offsetSetFile(307, $this->configuration->publicFolder . '/js/plugins/jquery.dataTables.js');
        $this->view->headScript()->offsetSetFile(996, $this->configuration->publicFolder . '/js/plugins/jquery.cookie.js');
        $this->view->headScript()->offsetSetFile(991, $this->configuration->publicFolder . '/js/jquery-ui-timepicker-addon.js');
        $this->view->headScript()->offsetSetFile(998, $this->configuration->publicFolder . '/js/plugins/jqFancyTransitions.1.8.min.js');
        $this->view->headScript()->offsetSetFile(107, $this->configuration->publicFolder . '/js/plugins/jquery.validate.js');
        $this->view->headScript()->offsetSetFile(108, $this->configuration->publicFolder . '/js/plugins/jquery.mustache.js');
        $this->view->headScript()->offsetSetFile(109, $this->configuration->publicFolder . '/js/plugins/mustache.js');
        $this->view->headScript()->offsetSetFile(111, $this->configuration->publicFolder . '/js/plugins/jquery.base64.js');
        $this->view->headScript()->offsetSetFile(112, $this->configuration->publicFolder . '/js/validation.js');
        $this->view->headScript()->offsetSetFile(113, $this->configuration->publicFolder . '/js/select2.min.js');
    }

    public function _initMetas() {
        $metas = array(
            "Keywords" => "mejor un libro,Dicionarios,Diccionarios enciclopedicos,Enciclopedias,Cuentos Intantiles,Libros para mama,Libros para Papa,Libros de cocina,Medicina,Enfermeria,Libros para docentes,Dia del nino,Regalos para dia del nino,Libros en cuotas,Enciclopedias de Argentina,Libros de cocina,Oficios y profesiones,Mecanica automotor,Oceano,Circulo Latino Austral,Billiken,Planeta,Educacion sexual,Negri ediciones,Ediciones RT,Contrareembolso,Libros por contrareembolso,LIBROS  para todos,Aprender leyendo",
            "Description" => "Mejor Un Libro, sitio de venta online de libros",
            "language" => "Spanish",
            "author" => "Gustavo Pero",
            "copyright" => date('Y'),
            "robots" => "ALL",
            "revisit-after" => "15 days",
            "document-class" => "dynamic",
            "document-classification" => "Computer Multimedia",
            "document-rating" => "Safe for Kids",
            "document-distribution" => "Global",
            "document-state" => "Dynamic"
        );

        foreach ($metas as $meta => $values) {
            $this->view->headMeta()->appendName($meta, $values);
        }
    }

    public function _initLogger() {
//        $this->_log = new Zend_log();
//        Zend_Registry::set('log', $this->_log);
    }

    public function _initStreamLogger() {
//        $streamLogger = new Zend_Log_Writer_Stream(APPLICATION_PATH.'/../log.txt');
//        
//        $streamLogger->setFormatter(
//            new Zend_Log_Formatter_Simple('[ %timestamp% ] [ %priorityName% ]: %message%' . PHP_EOL)
////            new Zend_Log_Formatter_Simple()
//        );
//
//        $this->_log->addWriter($streamLogger);
//        $this->_log->addPriority('login', 8);
    }

    public function _initXmlLog() {
//        require APPLICATION_PATH.'/../library/My/Log/Filter/DebugPriority.php';
//        // Use a customized Formatting and add custom log Events
//        $formatter = new Zend_Log_Formatter_Xml(
//            'miXml',
//            array(
//                'msg' => 'message',
//                'level' => 'priorityName',
//                'ip-visitor' => 'visitorIp',
//                'host-visitor' => 'visitorHost'
//            )
//        );
//        
//        $miXmlWriter = new Zend_Log_Writer_Stream(APPLICATION_PATH.'/../miXml.xml');
//        $miXmlWriter->setFormatter($formatter);
//        $filter = new My_Log_Filter_DebugPriority();
//        $miXmlWriter->addFilter($filter);
//        
////        $miXmlLogger = new Zend_Log($miXmlWriter);
//        $this->_log->addWriter($miXmlWriter);
//        
//        $this->_log->setEventItem('visitorIp', $_SERVER['REMOTE_ADDR']);
//        $this->_log->setEventItem('visitorHost', gethostbyaddr($_SERVER['REMOTE_ADDR']));
////        $miXmlLogger->addPriority('minimum', My_Log_Filter_MinimumPriority::MININUM_PRIORITY);
////        $miXmlLogger->warn('mensaje de warning en xml'); 
    }

    public function _initFirebugLog() {
//        $firebugLogger = new Zend_Log_Writer_Firebug();
//        $this->_log->addWriter($firebugLogger);
    }

    public function _initTestLog() {
        /*        $this->_log->log('mi alerta', Zend_Log::ALERT);
          $this->_log->log('mi critic', Zend_Log::CRIT);
          $this->_log->log('mi debug', Zend_Log::DEBUG);
          $this->_log->log('mi emerg', Zend_Log::EMERG);
          $this->_log->log('mi error', Zend_Log::ERR);
          $this->_log->log('mi info', Zend_Log::INFO);
          $this->_log->log('mi notice', Zend_Log::NOTICE);            $conn = Doctrine_Manager::connection("mysql://root:root@localhost/bookstore_backup_arriba",'doctrine');

          $this->_log->log('mi warning', Zend_Log::WARN);
          $this->_log->log('mi explosion', 8); */
    }

    protected function _getDBConnectionString() {
        return "mysql://" .
                trim($this->config->db->config->username) . ":" .
                trim($this->config->db->config->password) . "@" .
                trim($this->config->db->config->host) . "/" .
                trim($this->config->db->config->dbname);
    }

}