-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.17.0.7270
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sistemamonitoreo
CREATE DATABASE IF NOT EXISTS `sistemamonitoreo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `sistemamonitoreo`;

-- Volcando estructura para tabla sistemamonitoreo.estacion
CREATE TABLE IF NOT EXISTS `estacion` (
  `id_estacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `latitud` decimal(10,7) NOT NULL,
  `longitud` decimal(10,7) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  `provincia` varchar(100) NOT NULL,
  `pais` varchar(100) NOT NULL,
  PRIMARY KEY (`id_estacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sistemamonitoreo.estacion: ~5 rows (aproximadamente)
INSERT INTO `estacion` (`id_estacion`, `nombre`, `latitud`, `longitud`, `localidad`, `provincia`, `pais`) VALUES
	(1, 'Estación Norte', -34.5400000, -58.5580000, 'Villa Ballester', 'Buenos Aires', 'Argentina'),
	(2, 'Estación Sur', -34.6030000, -58.3810000, 'CABA', 'Buenos Aires', 'Argentina'),
	(3, 'Estación Este', -34.9200000, -57.9530000, 'La Plata', 'Buenos Aires', 'Argentina'),
	(4, 'Estación Oeste', -34.6580000, -58.5670000, 'Morón', 'Buenos Aires', 'Argentina'),
	(5, 'Estación Costa', -38.0000000, -57.5470000, 'Mar del Plata', 'Buenos Aires', 'Argentina');

-- Volcando estructura para tabla sistemamonitoreo.medicion
CREATE TABLE IF NOT EXISTS `medicion` (
  `id_medicion` int(11) NOT NULL AUTO_INCREMENT,
  `id_sensor` int(11) NOT NULL,
  `valor` decimal(12,4) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`id_medicion`),
  KEY `fk_medicion_sensor` (`id_sensor`),
  CONSTRAINT `fk_medicion_sensor` FOREIGN KEY (`id_sensor`) REFERENCES `sensor` (`id_sensor`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sistemamonitoreo.medicion: ~30 rows (aproximadamente)
INSERT INTO `medicion` (`id_medicion`, `id_sensor`, `valor`, `fecha`, `hora`) VALUES
	(1, 1, 22.5000, '2024-05-01', '10:00:00'),
	(2, 1, 23.1000, '2024-05-01', '11:00:00'),
	(3, 1, 22.8000, '2024-05-01', '12:00:00'),
	(4, 2, 21.7000, '2024-05-01', '10:00:00'),
	(5, 2, 46.2000, '2024-05-01', '11:00:00'),
	(6, 2, 44.8000, '2024-05-01', '12:00:00'),
	(7, 3, 19.5000, '2024-05-01', '09:00:00'),
	(8, 3, 20.2000, '2024-05-01', '10:00:00'),
	(9, 3, 21.0000, '2024-05-01', '11:00:00'),
	(10, 4, 1013.2000, '2024-05-01', '09:00:00'),
	(11, 4, 1012.8000, '2024-05-01', '10:00:00'),
	(12, 4, 1013.5000, '2024-05-01', '11:00:00'),
	(13, 5, 15.4000, '2024-05-01', '08:00:00'),
	(14, 5, 12.1000, '2024-05-01', '09:00:00'),
	(15, 5, 18.2000, '2024-05-01', '10:00:00'),
	(16, 6, 60.0000, '2024-05-01', '08:00:00'),
	(17, 6, 62.5000, '2024-05-01', '09:00:00'),
	(18, 6, 59.1000, '2024-05-01', '10:00:00'),
	(19, 7, 25.0000, '2024-05-01', '15:00:00'),
	(20, 7, 24.5000, '2024-05-01', '16:00:00'),
	(21, 7, 23.8000, '2024-05-01', '17:00:00'),
	(22, 8, 120.5000, '2024-05-01', '15:00:00'),
	(23, 8, 118.2000, '2024-05-01', '16:00:00'),
	(24, 8, 122.0000, '2024-05-01', '17:00:00'),
	(25, 9, 1010.1000, '2024-05-01', '20:00:00'),
	(26, 9, 1011.2000, '2024-05-01', '21:00:00'),
	(27, 9, 1010.5000, '2024-05-01', '22:00:00'),
	(28, 10, 80.2000, '2024-05-01', '20:00:00'),
	(29, 10, 82.1000, '2024-05-01', '21:00:00'),
	(30, 10, 79.5000, '2024-05-01', '22:00:00');

-- Volcando estructura para tabla sistemamonitoreo.sensor
CREATE TABLE IF NOT EXISTS `sensor` (
  `id_sensor` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `id_estacion` int(11) NOT NULL,
  `unidad` varchar(10) DEFAULT '—',
  PRIMARY KEY (`id_sensor`),
  KEY `fk_sensor_estacion` (`id_estacion`),
  CONSTRAINT `fk_sensor_estacion` FOREIGN KEY (`id_estacion`) REFERENCES `estacion` (`id_estacion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sistemamonitoreo.sensor: ~10 rows (aproximadamente)
INSERT INTO `sensor` (`id_sensor`, `tipo`, `id_estacion`, `unidad`) VALUES
	(1, 'Temperatura', 1, '°C'),
	(2, 'Humedad', 1, '%'),
	(3, 'Temperatura', 2, '°C'),
	(4, 'Presión', 2, 'hPa'),
	(5, 'Viento', 3, 'km/h'),
	(6, 'Humedad', 3, '%'),
	(7, 'Temperatura', 4, '°C'),
	(8, 'Caudal', 4, 'L/min'),
	(9, 'Presión', 5, 'hPa'),
	(10, 'Humedad', 5, '%');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
