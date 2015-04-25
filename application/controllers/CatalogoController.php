<?php

class CatalogoController extends My_Controller_Sabios {

    public function indexAction() {
        
    }

    public function productoAction() {



        //My_Function_Function::sendEmail(array("bodytext" => "body text!", "subject" => "test de prueba", "email" => "liderguitar@gmail.com", "name" => "Liderguitar" ));

        $this->view->id = $id = $this->_request->getParam('id', false);
        $id = $this->_request->getParam('id', false);
        $this->view->pagosTipos = Doctrine_Query::create()
                        ->from("PagoTipo p")
                        ->where("p.borrado = 'N' and p.app_id='" . APPLICATION_ID . "'")->execute()->toArray();
        $this->view->pts = $this->getpts();

        $query = Doctrine_Query::create()
                ->from("ProductoTextil pt")
                ->leftjoin("pt.Producto p")
                ->leftjoin("p.Categoria sc")
                ->leftjoin("p.FotosPorProducto fxp")
                ->leftJoin("fxp.Foto")
                ->where("p.borrado = 'N' and p.app_id='" . APPLICATION_ID . "'");
        $producto = Doctrine_Query::create()
                        ->from("ProductoTextil pt")
                        ->leftjoin("pt.Producto p")
                        ->leftjoin("p.Categoria sc")
                        ->leftjoin("p.FotosPorProducto fxp")
                        ->leftJoin("fxp.Foto")
                        ->where("p.borrado = 'N' and p.app_id='" . APPLICATION_ID . "' and p.id=" . $id)->execute()->toArray();

        $this->view->productoTextilId = $producto[0]['id'];

        $pi = $this->getPage($query, $this->view->productoTextilId);
        $page = $pi['page'];
        $this->view->index = $pi['index'];
        $this->view->count = $pi['count'];
        $this->view->page = $this->_request->getParam('page', 0);
        $this->view->productos = $pi['result'];
        $paginator = new Zend_Paginator(new My_Paginator($query));
        $paginator->setItemCountPerPage(18);
        $paginator->setCurrentPageNumber($page);
        $this->view->objects = $paginator;



        $this->view->producto = count($producto) ? $producto[0] : false;
        $this->view->stock = ProductoTextil::getTallesPorProducto2($this->view->productoTextilId);
        // My_Function_Function::var_debug($this->view->stock );
        $this->view->bread = My_Function_Function:: getCategoriasBread($this->view->producto["Producto"]["Categoria"]["id"]);
        //My_Function_Function::var_debug($bread);
        // My_Function_Function::var_debug($this->view->producto);
        if ($this->_request->isPost()) {
            $id = $this->_request->getParam('id', false);
        }
    }

    private function getPage($query, $id) {

        $result = $query->execute()->toArray();
        //My_Function_Function::var_debug($result);
        if (!count($result))
            return false;

        $count = 1;
        foreach ($result as $res) {

            if ($res['Producto']['id'] == $id) {
                break;
            }
            $count++;
        }

        return array(
            'page' => ceil($count / 18),
            'index' => $count - 1,
            'count' => count($result),
            'result' => $result);
    }

    public function categoriaAction() {

        if(APPLICATION_ID == 'home'){
            header('Location: /home');
        }
        if(APPLICATION_ID == 'admin'){
            header('Location: /superadmin/list');
        }


        $this->view->id = $id = $this->_request->getParam('id', false);
        $cats = array();
        if (!$id) {
            $q = Doctrine_Query::create()
                            ->from("Categoria c")
                            ->where("c.borrado = 'N' and c.app_id='" . APPLICATION_ID . "'")->fetchArray();
            foreach ($q as $cat) {
                $cats[] = $cat['id'];
            }
        } else {
            $cats = My_Function_Function::getCatChildren($id);
            $cats[] = $id;
        }


        $str = "";

        foreach ($cats as $cat) {
            $str .= $cat . ",";
        }
        
        
        $str = substr($str, 0, strlen($str) - 1);
        //die($str);
        $query = Doctrine_Query::create()
                ->from("ProductoTextil pt")
                ->leftjoin("pt.Producto p")
                ->leftjoin("p.Categoria sc")
                ->leftjoin("p.FotosPorProducto fxp")
                ->leftJoin("fxp.Foto")
                ->where("p.borrado = 'N' and p.app_id='" . APPLICATION_ID . "'");
        
        if(count($cats)) {
            $query->andWhere("id_subcategoria in (" . $str . ")");
        }
        
        

        //  My_Function_Function::var_debug($query->fetchArray()); 

        $adapter = new My_Paginator($query);


        $this->view->page = $this->_request->getParam('page');
        $this->view->bread = My_Function_Function:: getCategoriasBread($id);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(16);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
    }

