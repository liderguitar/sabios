<?php

/**
 * UsuarioController
 * 
 * @author
 * @version 
 */
class UsuarioController extends My_Controller_Sabios {

    /**
     * The default action - show the home page
     */
    protected $_auth;

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        $this->config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/application.ini', 'production');
    }

    public function loginAction() {
       // die(APPLICATION_ID);
        
        if ($this->_auth->hasIdentity()) {
            die('tiene');
            return $this->_redirect('/catalogo/categoria');
        }
        $origin = $this->_request->getHeader('referer');
        $this->view->messages = $this->_helper->flashMessenger->getMessages();
        $this->_helper->flashMessenger->clearCurrentMessages();

        $type = $this->_request->getParam("type", "local");

        if ($type <> 'local' && $type <> 'twitter' && $type <> 'facebook')
            throw new Zend_Exception('Parametro erroneo', 404);
        //$this->_helper->redirector('error', 'error','default');

        $this->view->form = new Form_Login();
        if ($this->_request->getParam('message')) {
            $this->view->message = $this->_request->getParam('message');
        }
        $scope = $this->_request->getParam("scope", "user_status");
        if ($scope == "publish_stream")
            $scope = 'user_status, publish_stream';

        switch ($type) {
            case 'local':
                if ($this->getRequest()->isPost()) {
                    if ($this->view->form->isValid(
                                    $this->getRequest()
                                            ->getParams())) {
                        $authAdapter = new My_Login_AuthAdapterDoctrine(
                                $this->getRequest()->getParams());
                        $result = $this->_auth->authenticate($authAdapter);
                       
                        if ($result->isValid()) {
                            $this->_helper->flashMessenger->addMessage('El usuario ' .
                                    $this->_auth->getIdentity()->nick .
                                    ' se ha logueado correctamente.');
                            return $this->_redirect($origin);
                        } else {
                            $this->_helper->flashMessenger->addMessage('No se ha podido loguear. Verifica tus credenciales.');
                            return $this->_redirect($origin);
                        }
                    }
                }
                break;
            case 'facebook':

                $origin = $this->_request->getHeader('referer');
                $appId = $this->config->facebook->appId;
                $secret = $this->config->facebook->consumerSecret;
                $redirectUri = $this->config->facebook->redirectUri;
                // $scope = 'user_status, publish_stream';
                // Create the authentication adapter.
                $adapter = new My_Adapter_Facebook($appId, $secret, $redirectUri, $scope);
                // Get an authenticator instance
                $auth = Zend_Auth::getInstance();
                // This call will automatically redirect to facebook with the passed parameters.
                $result = $auth->authenticate($adapter);
                if (!$result->isValid()) {
                    $this->_helper->flashMessenger->addMessage('Problemas autenticando con facebook.');
                } else {
                    $this->_helper->flashMessenger->addMessage('Se ha logueado correctamente.');
                }

                return $this->_redirect("$origin");
                break;
            case 'twitter':
                $consumerKey = $this->config->twitter->appId;
                $consumerSecret = $this->config->twitter->consumerSecret;
                $callbackUrl = $this->config->twitter->redirectUri;
                $adapter = new My_Adapter_Twitter();
                $adapter->setConsumerKey($consumerKey)
                        ->setConsumerSecret($consumerSecret)
                        ->setCallbackUrl($callbackUrl);
                if (isset($_GET)) {
                    $adapter->setQueryData($_GET);
                }
                $auth = Zend_Auth::getInstance();
                $result = $auth->authenticate($adapter);
                if ($result->isValid()) {
                    $this->_helper->flashMessenger->addMessage('Se ha conectado exitosamente.');
                    return $this->_redirect($origin);
                } else {
                    $this->_helper->flashMessenger->addMessage('No se ha podido conectar con Twitter.');
                    return $this->_redirect($origin);
                }
                break;
        }
    }

    public function logoutAction() {
        $this->_helper->flashMessenger->addMessage('Usuario Desconectado.');
        $this->_auth->clearIdentity();
        $ns = 'auth';
         $carrito = new Zend_Session_Namespace('carrito');
        $carrito->unsetAll();
        return $this->_redirect("/");
    }

    public function registerAction() {
        $form = new Form_UsuarioFront();
        $newUser = new Usuario();
        $origin = $this->_request->getHeader('referer');

        if ($this->_request->isPost()) {
            $data = $this->_request->getPost();
            if ($form->isValid($data)) {

                $post = new Post();
                $post->usuarioId = Zend_Auth::getInstance()->getIdentity()->id ? Zend_Auth::getInstance()->getIdentity()->id : 1;
                $date = Zend_Date::now();
                $post->fechaCreacion = $date->toString("yyyy-MM-dd HH:mm:ss");
                $post->borrado = "N";
                $post->save();

                $newUser->nick = $data['nick'];
                $newUser->nombre = $data['nombre'];
                $newUser->apellido = $data['apellido'];
                $newUser->password = md5($data['clave']);
                $newUser->email = $data['email'];
                $newUser->blockeado = 'Y';
                $newUser->Post = $post;
                $newUser->Perfil = Doctrine_Core::getTable("Perfil")->find("USER");
                $newUser->alta = $date->toString("yyyy-MM-dd HH:mm:ss");
                $mensaje = "Se ha registrado correctamente. </br> Verifique su casilla de Email";
                try {
                    $newUser->save();
                } catch (Exception $e) {
                    $mensaje = $e->getMessage();
                    $this->_helper->flashMessenger->addMessage($mensaje);
                    return $this->_redirect($origin);
                }
                $this->_helper->flashMessenger->addMessage($mensaje);


                $transport = new Zend_Mail_Transport_Smtp();
                Zend_Mail::setDefaultTransport($transport);

                // mandar email!!
                $mail = new Zend_Mail();
                $mail->setBodyHtml('Gracias por registrarte en mejorunlibro.com </br>
			    Has click en el siguiente link para validar tu usuario.</br>
			    <a href="http://mejorunlibro.com/usuario/validar/hash/' . $newUser->validationHash . '/nick/' . $newUser->nick . '">Validar</a>');
                $mail->setFrom('noreply@mejorunlibro.com', 'mejor Un Libro');
                $mail->addTo($newUser->email, 'Some Recipient');
                $mail->setSubject('Mejor Un Libro - Nuevo Usuario');
                $mail->send();

                $origin = $this->_request->getHeader('referer');
                return $this->_redirect($origin);
            } else {
                $this->_helper->flashMessenger->addMessage('Ha ocurrido un problema. Intente nuevamente.');
                $origin = $this->_request->getHeader('referer');
                return $this->_redirect($origin);
            }
        }
    }

    public function addAction() {
        $this->view->form = new Form_Usuario($this->_auth->getIdentity());
    }

    public function deleteAction() {
        $key = $this->_request->getparam('key', '');
        $usuario = Doctrine_Core::getTable('Usuario')->find($key);
        //Zend_Debug::dump($libro->Post);die;
        $usuario->Post->borrado = "Y";
        $result = $usuario->save();
        if ($result)
            $this->_helper->flashMessenger->addMessage('Usuario borrado correctamente.');
        else
            $this->_helper->flashMessenger->addMessage('Problemas al borrar Usuario.');

        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_response->setBody(json_encode(array('result' => 'true')));
        $this->_response->outputBody();
        exit;
    }

    public function validarAction() {

        $hash = $this->_request->getparam('hash', '');
        $email = $this->_request->getparam('email', '');

        if (!$email || !$hash) {
            $this->_helper->flashMessenger->addMessage('validacion incorrecta');
            return $this->_redirect("/");
        }

        $respuesta = Usuario::validarUsuario($email, $hash);
        if ($respuesta) {

            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Se ha validado correctamente el usuario');
        } else {
            $this->_helper->flashMessenger->setNamespace('error')->addMessage('No se ha podido validar el usuario');
        }

        return $this->_redirect("/");
    }

    public function verificarNickAction() {
        $nick = $this->_request->getparam('nick', '');
        $result = Usuario::verificarNick($nick);
        $response = $result ? 'true' : 'false';
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_response->setBody(json_encode(array('result' => $response)));
        $this->_response->outputBody();
        exit;
    }
    


}
