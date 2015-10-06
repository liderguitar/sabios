<?php

class ClienteController extends My_Controller_Sabios {

    public function init() {
        $this->_auth = Zend_Auth::getInstance();
        parent::init();
    }

    public function addAction() {


        if ($this->_request->isPost()) {
            // var_dump($this->_request->getPost());die;
            $cat = new Cliente();
            $cat->app_id = APPLICATION_ID;
            $cat->nombre_comercial = $this->_request->getParam('nombre');
            $cat->tipo = $this->_request->getParam('tipo_cliente_id');
            $cat->telefono1 = $this->_request->getParam('telefono1');
            $cat->telefono2 = $this->_request->getParam('telefono2');
            $cat->sms1 = $this->_request->getParam('sms1', '');
            $cat->sms2 = $this->_request->getParam('sms2', '');
            $cat->sms3 = $this->_request->getParam('sms3', '');
            $cat->email1 = $this->_request->getParam('email1', '');
            $cat->email2 = $this->_request->getParam('email2', '');
            $cat->email3 = $this->_request->getParam('email3', '');
            $cat->empresa_de_preferencia = $this->_request->getParam('empresa_preferencia', '');
            $cat->asegurado = $this->_request->getParam('porcentaje_asegurado', 0);
            $cat->direccion_de_envio = $this->_request->getParam('direccion_envio', '');
            $cat->enviar_a_nombre_de = $this->_request->getParam('enviar_nombres', '');
            $cat->razon_social = $this->_request->getParam('razon_social', '');
            $cat->tipo_contribucion = $this->_request->getParam('tipo_contribucion');
            $cat->viajante_id = $this->_request->getParam('viajante_id');
            $cat->habilita_acceso_pedidos = $this->_request->getParam('acceso');
            $cat->direccion_facturacion = $this->_request->getParam('direccion_facturacion');
            $cat->observaciones = $this->_request->getParam('observaciones');
            //  $cat->habilita_acceso_pedidos = $this->_request->getParam('habilita_acceso_pedidos');
            $cat->estado_id = $this->_request->getParam('id_estado', 0);
            $fecha = new Zend_Date();
            $cat->fecha_alta = $fecha->get('yyyy-MM-dd HH:mm:ss');

            // grabar usuario
            $user = new Usuario();
            $user->email = $this->_request->getParam('email');
            $user->password = md5($this->_request->getParam('password'));
            $user->app_id = APPLICATION_ID;
            $user->perfil = 'USER';
            $user->blockeado = 'N';
            $user->save();

            $cat->usuario_id = $user->id;


            try {
                $cat->save();
            } catch (Exception $e) {
                die($e->getMessage());
            }




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

            $sucursales = $this->_request->getParam('sucursal', null);

            if (is_array($sucursales)) {
                foreach ($sucursales as $sucursal) {
                    if ($sucursal['nombre'] == '')
                        continue;
                    $per = new Sucursal();

                    $per->app_id = APPLICATION_ID;

                    $per->nombre = $sucursal['nombre'];
                    $per->direccion = $sucursal['direccion'];
                    $per->encargados = $sucursal['encargados'];
                    $per->telefono1 = $sucursal['telefono1'];
                    $per->telefono2 = $sucursal['telefono2'];
                    $per->observaciones = $sucursal['observaciones'];
                    try {
                        $per->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                    $pxc = new SucursalPorCliente();
                    $pxc->Cliente = $cat;
                    $pxc->Sucursal = $per;
                    try {

                        $pxc->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                }
            }
            return $this->_redirect("/cliente/list");
        } else {

            $this->view->paises = Doctrine_Core::getTable('Pais')->findByDql("borrado='N'");
            $this->view->clientesTipo = Doctrine_Core::getTable('ClienteTipo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
            $this->view->cargos = Doctrine_Core::getTable('Cargo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
            $this->view->vendedores = Doctrine_Core::getTable('Vendedor')->findByDql("app_id='" . APPLICATION_ID . "'");
        }
    }

    public function editAction() {



        $id = $this->_request->getParam('id', false);
        $cliente = Doctrine_Query::create()
                        ->from('Cliente')
                        ->where("id = '" . $id . "' and borrado='N' and app_id='" . APPLICATION_ID . "'")->execute();
        // dump($cliente->toArray());
        $this->view->personal = $this->_getPersonal($id);
        $this->view->sucursales = $this->_getSucursal($id);
        $this->view->record = $cliente[0];
        $cliente = $cliente[0];
        $user_id = $cliente->usuario_id;

        $usuario = Doctrine_Query::create()
                        ->from('Usuario')
                        ->where('id=' . $user_id)->fetchOne();

        $this->view->usuario = $usuario;


        if ($this->_request->isPost()) {
            // var_dump($this->_request->getPost());die;
            $cliente->app_id = APPLICATION_ID;
            $cliente->nombre_comercial = $this->_request->getParam('nombre');
            $cliente->tipo = $this->_request->getParam('tipo_cliente_id');
            $cliente->telefono1 = $this->_request->getParam('telefono1');
            $cliente->telefono2 = $this->_request->getParam('telefono2');
            $cliente->sms1 = $this->_request->getParam('sms1', '');
            $cliente->sms2 = $this->_request->getParam('sms2', '');
            $cliente->sms3 = $this->_request->getParam('sms3', '');
            $cliente->email1 = $this->_request->getParam('email1', '');
            $cliente->email2 = $this->_request->getParam('email2', '');
            $cliente->email3 = $this->_request->getParam('email3', '');
            $cliente->empresa_de_preferencia = $this->_request->getParam('empresa_preferencia', '');
            $cliente->asegurado = $this->_request->getParam('porcentaje_asegurado', 0);
            $cliente->direccion_de_envio = $this->_request->getParam('direccion_envio', '');
            $cliente->enviar_a_nombre_de = $this->_request->getParam('enviar_nombres', '');
            $cliente->razon_social = $this->_request->getParam('razon_social', '');
            $cliente->tipo_contribucion = $this->_request->getParam('tipo_contribucion');
            $cliente->viajante_id = $this->_request->getParam('viajante_id');
            $cliente->habilita_acceso_pedidos = $this->_request->getParam('acceso');
            $cliente->direccion_facturacion = $this->_request->getParam('direccion_facturacion');
            $cliente->observaciones = $this->_request->getParam('observaciones');
            //  $cliente->habilita_acceso_pedidos = $this->_request->getParam('habilita_acceso_pedidos');
            $cliente->estado_id = $this->_request->getParam('id_estado', 0);
            $fecha = new Zend_Date();
            $cliente->fecha_alta = $fecha->get('yyyy-MM-dd HH:mm:ss');



            try {
                $cliente->save();
            } catch (Exception $e) {
                die($e->getMessage());
            }

            // grabar usuario
            $usuario->email = $this->_request->getParam('email');
            $usuario->password = md5($this->_request->getParam('password'));
            $usuario->save();


            $this->saveAuditoria($cliente->id);
            // TODO borrar personal anterior


            $this->removePersonalPorCliente($id);

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
                    $pxc->Cliente = $cliente;
                    $pxc->Personal = $per;
                    try {

                        $pxc->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                }
            }

            $sucursales = $this->_request->getParam('sucursal', null);
            // TODO borrar sucursales anteriores
            $this->removeSucursalesPorCLiente($id);

            if (is_array($sucursales)) {
                foreach ($sucursales as $sucursal) {
                    if ($sucursal['nombre'] == '')
                        continue;
                    $per = new Sucursal();
                    $per->app_id = APPLICATION_ID;
                    $per->nombre = $sucursal['nombre'];
                    $per->direccion = $sucursal['direccion'];
                    $per->encargados = $sucursal['encargados'];
                    $per->telefono1 = $sucursal['telefono1'];
                    $per->telefono2 = $sucursal['telefono2'];
                    $per->observaciones = $sucursal['observaciones'];
                    try {
                        $per->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                    $pxc = new SucursalPorCliente();
                    $pxc->Cliente = $cliente;
                    $pxc->Sucursal = $per;
                    try {

                        $pxc->save();
                    } catch (Exception $e) {
                        die($e->getMessage());
                    }
                }
            }
            return $this->_redirect("/cliente/list");
        } else {

            $this->view->paises = Doctrine_Core::getTable('Pais')->findByDql("borrado='N'");
            $this->view->clientesTipo = Doctrine_Core::getTable('ClienteTipo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
            $this->view->cargos = Doctrine_Core::getTable('Cargo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
            $this->view->vendedores = Doctrine_Core::getTable('Vendedor')->findByDql("app_id='" . APPLICATION_ID . "'");
        }
    }

    public function avisonuevoclienteAction() {
        $alertaEmails = Doctrine_Query::create()
                ->from("Alertaemails a")
                ->where('app_id="' . APPLICATION_ID . '"')
                ->fetchOne();
        

        if ($this->_request->isPost()) {
            
            
            $alertaEmails->email1 = $this->_request->getParam('email1');
            $alertaEmails->email2 = $this->_request->getParam('email2');
            
            $alertaEmails->save();
            $this->_helper->flashMessenger->setNamespace('success')->addMessage("Guardado Correctamente!");
            return $this->_redirect("/cliente/avisonuevocliente");          
            
        }

        $app = Doctrine_Query::create()
                ->from("Application a")
                ->where('app_id="' . APPLICATION_ID . '"')
                ->execute();

        $this->view->email = $app[0]->responsable_email;


//s
        $this->view->email1 = $alertaEmails->email1;
        $this->view->email2 = $alertaEmails->email2;
        //  dump($alertaEmails);
    }

    public function listAction() {

        $nombre = $this->_request->getParam('nombre', '');
        $this->view->nombre = $nombre;
        $cliente_tipo_id = $this->_request->getParam('cliente_tipo_id', 0);
        $this->view->cliente_tipo_id = $cliente_tipo_id;

        if ($nombre) {
            $nom = " and c.nombre_comercial like '%$nombre%' ";
        }
        else
            $nom = "";

        if ($cliente_tipo_id) {
            $tipo = " and c.tipo = $cliente_tipo_id ";
            $this->view->clienteTipoNombre = Doctrine_Core::getTable('ClienteTipo')->findByDql("id = '" . $cliente_tipo_id . "' and borrado='N' and app_id='" . APPLICATION_ID . "'");
        }
        else
            $tipo = "";


        $this->view->clienteTipos = Doctrine_Core::getTable('ClienteTipo')->findByDql("borrado='N' and app_id='" . APPLICATION_ID . "'");
        // var_dump($this->view->clienteTipos);die;

        $adapter = new My_Paginator(
                Doctrine_Query::create()
                        ->from("Cliente c")
                        ->leftJoin('c.ClienteTipo ct')
                        ->leftJoin('c.ClienteEstado ce')
                        ->where("c.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $nom . $tipo)
        );


        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(15);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
        $this->view->categorias = My_Function_Function::getCategoriaCombo();
    }

    public function _editAction() {
        //die('sdfsdf');
        $id = $this->_request->getParam('id', '');
        $cliente = Doctrine_Core::getTable('Cliente')->findByDql("id = '" . $id . "' and borrado='N' and app_id='" . APPLICATION_ID . "'");
        // var_dump($cliente->toArray());die;
        $this->view->record = $cliente[0];
    }

    private function _getPersonal($cliente_id) {
        $pers = Doctrine_Core::getTable('PersonalPorCliente')->findByDql("id_cliente = " . $cliente_id);
        $personal = array();
        if (isset($pers[0])) {
            $inString = "";
            foreach ($pers as $per) {
                $inString = $inString . $per->id_personal . ", ";
            }
            $personal = Doctrine_Core::getTable('Personal')->findByDql("id in (" . substr($inString, 0, strlen($inString) - 2) . ")");
        }
        return $personal;
    }

    private function _getSucursal($cliente_id) {
        $pers = Doctrine_Core::getTable('SucursalPorCliente')->findByDql("id_cliente = " . $cliente_id);
        $personal = array();
        if (isset($pers[0])) {
            $inString = "";
            foreach ($pers as $per) {
                $inString = $inString . $per->id_sucursal . ", ";
            }
            $personal = Doctrine_Core::getTable('Sucursal')->findByDql("id in (" . substr($inString, 0, strlen($inString) - 2) . ")");
        }
        return $personal;
    }

    private function removePersonalPorCliente($clienteId) {

        $q = Doctrine_Query::create()
                ->from('PersonalPorCliente')
                ->where('id_cliente=' . $clienteId)
                ->execute();

        if ($q->count) {
            foreach ($q as $pxc) {
                $pxc->delete();
            }
        }
        return;
    }

    private function removeSucursalesPorCLiente($clienteId) {
        $q = Doctrine_Query::create()
                ->from('SucursalPorCliente')
                ->where('id_cliente=' . $clienteId)
                ->execute();
        if ($q->count) {
            foreach ($q as $pxc) {
                $pxc->delete();
            }
        }
        return;
    }

}