<?php

class InscricoesController extends Phpdf_Controller_Action
{
	
	public function indexAction()
	{
	}
	
	public function inscreverAction() 
	{
	    if($this->getRequest()->isPost()) {
    	    $inscricao    = new Inscricao();
            $dados        = $this->_getAllParams();
    	    $rowInscricao = $inscricao->createRow();
    	    unset($dados['id']);
    	    
    	    $rowInscricao->setFromArray($dados);
    	    try {
    	        $rowInscricao->save();
    	        $this->_addMessage('Sua inscrição foi realizado com sucesso');
        	} catch ( Exception $e ) {
                $this->_addMessage('Sua inscrição não foi realizado');
            }
            
	    }
	    $this->_redirect('index');
	}
}
