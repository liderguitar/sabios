<?php
// Connection Component Binding
Doctrine_Manager::getInstance()->bindComponent('Pais', 'doctrine');

/**
 * BasePais
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $nombre
 * @property string $iso_code_2
 * @property string $iso_code_3
 * @property integer $address_format_id
 * @property enum $borrado
 * @property Doctrine_Collection $Provincia
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BasePais extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('pais');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => true,
             'autoincrement' => true,
             ));
        $this->hasColumn('nombre', 'string', 64, array(
             'type' => 'string',
             'length' => 64,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('iso_code_2', 'string', 2, array(
             'type' => 'string',
             'length' => 2,
             'fixed' => true,
             'unsigned' => false,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('iso_code_3', 'string', 3, array(
             'type' => 'string',
             'length' => 3,
             'fixed' => true,
             'unsigned' => false,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('address_format_id', 'integer', 4, array(
             'type' => 'integer',
             'length' => 4,
             'fixed' => false,
             'unsigned' => false,
             'primary' => false,
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('borrado', 'enum', 1, array(
             'type' => 'enum',
             'length' => 1,
             'fixed' => false,
             'unsigned' => false,
             'values' => 
             array(
              0 => 'Y',
              1 => 'N',
             ),
             'primary' => false,
             'default' => 'N',
             'notnull' => false,
             'autoincrement' => false,
             ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasMany('Provincia', array(
             'local' => 'id',
             'foreign' => 'id_pais'));
    }
}