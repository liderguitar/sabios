<?php
// Connection Component Binding
Doctrine_Manager::getInstance()->bindComponent('Cargo', 'doctrine');

/**
 * BaseCargo
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $app_id
 * @property string $nombre
 * @property enum $borrado
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseCargo extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('cargo');
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
             'notnull' => true,
             'autoincrement' => false,
             ));
        $this->hasColumn('nombre', 'string', 100, array(
             'type' => 'string',
             'length' => 100,
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
        
    }
}