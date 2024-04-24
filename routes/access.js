const express = require("express");
const router = express.Router();
const acessosController = require("../controllers/accessController");

router.post("/novo", acessosController.novoAcesso);


/**
 * @swagger
 * tags:
 *   name: Acessos
 *   description: Gerenciamento dos acessos à plataforma
 */

/**
 * @swagger
 * /acessos:
 *   post:
 *     summary: Registra um novo acesso à plataforma
 *     tags: [Acessos]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/AcessoInput'
 *     responses:
 *       201:
 *         description: Acesso registrado com sucesso.
 *       400:
 *         description: Dados incompletos no corpo da requisição.
 *       409:
 *         description: Um acesso com essa plataforma ou endereço IP já existe.
 *       500:
 *         description: Erro ao registrar o acesso.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     AcessoInput:
 *       type: object
 *       properties:
 *         latitude:
 *           type: string
 *           description: Latitude do acesso.
 *         longitude:
 *           type: string
 *           description: Longitude do acesso.
 *         regiao:
 *           type: string
 *           description: Região do acesso.
 *         plataforma:
 *           type: string
 *           description: Plataforma utilizada para o acesso.
 *         navegador:
 *           type: string
 *           description: Navegador utilizado para o acesso.
 *         enderecoIp:
 *           type: string
 *           description: Endereço IP do acesso.
 *         id_user:
 *           type: integer
 *           description: ID do usuário associado ao acesso.
 *       required:
 *         - latitude
 *         - longitude
 *         - regiao
 *         - plataforma
 *         - navegador
 *         - enderecoIp
 *         - id_user
 *       example:
 *         latitude: "40.7128"
 *         longitude: "74.0060"
 *         regiao: "Nova York"
 *         plataforma: "Windows"
 *         navegador: "Chrome"
 *         enderecoIp: "192.168.1.1"
 *         id_user: 1
 *     Acesso:
 *       type: object
 *       properties:
 *         id_acesso:
 *           type: integer
 *           description: ID do acesso.
 *         latitude:
 *           type: string
 *           description: Latitude do acesso.
 *         longitude:
 *           type: string
 *           description: Longitude do acesso.
 *         regiao:
 *           type: string
 *           description: Região do acesso.
 *         plataforma:
 *           type: string
 *           description: Plataforma utilizada para o acesso.
 *         navegador:
 *           type: string
 *           description: Navegador utilizado para o acesso.
 *         enderecoIp:
 *           type: string
 *           description: Endereço IP do acesso.
 *         id_user:
 *           type: integer
 *           description: ID do usuário associado ao acesso.
 *       required:
 *         - latitude
 *         - longitude
 *         - regiao
 *         - plataforma
 *         - navegador
 *         - enderecoIp
 *         - id_user
 *       example:
 *         id_acesso: 1
 *         latitude: "40.7128"
 *         longitude: "74.0060"
 *         regiao: "Nova York"
 *         plataforma: "Windows"
 *         navegador: "Chrome"
 *         enderecoIp: "192.168.1.1"
 *         id_user: 1
 */



module.exports = router;
