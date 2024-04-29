<?php

# API
class API {
    

    # Escreve na API de usuarios
    private function SetUsuarios($dados){
        file_put_contents(__DIR__ . '/data/users.json', json_encode($dados, JSON_PRETTY_PRINT));
    }
    
    # Retorna dados dos usuarios
    private function GetUsuarios(){
        return json_decode(file_get_contents(__DIR__ . '/data/users.json'), true);
    }
    
    # Novo usuario
    private function NewUser($dados){
        $usuario = $this->GetUsuariosPormt4id($dados['mtid']);
        if (!$usuario) {
            $usuarios = $this->GetUsuarios();
            $usuarios[] = $dados;
            $this->SetUsuarios($usuarios);
            return $dados;
        }else{
            return 'false';
        }
    }

    # Buscar usuarios por mt4id
    private function GetUsuariosPormt4id($mt4id)
    {
        $usuarios = $this->GetUsuarios();
        foreach ($usuarios as $usuario) {
            if ($usuario['mtid'] == $mt4id or $usuario['cid'] == $mt4id) {
                return $usuario;
            }
        }
        return null;
    }
    
    # Deletar usuarios por mt4id
    private function DeleteUsuario($mt4id){
        $usuarios = $this->GetUsuarios();
        foreach ($usuarios as $i => $usuario) {
            if ($usuario['mtid'] == $mt4id) {
                array_splice($usuarios, $i, 1);
            }
        }
        $this->SetUsuarios($usuarios);
    }
    
    # Atualizar cadastro de usuário
    private function updateUser($dados, $mt4id){
        
        if(!isset($dados['ativar_ip']))
        {
            $dados['ativar_ip'] = 'off';
        }
        
        if(!isset($dados['ativar_nome_usuario']))
        {
            $dados['ativar_nome_usuario'] = 'off';
        }
        
        if(!isset($dados['ativar_expiracao']))
        {
            $dados['ativar_expiracao'] = 'off';
        }
        
        if(!isset($dados['ativar_tipo_conta']))
        {
            $dados['ativar_tipo_conta'] = 'off'; 
        }
        
        $AtualizarUsuario = [];
        $usuarios = $this->GetUsuarios();

        foreach ($usuarios as $i => $usuario) {
            if ($usuario['mtid'] == $mt4id){
                $usuarios[$i] = $AtualizarUsuario = array_merge($usuario, $dados);
            }
        }
        $this->SetUsuarios($usuarios);
        return $AtualizarUsuario;
    }
    
    
    
    
    
    
    
    # Escreve na API do projeto
    private function SetProjeto($dados){
        file_put_contents(__DIR__ . '/data/config.json', json_encode($dados, JSON_PRETTY_PRINT));
    }
    
    # Retorna dados do projeto
    private function GetProjeto(){
        return json_decode(file_get_contents(__DIR__ . '/data/config.json'), true);
    }

    # Buscar projeto
    private function GetProjetoPorid($id)
    {
        $projetos = $this->GetProjeto();
        foreach ($projetos as $proj) {
            if ($proj['id'] == $id) {
                return $proj;
            }
        }
        return null;
    }
    
    # Atualizar projeto
    private function updateProjeto($dados, $id){
        
        if(!isset($dados['alert_data_hora_compilado']))
        {
            $dados['alert_data_hora_compilado'] = 'off';
        }
        if(!isset($dados['atualizar']))
        {
            $dados['atualizar'] = 'off';
        }
        
        
        $AtualizarProjeto = [];
        
        $projetos = $this->GetProjeto();
        
         foreach ($projetos as $i => $projeto) {
            if ($projeto['id'] == $id){
                $projetos[$i] = $AtualizarProjeto = array_merge($projeto, $dados);
            }
        }
        $this->SetProjeto($projetos);
        return $AtualizarProjeto;
    }
    
    
 
       
   
    
    
    
    
    
    
    
    
    
    
    
    

    # FUNÇÕES PUBLICAS

    // Novo usuário
    public function NovoUsuario($dados) {
        return $this->NewUser($dados);
    }
    
    // Get usuários
    public function Usuarios() {
        return $this->GetUsuarios();
    }

    // Get usuário
    public function Usuario($mt4id) {
        return $this->GetUsuariosPormt4id($mt4id);
    }
    
    // Delete usuário
    public function ExcluirUsuario($mt4id) {
        return $this->DeleteUsuario($mt4id);
    }
    
    // Update usuário
    public function AtualizarUsuario($dados, $mt4id) {
        return $this->updateUser($dados, $mt4id);
    }
    
    // Get projeto
    public function Projeto($id) {
        return $this->GetProjetoPorid($id);
    }
    
    // Update usuário
    public function AtualizarProjeto($dados, $id) {
        return $this->updateProjeto($dados, $id);
    }
    
}



?>