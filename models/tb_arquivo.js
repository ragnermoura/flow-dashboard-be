const { Sequelize, DataTypes } = require("sequelize");
const conn = require("../data/conn");

const Arquivo = conn.define(
  "tb_arquivo",
  {
    id_arquivo: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    ativar_ip: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ip: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    cid: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    mtid: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ativar_nome_usuario: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    nome_usuario: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ativar_expiracao: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    expiracao: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ativar_tipo_conta: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tipo_conta: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    page: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  { freezeTableName: true }
);

module.exports = Arquivo;
