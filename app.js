const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cors = require("cors");

const rotaAcesso = require("./routes/access");
const rotaLogin = require("./routes/login");
const rotaNivel = require("./routes/nivel");
const rotaRecovery = require("./routes/recovery");
const rotaStatus = require("./routes/status");
const rotaUsuarios = require("./routes/usuario");
const rotaEnvios = require("./routes/envio");
const rotaArquivo = require("./routes/arquivos");

require("dotenv").config();

const Code = require("./models/tb_code");
const Token = require("./models/tb_token");
const Qrcode = require("./models/tb_qrcode");
const User = require("./models/tb_usuarios");


User.hasOne(Code, {
    foreignKey: "id_user",
    as: "code",
  });
  
  User.hasOne(Token, {
    foreignKey: "id_user",
    as: "token",
  });
  
  User.hasOne(Qrcode, {
    foreignKey: "id_user",
    as: "qrcode",
  });


app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Credentials", "true");
  res.header(
    "Access-Control-Allow-Header",
    "Origin, X-Api-Key, X-Requested-With, Content-Type, Accept, Authorization"
  );

  if (req.method === "OPTIONS") {
    res.header(
      "Access-Control-Allow-Methods",
      "PUT, POST, PATCH, DELETE, GET, OPTIONS"
    );
    return res.status(200).send({});
  }
  next();
});

app.use("/acesso", rotaAcesso);
app.use("/login", rotaLogin);
app.use("/nivel", rotaNivel);
app.use("/recovery", rotaRecovery);
app.use("/status", rotaStatus);
app.use("/usuarios", rotaUsuarios);
app.use("/email", rotaEnvios);
app.use("/arquivo", rotaArquivo);

app.get("/api/test", (req, res) => {
  res.status(200).json({ message: "OK" });
});

app.use(express.static("public"));

app.use((req, res, next) => {
  const erro = new Error("Rota não encontrada");
  erro.status = 404;
  next(erro);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  return res.send({
    erro: {
      mensagem: error.mensagem,
    },
  });
});

module.exports = app;
