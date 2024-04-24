const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const  Usuario  = require("../models/tb_usuarios");


const autenticarUsuario = async (req, res, next) => {
  try {
    const { email, senha } = req.body;

    const user = await Usuario.findOne({ where: { email: email } });

    if (!user) {
      return res.status(401).send({
        mensagem: "Falha na autenticação.",
      });
    }

    const isPasswordValid = await bcrypt.compare(senha, user.senha);

    if (isPasswordValid) {
      const token = jwt.sign(
        {
          id_user: user.id_user,
          nome: user.nome,
          sobrenome: user.sobrenome,
          email: user.email,
          avatar: user.avatar,
          id_nivel: user.id_nivel,
          id_status: user.id_status,
        },
        process.env.JWT_KEY,
        {
          expiresIn: "6h",
        }
      );

      return res.status(200).send({
        mensagem: "Autenticado com sucesso!",
        token: token,
        id_status: user.id_status

      });
    } else {
      return res.status(401).send({ mensagem: "Falha na autenticação." });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).send({ error: error.message });
  }
};

const logoutUsuario = async (req, res) => {
  try {
    const { id_user } = req.params;
    const novoStatus = 0;

    const resultado = await Logado.update(
      { status: novoStatus },
      { where: { id_user: id_user } }
    );

    await registrarLog('Usuário deslogado', id_user);

    if (resultado[0] > 0) {
      return res.status(200).send({ mensagem: "Logout realizado com sucesso." });
    } else {
      return res.status(404).send({ mensagem: "Registro de login não encontrado para atualização." });
    }
  } catch (error) {
    console.error("Erro ao realizar logout:", error);
    return res.status(500).send({ error: error.message });
  }
};

module.exports = {
  autenticarUsuario,
  logoutUsuario
};