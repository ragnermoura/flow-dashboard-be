require("dotenv").config();
const express = require("express");
const router = express.Router();
const authController = require("../controllers/loginController");

router.post("/", authController.autenticarUsuario);


/**
 * @swagger
 * tags:
 *   name: Autenticacao
 *   description: Autenticação de usuário
 */

/**
 * @swagger
 * /autenticar:
 *   post:
 *     summary: Autentica um usuário e retorna um JWT
 *     tags: [Autenticacao]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: Email do usuário.
 *                 example: usuario@example.com
 *               senha:
 *                 type: string
 *                 format: password
 *                 description: Senha do usuário.
 *                 example: senha123
 *     responses:
 *       200:
 *         description: Autenticado com sucesso! Retorna o token JWT.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 mensagem:
 *                   type: string
 *                   example: Autenticado com sucesso!
 *                 token:
 *                   type: string
 *                   example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
 *                 id_status:
 *                   type: integer
 *                   example: 1
 *       401:
 *         description: Falha na autenticação.
 *       500:
 *         description: Erro no servidor.
 */



module.exports = router;