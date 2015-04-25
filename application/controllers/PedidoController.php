<?php

class PedidoController extends My_Controller_Rest {

    public function indexAction() {

        //all
        $this->_success = true;
        $this->_message = '';
        $this->_responseCode = 200;

        try {
            $this->_data = Doctrine_Query::create()->select()
                            ->from('Pedido p')
                            ->leftJoin('p.PedidoDetallePorTalle pdt')
                            ->leftJoin('pdt.Producto pd')
                            ->leftJoin('pd.ProductoTextil pt')
                            ->andWhere("p.app_id='" . APPLICATION_ID . "'")->execute()->toArray();
        } catch (Exception $e) {
            var_dump($e);
            die;
        }

        $this->_setResponse();
    }


    public function getAction() {

        $id = $this->_request->getParam('id');
        if (!isset($id)) {
            $this->_message = 'falta datos';
            $this->_success = false;
        }

        try {
            $data = Doctrine_Query::create()->select()
                            ->from('Pedido p')
                            ->leftJoin('p.PedidoDetallePorTalle pdt')
                            ->leftJoin('pdt.Producto pd')
                            ->leftJoin('pd.ProductoTextil pt')
                            ->where('p.id='.$id)
                            ->andWhere("p.app_id='" . APPLICATION_ID . "'")->execute()->toArray();
        } catch (Exception $e) {
            var_dump($e);
            die;
        }

        if (count($data)) {
            $this->_message = 'ok';
            $this->_success = true;
            $this->_data = $data;
        } else {
            $this->_message = 'Wrong Id';
            $this->_success = false;
        }

        $this->_setResponse();
    }

   public function postAction() {

        $this->_success = true;
        $this->_message = 'Producto Insertado';


        $ped = new Pedido();
        $fecha = new Zend_Date();

        $ped->app_id = APPLICATION_ID;
        $ped->id_cliente = $this->_request->getParam('id_cliente');
        $ped->fecha = $fecha->get('yyyy-MM-dd HH:mm:ss');
        $ped->importe = $this->_request->getParam('importe');
        $ped->id_tipo_pago = $this->_request->getParam('id_tipo_pago');
        $ped->interes = $this->_request->getParam('interes');
        $ped->iva = $this->_request->getParam('iva');
        //$ped->id_pedido_estado =  1; 
        $ped->save();


        foreach ($this->_request->getParam('productos') as $producto) {
            $pdt = new PedidoDetallePorTalle();
            $pdt->id_pedido = $ped->id;
            $pdt->id_producto = $producto['id_producto'];
            $pdt->id_talle = $producto['id_talle'];
            $pdt->cantidad = $producto['cantidad'];
            $pdt->precio = $producto['precio'];
            $pdt->save();
        }


        $this->saveAuditoria(json_encode($ped->toArray()));

        $this->_setResponse();
        /*
         * 
         * $.ajax({
          type: "POST",
          dataType : 'json',
          data: {
          codigo: 'XXX67364',
          nombre: 'Remera Dub Explosion',
          descripcion : 'Remera blanca con colores rasta',
          precio: 100.45,
          costo: 38.56,
          id_subcategoria : 4,
          talle_tipo_id: 2
          },
          url: 'http://127.0.0.1:8380/productotextil',
          beforeSend: function(xhr){
          xhr.setRequestHeader("apikey", '04f50f7dfc94e524e2fc6ce675663c1d');
          xhr.setRequestHeader("user_id", '999');
          },
          success: function(response){
          console.log(response);

          },
          statusCode: {
          403: function() {
          alert( "Api Incorrect" );
          }
          }

          });
         */
    }

}