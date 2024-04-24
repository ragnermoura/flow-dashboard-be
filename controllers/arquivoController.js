const Arquivo = require('../models/tb_arquivo');

const arquivoController = {
  // GET: Listar todos os arquivos
  listarTodos: async (req, res) => {
    try {
      const arquivos = await Arquivo.findAll();
      res.status(200).json(arquivos);
    } catch (error) {
      res.status(500).json({ message: 'Erro ao buscar os arquivos', error: error.message });
    }
  },

  // GET: Buscar um arquivo específico por ID
  obterArquivo: async (req, res) => {
    try {
      const { id } = req.params;
      const arquivo = await Arquivo.findByPk(id);
      if (arquivo) {
        res.status(200).json(arquivo);
      } else {
        res.status(404).json({ message: 'Arquivo não encontrado' });
      }
    } catch (error) {
      res.status(500).json({ message: 'Erro ao buscar o arquivo', error: error.message });
    }
  },

  // POST: Criar um novo arquivo
  criarArquivo: async (req, res) => {
    try {
      const { ativar_ip, ip, status, cid, mtid, ativar_nome_usuario, nome_usuario, ativar_expiracao, expiracao, ativar_tipo_conta, tipo_conta, page } = req.body;
      const novoArquivo = await Arquivo.create({
        ativar_ip, ip, status, cid, mtid, ativar_nome_usuario, nome_usuario, ativar_expiracao, expiracao, ativar_tipo_conta, tipo_conta, page
      });
      res.status(201).json(novoArquivo);
    } catch (error) {
      res.status(500).json({ message: 'Erro ao criar o arquivo', error: error.message });
    }
  },

  // PUT: Atualizar um arquivo existente
  atualizarArquivo: async (req, res) => {
    try {
      const { id } = req.params;
      const { ativar_ip, ip, status, cid, mtid, ativar_nome_usuario, nome_usuario, ativar_expiracao, expiracao, ativar_tipo_conta, tipo_conta, page } = req.body;
      const arquivo = await Arquivo.findByPk(id);
      if (arquivo) {
        await arquivo.update({ ativar_ip, ip, status, cid, mtid, ativar_nome_usuario, nome_usuario, ativar_expiracao, expiracao, ativar_tipo_conta, tipo_conta, page });
        res.status(200).json({ message: 'Arquivo atualizado com sucesso' });
      } else {
        res.status(404).json({ message: 'Arquivo não encontrado' });
      }
    } catch (error) {
      res.status(500).json({ message: 'Erro ao atualizar o arquivo', error: error.message });
    }
  },

  // DELETE: Deletar um arquivo
  deletarArquivo: async (req, res) => {
    try {
      const { id } = req.params;
      const arquivo = await Arquivo.findByPk(id);
      if (arquivo) {
        await arquivo.destroy();
        res.status(200).json({ message: 'Arquivo deletado com sucesso' });
      } else {
        res.status(404).json({ message: 'Arquivo não encontrado' });
      }
    } catch (error) {
      res.status(500).json({ message: 'Erro ao deletar o arquivo', error: error.message });
    }
  }
};

module.exports = arquivoController;
