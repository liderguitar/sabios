<?php
interface My_Model_Interfase_Object
{
	public function fill($data);
	public static function getById($id);
	public function getAll();
	public function save();
	public static function getByTitle($title);
	public function _getById($id);
	public function getAllQuery($params);
	public function block($usuario);

}
?>