const express = require("express");
const router = express.Router();
const emailController = require("../controllers/emailsController");

router.post("/boas-vindas", emailController.enviarBoasVindas);
router.post("/senha", emailController.enviarSenha);
router.post("/imovel", emailController.enviarNovoImovel);
router.post("/acesso", emailController.enviarEmailAcesso);


/**
 * @swagger
 * tags:
 *   name: EmailController
 *   description: Controle de envio de e-mails
 */

/**
 * @swagger
 * /enviar-boas-vindas:
 *   post:
 *     summary: Envia e-mail de boas-vindas
 *     tags: [EmailController]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/EnviarBoasVindasRequest'
 *     responses:
 *       200:
 *         description: E-mail de boas-vindas enviado com sucesso.
 *       500:
 *         description: Erro ao enviar o e-mail de boas-vindas.
 */

/**
 * @swagger
 * /enviar-novo-cadastro-anfitriao:
 *   post:
 *     summary: Envia e-mail de novo cadastro para o anfitrião
 *     tags: [EmailController]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/EnviarNovoCadastroAnfitriaoRequest'
 *     responses:
 *       200:
 *         description: E-mail de novo cadastro enviado com sucesso.
 *       500:
 *         description: Erro ao enviar o e-mail de novo cadastro.
 */

/**
 * @swagger
 * /enviar-doc-anfitriao:
 *   post:
 *     summary: Envia e-mail de novos documentos para o anfitrião
 *     tags: [EmailController]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/EnviarDocAnfitriaoRequest'
 *     responses:
 *       200:
 *         description: E-mail de novos documentos enviado com sucesso.
 *       500:
 *         description: Erro ao enviar o e-mail de novos documentos.
 */

/**
 * @swagger
 * /enviar-email-acesso:
 *   post:
 *     summary: Envia e-mail de acesso detectado
 *     tags: [EmailController]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/EnviarEmailAcessoRequest'
 *     responses:
 *       200:
 *         description: E-mail de acesso detectado enviado com sucesso.
 *       500:
 *         description: Erro ao enviar o e-mail de acesso detectado.
 */

/**
 * @swagger
 * /enviar-altera-senha:
 *   post:
 *     summary: Envia e-mail de alteração de senha
 *     tags: [EmailController]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/EnviarAlteraSenhaRequest'
 *     responses:
 *       200:
 *         description: E-mail de alteração de senha enviado com sucesso.
 *       500:
 *         description: Erro ao enviar o e-mail de alteração de senha.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     EnviarBoasVindasRequest:
 *       type: object
 *       properties:
 *         email:
 *           type: string
 *           description: E-mail do destinatário.
 *         nome:
 *           type: string
 *           description: Nome do destinatário.
 *         id:
 *           type: integer
 *           description: ID do destinatário.
 *         perfil:
 *           type: string
 *           description: Perfil do destinatário.
 *       example:
 *         email: "exemplo@gmail.com"
 *         nome: "João"
 *         id: 123
 *         perfil: "Usuário"
 *     EnviarNovoCadastroAnfitriaoRequest:
 *       type: object
 *       properties:
 *         email:
 *           type: string
 *           description: E-mail do destinatário.
 *         nomecliente:
 *           type: string
 *           description: Nome do cliente.
 *       example:
 *         email: "exemplo@gmail.com"
 *         nomecliente: "Maria"
 *     EnviarDocAnfitriaoRequest:
 *       type: object
 *       properties:
 *         email:
 *           type: string
 *           description: E-mail do destinatário.
 *       example:
 *         email: "exemplo@gmail.com"
 *     EnviarEmailAcessoRequest:
 *       type: object
 *       properties:
 *         email:
 *           type: string
 *           description: E-mail do destinatário.
 *         nome:
 *           type: string
 *           description: Nome do usuário.
 *         regiao:
 *           type: string
 *           description: Região do acesso.
 *         plataforma:
 *           type: string
 *           description: Plataforma do acesso.
 *         navegador:
 *           type: string
 *           description: Navegador do acesso.
 *         enderecoIp:
 *           type: string
 *           description: Endereço IP do acesso.
 *       example:
 *         email: "exemplo@gmail.com"
 *         nome: "João"
 *         regiao: "São Paulo"
 *         plataforma: "Windows"
 *         navegador: "Chrome"
 *         enderecoIp: "192.168.0.1"
 *     EnviarAlteraSenhaRequest:
 *       type: object
 *       properties:
 *         email:
 *           type: string
 *           description: E-mail do destinatário.
 *         nome:
 *           type: string
 *           description: Nome do usuário.
 *         regiao:
 *           type: string
 *           description: Região do acesso.
 *         plataforma:
 *           type: string
 *           description: Plataforma do acesso.
 *         navegador:
 *           type: string
 *           description: Navegador do acesso.
 *         enderecoIp:
 *           type: string
 *           description: Endereço IP do acesso.
 *       example:
 *         email: "exemplo@gmail.com"
 *         nome: "João"
 *         regiao: "São Paulo"
 *         plataforma: "Windows"
 *         navegador: "Chrome"
 *         enderecoIp: "192.168.0.1"
 */



module.exports = router;
