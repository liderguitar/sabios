<?php

class HomeController extends My_Controller_Sabios {

    private $_adapter = null;
    private $_registerSession;
    private $_twitter_session;

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        $this->_registerSession = new Zend_Session_Namespace('register');
        parent::init();
    }

    public function indexAction(){

//  	Zend_Debug::dump(Doctrine_Core::generateModelsFromDb(APPLICATION_PATH.  '/models',array('doctrine'),array('generateTableClasses' => true)));
//die;
        $this->view->contactsuccess = $this->_request->getParam('contactsuccess', false);
    }

    public function authorizeAction() {
        
    }

    public function registerAction() {


        $errors = false;
        $config = new Zend_Config_Ini(APPLICATION_PATH . DIRECTORY_SEPARATOR . 'configs' . DIRECTORY_SEPARATOR . 'application.ini', 'production');

        if ($this->_request->isPost()) {

            $data = $this->_request->getParams();
            //var_dump($data);die;


            if (!Application::isNameAvailable($data['cuenta'])) {
                $errors = true;
                $this->_helper->flashMessenger->setNamespace('error')->addMessage("Nombre de cuenta no disponible");
            }

            if (!Usuario::isAvailableEmail($data['email'])) {
                $errors = true;
                $this->_helper->flashMessenger->setNamespace('error')->addMessage("Email no disponible. Pruebe con otro");
            }

            if ($errors) {
                $this->_registerSession->data = $data;
                return $this->_redirect("/home/register");
            }

            $date = Zend_Date::now();
            $app = new Application();
            $app->app_id = md5($date->toString("yyyy-MM-dd HH:mm:ss") . $data['cuenta']);
            $app->nombre = $data['cuenta'];
            $app->subdominio = strtolower($data['cuenta']);
            $app->tipo_actividad = $data['tipoactividad'];
            $app->web = $data['web'];
            $app->estado = 'OFFLINE';
            $app->responsable_nombre = $data['responsablenombre'];
            $app->responsable_email = $data['responsableemail'];
            $app->responsable_telefono = $data['responsabletelefono'];
            $app->responsable_direccion = $data['responsabledireccion'];
            $app->save();

            // insertar categorias y talles por defecto

            $this->generarTallesPorDefecto($app->app_id);
            $this->generarCategoriasPorDefecto($app->app_id);

            $newUser = new Usuario();
            //$newUser->nick = $data['nick'];
            $newUser->nombre = $data['nombre'];
            $newUser->app_id = $app->app_id;
            $newUser->apellido = $data['apellido'];
            $newUser->password = md5($data['password']);
            $newUser->email = $data['email'];
            $newUser->blockeado = 'Y';
            $newUser->Perfil = Doctrine_Core::getTable("Perfil")->find("ADMIN");


            $newUser->alta = $date->toString("yyyy-MM-dd HH:mm:ss");
            try {
                $newUser->save();
            } catch (Exception $e) {
                $errors = true;
                $mensaje = $e->getMessage();
                $this->_helper->flashMessenger->setNamespace('error')->addMessage($mensaje);
            }

            My_Function_Function::sendEmail(
                array(
                    "bodytext" => "Estimado " . $data['nombre'] . " " . $data['apellido'] . ", <br>
              &#161;Bienvenido a Sabios&#33; Por favor haga click en el siguiente link para confirmar su cuenta SABBIOS gratuita:<br>
              <a href='http://sabbios.com/usuario/validar/hash/" . $newUser->validationHash . "/email/" . $data['email'] . "'>
              http://sabbios.com/usuario/validar/hash/" . $newUser->validationHash . "/email/" . $data['email'] . "</a><br>
              Un administrador activar&aacute: tu cuenta despues de eso <br>
              <a href='http://".$app->subdominio.".sabbios.com/'>Ver Sitio</a><br>
              <a href='http://".$app->subdominio.".sabbios.com/admin'>Administrar</a>
              Saludos Cordiales<br>
              <a href='http://sabbios.com'>SABBIOS</a><br>
              <a href='http://sabbios.com/home/condiciones'>Condiciones</a> <a href='http://sabbios.com/home/privacidad'>Privacidad</a>",
                    "subject" => "Registro en Sabbios",
                    "email" => $data['email'],
                    "name" => $newUser->nombre
            ));

            My_Function_Function::sendEmail( array(
                "bodytext" => "Se ha registrado  " . $data['nombre'] . " " . $data['apellido'] . ", <br>
              con la cuenta: <a href='http://".$app->subdominio.".sabbios.com/'></a><br>
              Saludos Cordiales<br>",
                "subject" => "Nueva Cuenta Registro en Sabbios",
                "email" => $config->superadmin->email,
                "name" => $newUser->nombre
            ));

            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Verifique su casilla de email para confirmar su registro.');
            return $this->_redirect("/home/?success=1");
        } else {
            if (isset($this->_registerSession->data)) {
                $this->view->nombre = $this->_registerSession->data['nombre'];
                $this->view->apellido = $this->_registerSession->data['apellido'];
                $this->view->email = $this->_registerSession->data['email'];
                $this->view->cuenta = $this->_registerSession->data['cuenta'];
                $this->view->web = $this->_registerSession->data['web'];
                $this->view->tipoactividad = $this->_registerSession->data['tipoactividad'];
                $this->view->responsablenombre = $this->_registerSession->data['responsablenombre'];
                $this->view->responsabletelefono = $this->_registerSession->data['responsabletelefono'];
                $this->view->responsableemail = $this->_registerSession->data['responsableemail'];
                $this->view->responsabledireccion = $this->_registerSession->data['responsabledireccion'];
            }
        }
    }

    public function validarAction() {

        $hash = $this->_request->getparam('hash', '');
        $email = $this->_request->getparam('email', '');

        if (!$hash || !$email) {
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

    public function contactAction() {
        if ($this->_request->isPost()) {

            $data = $this->_request->getParams();
            $transport = new Zend_Mail_Transport_Smtp();
            Zend_Mail::setDefaultTransport($transport);

            $html = "Nombre: "
                    . $data['nombre'] . "<br>Apellido: "
                    . $data['apellido'] . "<br>Email: "
                    . $data['email'] . "<br>Cometarios: "
                    . $data['comentarios'];

            $mail = new Zend_Mail();
            $mail->setBodyHtml($html);
            $mail->setFrom($data['email'], 'Sabios');
            $mail->addTo('info@sabbios.com', 'Contacto');
            $mail->setSubject('Sabbios - Contacto');
            $mail->send();
            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Gracias por contactarse con nosotros.');
            return $this->_redirect("/?contactsuccess=true");
        }
    }

    public function investAction() {
        if ($this->_request->isPost()) {
            $data = $this->_request->getParams();

            $transport = new Zend_Mail_Transport_Smtp();
            Zend_Mail::setDefaultTransport($transport);
            $html = "Nombre: "
                    . $data['nombre'] . "<br>Apellido: "
                    . $data['apellido'] . "<br>Email: "
                    . $data['email'] . "<br>Intereses: "
                    . $data['intereses'] . "<br>Preguntas: "
                    . $data['preguntas'];

            $mail = new Zend_Mail();
            $mail->setBodyHtml($html);
            $mail->setFrom($data['email'], 'Sabios');
            $mail->addTo('info@sabbios.com', 'Inversores');
            $mail->setSubject('Sabbios - Inversores');
            $mail->send();
            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Gracias por contactarse con nosotros.');
            return $this->_redirect("/?contactsuccess=true");
        }
    }

    public function searchAction() {
        $this->view->page = $this->_request->getParam('page');
        $this->view->terms = $this->_request->getParam('terms', false);
        $this->view->genero = $this->_request->getParam('genero', false);

        $this->view->columnaUno = Articulo::getColumnArticleOne();
        $this->view->columnaDos = Articulo::getColumnArticleTwo();

        $origin = $this->_request->getHeader('referer');

        if ($this->_request->isPost() || $this->view->terms) {



            if ($this->view->terms) {
                $data['filtro_titulo'] = $this->view->terms;
                $this->view->search = $this->view->terms;
            } else {

                $data = $this->_request->getPost();
                if (!isset($data['input-search'])) {
                    return $this->_redirect("/");
                }


                $data['filtro_titulo'] = $data['input-search'];
                $this->view->search = $data['input-search'];
            }
            $libro = new Libro();
            $data['publicado'] = true;
            //var_dump($data);die;

            $result = $libro->getAllQuery($data)->execute();
            if (!count($libro->getAllQuery($data)->execute()->toArray())) {
                $this->_helper->flashMessenger->addMessage("No se han encontrado resultados");
                return $this->_redirect("/");
            }

            // PAGINATOR
            $adapter = new My_Paginator($libro->getAllQuery($data));
            $paginator = new Zend_Paginator($adapter);
            $paginator->setItemCountPerPage(10);
            $paginator->setCurrentPageNumber($this->view->page ? $this->view->page : 1);
            $this->view->librosSearch = $paginator;
            // FIN PAGINATOR				
        } else {

            return $this->_redirect("/");
        }
    }

    public function contactoAction() {
        $origin = $this->_request->getHeader('referer');
        $form = new Form_Presupuesto();
        if ($this->_request->isPost()) {
            $data = $this->_request->getPost();
            if ($form->isValid($data)) {

                $transport = new Zend_Mail_Transport_Smtp();
                Zend_Mail::setDefaultTransport($transport);

                // mandar email!!
                $mail = new Zend_Mail();
                $mail->setBodyHtml($this->_armarMailDeContacto($data));
                $mail->setFrom($data['email'], 'mejor Un Libro');
                $mail->addTo('contacto@mejorunlibro.com', 'contacto');
                $mail->setSubject('Mejor Un Libro - Consulta');
                $mail->send();
                $this->_helper->flashMessenger->addMessage('Gracias por Contactarse con nosotros.');
            } else {
                $this->_helper->flashMessenger->addMessage('Ha ocurrido un problema. Intente nuevamente.');
            }

            return $this->_redirect($origin);
        }
    }

    public function forgotpasswordAction() {
        if ($this->_request->isPost()) {

            $email = $this->_request->getParam('email', false);
            $user = Usuario::getUserByEmail($email);
            if (!$user) {
                $this->_helper->flashMessenger->setNamespace('error')->addMessage('Email no registrado');
                $this->view->email = $email;
            } else {

                $user->blockeado = 'Y';

                $date = Zend_Date::now();
                $fecha = $date->toString("yyyy-MM-dd HH:mm:ss");
                $user->validationHash = md5($email . $fecha);
                $user->save();
                My_Function_Function::sendEmail(
                        array(
                            "bodytext" => "aga click en el siguiente enlace para Resetear su contrase&nacute;a . <a href='http://" . $_SERVER['SERVER_NAME'] . "/home/resetpassword?hash=" . $user->validationHash . "&email=" . $user->email . "'>Validar</a>",
                            "subject" => "Registro en Sabios",
                            "email" => $email,
                            "name" => "")
                );
                $this->_helper->flashMessenger->setNamespace('success')->addMessage('Se ha enviado un mail con un link para cambiar la clave');
            }
        }
    }

    public function resetpasswordAction() {

        $email = utf8_decode($this->_request->getParam('email', FALSE));
        $hash = utf8_decode($this->_request->getParam('hash', FALSE));
        if (!$email || !$hash) {
            $this->_helper->flashMessenger->setNamespace('error')->addMessage('Url no v&aacute;lida.');
            return $this->_redirect("/home");
        }
        if ($this->_request->isPost()) {
            $data = $this->_request->getPost();
            $respuesta = Usuario::validarUsuario($data['email'], $data['hash']);
            if ($respuesta) {
                $user = Doctrine_Query::create()
                        ->from("Usuario U")
                        ->where("U.email = ?", $data['email'])
                        ->andWhere("U.validationHash = ?", $data['hash'])->fetchOne();
                $user->password = md5($data['hash']);
                $user->save();

                $this->_helper->flashMessenger->setNamespace('success')->addMessage('Se ha reestablecido su contrase&ntilde;a');
            } else {
                $this->_helper->flashMessenger->setNamespace('error')->addMessage('No se ha podido reestabler su contrase&ntilde;a');
            }

            return $this->_redirect("/home");
        } else {
            $this->view->email = $email;
            $this->view->hash = $hash;
        }
    }

    public function resetAction() {
        $origin = $this->_request->getHeader('referer');

        $nick = utf8_decode($this->_request->getParam('nick'));
        $hash = $this->_request->getParam('hash', false);

        $usuario = Usuario::getUserByNick($nick);

        if ($this->_request->isPost()) {

            $data = $this->_request->getPost();
            if (!isset($data['nick']) || !isset($data['clave']) || !isset($data['repitePassword'])) {
                $this->_helper->flashMessenger->addMessage('Datos no v&aacute;lidos.');
                return $this->_redirect($origin);
            }
            $usuario = Usuario::getUserByNick($data['nick']);
            $usuario->password = md5($data['clave']);
            $usuario->save();
            $this->_helper->flashMessenger->addMessage('Ha cambiado su clave con exito.');

            return $this->_redirect("/");
        }

        if ($hash) {

            $result = Usuario::validarUsuario($usuario->nick, $usuario->validationHash);
            $this->_session->resetPassword = true;
            $this->_session->usuario = $usuario->nick;
            // aqui cambiar la clave!!
            return $this->_redirect("/");
        } else {

            if (!$usuario) {
                $this->_helper->flashMessenger->addMessage('Usuario inexistente.');
            } else {

                $date = Zend_Date::now();
                $fecha = $date->toString("yyyy-MM-dd HH:mm:ss");
                $result = count($usuario->toArray());
                $usuario->validationHash = md5($usuario->nick . $usuario->email . $fecha);
                $usuario->blockeado = 'Y';
                $usuario->save();


                $transport = new Zend_Mail_Transport_Smtp();
                Zend_Mail::setDefaultTransport($transport);
                // die("<a href='/index/reset/nick/".$usuario->nick."/hash/" . $usuario->validationHash . "'>Haz click aqu&iacute;</a>");
                // mandar email!!
                $mail = new Zend_Mail();
                $mail->setBodyHtml(
                        "<a href='http://mejorunlibro.com/index/reset/nick/" . $usuario->nick . "/hash/" . $usuario->validationHash . "'>Haz click aqu� para cambiar tu password</a>"
                );
                $mail->setFrom('noreply@mejorunlibro.com', 'mejor Un Libro');
                $mail->addTo($usuario->email, 'Reset password');
                $mail->setSubject('Mejor Un Libro - Reset Password');
                $mail->send();

                $this->_helper->flashMessenger->addMessage('En tu email hay un link para cambiar la clave.');
            }
        }
        return $this->_redirect($origin);
    }

    public function condicionesAction() {
        
    }

    private function _armarMailDeContacto($data) {
        $text = "";
        $text.= isset($data['nombre']) ? "Nombre: " . $data['nombre'] . "<br/>" : "";
        $text.= isset($data['apellido']) ? "Apellido: " . $data['apellido'] . "<br/>" : "";
        $text.= isset($data['email']) ? "Email: " . $data['email'] . "<br/>" : "";
        $text.= isset($data['direccion']) ? "Direcci&oacute;n: " . $data['direccion'] . "<br/>" : "";
        $text.= isset($data['localidad']) ? "Localidad:" . $data['localidad'] . "<br/>" : "";
        $text.= isset($data['codigoPostal']) ? "C.P:" . $data['codigoPostal'] . "<br/>" : "";
        $text.= isset($data['provincia']) ? "Provincia: " . $data['provincia'] . "<br/>" : "";
        $text.= isset($data['telefono']) ? "Tel&eacute;fono: " . $data['telefono'] . "<br/>" : "";
        $text.= "<br/>" . $data['consulta'];

        return $text;
    }

    public function getChild($level, $parent = 0) {

        $array = array();
        $rec = Doctrine_Core::getTable('CategoriaTree')->findByDql('parent_id=' . $parent)->toArray();
        foreach ($rec as $item) {
            $array[$level]['item'] = $item;
            $children = $this->getChild($level + 1, $item['id']);
            if (count($children))
                $array[$level][] = $children;
            $level++;
        }

        return $array;
    }

    public function privacidadAction() {
        
    }
    private function generarCategoriasPorDefecto($app_id){

        $prioridad = 1;
        $cat = new Categoria();
        $cat->app_id = $app_id;
        $cat->nombre = "Hombre";
        $cat->parent_id =0;
        $cat->save();

        $hombre_id = $cat->id;

        $prioridad ++;
        $cat2 = new Categoria();
        $cat2->app_id = $app_id;
        $cat2->nombre = "Mujer";
        $cat2->parent_id =0;
        $cat2->save();

        $mujer_id=$cat2->id;

        $hombre = array(
            "Remeras Mangas Cortas",
            "Musculosas",
            "Pantalones",
            "Zapatillas",
            "Boxer",
            "Camisas",
            "Mallas",
            "Buzos",
            "Camperas"
        );
        $mujer = array("Remeras Mangas Cortas",
            "Musculosas",
            "Mallas",
            "Buzos",
            "Camperas");

        $prioridad = 1;
        foreach($hombre as $h){
            $cat3 = new Categoria();
            $cat3->nombre = $h;
            $cat3->app_id = $app_id;
            $cat3->prioridad = $prioridad;
            $cat3->parent_id = $hombre_id;
            $cat3->save();
            $prioridad++;
        }

        $prioridad = 1;

        foreach($mujer as $h){
            $cat3 = new Categoria();
            $cat3->nombre = $h;
            $cat3->app_id = $app_id;
            $cat3->prioridad = $prioridad;
            $cat3->parent_id = $mujer_id;
            $cat3->save();
            $prioridad++;
        }

    }

    private function generarTallesPorDefecto($app_id){

        $tt = new TalleTipo();
        $tt->app_id = $app_id;
        $tt->descripcion = "XS al XXL";
        $tt->save();

        $talles = array( "XS", "S", "M", "L", "XL", "XXL");
        $prioridad = 1;
        foreach($talles as $tt){

            $t= new Talle();
            $t->app_id = $app_id;
            $t->prioridad = $prioridad;
            $t->id_tipo_talle = $tt->id;
            $t->talle = $tt;
            $t->save();
            $prioridad++;
        }

        $tt = new TalleTipo();
        $tt->app_id = $app_id;
        $tt->descripcion = "Numeros pares 6 al 16";
        $tt->save();

        $talles = array( 6, 8, 10, 12, 14, 16);
        $prioridad = 1;
        foreach($talles as $tt){

            $t= new Talle();
            $t->app_id = $app_id;
            $t->prioridad = $prioridad;
            $t->id_tipo_talle = $tt->id;
            $t->talle = $tt;
            $t->save();
            $prioridad++;
        }
        $tt = new TalleTipo();
        $tt->app_id = $app_id;
        $tt->descripcion = "Numeros pares 38 al 50";
        $tt->save();

        $talles = array( 38, 40, 42, 44, 46, 48, 50);
        $prioridad = 1;
        foreach($talles as $tt){

            $t= new Talle();
            $t->app_id = $app_id;
            $t->prioridad = $prioridad;
            $t->id_tipo_talle = $tt->id;
            $t->talle = $tt;
            $t->save();
            $prioridad++;
        }

        $tt = new TalleTipo();
        $tt->app_id = $app_id;
        $tt->descripcion = "Numeros del 34 al 50";
        $tt->save();

        $talles = array( 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50);
        $prioridad = 1;
        foreach($talles as $tt){

            $t= new Talle();
            $t->app_id = $app_id;
            $t->prioridad = $prioridad;
            $t->id_tipo_talle = $tt->id;
            $t->talle = $tt;
            $t->save();
            $prioridad++;
        }

    }

}

