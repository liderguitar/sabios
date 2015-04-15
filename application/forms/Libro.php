<?php
class Form_Libro extends Zend_Form
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

        $fotoname2 = new Zend_Form_Element_Hidden('fotoname2');
        $fotoname2->setDecorators(array('ViewHelper'));
        $this->addElement($fotoname2);         

        $fotoname3 = new Zend_Form_Element_Hidden('fotoname3');
        $fotoname3->setDecorators(array('ViewHelper'));
        $this->addElement($fotoname3);  

        $fotoname4 = new Zend_Form_Element_Hidden('fotoname4');
        $fotoname4->setDecorators(array('ViewHelper'));
        $this->addElement($fotoname4);  

        $fotoname5 = new Zend_Form_Element_Hidden('fotoname5');
        $fotoname5->setDecorators(array('ViewHelper'));
        $this->addElement($fotoname5);  
        
        $urlCode = new Zend_Form_Element_Hidden('urlCode');
        $urlCode->setDecorators(array('ViewHelper'));
        $this->addElement($urlCode);   
        
        
        $titulo = new Zend_Form_Element_Text('titulo');
        
        $titulo->setLabel('Titulo:')
             ->addFilter(new Zend_Filter_StringTrim())
            // ->addValidator(new Zend_Validate_StringLength(6, 75), true)
             ->setRequired(true);
		$titulo->class = 'rounded-input span-16';

		$this->addElement($titulo);
		$this->_addDecorators('titulo', 'fusasLabel');
		
        $descripcion = new Zend_Form_Element_Textarea('descripcion');
		$descripcion->setLabel('Descripcion:')
         //    ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('cols', '44')
             ->setAttrib('rows', '10');
		$descripcion->class = 'rounded span-16';
				
		$this->addElement($descripcion);
		$this->_addDecorators('descripcion', 'fusasLabel');

        $editorial = new Zend_Form_Element_Text('editorial');
        
        $editorial->setLabel('Editorial:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('autocomplete', 'off');
		$editorial->class = 'rounded-input span-16 righty';

		$this->addElement($editorial);
		$this->_addDecorators('editorial', 'fusasLabel');

        $editorialId = new Zend_Form_Element_Hidden('editorialId');
        $editorialId->setDecorators(array('ViewHelper'));
        $this->addElement($editorialId);
        
       	$autor = new Zend_Form_Element_Text('autor');
        
        $autor->setLabel('Autor:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$autor->class = 'rounded-input span-16 righty';
			
		$this->addElement($autor);
		$this->_addDecorators('autor', 'fusasLabel');

        $autorId = new Zend_Form_Element_Hidden('autorId');
        $autorId->setDecorators(array('ViewHelper'));
        $this->addElement($autorId);		
/*
        $foto = new Zend_Form_Element_File('foto', array(
            'MaxFileSize' => 2097152, // 2097152 bytes = 2 megabytes
            'validators' => array(
                array('Count', false, 5),
                array('Size', false, 2097152),
                array('Extension', false, 'gif,jpg,png'),
                array('ImageSize', false, array('minwidth' => 100,
                                                'minheight' => 100,
                                                'maxwidth' => 1000,
                                                'maxheight' => 1000))
            )
        ));
        
	    $foto->setRequired(false);
        
		$foto->setLabel('Fotos:');
		$foto->setDecorators(array('File'));
		$foto->setMultiFile(5);				  
		$this->addElement($foto);
*/
	    $fotoName = new Zend_Form_Element_Hidden('fotoname');
	    $fotoName->setRequired(false);
        $fotoName->setDecorators(array('ViewHelper'));
        $this->addElement($fotoName);	
	
        $genero = new Zend_Form_Element_Text('genero');
        
        $genero->setLabel('Genero:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('autocomplete', 'off');
		$genero->class = 'rounded-input span-16 righty';

		$this->addElement($genero);
		$this->_addDecorators('genero', 'fusasLabel');

        $generoId = new Zend_Form_Element_Hidden('generoId');
        $generoId->setDecorators(array('ViewHelper'));
        $this->addElement($generoId);

		$encuadernacion = new Zend_Form_Element_Select('encuadernacion');
		$encuadernacion->setLabel('Encuadernacion:')
				   ->setRequired(true);
		

        $encuadernacion->class="rounded span-16";
        $encuadernacion->setRegisterInArrayValidator(false);

        $encuadernacion->addMultiOption('', 'Elegir');
        $encuadernacion->addMultiOption('RUSTICA', 'RUSTICA');
        $encuadernacion->addMultiOption('TAPA DURA', 'TAPA DURA');
           
        $this->addElement($encuadernacion);
        $this->_addDecorators('encuadernacion', 'fusasLabel');
        
   		$oferta = new Zend_Form_Element_Checkbox('oferta');
   		$oferta->setLabel('Oferta:');
        $oferta->class = "checkbox";
        $this->addElement($oferta);
		$this->_addDecorators('oferta', 'fusasLabel');
        
   		$destacado = new Zend_Form_Element_Checkbox('destacado');
   		$destacado->setLabel('Destacado:');
        $this->addElement($destacado);
        $destacado->class = "checkbox";
		$this->_addDecorators('destacado', 'fusasLabel');
		
   		$novedad = new Zend_Form_Element_Checkbox('novedad');
   		$novedad->setLabel('Novedad:')->setValue(true);
        $novedad->class = "checkbox";

        $this->addElement($novedad);
		$this->_addDecorators('novedad', 'fusasLabel');
		        
   		$mostrarPrecio = new Zend_Form_Element_Checkbox('mostrarPrecio');
   		$mostrarPrecio->setLabel('Mostrar:')->setValue(true);
        $mostrarPrecio->class = "checkbox";        
        
        $this->addElement($mostrarPrecio);
		$this->_addDecorators('mostrarPrecio', 'fusasLabel');
		
		
	$tomos = new Zend_Form_Element_Text('tomos');
        
        $tomos->setLabel('Tomos:')
             ->setRequired(true)
             ->setValue(1);
		$tomos->class = 'rounded-input shortText';	
		$this->addElement($tomos);
		$this->_addDecorators('tomos', 'fusasLabel');		
		
		$anio = new Zend_Form_Element_Text('anio');
        
        $anio->setLabel('Anio:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true);
		$anio->class = 'rounded-input';	
		$this->addElement($anio);
		$this->_addDecorators('anio', 'fusasLabel');		
		$anio->class = 'rounded-input shortText';
		
		
		$precio = new Zend_Form_Element_Text('precio');
        
        $precio->setLabel('Precio:')
             ->setRequired(true);
		$precio->class = 'rounded-input shortText';

		$this->addElement($precio);
		$this->_addDecorators('precio', 'fusasLabel');		
		$stock = new Zend_Form_Element_Text('stock');
        
        $stock->setLabel('Stock:')
             ->setRequired(true);

		$stock->class = 'rounded-input shortText';
		
		$this->addElement($stock);
		$this->_addDecorators('stock', 'fusasLabel');
		
		$valoracion = new Zend_Form_Element_Radio('valoracion');
		$valoracion	->setLabel('Valoracion:')
      				->addMultiOptions(
      					array(
					        '1' => '',
					        '2' => '',
      						'3' => '',
      						'4'	=> '',
      						'5'	=> ''
      						)
      					)
      				->setSeparator('');
      	$valoracion->class = "star";
      	$valoracion->setDecorators(array('ViewHelper','Label'));
		$this->addElement($valoracion);		
		
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