    public function carritoAction() {

        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        if ($this->_request->isPost()) {
            $data = $this->_request->getParam('data');
            $carrito = new Zend_Session_Namespace('carrito');
            if (!isset($carrito->carrito)) {
                $carrito->carrito = array();
            }
            $carrito->carrito[$data[0]['id']]['codigo'] = $data[0]['codigo'];
            $carrito->carrito[$data[0]['id']]['nombre'] = $data[0]['nombre'];
            $carrito->carrito[$data[0]['id']]['precio'] = $data[0]['precio'];
            $carrito->carrito[$data[0]['id']]['stock'] = $data[0]['stock'];

            $this->getResponse()
                    ->appendBody(json_encode(array('success' => true, 'message' => '', 'data' => $carrito->carrito)));
        }
    }

    public function getcarritoAction() {
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $carrito = new Zend_Session_Namespace('carrito');
        if (!isset($carrito->carrito)) {
            $this->getResponse()
                    ->appendBody(json_encode(array('success' => false, 'message' => 'No hay Carrito', 'data' => false)));
        }

        $this->getResponse()
                ->appendBody(json_encode(array('success' => true, 'message' => '', 'data' => count($carrito->carrito) ? $carrito->carrito : false)));
    }

    public function borrarcarritoAction() {


        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $carrito = new Zend_Session_Namespace('carrito');
        if (!isset($carrito->carrito)) {
            $this->getResponse()
                    ->appendBody(json_encode(array('success' => false, 'message' => 'No hay Carrito', 'data' => false)));
        }
        $id = $this->_request->getParam('id', false);
        unset($carrito->carrito[$id]);
        $this->getResponse()
                ->appendBody(json_encode(array('success' => true, 'message' => '', 'data' => count($carrito->carrito) ? $carrito->carrito : false)));
    }

    public function confirmarcarritoAction() {

        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $fdp = $this->_request->getParam('fdp', false);
        //  die($fdp);
        $fdpPorc = Doctrine_Query::create()
                        ->from("PagoTipo")
                        ->where("app_id='" . APPLICATION_ID . "' and id=" . $fdp)->fetchOne();
        // My_Function_Function::var_debug($fdpPorc->toArray());


        $carrito = new Zend_Session_Namespace('carrito');
        if (!isset($carrito->carrito) || !count($carrito->carrito)) {
            $this->getResponse()
                    ->appendBody(json_encode(array('success' => false, 'message' => 'No hay Carrito', 'data' => false)));
        }

        $venta = new Venta;
        $venta->app_id = APPLICATION_ID;
        $venta->formaDePagoId = $fdp;

        $tppt = Doctrine_Query::create()
                        ->from("Cliente")
                        ->where("usuario_id=" . $this->_user_id)->fetchOne();




        $venta->clienteId = 14; //$this->_user_id; // buscar cliente y poner aca
        $venta->formaDePagoPorc = $fdpPorc->interes;
        $venta->ventaEstadoId = 2;
        $venta->save();
        $ventaId = $venta->id;
        foreach ($carrito->carrito as $prodid => $item) {

            foreach ($item['stock'] as $talle) {

                // hacer el update de stock
                $tppt = Doctrine_Query::create()
                                ->from("TallePorProductoTextil")
                                ->where("id=" . $talle['talle']['id'])->fetchOne();

                $tppt->stock = $tppt->stock - $talle['stock'];
                $tppt->save();
                $vd = new VentaDetalle();
                $vd->ventaId = $ventaId;
                $vd->productoTextilId = $prodid;
                $vd->cantidad = $talle['stock'];
                $vd->tallePorProductoTextil = $talle['talle']['id'];
                // TODO buscar el presio y plicarle el tipo de pago aqui



                $vd->precioUnitario = $item['precio'];
                $vd->save();
            }
        }

        unset($carrito->carrito);
        $this->getResponse()
                ->appendBody(json_encode(array('success' => true, 'message' => 'Se guardo el pedido. Se ha enviado un Email a su cuenta', 'data' => false)));
    }

    private function getpts() {

        $pts = Doctrine_Query::create()
                        ->from("PagoTipo p")
                        ->where("p.borrado = 'N' and p.app_id='" . APPLICATION_ID . "'")->execute()->toArray();
        $ret = array();
        foreach ($pts as $pt) {
            $ret[$pt['id']] = (100 + $pt['interes']) / 100;
        }
        return $ret;
    }

