<?php
class My_Adapter_Twitter extends My_Adapter_Oauth
{
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
    
    /**
* Constructor
*
* @param array $options An array of options for this adapter
* @param string $consumerKey Consumer key
* @param string $consumerSecret Consumer secret
* @param string $callbackUrl Callback URL
*/
    public function __construct(array $options = array(),
        $consumerKey = null, $consumerSecret = null, $callbackUrl = null)
    {
        $this->setOptions($options);
        
        if ($consumerKey !== null) {
            $this->setConsumerKey($consumerKey);
        }
        
        if ($consumerSecret !== null) {
            $this->setConsumerSecret($consumerSecret);
        }
        
        if ($callbackUrl !== null) {
            $this->setCallbackUrl($callbackUrl);
        }
    }
    
    /**
* Sets the consumer key for authentication
*
* @param string $consumerKey
* @return Ja_Auth_Adapter_Twitter Fluent interface
*/
    public function setConsumerKey($consumerKey)
    {
        $this->_consumerKey = (string) $consumerKey;
        return $this;
    }
    
    /**
* Gets the consumer key
*
* @return string|null
*/
    public function getConsumerKey()
    {
        return $this->_consumerKey;
    }
    
    /**
* Sets the consumer secret for authentication
*
* @param string $consumerSecret
* @return Ja_Auth_Adapter_Twitter Fluent interface
*/
    public function setConsumerSecret($consumerSecret)
    {
        $this->_consumerSecret = (string) $consumerSecret;
        return $this;
    }
    
    /**
* Gets the consumer secret
*
* @return string|null
*/
    public function getConsumerSecret()
    {
        return $this->_consumerSecret;
    }
    
    /**
* Sets the callback URL
*
* @param string $callbackUrl
* @return Ja_Auth_Adapter_Twitter Fluent interface
*/
    public function setCallbackUrl($callbackUrl)
    {
        $this->_callbackUrl = (string) $callbackUrl;
        return $this;
    }
    
    /**
* Gets the callback URL
*
* @return string|null
*/
    public function getCallbackUrl()
    {
        return $this->_callbackUrl;
    }
    
    /**
* Authenticate the user
*
* @return Zend_Auth_Result
*/
    public function authenticate()
    {
        if (!$this->_consumerKey) {
            $code = Zend_Auth_Result::FAILURE;
            $message = array('A consumer key is required');
            return new Zend_Auth_Result($code, '', $message);
        }
        
        if (!$this->_consumerSecret) {
            $code = Zend_Auth_Result::FAILURE;
            $message = array('A consumer secret is required');
            return new Zend_Auth_Result($code, '', $message);
        }
        
        if (!$this->_callbackUrl) {
            $code = Zend_Auth_Result::FAILURE;
            $message = array('A callback URL is required');
            return new Zend_Auth_Result($code, '', $message);
        }
        
       $oauthConfig = array(
            'callbackUrl' => $this->_callbackUrl,
            'siteUrl' => 'https://twitter.com/oauth',
            'consumerKey' => $this->_consumerKey,
            'consumerSecret' => $this->_consumerSecret,
            'sessionNamespace' => 'twitter'

        );
       
        
        require_once 'Zend/Oauth/Consumer.php';
        $consumer = new Zend_Oauth_Consumer($oauthConfig);
        // var_dump($consumer);die;
        $this->setConsumer($consumer);
        //$token = $consumer->getRequestToken();
        $response =  parent::authenticate();
        //var_dump($response);die;
       // oauth_token
        
        
        if($response->isValid()) {
                $session = new Zend_Session_Namespace('twitter');
                $record = $response->getIdentity();
                $session->user = $record;
                //var_dump($record);die;
                $usuario = Usuario::verifyExternalUser("twitter", 
                $record['user_id'], $record['screen_name']);
                return new Zend_Auth_Result(Zend_Auth_Result::SUCCESS , $usuario, array());
        	
        } else {
        		return new Zend_Auth_Result(Zend_Auth_Result::FAILURE , array(), array());
        }


        //Zend_Debug::dump($response);die;
    }
}