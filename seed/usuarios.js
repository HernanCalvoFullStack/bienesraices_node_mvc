import bcrypt from "bcrypt";

const usuarios = [
  {
    nombre: "Hernan",
    email: "hernan@hernan.com",
    confirmado: 1,
    password: bcrypt.hashSync("password", 10),
  },
];

export default usuarios;
