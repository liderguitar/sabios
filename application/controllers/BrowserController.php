<?php

/**
 * BrowserController
 * 
 * @author
 * @version 
 */
class BrowserController extends Zend_Controller_Action {

    /**
     * The default action - show the home page
     */
    public function indexAction() {
        $layout = Zend_Layout::getMvcInstance();
        $layout->setLayout('layout2');

        $this->view->files = $this->getDirectoryList("upload");
    }

    public function uploadAction() {
        $this->view->callbackFunction = $this->_request->getParam('CKEditorFuncNum');
        if ($this->_request->isPost()) {
            $type = explode("/", $_FILES["upload"]["type"]);
            $extension = $type[1];
            if ($extension == "jpeg")
                $extension = "jpg";

            $tmp_name = $_FILES["upload"]["tmp_name"];
            $name = $this->getFileName() . "." . $extension;
            if (!move_uploaded_file($tmp_name, "upload/" . $name))
                die("Error al cargar el archivo.");
        }
        $this->view->filename = PUBLIC_FOLDER . "/upload/" . $name;
    }

    public function ajaxuploadAction() {
        $result = array();
        if ($this->_request->isPost()) {

            foreach ($_FILES as $file) {
                $type = explode("/", $file["type"]);
                $extension = $type[1];

                if ($extension == "jpeg")
                    $extension = "jpg";

                if (
                        $extension <> "jpg" &&
                        $extension <> "gif" &&
                        $extension <> "png"
                ) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension";
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }
                $tmp_name = $file["tmp_name"];
                if ($file["size"] > 307200) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique que el tamaño menor a 300kb.";
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }
                $name = $this->getFileName() . "." . $extension;
                if (!move_uploaded_file($tmp_name, "files/" . $name)) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension y el tamaño menor a 200kb.";
                } else {

                    My_Function_Function::thumbnail("files/" . $name, "files/thumb_" . $name, $type);
                    My_Function_Function::thumbnail("files/" . $name, "files/icon_" . $name, $type,50,38);                    
                    My_Function_Function::thumbnail("files/" . $name, "files/large_" . $name, $type,800,600);                    
                    My_Function_Function::thumbnail("files/" . $name, "files/medium_" . $name, $type,500,375);                    
                    $data['success'] = true;
                    $data['publicFolder'] = PUBLIC_FOLDER . "/files";
                    $data['fileName'] = $name;
                    $data['message'] = "Archivo cargado con exito";
                }
            }
        }
        $result = Zend_Json_Encoder::encode($data);
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_response->setBody($result);
        $this->_response->outputBody();
        exit;
    }

    public function ajaxuploadnovedadAction() {
        $result = array();
        if ($this->_request->isPost()) {

            foreach ($_FILES as $file) {
                $type = explode("/", $file["type"]);
                $extension = $type[1];

                if ($extension == "jpeg")
                    $extension = "jpg";

                if (
                        $extension <> "jpg" &&
                        $extension <> "gif" &&
                        $extension <> "png"
                ) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension";
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }
                $tmp_name = $file["tmp_name"];
                $imagen = getimagesize($tmp_name);
                $ancho = $imagen[0];              //Ancho
                $alto = $imagen[1];



                if ($file["size"] > 1659896  || $ancho < 800 || $alto < 600) {
                    $data['success'] = false;
                    $data['message'] = "$ancho  $alto {$file["size"]} Error al cargar el archivo. El tamaño debe ser de al menos 800 x 600. Verifique que el tamaño menor a 1mb.";
                    unlink ( $tmp_name );
                    
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }
                $name = $this->getFileName() . "." . $extension;
                if (!move_uploaded_file($tmp_name, "files/" . $name)) {
                    unlink ( $tmp_name );
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension y el tamaño menor a 300kb.";
                } else {

                    My_Function_Function::thumbnail("files/" . $name, "files/thumb_" . $name, $type);
                    My_Function_Function::thumbnail("files/" . $name, "files/large_" . $name, $type,800,600);
                    unlink ( "files/" . $name );
                    
                    $data['success'] = true;
                    $data['publicFolder'] = PUBLIC_FOLDER . "/files";
                    $data['fileName'] = $name;
                    $data['message'] = "Archivo cargado con exito Alto:" . $alto . " ancho: " . $ancho;
                }
            }
        }
        $result = Zend_Json_Encoder::encode($data);
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_response->setBody($result);
        $this->_response->outputBody();
        exit;
    }

    private function getDirectoryList($directory) {

        // create an array to hold directory list
        $results = array();

        // create a handler for the directory
        $handler = opendir($directory);

        // open directory and walk through the filenames
        while ($file = readdir($handler)) {

            // if file isn't this directory or its parent, add it to the results
            if ($file != "." && $file != "..") {
                $array = explode(".", $file);
                $ext = $array[1];
                if ($ext == "jpg" || $ext == "gif" || $ext == "png")
                    $results[] = $file;
            }
        }

        // tidy up: close the handler
        closedir($handler);

        // done!
        return $results;
    }

    protected function getFileName() {

        $date = new Zend_Date();
        $datetime = $date->get();

        return $datetime;
    }

    public function ajaxuploadlogoAction() {
        $result = array();
        if ($this->_request->isPost()) {

            foreach ($_FILES as $file) {
                $type = explode("/", $file["type"]);
                $extension = $type[1];

                if ($extension == "jpeg")
                    $extension = "jpg";

                if (
                    $extension <> "jpg" &&
                    $extension <> "gif" &&
                    $extension <> "png"
                ) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension";
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }

                $height = imagesy($file["tmp_name"]);
                $width = imagesx($file["tmp_name"]);
                $tmp_name = $file["tmp_name"];
                if ($height < 300 || $width < 300) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. La resolucion debe ser mayor a 300px";
                    $result = Zend_Json_Encoder::encode($data);
                    $this->_helper->layout()->disableLayout();
                    $this->_helper->viewRenderer->setNoRender(true);
                    $this->_response->setBody($result);
                    $this->_response->outputBody();
                    exit;
                }
                $name = $this->getFileName() . "." . $extension;
                if (!move_uploaded_file($tmp_name, "files/" . $name)) {
                    $data['success'] = false;
                    $data['message'] = "Error al cargar el archivo. Verifique la extension y el tamaño menor a 200kb.";
                } else {

                    My_Function_Function::thumbnail("files/" . $name, "files/thumb_" . $name, $type);
                    My_Function_Function::thumbnail("files/" . $name, "files/icon_" . $name, $type,50,38);
                    My_Function_Function::thumbnail("files/" . $name, "files/large_" . $name, $type,800,600);
                    My_Function_Function::thumbnail("files/" . $name, "files/medium_" . $name, $type,500,375);
                    $data['success'] = true;
                    $data['publicFolder'] = PUBLIC_FOLDER . "/files";
                    $data['fileName'] = $name;
                    $data['message'] = "Archivo cargado con exito";
                }
            }
        }
        $result = Zend_Json_Encoder::encode($data);
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_response->setBody($result);
        $this->_response->outputBody();
        exit;
    }

}