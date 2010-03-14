<?php

class IndexController extends Phpdf_Controller_Action
{

    public function indexAction()
    {
        $this->_redirect('participantes');
        // action body
    }

    public function loginAction()
    {
    	if ( $this->_request->isPost() )
    	{
    		$auth = new Zend_Auth_Adapter_DbTable(
    			Zend_Registry::get('db'),'usuario','email','senha'
    		);
    		$auth->setIdentity( $this->_request->getPost('email') )
    			 ->setCredential( $this->_request->getPost('senha') );
    		$result = $auth->authenticate();
    		if( $result->isValid() )
    		{
    			$this->_redirect('/inicio/');
    		}
    		else
    		{
    			$this->_redirect('/index/');
    		}
    	}
    	else
    	{
    		$this->_redirect('/index/');
    	}
    }
}