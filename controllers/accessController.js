const express = require("express");
const Acesso = require("../models/tb_acesso");

require('dotenv').config()

const novoAcesso = async (req, res, next) => {
    try {
        const { latitude, longitude, regiao, plataforma, navegador, enderecoIp, id_user } = req.body;

        if (!latitude || !longitude || !regiao || !plataforma || !navegador || !enderecoIp || !id_user) {
            return res.status(400).send('Dados incompletos.');
        }

        // Verificando se já existe um acesso com a mesma plataforma ou endereço IP
        const acessoExistente = await Acesso.findOne({
            where: {
                [Sequelize.Op.or]: [{ plataforma: plataforma }, { enderecoIp: enderecoIp }]
            }
        });

        if (acessoExistente) {
            return res.status(409).send('Um acesso com essa plataforma ou endereço IP já existe.');
        }

        const novoAcesso = await Acesso.create({
            latitude,
            longitude,
            regiao,
            plataforma,
            navegador,
            enderecoIp,
            id_user
        });

        res.status(201).send({ mensagem: 'Acesso registrado com sucesso!', acesso: novoAcesso });
    } catch (error) {
        console.log(error);
        res.status(500).send('Erro ao registrar o acesso.');
    }
};

module.exports = {
    novoAcesso,
};
