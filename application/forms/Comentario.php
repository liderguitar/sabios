<?php
class Form_Comentario extends Zend_Form
{
    public function init()
    {

        $this->setMethod('post');
        $this->setAttrib('enctype', 'multipart/form-data');
        
        $id = new Zend_Form_Element_Hidden('id');
        $id->setDecorators(array('ViewHelper'));
        $this->addElement($id);

        $postId = new Zend_Form_Element_Hidden('postId');
        $postId->setDecorators(array('ViewHelper'));
        $this->addElement($postId);        

        $libroId = new Zend_Form_Element_Hidden('libroId');
        $postId->setDecorators(array('ViewHelper'));
        $this->addElement($libroId);        
        
        
        $texto = new Zend_Form_Element_Textarea('texto');
		$texto->setLabel('Comentario:')
         //    ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('cols', '44')
             ->setAttrib('rows', '10');
		$texto->class = 'rounded span-16';
				
		$this->addElement($texto);
		$this->_addDecorators('texto', 'fusasLabel');

 	
        $submit = new Zend_Form_Element_Submit('agregar');
        $submit->class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only";
        $submit->setDecorators(array('ViewHelper'));
        
        $this->addElement($submit);
        
        
    }

    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    	
    	
    	    	
    }
    
    protected function getGeneros()
    {
    	$result = new Genero();
    	return $result->getAll()->toArray();
    	
    }
    public function populate($values)
    {
    	//Zend_Debug::dump($values);die;
    	
    	$this->titulo->setValue(utf8_encode($values['titulo']));
    	$editorial = Editorial::getById($values['editorialId']);
    	$nombre = $editorial->nombre;
    	$this->editorial->setValue(utf8_encode($nombre));
		$this->editorialId->setValue($values['editorialId']); 
		$this->fotoname->setValue($values['foto']); 

		
		$this->fotoname2->setValue($values['foto2']);   	
		$this->fotoname3->setValue($values['foto3']);   	
		$this->fotoname4->setValue($values['foto4']);   	
		$this->fotoname5->setValue($values['foto5']);   	
   	    	    	
    	$this->descripcion->setValue(utf8_encode($values['descripcion']));

		$autor = Autor::getById($values['autorId']);
    	$nombre = $autor->nombre;
    	$this->autor->setValue(utf8_encode($nombre));    	
    	
    	$this->encuadernacion->setValue($values['encuadernacion']);
    	$this->autorId->setValue($values['autorId']);

		$genero = Genero::getById($values['generoId']);
    	$nombre = $genero->nombre;
    	$this->genero->setValue(utf8_encode($nombre));
		$this->generoId->setValue($values['generoId']);     	
    	
    	
    	$this->valoracion->setValue($values['valoracion']);
    	$this->anio->setValue($values['anio']);
    	$this->stock->setValue($values['stock']);
    	$this->precio->setValue($values['precio']);
    	$this->tomos->setValue($values['tomos']);
    	$this->oferta->setValue($values['oferta'] == "Y" ? true : false);
    	$this->novedad->setValue($values['novedad'] == "Y" ? true : false);
    	$this->mostrarPrecio->setValue($values['mostrarPrecio'] == "Y" ? true : false);
    	
    	$this->destacado->setValue($values['destacado'] == "Y" ? true : false);
    	
	   	if ($values['postId']) {
    		$this->postId->setValue($values['postId']);
    	}
    	if ($values['id'])
    		$this->id->setValue($values['id']);    		
    	if ($values['urlCode'])
    		$this->urlCode->setValue($values['urlCode']);
    }

}