<?php
class Form_Articulo extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        
        $id = new Zend_Form_Element_Hidden('id');
        $id->setDecorators(array('ViewHelper'));        
        $this->addElement($id);
	    
        $fotoName = new Zend_Form_Element_Hidden('fotoname');
	    $fotoName->setRequired(false);
        $fotoName->setDecorators(array('ViewHelper'));
        $this->addElement($fotoName);
        
        $postId = new Zend_Form_Element_Hidden('postId');
        $postId->setDecorators(array('ViewHelper'));
        $this->addElement($postId);          
        
        $titulo = new Zend_Form_Element_Text('titulo');
        
        $titulo->setLabel('Titulo:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addValidator(new Zend_Validate_StringLength(6, 75), true)
             ->setRequired(true);
		$titulo->class = 'rounded-input span-10';
			
		$this->addElement($titulo);
		$this->_addDecorators('titulo', 'fusasLabel');


		
        $subTitulo = new Zend_Form_Element_Textarea('subtitulo');
        
        $subTitulo->setLabel('Subtitulo:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->addValidator(new Zend_Validate_StringLength(6, 250), true)
             ->setRequired(true)
             ->setAttrib('rows', 6)
			 ->setAttrib('cols', 60);
		$subTitulo->class = 'rounded-input rounded-text-area span-10';
			
		$this->addElement($subTitulo);
		$this->_addDecorators('subtitulo', 'fusasLabel', '');		

		
		$categoria = new Zend_Form_Element_Select('categoria');
		$categoria->setLabel('Categoria:');
		
		$cats = $this->getCategorias();
		foreach ($cats as $cat){
            $categoria->addMultiOption($cat['id'], $cat['nombre']);
        }
        $categoria->class="rounded-select";
        $this->addElement($categoria);
        $this->_addDecorators('categoria', 'fusasLabel');
        		
		//$body = new My_Form_Element_CkEditor('body', array('height' => 600, 'width' => 830, 'disableLoadDefaultDecorators' => true));
		$body = new Zend_Form_Element_Textarea('body');
		$body->class="rounded-input";
		$body->setAttribs(array("cols" => "120", "rows" => "20"));
		$body->setRequired(true);
		$this->addElement($body);

		
		$desde = new Zend_Form_Element_Text('desde');
        
        $desde->setLabel('Desde:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('readonly', 'readonly');
		$desde->class = 'rounded-input datetimepicker';	
		$this->addElement($desde);
		$this->_addDecorators('desde', 'fusasLabel');		
		
		$hasta = new Zend_Form_Element_Text('hasta');
        
        $hasta->setLabel('Hasta:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setAttrib('readonly', 'readonly');;
	    $hasta->class = 'rounded-input datetimepicker';
		$this->addElement($hasta);
		$this->_addDecorators('hasta', 'fusasLabel');		
		
		$peso = new Zend_Form_Element_Text('peso');
        
        $peso->setLabel('Peso:')
             ->addFilter(new Zend_Filter_Digits())
             ->setRequired(true);
		$peso->class = 'rounded-input span-2';
			
		$this->addElement($peso);
		$this->_addDecorators('peso', 'fusasLabel');
		
        $link = new Zend_Form_Element_Text('link');
        $link->setLabel('Link:');
		$link->class = 'rounded-input span-15';
			
		$this->addElement($link);
		$this->_addDecorators('link', 'fusasLabel');                
                
        $submit = new Zend_Form_Element_Submit('agregar');
        $submit->class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only";
        $this->addElement($submit);
        
        
    }

    
    protected function _addDecorators($element, $labelClass="", $class="")
    {
    	$this->getElement($element)->setDecorators(array('ViewHelper', 'Errors'));
    }
    
    protected function getCategorias()
    {
    	$result = new Categoria();
    	return $result->getAll()->toArray();
    	
    }
    public function populate($values)
    {
    	if(isset($values['id']))
    		$this->id->setValue($values['id']);
    	if(isset($values['postId']))
    		$this->postId->setValue($values['postId']);
    	
    	$this->titulo->setValue(utf8_encode($values['titulo']));
    	$this->subtitulo->setValue(utf8_encode($values['subtitulo']));
    	$this->categoria->setValue($values['categoriaId']);
    	
    	$this->body->setValue(utf8_encode($values['contenido']));
    	$this->desde->setValue($values['desde']);
    	$this->hasta->setValue($values['hasta']);
    	$this->peso->setValue($values['peso']);  
        $this->link->setValue($values['link']); 
	$this->fotoname->setValue($values['foto']);     		    	
    }
}