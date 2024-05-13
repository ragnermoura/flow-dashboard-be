const express = require("express");
const fs = require("fs").promises;
const path = require("path");
const Arquivo = require("../models/tb_acesso");
const querystring = require("querystring");

const USERS_FILE = path.join(__dirname, "public", "users.json");

const getUsers = async (req, res, next) => {
  try {
    const data = await fs.readFile(USERS_FILE, "utf8");
    const users = JSON.parse(data);
    return res.status(200).send({ response: users });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const getUserById = async (req, res, next) => {
  try {
    const data = await fs.readFile(USERS_FILE, "utf8");
    const users = JSON.parse(data);
    const user = users.find((u) => u.mtid === req.params.mtid);
    if (user) {
      return res.status(200).send({ response: user });
    } else {
      return res.status(404).send({ message: "Usuário não encontrado" });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const createUser = async (req, res, next) => {
  try {
    const newUser = req.body;
    const data = await fs.readFile(USERS_FILE, "utf8");
    const users = JSON.parse(data);
    users.push(newUser);
    await fs.writeFile(USERS_FILE, JSON.stringify(users, null, 2));
    return res.status(201).send({ response: newUser });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const verifyAndUpdateUser = async (req, res, next) => {
  try {
    // Extrair os dados do URL fornecido pelo PHP
    const queryData = querystring.parse(req.url.split("?")[1]);

    // Converter os dados para o formato JSON
    const userData = JSON.parse(decodeURIComponent(queryData.data));

    // Lendo os dados do arquivo users.json
    const data = await fs.readFile(USERS_FILE, "utf8");
    let users = JSON.parse(data);

    // Verificando se o usuário já existe pelo mtid
    let existingUser = users.find((u) => u.mtid === userData.mtid);

    // Atualizando ou criando um novo usuário
    if (existingUser) {
      // Atualizando um usuário existente
      existingUser = {
        ...existingUser,
        ...userData,
        status: "ATIVADO",
        ip: req.ip,
      };
      users = users.map((u) => (u.mtid === userData.mtid ? existingUser : u));
    } else {
      // Criando um novo usuário
      const newUser = {
        ...userData,
        status: "PENDENTE",
        ativar_ip: "off",
        ativar_nome_usuario: "off",
        ativar_expiracao: "off",
        expiracao: "",
        ativar_tipo_conta: "off",
        tipo_conta: "DEMO",
        ip: req.ip,
      };
      users.push(newUser);
    }

    // Escrevendo os dados atualizados no arquivo users.json
    await fs.writeFile(USERS_FILE, JSON.stringify(users, null, 2));

    return res.status(200).send({
      message: "Usuário atualizado com sucesso",
      user: existingUser || newUser,
    });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const updateUser = async (req, res, next) => {
  try {
    const mtid = req.params.mtid;
    const data = await fs.readFile(USERS_FILE, "utf8");
    let users = JSON.parse(data);
    let updated = false;
    users = users.map((user) => {
      if (user.mtid === mtid) {
        updated = true;
        return { ...user, ...req.body };
      }
      return user;
    });
    if (updated) {
      await fs.writeFile(USERS_FILE, JSON.stringify(users, null, 2));
      return res
        .status(200)
        .send({ message: "Usuário atualizado com sucesso" });
    } else {
      return res.status(404).send({ message: "Usuário não encontrado" });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

const deleteUser = async (req, res, next) => {
  try {
    const mtid = req.params.mtid;
    const data = await fs.readFile(USERS_FILE, "utf8");
    let users = JSON.parse(data);
    const initialLength = users.length;
    users = users.filter((user) => user.mtid !== mtid);
    if (users.length !== initialLength) {
      await fs.writeFile(USERS_FILE, JSON.stringify(users, null, 2));
      return res.status(200).send({ message: "Usuário deletado com sucesso" });
    } else {
      return res.status(404).send({ message: "Usuário não encontrado" });
    }
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
};

module.exports = {
  getUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
  verifyAndUpdateUser,
};