    public function registroAction() {

        $this->view->clientesTipo = Doctrine_Core::getTable('ClienteTipo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
        if ($this->_request->isPost()) {
            // var_dump($this->_request->getPost());die;
            $cat = new Cliente();
            $cat->app_id = APPLICATION_ID;
            $cat->nombre_comercial = $this->_request->getParam('nombre');
            $cat->tipo = $this->_request->getParam('tipo_cliente_id');
            $cat->empresa_de_preferencia = $this->_request->getParam('empresa_preferencia', '');
            $cat->asegurado = $this->_request->getParam('porcentaje_asegurado', 0);
            $cat->direccion_de_envio = $this->_request->getParam('direccion_envio', '');
            $cat->estado_id = $this->_request->getParam('id_estado', 0);
            $cat->enviar_a_nombre_de = $this->_request->getParam('enviar_nombres', '');

            $fecha = new Zend_Date();
            $cat->fecha_alta = $fecha->get('yyyy-MM-dd HH:mm:ss');

            // TODO: revisar q no exista el mismo mail
            $user = new Usuario();
            $user->email = $this->_request->getParam('email');
            $user->password = md5($this->_request->getParam('password'));
            $user->app_id = APPLICATION_ID;
            $user->perfil = 'USER';
            $user->blockeado = 'Y';
            $user->validationHash = md5($this->_request->getParam('email') . $this->_request->getParam('nombre'));
            $cat->usuario_id = $user->id;
            $personales = $this->_request->getParam('personal', null);

            if (is_array($personales)) {
                foreach ($personales as $personal) {
                    // var_dump($personal);die;
                    if ($personal['nombre'] == '')
                        continue;
                    $per = new Personal();
                    $per->app_id = APPLICATION_ID;
                    $per->nombre_apellido = $personal['nombre'];
                    $per->cargo = $personal['cargo'];
                    $per->telefono1 = $personal['telefono1'];
                    try {
                        $per->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                    $pxc = new PersonalPorCliente();
                    $pxc->Cliente = $cat;
                    $pxc->Personal = $per;
                    try {

                        $pxc->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                }
            }
            try {
                $cat->save();
            } catch (Exception $e) {
                die($e->getMessage());
            }
            $user->save();
            $this->saveAuditoria($cat->id);
            $personales = $this->_request->getParam('personal', null);
            if (is_array($personales)) {
                foreach ($personales as $personal) {
                    // var_dump($personal);die;
                    if ($personal['nombre'] == '')
                        continue;
                    $per = new Personal();
                    $per->app_id = APPLICATION_ID;
                    $per->nombre_apellido = $personal['nombre'];
                    $per->cargo = $personal['cargo'];
                    $per->telefono1 = $personal['telefono1'];
                    $per->telefono2 = $personal['telefono2'];
                    $per->email1 = $personal['email1'];
                    $per->email2 = $personal['email2'];
                    $per->dia_nacimiento = $personal['dia_nacimiento'];
                    $per->mes_nacimiento = $personal['mes_nacimiento'];
                    try {
                        $per->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                    $pxc = new PersonalPorCliente();
                    $pxc->Cliente = $cat;
                    $pxc->Personal = $per;
                    try {
                        $pxc->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                }
            }
            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Registrado. Revise su Email');
            // My_Function_Function::sendEmail($options);
            My_Function_Function::sendEmail(
                    array(
                        "bodytext" => "Bienvenido a ".APPLICATION_NAME.". Haga click en el siguiente enlace para activar su cuenta. <a href='http://".$_SERVER['SERVER_NAME']."/usuario/validar?hash=".$user->validationHash."&email=".$user->email."'>Validar Usuario</a>",
                        "subject" => "Registro en Sabios",
                        "email" => $this->_request->getParam('email'),
                        "name" => $this->_request->getParam('nombre'))
            );

            return $this->_redirect("/");
        }
        //dump($this->view->clientesTipo->toArray());
    }

    
    public function validaremailAction(){
        
        $resp = false;
        $this->_helper->layout()->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        
        $email = $this->_request->getParam('email', false);
       
        $user = Doctrine_Core::getTable("Usuario")->findByDql("email='".$email."'");

       // dump($user->toArray());
        if(count($user->toArray())){
            $resp = false;
        } else  
        {
            $resp = true;
        }

         $this->getResponse()
                ->appendBody(json_encode(array('success' => $resp, 'message' => '', 'data' => false)));       
        
    }
    
    public function novedadesAction() {

        $novedades = Doctrine_Query::create()
                        ->from("Novedad n")
                        ->where("n.borrado = 'N' and n.app_id='" . APPLICATION_ID . "'")->execute()->toArray();


        $positions = array(1, 2, 3, 4, 5, 6, 7, 8, 9);
        $novedadesview = array();
        foreach ($positions as $pos) {
            foreach ($novedades as $nov) {
                if ($nov['posicion'] == $pos) {
                    $novedadesview[$pos] = $nov;
                }
            }
        }
        $this->view->novedades = $novedadesview;
    }    
}