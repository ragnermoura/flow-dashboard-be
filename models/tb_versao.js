
const { Sequelize, DataTypes } = require('sequelize');
const conn = require("../data/conn");

const Versao = conn.define('tb_versao', {
    id_versao: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nome_arquivo: {
        type: DataTypes.STRING
    },
    data_hora_compilado: {
        type: DataTypes.DATE
    },
    alert_data_hora_compilado: {
        type: DataTypes.STRING
    },
    atualizar: {
        type: DataTypes.STRING
    },
    versao: {
        type: DataTypes.STRING
    },
    link_atualizar: {
        type: DataTypes.STRING
    },
    msg_atualizar: {
        type: DataTypes.STRING
    }
});

module.exports = Versao;
