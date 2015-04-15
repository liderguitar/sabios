<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Sabios
 *
 * @author Lider
 */
class My_Service_Sabios {

    //put your code here

    public static function get($entity, $type, $data = null) {

        $config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/application.ini', APPLICATION_ENV);
        $baseUrl = $config->sabios->baseUrl;
        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];

        //die($app->auth_token);

        $rs = new Zend_Http_Client();
        try {
            $rs->setHeaders(array('apikey: ' . APPLICATION_ID));
            $rs->setHeaders(array("authtoken: " . $app->auth_token));
        } catch (Exception $e) {

            var_dump($e);
            die('murio');
        }

        $rs->setUri($baseUrl . '/' . $entity);

        if (!is_null($data))
            $rs->setParameterGet($data);
        try {
            $resp = $rs->request($type);
        } catch (Exception $e) {
            var_dump($e);
            die();
        }
            
        return ($resp->getBody() == 'token expired') ? false : $resp->getBody();
        
    }

    public static function authorize() {


        $config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/application.ini', APPLICATION_ENV);
        $baseUrl = $config->sabios->baseUrl;

        $rs = new Zend_Http_Client();
        try {
            $rs->setHeaders(array('apikey: ' . APPLICATION_ID));
            $rs->setHeaders(array('Authorization: Basic ' . base64_encode(APPLICATION_ID . ':' . APPLICATION_SECRET)));
            //    $rs->setHeaders(array("apisecret: " . APPLICATION_SECRET));
        } catch (Exception $e) {

            var_dump($e);
            die('murio');
        }
        $rs->setUri($baseUrl . '/authorize');
        $resp = $rs->request("GET");
        //  die('despues de request');
        //  die('paso');
        $body = json_decode($resp->getBody());
        // aca guardar el token.
        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];
        $app->auth_token = $body->data->auth_token;
        //define('APPLICATION_AUTH_TOKEN', $body->data->auth_token);
        $app->save();
        return $body;
    }

    public static function isAuthorized() {

        $app = Doctrine_Core::getTable('Application')->findByDql("app_id='" . APPLICATION_ID . "'");
        $app = $app[0];
        $date = new Zend_Date();
        $fecha = $date->get('yyyy-MM-dd HH:mm:ss');

        if ($fecha < $app->auth_token_expires) {
               return false;
            } else {
               return true;
               // die('else');
            }
    }

}

?>
