import jwt from "jsonwebtoken";
import { Usuario } from "../models/index.js";

const protegerRuta = async (req, res, next) => {
  // Verificamos si existe un Token
  const { _token } = req.cookies;
  if (!_token) {
    return res.redirect("/auth/login");
  }

  // Comprobamos el token
  try {
    const decoded = jwt.verify(_token, process.env.JWT_SECRET);
    const usuario = await Usuario.scope("eliminarPassword").findByPk(
      decoded.id
    );

    // Almacenamos el usuario al Request
    if (usuario) {
      req.usuario = usuario;
    } else {
      return res.redirect("/auth/login");
    }
    return next();
  } catch (error) {
    return res.clearCookies("_token").redirect("/auth/login");
  }
};

export default protegerRuta;
