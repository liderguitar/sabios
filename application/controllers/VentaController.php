<?php

class VentaController extends My_Controller_Sabios {

    public function indexAction() {
        
    }

    public function editAction() {
        $id = $this->_request->getParam('id', false);

        $venta = Doctrine_Query::create()
                        ->from("Venta v")
                        ->leftJoin("v.Cliente c")
                        ->leftJoin("v.PagoTipo f")
                        ->leftJoin("v.VentaEstado ve")
                        ->leftJoin("v.VentaDetalle vd")
                        ->leftJoin("v.Vendedor vn")
                        ->leftJoin("vd.ProductoTextil pt")
                        ->leftJoin("pt.Producto p")
                        ->leftJoin("vd.TallePorProductoTextil tppt")
                        ->leftJoin("tppt.Talle")
                        ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N" and v.id=' . $id)->fetchOne();

        if ($this->_request->isPost()) {

            if ($venta->VentaEstado->cancelado == 'Y') {
                $this->_helper->flashMessenger->setNamespace('error')->addMessage('No se puede cambiar el estado Cancelado.');
                return $this->_redirect("/venta/list");
            }

            $venta->ventaEstadoId = $this->_request->getParam('vd-estado');
            $venta->save();
            $this->_helper->flashMessenger->setNamespace('success')->addMessage('Venta Actualizada.');

            //  dump($venta->VentaEstado->cancelado);


            if ($venta->VentaEstado->devuelveStock == 'Y') {


                // dump("devuelve stock");
                $ventaArray = $venta->toArray();
                foreach ($ventaArray['VentaDetalle'] as $vd) {
                    $vdItem = array();
                    $cant = $vd['cantidad'];
                    $tptt = $vd['tallePorProductoTextil'];
                    $st = Doctrine_Core::getTable("TallePorProductoTextil")->find($tptt);
                    $st->stock = $st->stock + $cant;
                    $st->save();
                }
            }


            return $this->_redirect("/venta/list");
        }

        //    My_Function_Function::var_debug($venta->toArray());


        $this->view->estados = Doctrine_Query::create()
                        ->from("VentaEstado v")
                        ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"')->execute();


        $ventaArray = $venta->toArray();

        $ventaDetalle = array();
        foreach ($ventaArray['VentaDetalle'] as $vd) {
            $vdItem = array();
            $cantidad = $vd['cantidad'];
            $tallePorProductoTextil = $vd['tallePorProductoTextil'];
            $vdItem['id'] = $vd['id'];
            $vdItem['codigo'] = $vd['ProductoTextil']['Producto']['codigo'] . ' - ' . $vd['ProductoTextil']['Producto']['nombre'];
            $vdItem['precio'] = $vd['precioUnitario'];
            $vdItem['talles'][$tallePorProductoTextil]['talle'] = $vd['TallePorProductoTextil']['Talle']['talle'];
            $vdItem['talles'][$tallePorProductoTextil]['cant'] = $cantidad;

            if (!isset($ventaDetalle[$vd['productoTextilId']])) {
                $ventaDetalle[$vd['productoTextilId']] = $vdItem;
            } else {

                $ventaDetalle[$vd['productoTextilId']]['talles'][$tallePorProductoTextil]['talle'] = $vd['TallePorProductoTextil']['Talle']['talle'];
                $ventaDetalle[$vd['productoTextilId']]['talles'][$tallePorProductoTextil]['cant'] = $cantidad;
            }
        }

        //  My_Function_Function::var_debug($ventaDetalle);
        $this->view->ventadetalle = $ventaDetalle;
        $this->view->venta = $venta;
    }

