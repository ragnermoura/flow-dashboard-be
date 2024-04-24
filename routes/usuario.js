const express = require("express");
const router = express.Router();
const userController = require("../controllers/usuariosController");
const { uploadFields } = require("../helpers/file-uploader");
    
router.get("/", userController.obterUsuarios);
router.get("/:id_user", userController.obterUsuarioPorId);
router.patch("/status/", userController.atualizarStatusUsuario);
router.patch("/edit", userController.atualizarUsuario);
router.delete("/delete/:id_user", userController.excluirUsuario);

router.post("/cadastro", uploadFields, userController.cadastrarUsuario);
router.post("/cadastro-simples", uploadFields, userController.cadastrarUsuarioSimple);


/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: Gerenciamento de usuários
 */

/**
 * @swagger
 * /usuarios:
 *   get:
 *     summary: Lista todos os usuários
 *     tags: [Usuarios]
 *     responses:
 *       200:
 *         description: Lista de usuários retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Usuario'
 *   post:
 *     summary: Cadastra um novo usuário
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsuarioCadastro'
 *     responses:
 *       202:
 *         description: Usuário cadastrado com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/UsuarioResponse'
 *       409:
 *         description: Email já cadastrado.
 */

/**
 * @swagger
 * /usuarios/{id_user}:
 *   get:
 *     summary: Obtém um usuário pelo ID
 *     tags: [Usuarios]
 *     parameters:
 *       - in: path
 *         name: id_user
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     responses:
 *       200:
 *         description: Usuário encontrado.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Usuario'
 *       404:
 *         description: Usuário não encontrado.
 *   put:
 *     summary: Atualiza um usuário pelo ID
 *     tags: [Usuarios]
 *     parameters:
 *       - in: path
 *         name: id_user
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UsuarioAtualizacao'
 *     responses:
 *       201:
 *         description: Dados de usuário alterados com sucesso.
 *       404:
 *         description: Usuário não encontrado.
 *   delete:
 *     summary: Exclui um usuário pelo ID
 *     tags: [Usuarios]
 *     parameters:
 *       - in: path
 *         name: id_user
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     responses:
 *       202:
 *         description: Usuário excluído com sucesso.
 *       404:
 *         description: Usuário não encontrado.
 */

/**
 * @swagger
 * /usuarios/upload/{id_user}:
 *   post:
 *     summary: Faz upload de uma imagem para o usuário
 *     tags: [Usuarios]
 *     parameters:
 *       - in: path
 *         name: id_user
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     requestBody:
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               file:
 *                 type: string
 *                 format: binary
 *     responses:
 *       201:
 *         description: Imagem cadastrada com sucesso.
 *       500:
 *         description: Erro ao fazer upload da imagem.
 */

/**
 * @swagger
 * /usuarios/imagem/{id_user}:
 *   get:
 *     summary: Obtém a imagem de um usuário pelo ID
 *     tags: [Usuarios]
 *     parameters:
 *       - in: path
 *         name: id_user
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     responses:
 *       200:
 *         description: Imagem do usuário retornada com sucesso.
 *       500:
 *         description: Erro ao obter a imagem do usuário.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Usuario:
 *       type: object
 *       properties:
 *         id_user:
 *           type: integer
 *           description: ID do usuário
 *         nome:
 *           type: string
 *           description: Nome do usuário
 *         sobrenome:
 *           type: string
 *           description: Sobrenome do usuário
 *         email:
 *           type: string
 *           description: Email do usuário
 *         senha:
 *           type: string
 *           description: Senha do usuário
 *         avatar:
 *           type: string
 *           description: URL do avatar do usuário
 *         id_nivel:
 *           type: integer
 *           description: Nível de acesso do usuário
 *         id_status:
 *           type: integer
 *           description: Status do usuário
 *         id_plano:
 *           type: integer
 *           description: Plano do usuário
 *       required:
 *         - nome
 *         - sobrenome
 *         - email
 *         - senha
 *         - id_nivel
 *         - id_status
 *         - id_plano
 *     UsuarioCadastro:
 *       allOf:
 *         - $ref: '#/components/schemas/Usuario'
 *         - type: object
 *           properties:
 *             senha:
 *               type: string
 *               format: password
 *     UsuarioAtualizacao:
 *       allOf:
 *         - $ref: '#/components/schemas/Usuario'
 *         - type: object
 *           properties:
 *             nome:
 *               type: string
 *             sobrenome:
 *               type: string
 *     UsuarioResponse:
 *       type: object
 *       properties:
 *         mensagem:
 *           type: string
 *           description: Mensagem de resposta
 *         usuarioCriado:
 *           $ref: '#/components/schemas/Usuario'
 */



module.exports = router;