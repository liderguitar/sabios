<?php

class ProductoTextilController extends My_Controller_Sabios {

    public function init() {


        $this->view->errormessages = $this->_helper->flashMessenger->getMessages();
        $this->view->userId = Zend_Auth::getInstance()->getIdentity()->id;
        // die( $this->view->userId);
        parent::init();
    }

    public function indexAction() {
        
    }

    public function editAction() {



        if ($this->_request->isPost()) {
            $id = $this->_request->getParam('id');
            $prod = ProductoTextil::getByProductoId($id);
            $prod->unBlock();
//            $prod->codigo = $this->_request->getParam('codigo'); // verificar codigo unico
            $prod->descripcion = $this->_request->getParam('descripcion');
            $prod->nombre = $this->_request->getParam('nombre');
            $prod->precio = $this->_request->getParam('precio');
            $prod->costo = $this->_request->getParam('costo');
            $prod->id_subcategoria = $this->_request->getParam('categoria');
            unset($prod->FotosPorProducto);
            //borrado logico
            $prod->ProductoTextil[0]->talle_tipo_id = $this->_request->getParam('tipotalle');


            for ($a = 1; $a < 7; $a++) {
                if (!is_null($this->_request->getParam('fotoname-' . $a, null))) {
                    $foto = new Foto();
                    $foto->url = $this->_request->getParam('fotoname-' . $a);
                    $foto->save();
                    $fxp = new FotosPorProducto();
                    $fxp->Foto = $foto;
                    $fxp->Producto = $prod;
                    $fxp->save();
                }
            }

            // $TallePorProductoTextil
            // unset($prod->ProductoTextil[0]->TallePorProductoTextil);
//           foreach ($prod->ProductoTextil[0]->TallePorProductoTextil as $txp){
//               $txp->borrado = 'Y';
//               $txp->save();
//           }
            $prod->save(); //die("listo");
//            $count = 0;
//            $stock = $this->_request->getParam('stock');
//            foreach ($this->_request->getParam('id_talle') as $idTalle) {
//                $tppt = new TallePorProductoTextil();
//                $tppt->id_producto_textil = $prod->ProductoTextil[0]->id;
//                $tppt->id_talle = $idTalle;
//                $tppt->stock = $stock[$count];
//                $tppt->save();
//                $count++;
//            }
            $this->_helper->flashMessenger->addMessage('Producto grabado.');

            return $this->_redirect("/productotextil/list");
        } else {
            $id = $this->_request->getParam('id');
            if (is_null($id)) {
                $this->_success = false;
                $this->_message = 'Falta de datos';
            } else {
                $data = ProductoTextil::getByProductoIdArray($id);
                $bloq = ProductoTextil::getByProductoId($id);
                $this->view->producto = $data;
                if ($bloq->isBlocked($this->view->userId)) {
                    $this->_helper->flashMessenger->addMessage('Producto Bloqueado por otro usuario.');
                    return $this->_redirect("/productotextil/list");
                }

                $bloq->block($this->view->userId);


                $cat = Doctrine_Query::create()->select()
                                ->from('Categoria c')
                                ->where('c.id=' . $this->view->producto['id_subcategoria'])->execute();
                $this->view->categoria = $cat[0];
                //var_dump($cat[0]);die;
                $this->view->tallesTipo = Doctrine_Query::create()->select()
                                ->from('TalleTipo t')
                                ->where("t.app_id='" . APPLICATION_ID . "'")
                                ->andWhere("t.borrado='N'")->execute();

                $this->view->categorias = My_Function_Function::getCategoriaCombo();
                //var_dump($data);die;
            }
        }
    }

    public function addAction() {


        if ($this->_request->isPost()) {

            //var_dump($this->_request->getParams());die;

            $prod = new Producto();
            $prod->app_id = APPLICATION_ID;
            $prod->codigo = $this->_request->getParam('codigo');
            $prod->descripcion = $this->_request->getParam('descripcion');
            $prod->nombre = $this->_request->getParam('nombre');
            $prod->precio = $this->_request->getParam('precio');
            $prod->costo = $this->_request->getParam('costo');
            $prod->id_subcategoria = $this->_request->getParam('categoria');
            //$prod->save();



            $prodt = new ProductoTextil();
            $prodt->talle_tipo_id = $this->_request->getParam('tipotalle');
            $prodt->Producto = $prod;
            $prodt->save();

            for ($a = 1; $a < 7; $a++) {

                if (!is_null($this->_request->getParam('fotoname-' . $a, null))) {
                    $foto = new Foto();
                    $foto->url = $this->_request->getParam('fotoname-' . $a);
                    $foto->save();
                    $fxp = new FotosPorProducto();
                    $fxp->Foto = $foto;
                    $fxp->Producto = $prod;
                    $fxp->save();
                    //$this->saveAuditoria(json_encode($prodt->toArray()));
                }
            }
            return $this->_redirect("/productotextil/list");
        } else {

            $this->view->tallesTipo = Doctrine_Query::create()->select()
                            ->from('TalleTipo t')
                            ->where("t.app_id='" . APPLICATION_ID . "'")
                            ->andWhere("t.borrado='N'")->execute();

            $this->view->categorias = My_Function_Function::getCategoriaCombo();
        }

        $cat = Doctrine_Query::create()->select()
                        ->from('Categoria c')
                        ->where('c.id=' . $this->view->producto['id_subcategoria'])->execute();
        $this->view->categoria = $cat[0];
    }

