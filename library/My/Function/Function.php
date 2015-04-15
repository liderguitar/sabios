<?php

class My_Function_Function {

    public static function makeFriendlyUrl($titulo) {

        // Tranformamos todo a minusculas
        $titulo = strtolower($titulo);
        //Rememplazamos caracteres especiales latinos
        $find = array('�', '�', '�', '�', '�', '�');
        $repl = array('a', 'e', 'i', 'o', 'u', 'n');
        $titulo = str_replace($find, $repl, $titulo);
        // A�aadimos los guiones
        $find = array(' ', '&', '\r\n', '\n', '+');
        $titulo = str_replace($find, '-', $titulo);
        // Eliminamos y Reemplazamos dem�s caracteres especiales
        $find = array('/[^a-z0-9\-<>]/', '/[\-]+/', '/<[^>]*>/');
        $repl = array('', '-', '');
        $titulo = preg_replace($find, $repl, $titulo);
        return $titulo;
    }

    public static function autorUrl($autor) {
        // Tranformamos todo a minusculas
        $autor = strtolower($autor);
        $autor = ucwords($autor);

        //Rememplazamos caracteres especiales latinos
        $find = array('�', '�', '�', '�', '�', '�');
        $repl = array('a', 'e', 'i', 'o', 'u', 'n');
        $autor = str_replace($find, $repl, $autor);

        // A�aadimos los guiones
        $find = array(' ', '&', '\r\n', '\n', '+');
        $autor = str_replace($find, '_', $autor);

        return $autor;
    }

    public static function word_trim($string, $count, $ellipsis = FALSE) {
        $words = explode(' ', $string);
        if (count($words) > $count) {
            array_splice($words, $count);
            $string = implode(' ', $words);
            if (is_string($ellipsis)) {
                $string .= $ellipsis;
            } elseif ($ellipsis) {
                $string .= '&hellip;';
            }
        }
        return $string;
    }

    public static function getCategoriaTree($level = 0, $parent = 0) {

        $array = array();
        $rec = Doctrine_Core::getTable('Categoria')
                        ->findByDql("borrado='N' 
                            and app_id='" . APPLICATION_ID . "' 
                            and parent_id=" . $parent
                        )->toArray();

        foreach ($rec as $item) {
            $array[$level]['categoria'] = $item;
            $children = My_Function_Function::getCategoriaTree($level + 1, $item['id']);
            if (count($children))
                $array[$level]['children'] = $children;
            $level++;
        }

        return $array;
    }

    public static function getCategoriaCombo($level = 0, $parent = 0) {

        $array = array();
        $rec = Doctrine_Core::getTable('Categoria')
                        ->findByDql("borrado='N' 
                            and app_id='" . APPLICATION_ID . "' 
                            and parent_id=" . $parent
                        )->toArray();

        foreach ($rec as $item) {

            $arrayt['categoria'] = str_repeat("—", $level) . " " . $item['nombre'];
            $arrayt['id'] = $item['id'];
            $arrayt['object'] = $item;
            $array[] = $arrayt;
            $children = My_Function_Function::getCategoriaCombo($level + 1, $item['id']);
            if (count($children)) {
                foreach ($children as $child) {
                    $arrayt['categoria'] = $child['categoria'];
                    $arrayt['id'] = $child['id'];
                    $arrayt['object'] = $item;
                    $array[] = $arrayt;
                }
            }
        }

        return $array;
    }

    public static function getMenuHtml($level = 0, $parent = 0, $menu_id = 1) {
        $html = "";
        try {
            $rec = Doctrine_Core::getTable('MenuItem')
                            ->findByDql(" id_parent_menu_item=" . $parent . " and id_menu=" . $menu_id .
                                    " order by prioridad")->toArray();
        } catch (Exception $e) {
            die($e->getMessage());
        }

        //My_Function_Function::var_debug($rec);
        foreach ($rec as $item) {
            if ($item['path']) {
                $html .= "<li><a href='" . $item['path'] . "'>" . $item['nombre'] . "</a></li>";
            } else {
                $html .= "<li menuid='" . $item['id'] . "' class='expandable'>" . $item['nombre'] . "</li>";
            }
            $child = My_Function_Function::getMenuHtml($level + 1, $item['id']);
            if ($child) {
                $html .= "<div class='ul-container oculto'><ul>" . $child . "</ul></div>";
            }
        }

        //My_Function_Function::var_debug($html); 

        return $html;
    }

    public static function getChildMenuHtml($level = 0, $parent = 0) {
        $html = "";
        try {
            $rec = Doctrine_Core::getTable('MenuItem')
                            ->findByDql(" id_parent_menu_item=" . $parent
                            )->toArray();
        } catch (Exception $e) {
            die($e->getMessage());
        }

        //My_Function_Function::var_debug($rec);
        foreach ($rec as $item) {
            $html .= "<li>" . $item['nombre'] . "</li>";
            $child = My_Function_Function::getMenuHtml($level + 1, $item['id']);
            if ($child) {
                My_Function_Function::var_debug($child);
                $html .= "<ul>" . $child . "</ul>";
            }
        }

        //My_Function_Function::var_debug($html); 
        if ($html && $parent)
            $html = "<ul>" . $html . "</ul>";

        return $html;
    }

