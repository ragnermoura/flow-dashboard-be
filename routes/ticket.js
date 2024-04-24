const express = require('express');
const router = express.Router();
const ticketController = require('../controllers/ticketController');

router.post('/abrir', ticketController.criarTicket);
router.get('/', ticketController.listarTickets);
router.get('/list/:id_user', ticketController.obterTicket);
router.patch('/:id_ticket', ticketController.respostaTicket);
router.delete('/tickets/:id_ticket', ticketController.excluirTicket);

module.exports = router;