    public function listAction() {


        $fd = new Zend_Date();
        $this->view->fecha_hasta = $fd->toString("dd-MM-Y");
        $fd->sub('1', Zend_Date::MONTH);
        $this->view->fecha_desde = $fd->toString("dd-MM-Y");


        if ($this->_request->isPost()) {

            $fd = new Zend_Date();
            $fd->set($this->_request->getParam('fecha_desde'), 'dd-MM-yyyy');
            $fecha_desde = $fd->toString("Y-MM-dd");
            $fh = new Zend_Date();
            $fh = $fh->set($this->_request->getParam('fecha_hasta'), 'dd-MM-yyyy');
            $fecha_hasta = $fh->toString("Y-MM-dd");

            $this->view->fecha_desde = $this->_request->getParam('fecha_desde');
            $this->view->fecha_hasta = $this->_request->getParam('fecha_hasta');

            //  dump($this->_request->getPost());
            $filtros = $this->parseFilters($this->_request->getPost());
            // guardar filtros en session
            $query = Doctrine_Query::create()
                    ->from("Venta v")
                    ->leftJoin("v.Cliente c")
                    ->leftJoin("v.PagoTipo f")
                    ->leftJoin("v.VentaEstado ve")
                    ->leftJoin("v.VentaDetalle vd")
                    ->leftJoin("v.Vendedor vn")
                    ->leftJoin("vd.ProductoTextil pt")
                    ->leftJoin("pt.Producto")
                    ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"');
            if ($filtros['estado']) {
                $query->andWhere("v.ventaestadoid in(" . $filtros['estado'] . ")");
            }
            if ($filtros['fdp']) {
                $query->andWhere("v.formadepagoid in(" . $filtros['fdp'] . ")");
            }
            if ($filtros['vendedor']) {
                $query->andWhere("v.vendedorid in(" . $filtros['vendedor'] . ")");
            }

            $query->andWhere("v.fecha BETWEEN '" . $fecha_desde . "' and '" . $fecha_hasta . "' ");



          //  $this->view->ventas = $query->execute();
        } else {
            $query = Doctrine_Query::create()
                    ->from("Venta v")
                    ->leftJoin("v.Cliente c")
                    ->leftJoin("v.PagoTipo f")
                    ->leftJoin("v.VentaEstado ve")
                    ->leftJoin("v.VentaDetalle vd")
                    ->leftJoin("v.Vendedor vn")
                    ->leftJoin("vd.ProductoTextil pt")
                    ->leftJoin("pt.Producto")
                    ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"');
            //  dump($this->view->ventas);
        }
        $this->view->ventaEstados = Doctrine_Query::create()
                ->from("VentaEstado v")
                ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"')
                ->execute();

        $this->view->formasDePago = Doctrine_Query::create()
                ->from("PagoTipo v")
                ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"')
                ->execute();

        $this->view->vendedores = Doctrine_Query::create()
                ->from("Vendedor v")
                ->where('app_id="' . APPLICATION_ID . '" and v.borrado="N"')
                ->execute();


        $adapter = new My_Paginator($query);


        $this->view->page = $this->_request->getParam('page');
        //die($this->view->page);
        $paginator = new Zend_Paginator($adapter);
        $paginator->setItemCountPerPage(15);
        $paginator->setCurrentPageNumber($this->view->page);  
        $this->view->ventas  = $paginator;
        
        
        //dump($this->view->formasDePago->toArray());die;
    }

    public function avisonvAction() {
        
    }

    private function parseFilters($data) {


        // estado mostrar
        $estado = array();
        $fdp = array();
        $vendedores = array();
        $estado_st = array();
        $fdp_st = array();
        $vendedores_st = array();
        foreach ($data as $key => $filter) {

            // estado_mostrar
            if (strpos($key, 'estado_mostrar_') !== false) {
                if ($data[$key] == 1) {
                    $estado[] = substr($key, 15, strlen($key) - 1);
                }
            }
            if (strpos($key, 'vendedor_mostrar_') !== false) {
                if ($data[$key] == 1) {
                    $vendedores[] = substr($key, 17, strlen($key) - 1);
                }
            }
            if (strpos($key, 'fdp_mostrar_') !== false) {
                if ($data[$key] == 1) {
                    $fdp[] = substr($key, 12, strlen($key) - 1);
                }
            }

            if (strpos($key, 'estado_subtotal_') !== false) {
                if ($data[$key] == 1) {
                    $estado_st[] = substr($key, 16, strlen($key) - 1);
                }
            }
            if (strpos($key, 'vendedor_subtotal_') !== false) {
                if ($data[$key] == 1) {
                    $vendedores_st[] = substr($key, 18, strlen($key) - 1);
                }
            }
            if (strpos($key, 'fdp_subtotal_') !== false) {
                if ($data[$key] == 1) {
                    $fdp_st[] = substr($key, 13, strlen($key) - 1);
                }
            }
        }

        $filtros = new Zend_Session_Namespace('filters');

        $filtros->filtros = array(
            'estado' => $estado,
            'estado_st' => $estado_st,
            'fdp' => $fdp,
            'fdp_st' => $fdp_st,
            'vendedor' => $vendedores,
            'vendedor_st' => $vendedores_st
        );

        return array(
            'estado' => $this->arrayToString($estado),
            'estado_st' => $this->arrayToString($estado_st),
            'fdp' => $this->arrayToString($fdp),
            'fdp_st' => $this->arrayToString($fdp_st),
            'vendedor' => $this->arrayToString($vendedores),
            'vendedor_st' => $this->arrayToString($vendedores_st)
        );
    }

    private function arrayToString($array) {

        $string = '';
        foreach ($array as $id) {
            $string .= $id . ',';
        }
        return substr($string, 0, strlen($string) - 1);
    }

}