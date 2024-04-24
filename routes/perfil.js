const express = require("express");
const router = express.Router();
const perfilController = require("../controllers/perfilController");

router.get("/", perfilController.obterPerfil);
router.get("/:id_perfil", perfilController.obterPerfilPorId);
router.patch("/edit", perfilController.atualizarPerfil);
router.delete("/delete", perfilController.excluirPerfil);
router.post("/cadastro", perfilController.cadastrarPerfil);


/**
 * @swagger
 * tags:
 *   name: Perfil
 *   description: Gerenciamento de perfis de usuário
 */

/**
 * @swagger
 * /perfil:
 *   get:
 *     summary: Lista todos os perfis
 *     tags: [Perfil]
 *     responses:
 *       200:
 *         description: Lista de perfis retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Perfil'
 *   post:
 *     summary: Cadastra um novo perfil
 *     tags: [Perfil]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Perfil'
 *     responses:
 *       201:
 *         description: Perfil cadastrado com sucesso.
 *       409:
 *         description: CNPJ já cadastrado.
 *       500:
 *         description: Erro ao cadastrar o perfil.
 */

/**
 * @swagger
 * /perfil/{id_perfil}:
 *   get:
 *     summary: Obtém um perfil pelo ID
 *     tags: [Perfil]
 *     parameters:
 *       - in: path
 *         name: id_perfil
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do perfil
 *     responses:
 *       200:
 *         description: Perfil encontrado.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Perfil'
 *       404:
 *         description: Perfil não encontrado.
 *   put:
 *     summary: Atualiza um perfil pelo ID
 *     tags: [Perfil]
 *     parameters:
 *       - in: path
 *         name: id_perfil
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do perfil
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Perfil'
 *     responses:
 *       201:
 *         description: Dados do perfil alterados com sucesso.
 *       404:
 *         description: Perfil não encontrado.
 *   delete:
 *     summary: Exclui um perfil pelo ID
 *     tags: [Perfil]
 *     parameters:
 *       - in: path
 *         name: id_perfil
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do perfil
 *     responses:
 *       202:
 *         description: Perfil excluído com sucesso.
 *       404:
 *         description: Perfil não encontrado.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Perfil:
 *       type: object
 *       properties:
 *         id_perfil:
 *           type: integer
 *           description: ID do perfil.
 *         razao_social:
 *           type: string
 *           description: Razão social da empresa do usuário.
 *         cnpj:
 *           type: string
 *           description: CNPJ da empresa do usuário.
 *         telefone:
 *           type: string
 *           description: Telefone de contato do usuário.
 *         cep:
 *           type: string
 *           description: CEP da localização da empresa.
 *         endereco:
 *           type: string
 *           description: Endereço da empresa do usuário.
 *         pdf_rg:
 *           type: string
 *           description: Link para o PDF do RG.
 *         pdf_cnpj:
 *           type: string
 *           description: Link para o PDF do CNPJ.
 *         termos:
 *           type: string
 *           description: Aceite dos termos de uso.
 *         id_user:
 *           type: integer
 *           description: ID do usuário associado ao perfil.
 *       required:
 *         - razao_social
 *         - cnpj
 *         - telefone
 *         - cep
 *         - endereco
 *         - termos
 *         - id_user
 *       example:
 *         id_perfil: 1
 *         razao_social: "Empresa Exemplo Ltda"
 *         cnpj: "00.000.000/0001-00"
 *         telefone: "(11) 9999-9999"
 *         cep: "00000-000"
 *         endereco: "Rua Exemplo, 100"
 *         termos: "Aceito"
 *         id_user: 2
 */



module.exports = router;