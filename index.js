import express from "express";
import csrf from "csurf";
import cookieParser from "cookie-parser";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import propiedadesRoutes from "./routes/propiedadesRoutes.js";
import appRoutes from "./routes/appRoutes.js";
import apiRoutes from "./routes/apiRoutes.js";
import db from "./config/db.js";

// Crear la App
const app = express();

// Habilitar lectura de datos de formularios
app.use(express.urlencoded({ extended: true }));

// Habilitamos Cookie Parser
app.use(cookieParser());

// Habilitamos CSRF
app.use(csrf({ cookie: true }));

// Conexión a la Base de Datos
try {
  await db.authenticate();
  db.sync();
  console.log("Conexión correcta a la BBDD");
} catch (error) {
  console.log(error);
}

// Habilitar Pug
app.set("view engine", "pug");
app.set("views", "./views");

// Carpeta Pública
app.use(express.static("public"));

// Routing
app.use("/", appRoutes);
app.use("/auth", usuarioRoutes);
app.use("/", propiedadesRoutes);
app.use("/api", apiRoutes);

// Definimos el puerto y arrancamos el servidor
const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`El servidor está funcionando en el puerto ${port}`);
});
