<?php
// Connection Component Binding
Doctrine_Manager::getInstance()->bindComponent('DetallePedidoXTalle', 'doctrine');

/**
 * BaseDetallePedidoXTalle
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id_pedido
 * @property integer $id_producto
 * @property integer $id_talle
 * @property integer $cantidad
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseDetallePedidoXTalle extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('detalle_pedido_x_talle');
        $this->hasColumn('id_pedido', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('id_producto', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('id_talle', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('cantidad', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '0',
             'notnull' => true,
             'autoincrement' => false,
             ));
    }

    public function setUp()
    {
        parent::setUp();
        
    }
}