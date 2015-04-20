<?php

class IndexController extends My_Controller_Sabios {

    private $_session;

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();

        // $this->view->user = $this->_auth->getIdentity()->nombre;
    }

    public function indexAction() {

        return $this->_redirect("/catalogo/categoria");
    }

    public function generatemodelsAction() {
Zend_Debug::dump(Doctrine_Core::generateModelsFromDb(APPLICATION_PATH.  '/models',array('doctrine'),array('generateTableClasses' => true)));die;
        die;
    }

    public function adminAction() {
//  	Zend_Debug::dump(Doctrine_Core::generateModelsFromDb(APPLICATION_PATH.  '/models',array('doctrine'),array('generateTableClasses' => true)));
//die;

        $this->view->clientes =
            Doctrine_Query::create()
                ->from("Cliente c")
                ->leftJoin('c.ClienteTipo ct')
                ->leftJoin('c.ClienteEstado ce')
                ->where("c.borrado = 'N' and app_id='" . APPLICATION_ID . "'")->orderBy("c.id desc")->limit(5)->execute();


        $this->view->ventas = Doctrine_Query::create()
            ->from("Venta v")
            ->leftJoin("v.Cliente c")
            ->leftJoin("v.PagoTipo f")
            ->leftJoin("v.VentaEstado ve")
            ->leftJoin("v.VentaDetalle vd")
            ->leftJoin("v.Vendedor vn")
            ->leftJoin("vd.ProductoTextil pt")
            ->leftJoin("pt.Producto")
            ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"')
            ->andWhere("")->orderBy("v.id desc")->limit(5)->execute();

        $this->view->contactsuccess = $this->_request->getParam('contactsuccess', false);
    }

    public function authorizeAction() {

        $response = My_Service_Sabios::authorize();
        die(var_dump(json_decode($response)));
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

}