<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class My_Social_Facebook{
    
      /**
     * The Authentication URI, used to bounce the user to the facebook redirect uri.
     *
     * @var string
     */
    const AUTH_URI = 'https://graph.facebook.com/oauth/authorize?client_id=%s&redirect_uri=%s';

    /**
     * The token URI, used to retrieve the OAuth Token.
     *
     * @var string
     */
    const TOKEN_URI = 'https://graph.facebook.com/oauth/access_token';

    /**
     * The user URI, used to retrieve information about the user.
     *
     * @var string
     */
    const USER_URI = 'https://graph.facebook.com/me';
   
    /**
     * The post URI, used to post on the wall.
     *
     * @var string
     */   
    const POST_URI = 'https://graph.facebook.com/me/feed';  

    
    public function authenticate($appId, $secret, $redirectUri, $scope){
        $frontController = Zend_Controller_Front::getInstance();
    	$request = $frontController->getRequest();

    	// First check to see wether we're processing a redirect response.
    	$code = $request->getParam('code');

    	if ( empty ($code ) )
    	{
	    	// Create the initial redirect
	    	$loginUri = sprintf(My_Social_Facebook::AUTH_URI , $appId, $redirectUri);

	    	if ( !empty($scope) )
	    	{
	    		$loginUri .= "&scope=" . $scope;
	    	}
                //die($loginUri);
	    	header('Location: ' . $loginUri );die;
    	}
    	else
    	{
            //die(My_Social_Facebook::TOKEN_URI );
    		// Looks like we have a code. Let's get ourselves an access token
	    	$client = new Zend_Http_Client(My_Social_Facebook::TOKEN_URI );
	    	$client->setParameterGet('client_id', $appId);
	    	$client->setParameterGet('client_secret', $secret);
	    	$client->setParameterGet('code', $code);
	    	$client->setParameterGet('redirect_uri', $redirectUri);

	    	$result = $client->request('GET');
	    	$params = array();
               // var_dump($result);
	    	parse_str($result->getBody(), $params);
                $session = new Zend_Session_Namespace('facebook');
                $session->access_token = $params['access_token'];
                $this->_access_token = $params['access_token'];
                
	    	// REtrieve the user info
	    	$client = new Zend_Http_Client(My_Social_Facebook::USER_URI );
	    	$client->setParameterGet('client_id', $appId);
	    	$client->setParameterGet('access_token', $params['access_token']);
                
	    	$user = json_decode($result->getBody());
                var_dump($user);die;
	        $session->user =  $user;  		
            return $user;
    	}

        return false;
    
    }
        public static function publish($content, $photoUrl, $accessToken){
       // die($accessToken);
                if (!isset($accessToken))
                        return false;
                
        	$client = new Zend_Http_Client( My_Adapter_Facebook::POST_URI  );
	    	$client->setParameterGet('access_token', $accessToken);
                $client->setParameterGet('picture', $photoUrl);
                $client->setParameterGet('message', $content);
                $client->setParameterGet('name', 'test post');

	    	$result = $client->request('POST');
                //	$params = array();
                //parse_str($result->getBody(), $params);
                
                return $result->getBody();
        
    }
    
}
?>
