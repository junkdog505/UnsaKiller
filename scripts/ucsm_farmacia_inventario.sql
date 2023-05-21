-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: ucsm_farmacia
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_sucursal` int NOT NULL,
  PRIMARY KEY (`id_inventario`),
  KEY `id_producto` (`id_producto`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,1),(2,2,1),(3,3,1),(4,11,1),(5,12,1),(6,13,1),(7,21,1),(8,22,1),(9,23,1),(10,31,1),(11,32,1),(12,33,1),(13,41,1),(14,42,1),(15,43,1),(16,51,1),(17,52,1),(18,53,1),(19,61,1),(20,62,1),(21,63,1),(22,71,1),(23,72,1),(24,73,1),(25,4,2),(26,5,2),(27,6,2),(28,14,2),(29,15,2),(30,16,2),(31,24,2),(32,25,2),(33,26,2),(34,34,2),(35,35,2),(36,36,2),(37,44,2),(38,45,2),(39,46,2),(40,54,2),(41,55,2),(42,56,2),(43,64,2),(44,65,2),(45,66,2),(46,74,2),(47,75,2),(48,76,2),(49,7,3),(50,8,3),(51,9,3),(52,10,3),(53,17,3),(54,18,3),(55,19,3),(56,20,3),(57,27,3),(58,28,3),(59,29,3),(60,30,3),(61,37,3),(62,38,3),(63,39,3),(64,40,3),(65,47,3),(66,48,3),(67,49,3),(68,50,3),(69,57,3),(70,58,3),(71,59,3),(72,60,3),(73,67,3),(74,68,3),(75,69,3),(76,70,3),(77,77,3),(78,78,3),(79,79,3),(80,80,3);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-20 20:20:40
