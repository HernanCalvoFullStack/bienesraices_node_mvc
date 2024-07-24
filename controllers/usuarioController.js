import { check, validationResult } from "express-validator";
import bcrypt from "bcrypt";
import Usuario from "../models/Usuario.js";
import { generarJWT, generarId } from "../helpers/tokens.js";
import { emailRegistro, emailOlvidePassword } from "../helpers/email.js";

const formularioLogin = (req, res) => {
  res.render("auth/login", {
    pagina: "Iniciar Sesión",
    csrfToken: req.csrfToken(),
  });
};

const autenticar = async (req, res) => {
  // Validación
  await check("email")
    .isEmail()
    .withMessage("Formato erróneo de email")
    .run(req);

  await check("password")
    .notEmpty()
    .withMessage("El password es obligatorio")
    .run(req);

  let resultado = validationResult(req);

  // Verificamos que el resultado este vacío, no creamos aún el usuario
  if (!resultado.isEmpty()) {
    // Hay errores
    return res.render("auth/login", {
      pagina: "Iniciar Sesión",
      csrfToken: req.csrfToken(),
      errores: resultado.array(),
    });
  }

  const { email, password } = req.body;

  // Comprobamos si existe el usuario
  const usuario = await Usuario.findOne({ where: { email } });
  if (!usuario) {
    return res.render("auth/login", {
      pagina: "Iniciar Sesión",
      csrfToken: req.csrfToken(),
      errores: [{ msg: "El Usuario no Existe" }],
    });
  }

  // Comprobamos si el usuario está confirmado
  if (!usuario.confirmado) {
    return res.render("auth/login", {
      pagina: "Iniciar Sesión",
      csrfToken: req.csrfToken(),
      errores: [{ msg: "Tu Cuenta no ha sido Confirmada" }],
    });
  }

  // Revisamos el Password
  if (!usuario.verificarPassword(password)) {
    return res.render("auth/login", {
      pagina: "Iniciar Sesión",
      csrfToken: req.csrfToken(),
      errores: [{ msg: "El Password es incorrecto" }],
    });
  }

  // Auntenticamos al Usuario
  const token = generarJWT({ id: usuario.id, nombre: usuario.nombre });

  // Almacenamos el token en un cookie
  return res
    .cookie("_token", token, {
      httpOnly: true,
      secure: true,
      sameSite: true,
    })
    .redirect("/mis-propiedades");
};

const cerrarSesion = (req, res) => {
  return res.clearCookie("_token").status(200).redirect("/auth/login");
};

const formularioRegistro = (req, res) => {
  res.render("auth/registro", {
    pagina: "Crear Cuenta",
    csrfToken: req.csrfToken(),
  });
};

const registrar = async (req, res) => {
  // Validación al crear un Usuario
  await check("nombre")
    .notEmpty()
    .withMessage("El nombre es obligatorio")
    .run(req);

  await check("email")
    .isEmail()
    .withMessage("Formato erróneo de email")
    .run(req);

  await check("password")
    .isLength({ min: 8 })
    .withMessage("El password debe tener mínimo 8 caracteres")
    .run(req);

  await check("repetir_password")
    .equals(req.body.password)
    .withMessage("Los passwords deben ser idénticos")
    .run(req);

  let resultado = validationResult(req);

  // Verificamos que el resultado este vacío, no creamos aún el usuario
  if (!resultado.isEmpty()) {
    // Hay errores
    return res.render("auth/registro", {
      pagina: "Crear Cuenta",
      csrfToken: req.csrfToken(),
      errores: resultado.array(),
      usuario: {
        nombre: req.body.nombre,
        email: req.body.email,
      },
    });
  }

  // Verificamos que el usuario ya exista para no duplicar el registro
  const existeUsuario = await Usuario.findOne({
    where: { email: req.body.email },
  });

  if (existeUsuario) {
    return res.render("auth/registro", {
      pagina: "Crear Cuenta",
      csrfToken: req.csrfToken(),
      errores: [{ msg: "El usuario ya está registrado" }],
      usuario: {
        nombre: req.body.nombre,
        email: req.body.email,
      },
    });
  }

  // Guardar un usuario
  const usuario = await Usuario.create({
    nombre: req.body.nombre,
    email: req.body.email,
    password: req.body.password,
    token: generarId(),
  });

  // Enviamos el email de confirmación
  emailRegistro({
    nombre: usuario.nombre,
    email: usuario.email,
    token: usuario.token,
  });

  // Mensaje de Confirmación de Usuario creado correctamente
  res.render("templates/mensaje", {
    pagina: "Cuenta Creada Correctamente",
    mensaje: "Hemos enviando un email de confirmación, has click en el enlace",
  });
};

