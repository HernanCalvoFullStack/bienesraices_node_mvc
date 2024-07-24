import nodemailer from "nodemailer";

const emailRegistro = async (datos) => {
  const transport = nodemailer.createTransport({
    host: process.env.EMAIL_HOST,
    port: process.env.EMAIL_PORT,
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });

  const { email, nombre, token } = datos;

  // Enviar el email
  await transport.sendMail({
    from: "BienesRaices.com",
    to: email,
    subject: "Confirma tu Cuenta en BienesRaices.com",
    text: "Confirma tu Cuenta en BienesRaices.com",
    html: `
      <p>Hola ${nombre}, comprueba tu Cuenta en BienesRaices.com</p>
      <p>Tu Cuenta ya está lista, confírmala en el siguiente enlace: 
      <a href="${process.env.BACKEND_URL}:${
      process.env.PORT ?? 3000
    }/auth/confirmar/${token}">Confirmar Cuenta</a></p>
      <p>Si no creaste esta Cuenta, ignorar el mensaje</a>
    `,
  });
};

const emailOlvidePassword = async (datos) => {
  const transport = nodemailer.createTransport({
    host: process.env.EMAIL_HOST,
    port: process.env.EMAIL_PORT,
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });

  const { email, nombre, token } = datos;

  // Enviar el email
  await transport.sendMail({
    from: "BienesRaices.com",
    to: email,
    subject: "Reestablece tu Password en BienesRaices.com",
    text: "Reestablece tu Password en BienesRaices.com",
    html: `
      <p>Hola ${nombre}, has solicitado restablecer tu Password en BienesRaices.com</p>
      <p>Sigue el siguiente enlace para resetear tu Password: 
      <a href="${process.env.BACKEND_URL}:${
      process.env.PORT ?? 3000
    }/auth/olvide-password/${token}">Reestablecer Password</a></p>
      <p>Si no solicitaste el cambio de Password, ignorar el mensaje</a>
    `,
  });
};

export { emailRegistro, emailOlvidePassword };
