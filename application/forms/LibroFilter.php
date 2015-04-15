<?php
class Form_LibroFilter extends Zend_Form
{
    public function init ()
    {
        $this->setMethod('post');
        $editorial = new Zend_Form_Element_Select('filtro_editorial');
        $editorial->setLabel('Editorial:');
        $cats = $this->getEditoriales();
        $editorial->addMultiOption("", 'Elegir editorial ...');
        foreach ($cats as $cat) {
            $editorial->addMultiOption($cat['id'], utf8_encode($cat['nombre']));
        }
        $editorial->setDecorators(array('ViewHelper', 'errors'));
        $editorial->class = "rounded-select span-4";
        $this->addElement($editorial);
        
        $genero = new Zend_Form_Element_Select('filtro_genero');
        $genero->setLabel('Genero:');
        $cats = $this->getGeneros();
        $genero->addMultiOption("", 'Elegir genero ...');
        
        foreach ($cats as $cat) {
            $genero->addMultiOption($cat['id'], utf8_encode($cat['nombre']));
        }
        $genero->setDecorators(array('ViewHelper', 'errors'));
        $genero->class = "rounded-select span-4";
        $this->addElement($genero);
        
        $autor = new Zend_Form_Element_Select('filtro_autor');
        $autor->setLabel('Autor:');
        $cats = $this->getAutores();
        $autor->addMultiOption("", 'Elegir autor ...');
        
        foreach ($cats as $cat) {
            $autor->addMultiOption($cat['id'], utf8_encode($cat['nombre']));
        }
        


		$autor->setDecorators(array('ViewHelper', 'errors'));
        $autor->class = "rounded-select span-4";
        $this->addElement($autor);

        
        $titulo = new Zend_Form_Element_Text('filtro_titulo');
        
        $titulo->setLabel('Titulo:')
             ->addFilter(new Zend_Filter_StringTrim())
             ->setRequired(true)
             ->setValue("typee aqui...");
		$titulo->class = 'rounded-input span-4';
		$titulo->setDecorators(array('ViewHelper', 'errors'));
		
		$this->addElement($titulo);
		
		$oferta = new Zend_Form_Element_Checkbox('oferta');
   		$oferta->setLabel('Oferta')->setValue(false);
        $oferta->class = "checkbox";
        $this->addElement($oferta);
        
   		$destacado = new Zend_Form_Element_Checkbox('destacado');
   		$destacado->setLabel('Destacado')->setValue(false);
        $this->addElement($destacado);
        $destacado->class = "checkbox";
		
   		$novedad = new Zend_Form_Element_Checkbox('novedad');
   		$novedad->setLabel('Novedad')->setValue(false);
        $novedad->class = "checkbox";
        $this->addElement($novedad);
		        
		
		
        $submit = new Zend_Form_Element_Submit('filter');
        $submit->setLabel("Filtrar");
        $submit->class = "ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only";
        $submit->setDecorators(array('ViewHelper'));
        $this->addElement($submit);
    }
    protected function getEditoriales ()
    {
        $result = new Editorial();
        return $result->getAll()->toArray();
    }
    protected function getGeneros ()
    {
        $result = new Genero();
        return $result->getAll()->toArray();
    }
    protected function getAutores ()
    {
        $result = new Autor();
        return $result->getAll()->toArray();
    }
}