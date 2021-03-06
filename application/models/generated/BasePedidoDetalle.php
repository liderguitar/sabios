<?php
// Connection Component Binding
Doctrine_Manager::getInstance()->bindComponent('PedidoDetalle', 'doctrine');

/**
 * BasePedidoDetalle
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $id_pedido
 * @property integer $id_producto
 * @property float $precio
 * @property Pedido $Pedido
 * @property Producto $Producto
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BasePedidoDetalle extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('pedido_detalle');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => true,
             ));
        $this->hasColumn('id_pedido', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '0',
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('id_producto', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '0',
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('precio', 'float', 15, array(
             'type' => 'float',
             'length' => 15,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '0.00',
             'notnull' => true,
             'autoincrement' => false,
             ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasOne('Pedido', array(
             'local' => 'id_pedido',
             'foreign' => 'id'));

        $this->hasOne('Producto', array(
             'local' => 'id_producto',
             'foreign' => 'id'));
    }
}