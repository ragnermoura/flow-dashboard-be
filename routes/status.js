const express = require("express");
const router = express.Router();
const statusController = require("../controllers/statusController");


router.post("/cadastrar", statusController.criarStatus);
router.get("/", statusController.obterStatus);
router.get("/:id_status", statusController.obterStatusPorId);
router.put("/:id_status", statusController.atualizarStatus);
router.delete("/:id_status", statusController.deletarStatus);


/**
 * @swagger
 * tags:
 *   name: Status
 *   description: Gerenciamento de status
 */

/**
 * @swagger
 * /status:
 *   get:
 *     summary: Lista todos os status
 *     tags: [Status]
 *     responses:
 *       200:
 *         description: Lista de status retornada com sucesso.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Status'
 *   post:
 *     summary: Cria um novo status
 *     tags: [Status]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Status'
 *     responses:
 *       201:
 *         description: Status criado com sucesso.
 *       500:
 *         description: Erro ao criar o status.
 */

/**
 * @swagger
 * /status/{id_status}:
 *   get:
 *     summary: Obtém um status pelo ID
 *     tags: [Status]
 *     parameters:
 *       - in: path
 *         name: id_status
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do status
 *     responses:
 *       200:
 *         description: Status encontrado.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Status'
 *       404:
 *         description: Status não encontrado.
 *   put:
 *     summary: Atualiza um status pelo ID
 *     tags: [Status]
 *     parameters:
 *       - in: path
 *         name: id_status
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do status
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Status'
 *     responses:
 *       200:
 *         description: Status atualizado com sucesso.
 *       404:
 *         description: Status não encontrado.
 *   delete:
 *     summary: Deleta um status pelo ID
 *     tags: [Status]
 *     parameters:
 *       - in: path
 *         name: id_status
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do status
 *     responses:
 *       200:
 *         description: Status deletado com sucesso.
 *       404:
 *         description: Status não encontrado.
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Status:
 *       type: object
 *       properties:
 *         id_status:
 *           type: integer
 *           description: ID do status.
 *         label:
 *           type: string
 *           description: Descrição do status.
 *       required:
 *         - label
 *       example:
 *         id_status: 1
 *         label: "Ativo"
 */



module.exports = router;