    public function talleslistAction() {

        $codigo = $this->_request->getParam('codigo', '');
        $this->view->codigo = $codigo;
        $categoria = $this->_request->getParam('categoria', '');
        $this->view->categoria = $categoria;

        if ($codigo) {
            $cod = " and p.codigo like '%$codigo%' ";
        }
        else
            $cod = "";
        if ($categoria) {
            $cat = " and p.id_subcategoria = $categoria ";
            $cate = Doctrine_Query::create()->select()
                            ->from('Categoria c')
                            ->where('c.id=' . $categoria)->execute();
            $this->view->categoria = $cate[0];
        }
        else
            $cat = "";
//                die(Doctrine_Query::create()
//                        ->from("Producto p")
//                        ->leftjoin('p.ProductoTextil ')
//                        ->where("p.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $cod . $cat
//                        )->getSqlQuery());

        $adapter = new My_Paginator(
                Doctrine_Query::create()
                        ->from("Producto p")
                        ->leftjoin('p.ProductoTextil pt')
                        ->where("p.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $cod . $cat
                        )
        );

        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(15);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
        $this->view->categorias = My_Function_Function::getCategoriaCombo();
    }

    public function listAction() {


        $codigo = $this->_request->getParam('codigo', '');
        $this->view->codigo = $codigo;
        $categoria = $this->_request->getParam('categoria', '');
        $this->view->categoria = $categoria;

        if ($codigo) {
            $cod = " and p.codigo like '%$codigo%' ";
        }
        else
            $cod = "";
        if ($categoria) {
            $cat = " and p.id_subcategoria = $categoria ";
            $cate = Doctrine_Query::create()->select()
                            ->from('Categoria c')
                            ->where('c.id=' . $categoria)->execute();
            $this->view->categoria = $cate[0];
        }
        else
            $cat = "";


        $adapter = new My_Paginator(
                Doctrine_Query::create()
                        ->from("Producto p")
                        ->where("p.borrado = 'N' and app_id='" . APPLICATION_ID . "'" . $cod . $cat
                        )
        );


        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber($this->view->page);

        $this->view->objects = $paginator;
        $this->view->categorias = My_Function_Function::getCategoriaCombo();
    }

    public function bloquearAction() {

        $id = $this->_request->getParam('id');
        $prod = Doctrine_Core::getTable("producto")->find($id);
        if (!is_object($prod))
            die(0);
        $prod->block($this->view->userId);
        die("1");
    }

    public function desbloquearAction() {

        $id = $this->_request->getParam('id');
        $prod = Doctrine_Core::getTable("producto")->find($id);
        if (!is_object($prod))
            die(0);
        $prod->unBlock();
        die("1");
    }

    public function savestockAction() {

//        die;
        $talles = $this->_request->getParam('talles');
        $id = $this->_request->getParam('id');
        $prod = ProductoTextil::getByProductoId($id);
        //unset($prod->ProductoTextil[0]->TallePorProductoTextil);
        // $prod->save(); //die("listo");

        foreach ($talles as $talle) {

            $tppt = Doctrine_Query::create()
                            ->from("TallePorProductoTextil tppt")
                            ->where("tppt.id_producto_textil=" . $id . " and id_talle=" . $talle['id_talle']
                            )->fetchOne();

            if (is_object($tppt)) {
                
               // var_dump($tppt->toArray());die;
                
                $tppt->stock = $talle['stock'];
                $tppt->save();
            } else {
                $tppt = new TallePorProductoTextil();
                $tppt->id_producto_textil = $prod->ProductoTextil[0]->id;
                $tppt->id_talle = $talle["id_talle"];
                $tppt->stock = $talle["stock"];
                $tppt->save();
            }

        }

        die("1");
    }

}