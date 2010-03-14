<?php

class ParticipantesController extends Phpdf_Controller_Action
{
	
	public function indexAction()
	{
	    $uf  = new Uf();
	    $rowSetUfs = $uf->fetchAll(null, 'nome');
	    
	    $ufs = array();
	    foreach($rowSetUfs as $rowUf) {
            $ufs[$rowUf->id] = $rowUf->nome;
	    }
	    
	    $this->view->ufs = $ufs;
	}
	
	public function cadastrarAction() 
	{
	    if($this->getRequest()->isPost()) {
    	    $usuario      = new Usuario();
            $dados        = $this->_getAllParams();
    	    $rowUsuario = $usuario->createRow();
    	    unset($dados['id']);
    	    
    	    $dados['perfil_id']   = 10;
    	    $dados['dt_cadastro'] = date('Y-m-d h:i:s');
    	    $rowUsuario->setFromArray($dados);
    	    try {
    	        $rowUsuario->save();
    	        $this->_addMessage('Você foi cadastrado com sucesso');
        	} catch ( Exception $e ) {
                $this->_addMessage('Seu cadastro não foi realizado');
            }
	    }
	    $this->_redirect('participantes');
	}
}
