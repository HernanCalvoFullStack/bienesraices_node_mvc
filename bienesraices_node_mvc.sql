/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mensajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mensaje` varchar(200) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `propiedadId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `usuarioId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `propiedadId` (`propiedadId`),
  KEY `usuarioId` (`usuarioId`),
  CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`propiedadId`) REFERENCES `propiedades` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `precios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `propiedades` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `habitaciones` int NOT NULL,
  `estacionamiento` int NOT NULL,
  `wc` int NOT NULL,
  `calle` varchar(60) NOT NULL,
  `lat` varchar(255) NOT NULL,
  `lng` varchar(255) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `publicado` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `precioId` int DEFAULT NULL,
  `categoriaId` int DEFAULT NULL,
  `usuarioId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `precioId` (`precioId`),
  KEY `categoriaId` (`categoriaId`),
  KEY `usuarioId` (`usuarioId`),
  CONSTRAINT `propiedades_ibfk_1` FOREIGN KEY (`precioId`) REFERENCES `precios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `propiedades_ibfk_2` FOREIGN KEY (`categoriaId`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `propiedades_ibfk_3` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `confirmado` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `categorias` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(1, 'Casas', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `categorias` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(2, 'Departamentos', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `categorias` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(3, 'Locales', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `categorias` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(4, 'Terrenos', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(5, 'Cabañas', '2024-07-22 22:15:08', '2024-07-22 22:15:08');

INSERT INTO `mensajes` (`id`, `mensaje`, `createdAt`, `updatedAt`, `propiedadId`, `usuarioId`) VALUES
(1, ' Hola, quisiera que el vendedor me contacte', '2024-07-24 17:14:48', '2024-07-24 17:14:48', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2);
INSERT INTO `mensajes` (`id`, `mensaje`, `createdAt`, `updatedAt`, `propiedadId`, `usuarioId`) VALUES
(2, ' Hola, quisiera que el vendedor me contacte', '2024-07-24 17:15:31', '2024-07-24 17:15:31', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2);
INSERT INTO `mensajes` (`id`, `mensaje`, `createdAt`, `updatedAt`, `propiedadId`, `usuarioId`) VALUES
(3, ' Hola, quisiera que el vendedor me contacte', '2024-07-24 17:17:35', '2024-07-24 17:17:35', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2);
INSERT INTO `mensajes` (`id`, `mensaje`, `createdAt`, `updatedAt`, `propiedadId`, `usuarioId`) VALUES
(4, ' Me gustaría contactarme con el vendedor', '2024-07-24 17:17:56', '2024-07-24 17:17:56', 'f96f6ccc-c067-456a-af67-a00e0fb9dfce', 2),
(5, ' Me gustaría contactarme con el vendedor', '2024-07-24 17:18:52', '2024-07-24 17:18:52', '983646b4-84ec-42de-978f-e25b843edf5c', 2),
(6, ' Me gustaría contactarme con el vendedor', '2024-07-24 17:20:08', '2024-07-24 17:20:08', '983646b4-84ec-42de-978f-e25b843edf5c', 2),
(7, ' Me gustaría contactarme con el vendedor', '2024-07-24 17:21:13', '2024-07-24 17:21:13', '983646b4-84ec-42de-978f-e25b843edf5c', 2),
(8, ' Quiero que me contacte el vendedor por favor', '2024-07-24 17:21:31', '2024-07-24 17:21:31', '983646b4-84ec-42de-978f-e25b843edf5c', 2),
(9, ' Quiero que me contacte el vendedor', '2024-07-24 17:22:29', '2024-07-24 17:22:29', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(10, ' Quiero que me contacte el vendedor', '2024-07-24 17:22:44', '2024-07-24 17:22:44', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(11, ' Quiero que me contacte el vendedor', '2024-07-24 17:23:18', '2024-07-24 17:23:18', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(12, ' Quiero que me contacte el vendedor', '2024-07-24 17:24:04', '2024-07-24 17:24:04', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(13, ' Hola, necesito que el vendedor se contacte conmigo', '2024-07-24 17:24:42', '2024-07-24 17:24:42', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(14, ' Hola, necesito que el vendedor se contacte conmigo', '2024-07-24 17:25:14', '2024-07-24 17:25:14', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(15, ' Me podría contactar con el vendedor por favor?', '2024-07-24 17:27:26', '2024-07-24 17:27:26', '983646b4-84ec-42de-978f-e25b843edf5c', 2),
(16, ' Probando el set time out', '2024-07-24 17:28:01', '2024-07-24 17:28:01', 'f45fb52d-bc1a-4716-a851-ba5326c0827f', 2),
(17, ' Probando nuevamente el settimeout', '2024-07-24 17:28:30', '2024-07-24 17:28:30', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(18, ' Probando nuevamente el settimeout', '2024-07-24 17:29:18', '2024-07-24 17:29:18', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(19, ' Haciendo prueba con un chaining', '2024-07-24 17:30:19', '2024-07-24 17:30:19', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(20, ' Haciendo prueba con un chaining', '2024-07-24 17:30:40', '2024-07-24 17:30:40', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2),
(21, ' Haciendo prueba con un chaining', '2024-07-24 17:33:26', '2024-07-24 17:33:26', '8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 2);

INSERT INTO `precios` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(1, '0 - $10,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `precios` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(2, '$10,000 - $30,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `precios` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(3, '$30,000 - $50,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `precios` (`id`, `nombre`, `createdAt`, `updatedAt`) VALUES
(4, '$50,000 - $75,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(5, '$75,000 - $100,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(6, '$100,000 - $150,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(7, '$150,000 - $200,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(8, '$200,000 - $300,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(9, '$300,000 - $500,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08'),
(10, '+ $500,000 USD', '2024-07-22 22:15:08', '2024-07-22 22:15:08');

INSERT INTO `propiedades` (`id`, `titulo`, `descripcion`, `habitaciones`, `estacionamiento`, `wc`, `calle`, `lat`, `lng`, `imagen`, `publicado`, `createdAt`, `updatedAt`, `precioId`, `categoriaId`, `usuarioId`) VALUES
('52cb43fa-a71b-434d-8bed-8d0605875892', 'Cabaña en Bosquesitos', 'Cabaña en Bosquesitos 3200 m2', 3, 1, 2, '', '-35.104181088276', '-58.187713623047', '230mm62f65o1i3e8hq8r.jpg', 1, '2024-07-22 22:21:14', '2024-07-24 19:43:00', 6, 5, 1);
INSERT INTO `propiedades` (`id`, `titulo`, `descripcion`, `habitaciones`, `estacionamiento`, `wc`, `calle`, `lat`, `lng`, `imagen`, `publicado`, `createdAt`, `updatedAt`, `precioId`, `categoriaId`, `usuarioId`) VALUES
('8f6a9de5-3ef4-4cb4-9b3d-6bb682bb590f', 'Departamento 6 Ambientes', 'Hermoso departamento en Olivos', 3, 2, 2, 'Calle Juan Bautista Alberdi 1159', '-34.509013911946', '-58.487594927888', '9a5qt1ad51o1i3inikup.jpg', 1, '2024-07-24 16:00:43', '2024-07-24 16:02:37', 8, 2, 1);
INSERT INTO `propiedades` (`id`, `titulo`, `descripcion`, `habitaciones`, `estacionamiento`, `wc`, `calle`, `lat`, `lng`, `imagen`, `publicado`, `createdAt`, `updatedAt`, `precioId`, `categoriaId`, `usuarioId`) VALUES
('983646b4-84ec-42de-978f-e25b843edf5c', 'Casa en la Playa', 'Casa en la Costa Argentina', 1, 1, 1, 'Calle Corrientes 391', '-34.50746962462', '-58.47771260683', '8soeun7ef481i3e8kg9v.jpg', 1, '2024-07-22 22:22:43', '2024-07-24 16:01:01', 5, 1, 1);
INSERT INTO `propiedades` (`id`, `titulo`, `descripcion`, `habitaciones`, `estacionamiento`, `wc`, `calle`, `lat`, `lng`, `imagen`, `publicado`, `createdAt`, `updatedAt`, `precioId`, `categoriaId`, `usuarioId`) VALUES
('b5050fd3-9cc8-4bfe-9ad4-e7efb70b33ef', 'Local Comercial Zona Olivos', 'Duplex en Olivos Centro apto para cualquier actividad', 1, 0, 1, 'Calle Roque Sáenz Peña 1439', '-34.509038409325', '-58.490974245803', 'qkbfkmckdog1i3inofig.jpg', 1, '2024-07-24 16:03:58', '2024-07-24 16:04:03', 4, 3, 1),
('f45fb52d-bc1a-4716-a851-ba5326c0827f', 'Duplex en Olivos Centro', 'Excelente Duplex en Olivos Centro', 2, 1, 1, 'Calle Gobernador Manuel Ugarte 1763', '-34.514663843716', '-58.492666507379', '2gabbb7dc1g1i3inlglb.jpg', 1, '2024-07-24 16:02:22', '2024-07-24 16:02:26', 8, 1, 1),
('f96f6ccc-c067-456a-af67-a00e0fb9dfce', 'Terreno en Olivos', 'Terreno apto para construcción en Olivos', 0, 0, 0, 'Calle Carlos Villate 797', '-34.512251260728', '-58.480671052885', '3fdikq726rg1i3inn4g0.jpg', 1, '2024-07-24 16:03:11', '2024-07-24 16:03:19', 3, 4, 1);

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `token`, `confirmado`, `createdAt`, `updatedAt`) VALUES
(1, 'Hernan', 'hernan@hernan.com', '$2b$10$ZZLpT5L3S8MmbBVQL.lO..i/m5FCv6mIxgZKRHO8N8se7.OZifDeC', NULL, 1, '2024-07-22 22:15:08', '2024-07-22 22:15:08');
INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `token`, `confirmado`, `createdAt`, `updatedAt`) VALUES
(2, 'Malena', 'male@male.com', '$2b$10$dLP02vvXoY9BQ7Q/BZVWsehMNrkDYugIPG5iibbNxGmJpQHeDUdRO', 'NULL', 1, '2024-07-24 16:29:35', '2024-07-24 16:29:35');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;