<?php
// Connection Component Binding
Doctrine_Manager::getInstance()->bindComponent('PagoTipo', 'doctrine');

/**
 * BasePagoTipo
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $app_id
 * @property string $descripcion
 * @property float $interes
 * @property string $contenido
 * @property string $borrado
 * @property Doctrine_Collection $Venta
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BasePagoTipo extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('pago_tipo');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => true,
             ));
        $this->hasColumn('app_id', 'string', 100, array(
             'type' => 'string',
             'length' => 100,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'notnull' => false,
             'autoincrement' => false,
             ));
        $this->hasColumn('descripcion', 'string', 250, array(
             'type' => 'string',
             'length' => 250,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '',
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('interes', 'float', 4, array(
             'type' => 'float',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'default' => '0.00',
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('contenido', 'string', null, array(
             'type' => 'string',
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('borrado', 'string', 1, array(
             'type' => 'string',
             'length' => 1,
             'fixed' => true,
             'unsigned' => false,
             'primary' => false,
             'default' => 'N',
             'notnull' => false,
             'autoincrement' => false,
             ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasMany('Venta', array(
             'local' => 'id',
             'foreign' => 'formaDePagoId'));
    }
}