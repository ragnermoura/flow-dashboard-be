const express = require("express");
const router = express.Router();
const usuariosController = require("../controllers/recoveryController");

router.post("/validar-email", usuariosController.validaEmail);
router.patch("/alterar-senha", usuariosController.alterarSenha);

/**
 * @swagger
 * /usuarios/validaEmail:
 *   post:
 *     summary: Valida se o e-mail existe na base de dados
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: E-mail do usuário a ser validado.
 *                 example: "usuario@example.com"
 *     responses:
 *       200:
 *         description: Usuário encontrado com o e-mail fornecido.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Usuario'
 *       404:
 *         description: Usuário não encontrado.
 *       500:
 *         description: Erro ao processar a solicitação.
 */

/**
 * @swagger
 * /usuarios/alterarSenha:
 *   post:
 *     summary: Altera a senha de um usuário
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_user:
 *                 type: integer
 *                 description: ID do usuário cuja senha será alterada.
 *                 example: 1
 *               senha:
 *                 type: string
 *                 format: password
 *                 description: Nova senha do usuário.
 *                 example: "novaSenha123"
 *     responses:
 *       201:
 *         description: Senha alterada com sucesso.
 *       404:
 *         description: Usuário não encontrado.
 *       500:
 *         description: Erro ao processar a solicitação.
 */


module.exports = router;