    public static function thumbnail($jpgimage, $outputfile, $type, $maxwidth = 236, $maxheight = 177) {

        switch ($type[1]) {
            case 'jpg' :
                $img = imagecreatefromjpeg($jpgimage);
                break;
            case 'jpeg' :
                $img = imagecreatefromjpeg($jpgimage);
                break;
            case 'gif' :
                $img = imagecreatefromgif($jpgimage);
                break;
            case 'png' :
                $img = imagecreatefrompng($jpgimage);
                break;
        }
//or imagecreatefrompng,imagecreatefromgif,etc. depending on user's uploaded file extension

        $width = imagesx($img); //get width and height of original image
        $height = imagesy($img);

//determine which side is the longest to use in calculating length of the shorter side, since the longest will be the max size for whichever side is longest.    
        if ($height > $width) {
            $ratio = $maxheight / $height;
            $newheight = $maxheight;
            $newwidth = $width * $ratio;
        } else {
            $ratio = $maxwidth / $width;
            $newwidth = $maxwidth;
            $newheight = $height * $ratio;
        }

//create new image resource to hold the resized image
        $newimg = imagecreatetruecolor($newwidth, $newheight);

        $palsize = ImageColorsTotal($img);  //Get palette size for original image
        for ($i = 0; $i < $palsize; $i++) { //Assign color palette to new image
            $colors = ImageColorsForIndex($img, $i);
            ImageColorAllocate($newimg, $colors['red'], $colors['green'], $colors['blue']);
        }

//copy original image into new image at new size.
        imagecopyresized($newimg, $img, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);

        imagejpeg($newimg, $outputfile); //$output file is the path/filename where you wish to save the file.  
//Have to figure that one out yourself using whatever rules you want.  Can use imagegif() or imagepng() or whatever.
    }

    public static function var_debug($var, $die = true) {

        echo '<pre>' . print_r($var, true) . '</pre>';

        if ($die)
            die;
    }

    public static function getCategoriasBread($id) {

        if (!$id) {
            return "<ul class='ul-cat'><li class='li-cat'><a href='/catalogo/categoria/'>Todas las Categorias</a></li></ul>";
        }
        $array = array_reverse(self::getCategorias($id));

        $string = "<ul class='ul-cat'>";
        foreach ($array as $cat) {
            $string .= "<li class='li-cat'><a href='/catalogo/categoria/" . $cat["id"] . "'>" . $cat["nombre"] . "</a></li>";
        }

        $string .= "</ul>";
        return $string;
    }

    public static function getCategorias($id) {

        $array = array();
        $parent = self::getParent($id);

        while ($parent) {

            $array[] = $parent;
            $parent = self::getParent($parent['parent_id']);
        }

        return $array;
    }

    public static function getParent($id) {

        $query = "borrado='N' and app_id='" . APPLICATION_ID . "' and id=" . $id;
        $rec = Doctrine_Core::getTable('Categoria')
                        ->findByDql($query)->toArray();
        return count($rec) ? $rec[0] : false;
    }

    public static function getCatChild($id) {

        $query = "borrado='N' and app_id='" . APPLICATION_ID . "' and parent_id=" . $id;
        $rec = Doctrine_Core::getTable('Categoria')
                        ->findByDql($query)->toArray();
        return count($rec) ? $rec[0] : false;
    }

    public static function getMenuCatHtml() {


        $array = My_Function_Function::getCategoriaCombo();
        $html = "";
        foreach ($array as $item) {
            $html .= "<li><a href='/catalogo/categoria/" . $item['id'] . "'>" . $item['categoria'] . "</a></li>";
        }
        if ($html)
            $html = "<ul>" . $html . "</ul>";
        //My_Function_Function::var_debug($html); 



        return $html;
    }

    public static function getCatChildren($id) {

        //$cats = array($id);
        $cats = array();
        $child = true;


        $query = "borrado='N' and app_id='" . APPLICATION_ID . "' and parent_id=" . $id;
        $rec = Doctrine_Core::getTable('Categoria')
                        ->findByDql($query)->toArray();

//            My_Function_Function::var_debug($rec);

        foreach ($rec as $cat) {
            $cats[] = $cat['id'];
            $children = My_Function_Function::getCatChildren($cat['id']);
            foreach ($children as $child) {
                $cats[] = $child;
            }
        }

        return $cats;
    }

    public static function sendEmail($options) {
        $config = array(
            'ssl' => 'tls',
            'port' => 587,
            'auth' => 'login',
            'username' => 'sabbios.web@gmail.com',
            'password' => 'sabiosrules2015'
            );

        $transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $config);

        $mail = new Zend_Mail();
        $mail->setBodyHtml($options['bodytext']);
        $mail->setFrom('your@gmail.com');
        $mail->addTo($options['email'], $options['name']);
        $mail->setSubject($options['subject']);
        $mail->send($transport);
    }

}

