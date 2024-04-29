const Versao = require('../models/tb_acesso'); // Importa a model Versao

const criarVersao = async (req, res, next) => {
  try {
    const novaVersao = await Versao.create(req.body); // Cria uma nova versão usando o método create da model
    return res.status(201).send({ response: novaVersao });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const obterVersoes = async (req, res, next) => {
  try {
    const versoes = await Versao.findAll(); // Obtém todas as versões usando o método findAll da model
    return res.status(200).send({ response: versoes });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const obterVersaoPorId = async (req, res, next) => {
  try {
    const versao = await Versao.findByPk(req.params.id_versao); // Obtém uma versão pelo ID usando o método findByPk da model
    if (versao) {
      return res.status(200).send({ response: versao });
    } else {
      return res.status(404).send({ message: 'Versão não encontrada' });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const atualizarVersao = async (req, res, next) => {
  try {
    const versaoAtualizada = await Versao.update(req.body, {
      where: { id_versao: req.params.id_versao } // Atualiza uma versão pelo ID usando o método update da model
    });
    if (versaoAtualizada[0]) {
      return res.status(200).send({ message: 'Versão atualizada com sucesso' });
    } else {
      return res.status(404).send({ message: 'Versão não encontrada' });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const deletarVersao = async (req, res, next) => {
  try {
    const deletado = await Versao.destroy({
      where: { id_versao: req.params.id_versao } // Deleta uma versão pelo ID usando o método destroy da model
    });
    if (deletado) {
      return res.status(200).send({ message: 'Versão deletada com sucesso' });
    } else {
      return res.status(404).send({ message: 'Versão não encontrada' });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

module.exports = {
  criarVersao,
  obterVersoes,
  obterVersaoPorId,
  atualizarVersao,
  deletarVersao
};
