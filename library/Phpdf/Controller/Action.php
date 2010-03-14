<?php

class Phpdf_Controller_Action extends Zend_Controller_Action
{
    
	public function init()
	{
	    parent::init();
	    
		// Messages
	    $flashMessenger = new Zend_Controller_Action_Helper_FlashMessenger();
		$this->view->messages  = $flashMessenger->getMessages();
		$flashMessenger->clearMessages();
	}
    
	/**
	 * Set message in flashMessenger
	 * @access protected
	 * @return Zend_Controller_Action_Helper_FlashMessenger
	 */
	protected function _addMessage($msg)
	{
	    $flashMessenger = new Zend_Controller_Action_Helper_FlashMessenger();
		return $flashMessenger->addMessage($msg);
	}
}