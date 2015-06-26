<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class My_Social_Twitter extends My_Adapter_Oauth{
    
    /**
* Consumer key, provided by Twitter.com
*
* @var string
*/
    protected $_consumerKey = null;
    
    /**
* Consumer secret, provided by Twitter.com
*
* @var string
*/
    protected $_consumerSecret = null;
    
    /**
* URL to redirect the user back from Twitter.com
*
* @var string
*/
    protected $_callbackUrl = null;
    
    /**
* Array of options for this adapter. Options include:
* - sessionNamespace: session namespace override
*
* @var array
*/
    protected $_options = null;

    
    
   public function authenticates($consumerKey, $consumerSecret, $callbackUrl  )
    {
   
        
       $oauthConfig = array(
            'callbackUrl' => $callbackUrl,
            'siteUrl' => 'https://twitter.com/oauth',
            'consumerKey' => $consumerKey,
            'consumerSecret' => $consumerSecret,
            'sessionNamespace' => 'twitter'

        );
       
        
        require_once 'Zend/Oauth/Consumer.php';
        $consumer = new Zend_Oauth_Consumer($oauthConfig);
        // var_dump($consumer);die;
        //$this->setConsumer($consumer);
        //$token = $consumer->getRequestToken();
        $response =  parent::authenticate();
        //var_dump($response);die;
       // oauth_token
        
        
        if($response->isValid()) {
                $session = new Zend_Session_Namespace('twitter');
                $record = $response->getIdentity();
                $session->user = $record;

                return true;
        	
        } else {
        	return false;
        }


        //Zend_Debug::dump($response);die;
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
