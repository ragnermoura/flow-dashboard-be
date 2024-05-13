const express = require("express");
const fs = require("fs").promises;
const path = require("path");
const Arquivo = require("../models/tb_acesso");

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
    const {
      page,
      mtid,
      cid,
      nome_usuario,
      Company,
      Balance,
      Credit,
      Currency,
      Equity,
      FreeMargin,
      Leverage,
      Margin,
      ProfitCompany,
      Server,
    } = req.query;

    // Verificação específica para retorno do IP, como no código PHP
    if (page === "IP") {
      return res.send({ ip: req.ip });
    }

    const data = await fs.readFile(USERS_FILE, "utf8");
    let users = JSON.parse(data);

    let usuarioExiste = users.find((u) => u.mtid === mtid);

    if (usuarioExiste) {
      // Atualizando um usuário existente
      usuarioExiste = {
        ...usuarioExiste,
        page,
        mtid,
        cid,
        nome_usuario,
        Company,
        Balance,
        Credit,
        Currency,
        Equity,
        FreeMargin,
        Leverage,
        Margin,
        ProfitCompany,
        Server,
        ip: req.ip,
        status: "ATIVO"
      };
      users = users.map(u => u.mtid === mtid ? usuarioExiste : u);
    } else {
      // Criando um novo usuário
      const newUser = {
        page,
        mtid,
        cid,
        nome_usuario,
        Company,
        Balance,
        Credit,
        Currency,
        Equity,
        FreeMargin,
        Leverage,
        Margin,
        ProfitCompany,
        Server,
        ip: req.ip,
        status: "PENDENTE",
        ativar_ip: "false",
        ativar_nome_usuario: "false",
        ativar_expiracao: "false",
        expiracao: "00.00.0000 00:00:00",
        ativar_tipo_conta: "false",
        tipo_conta: "DEMO",
      };
      users.push(newUser);
    }

    await fs.writeFile(USERS_FILE, JSON.stringify(users, null, 2));
    return res.status(200).send({ message: "Usuário atualizado com sucesso", user: usuarioExiste || newUser });

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
