<?php
/**
 * UploadController
 * 
 * @author
 * @version 
 */

class UploaderController extends Zend_Controller_Action
{
    /**
     * The default action - show the home page
     */
    public function indexAction ()
    {
        // TODO Auto-generated UploadController::indexAction() default action
    }
    public function uploadAction()
    {

			if  ($this->getRequest()->isPost()){
					
			}
			$this->_helper->layout()->disableLayout() ;
			$this->_helper->viewRenderer->setNoRender(true) ;
			$error = "";
			$msg = "";
			$fileElementName = 'fileToUpload';
			if(!empty($_FILES[$fileElementName]['error']))
			{
				switch($_FILES[$fileElementName]['error'])
				{
		
					case '1':
						$error = 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
						break;
					case '2':
						$error = 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
						break;
					case '3':
						$error = 'The uploaded file was only partially uploaded';
						break;
					case '4':
						$error = 'No file was uploaded.';
						break;
		
					case '6':
						$error = 'Missing a temporary folder';
						break;
					case '7':
						$error = 'Failed to write file to disk';
						break;
					case '8':
						$error = 'File upload stopped by extension';
						break;
					case '999':
					default:
						$error = 'No error code avaiable';
				}
			}elseif(empty($_FILES['fileToUpload']['tmp_name']) || $_FILES['fileToUpload']['tmp_name'] == 'none')
			{
				$error = 'No file was uploaded..';
			}else 
			{
				
					$msg .= " File Name: " . $_FILES['fileToUpload']['name'] . ", ";
					$msg .= " Tmp Name: " .$_FILES['fileToUpload']['tmp_name'];
					$msg .= " File Size: " . @filesize($_FILES['fileToUpload']['tmp_name']);
					$tmp_name = $_FILES["fileToUpload"]["tmp_name"];
					$name = $_FILES["fileToUpload"]["name"];

					move_uploaded_file($tmp_name,  "files/" .$name);

			}		
			//window.opener.CKEDITOR.tools.callFunction('2','/image.pepe');
			echo   "{"
			.				"    msg: 'Todo bien',\n"
			.				"    error: '" . $error . "',\n"
			.				"    path: '" . "/files/" .$name . "'\n"			
			.               "}";
		    }
}