// Comprobar cuenta
const confirmar = async (req, res) => {
  const { token } = req.params;

  // Verificamos si el token es válido
  const usuario = await Usuario.findOne({ where: { token } });
  if (!usuario) {
    return res.render("auth/confirmar-cuenta", {
      pagina: "Error al confirmar tu Cuenta",
      mensaje: "Hubo un error al confirmar tu Cuenta, intenta nuevamente",
      error: true,
    });
  }
  // Confirmamos la Cuenta
  usuario.token = null;
  usuario.confirmado = true;
  await usuario.save();

  res.render("auth/confirmar-cuenta", {
    pagina: "Cuenta Confirmada",
    mensaje: "La Cuenta ha sido confirmada correctamente",
  });
};

const olvidePassword = (req, res) => {
  res.render("auth/olvide-password", {
    pagina: "Cambiar Password",
    csrfToken: req.csrfToken(),
  });
};

const resetPassword = async (req, res) => {
  // Validación
  await check("email")
    .isEmail()
    .withMessage("Formato erróneo de email")
    .run(req);

  let resultado = validationResult(req);

  // Verificamos que el resultado este vacío, no creamos aún el usuario
  if (!resultado.isEmpty()) {
    // Hay errores
    return res.render("auth/olvide-password", {
      pagina: "Cambiar Password",
      csrfToken: req.csrfToken(),
      errores: resultado.array(),
    });
  }

  // Buscamos al usuario para genear nuevo Token
  const { email } = req.body;
  const usuario = await Usuario.findOne({ where: { email } });

  if (!usuario) {
    return res.render("auth/olvide-password", {
      pagina: "Cambiar Password",
      csrfToken: req.csrfToken(),
      errores: [{ msg: "El email no pertenece a un usuario registrado" }],
    });
  }

  // Generamos un token nuevo
  usuario.token = generarId();
  await usuario.save();

  // Envíamos un email
  emailOlvidePassword({
    email: usuario.email,
    nombre: usuario.nombre,
    token: usuario.token,
  });

  // Renderizamos un Mensaje
  res.render("templates/mensaje", {
    pagina: "Reestablece tu Password",
    mensaje: "Hemos enviado un email para que puedas reestablecer tu Password",
  });
};

const comprobarToken = async (req, res) => {
  const { token } = req.params;
  const usuario = await Usuario.findOne({ where: { token } });

  if (!usuario) {
    return res.render("auth/confirmar-cuenta", {
      pagina: "Reestablece tu Password",
      mensaje: "Hubo un error al validar tu información, intenta nuevamente",
      error: true,
    });
  }

  // Mostramos un Formulario para modificar el Password
  res.render("auth/reset-password", {
    pagina: "Reestablece tu Password",
    csrfToken: req.csrfToken(),
  });
};

const nuevoPassword = async (req, res) => {
  // Validamos el password
  await check("password")
    .isLength({ min: 8 })
    .withMessage("El password debe tener mínimo 8 caracteres")
    .run(req);

  let resultado = validationResult(req);

  // Verificamos que el resultado este vacío, no creamos aún el usuario
  if (!resultado.isEmpty()) {
    // Hay errores
    return res.render("auth/reset-password", {
      pagina: "Reestablece tu Password",
      csrfToken: req.csrfToken(),
      errores: resultado.array(),
    });
  }

  const { token } = req.params;
  const { password } = req.body;

  // Identificamos que usuario solicita el cambio
  const usuario = await Usuario.findOne({ where: { token } });

  // Hasheamos el password
  const salt = await bcrypt.genSalt(10);
  usuario.password = await bcrypt.hash(password, salt);
  usuario.token = null;

  await usuario.save();

  res.render("auth/confirmar-cuenta", {
    pagina: "Password reestablecido",
    mensaje: "El Password ha sido modificado correctamente",
  });
};

export {
  formularioLogin,
  autenticar,
  cerrarSesion,
  formularioRegistro,
  registrar,
  confirmar,
  olvidePassword,
  resetPassword,
  comprobarToken,
  nuevoPassword,
};
