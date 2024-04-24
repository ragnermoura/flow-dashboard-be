const { Sequelize, DataTypes } = require("sequelize");
const conn = require("../data/conn");

const Usuario = require("./tb_usuarios");

const Acessos = conn.define(
    "tb_acessos",
    {
        id_acesso: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            allowNull: false,
            primaryKey: true,
        },
        latitude: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        longitude: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        regiao: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        plataforma: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
        },
        navegador: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        enderecoIp: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
        },
        id_user: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },

    },
    { freezeTableName: true }
);

Acessos.belongsTo(Usuario, {
    foreignKey: "id_user",
    foreignKeyConstraint: true,
});


module.exports = Acessos;