const bcrypt = require('bcrypt');
const User = require('../models/tb_usuarios');

const validaEmail = async (req, res, next) => {
  try {
    const { email } = req.body;

    const usuario = await User.findOne({
      where: { email: email }
    });

    if (!usuario) {
      return res.status(404).send({ mensagem: "Usuário não encontrado." });
    }
    return res.status(200).send({ response: usuario });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const alterarSenha = async (req, res) => {
  try {
    const usuario = await User.findByPk(req.body.id_user);
    if (!usuario) {
      return res.status(404).send({ message: "Usuário não encontrado" });
    }

    const hashedPassword = await bcrypt.hash(req.body.senha, 10);

    usuario.senha = hashedPassword;

    await usuario.save();
    return res
      .status(201)
      .send({ mensagem: "Dados de usuário alterados com sucesso!" });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};


module.exports = {
  validaEmail,
  alterarSenha,
};
