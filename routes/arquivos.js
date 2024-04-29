const express = require('express');
const router = express.Router();
const arquivoController = require('../controllers/arquivoController');


router.get('/', arquivoController.getUsers);
router.get('/buscar/:mtid', arquivoController.getUserById);
router.post('/criar', arquivoController.createUser);
router.put('/edit/:mtid', arquivoController.updateUser);
router.delete('/delete/:mtid', arquivoController.deleteUser);

module.exports = router;
