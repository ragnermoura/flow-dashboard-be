const { Sequelize, DataTypes } = require("sequelize");
const conn = require("../data/conn");

const User = require("./tb_usuarios");

const Token = conn.define(
  "tb_token",
  {
    id_token: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false, 
      primaryKey: true,
    },
    token: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    id_user: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  { freezeTableName: true }
);

Token.belongsTo(User, {
  foreignKey: "id_user",
  foreignKeyConstraint: true,
});

module.exports = Token;