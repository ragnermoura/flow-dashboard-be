const express = require("express");
const router = express.Router();
const tokensController = require("../controllers/tokenController");

// Rota para criar um novo token
router.post("/cadastrar", tokensController.criarToken);
router.get("/buscar", tokensController.buscarTodosTokens);
router.get("/buscar/:id_token", tokensController.buscarTokenPorId);
router.put("/edit/:id_token", tokensController.atualizarToken);
router.delete("/delete/:id_token", tokensController.deletarToken);


/**
 * @swagger
 * tags:
 *   name: Tokens
 *   description: Gerenciamento dos tokens
 */

/**
 * @swagger
 * /tokens:
 *   get:
 *     summary: Lista todos os tokens
 *     tags: [Tokens]
 *     responses:
 *       200:
 *         description: Lista de tokens.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Token'
 *   post:
 *     summary: Cria um novo token
 *     tags: [Tokens]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Token'
 *     responses:
 *       200:
 *         description: Token criado com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Token'
 *       400:
 *         description: Erro na requisição.
 */

/**
 * @swagger
 * /tokens/{id}:
 *   get:
 *     summary: Busca um token pelo ID
 *     tags: [Tokens]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do token
 *     responses:
 *       200:
 *         description: Token encontrado.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Token'
 *       404:
 *         description: Token não encontrado.
 *   put:
 *     summary: Atualiza um token pelo ID
 *     tags: [Tokens]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do token
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Token'
 *     responses:
 *       200:
 *         description: Token atualizado com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Token'
 *       404:
 *         description: Token não encontrado.
 *   delete:
 *     summary: Deleta um token pelo ID
 *     tags: [Tokens]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do token
 *     responses:
 *       200:
 *         description: Token deletado com sucesso.
 *       404:
 *         description: Token não encontrado.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Token:
 *       type: object
 *       required:
 *         - token
 *       properties:
 *         id_token:
 *           type: integer
 *           description: O ID do token.
 *         token:
 *           type: string
 *           description: O valor do token.
 *       example:
 *         id_token: 1
 *         token: "123456789abcdef"
 */






module.exports = router;
