const express = require('express');
const router = express.Router();
const arquivoController = require('../controllers/arquivoController');

// Rota para listar todos os arquivos
router.get('/', arquivoController.listarTodos);
// Rota para obter um único arquivo por ID
router.get('/:id_arquivo', arquivoController.obterArquivo);
// Rota para criar um novo arquivo
router.post('/cadastrar', arquivoController.criarArquivo);
// Rota para atualizar um arquivo existente
router.put('/edit/:id_arquivo', arquivoController.atualizarArquivo);
// Rota para deletar um arquivo
router.delete('/delete/:id_arquivo', arquivoController.deletarArquivo);

module.exports = router;
