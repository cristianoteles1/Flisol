<?php

class Phpdf_Controller_Plugin_Acl extends Zend_Controller_Plugin_Abstract
{

	/**
	 * Called before an action is dispatched by Zend_Controller_Dispatcher.
	 *
	 * This callback allows for proxy or filter behavior.  By altering the
	 * request and resetting its dispatched flag (via
	 * {@link Zend_Controller_Request_Abstract::setDispatched() setDispatched(false)}),
	 * the current action may be skipped.
	 *
	 * @param  Zend_Controller_Request_Abstract $request
	 * @return void
	 */
	public function preDispatch(Zend_Controller_Request_Abstract $request)
	{
		$oAuth = Zend_Auth::getInstance();
		$oAcl = $this->getAcl();
		
		// Default role
		if ($oAuth->hasIdentity())
		{
			$oIdentity = $oAuth->getIdentity();
			$sRole     = isset($oIdentity->sRole) ? $oIdentity->sRole : 'identify';
		}

		$sModule     = $request->module;
		$sController = $request->controller;
		$sAction     = $request->action;
		$sResource   = $sController . ':' . $sAction;

		if($oAcl->has($sResource)) {
            if(!$oAcl->isAllowed('all', $sResource))
            {
    			// Access is not allowed
    			if (!$oAcl->isAllowed($sRole, $sResource))
    			{
    			    
    			}
            }
		} else {
    		$flashMessenger = new Zend_Controller_Action_Helper_FlashMessenger();
    		$flashMessenger->addMessage('Acesso negado');
    		$request->setModuleName('default');
    		$request->setControllerName('index');
    		$request->setActionName('index');
		}
	}

	protected function getAcl()
	{
		$oAcl  = new Zend_Acl();
		
		// Perfis
		$oAcl->addRole(new Zend_Acl_Role('all'));
		$oAcl->addRole(new Zend_Acl_Role('admin'), array('all'));
		
		// Conttrolers e Action
		$oAcl->add(new Zend_Acl_Resource('index:index'));
		$oAcl->add(new Zend_Acl_Resource('participantes:index'));
		$oAcl->add(new Zend_Acl_Resource('inscricoes:inscrever'));
		$oAcl->add(new Zend_Acl_Resource('participantes:cadastrar'));
		
		// Permissões
        $oAcl->allow('all', 'index:index');
        $oAcl->allow('all', 'index:index');
        $oAcl->allow('all', 'participantes:cadastrar');
        
		return $oAcl;
	}
}
