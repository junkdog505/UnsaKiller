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
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `chk_cantidad` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Paracetamol','Venta Libre','Alivia el dolor y la fiebre',100,5.99),(2,'Pastillas para la gripe','Venta Libre','Alivio de los síntomas de la gripe',50,7.99),(3,'Antihistamínico','Venta Libre','Tratamiento para las alergias',60,9.99),(4,'Antiácido','Venta Libre','Alivio de la acidez estomacal',80,4.99),(5,'Jarabe para la tos','Venta Libre','Alivio de la tos seca',70,6.99),(6,'Pastillas para la acidez','Venta Libre','Alivio de la acidez estomacal',90,3.99),(7,'Crema analgésica','Venta Libre','Alivio del dolor muscular',40,8.99),(8,'Solución para lentes de contacto','Venta Libre','Limpieza y humectación de lentes',30,6.99),(9,'Pastillas para el mareo','Venta Libre','Alivio del mareo y la náusea',50,5.99),(10,'Parches para dolores musculares','Venta Libre','Alivio de dolores musculares y articulares',60,9.99),(11,'Antibiótico','Receta','Tratamiento de infecciones bacterianas',50,12.99),(12,'Ansiolítico','Receta','Reducción de la ansiedad y el estrés',30,15.99),(13,'Antidepresivo','Receta','Tratamiento de la depresión',40,19.99),(14,'Antiinflamatorio','Receta','Reducción de la inflamación y el dolor',60,11.99),(15,'Hipertensión','Receta','Control de la presión arterial alta',35,17.99),(16,'Antialérgico','Receta','Tratamiento de las alergias',45,13.99),(17,'Tratamiento para el insomnio','Receta','Ayuda para conciliar el sueño',25,16.99),(18,'Antiarrítmico','Receta','Control de los trastornos del ritmo cardíaco',55,14.99),(19,'Anticoagulante','Receta','Prevención de coágulos de sangre',65,18.99),(20,'Tratamiento para la diabetes','Receta','Control de los niveles de azúcar en la sangre',20,21.99),(21,'Shampoo revitalizante','Cuidado Personal','Fortalece y revitaliza el cabello',50,9.99),(22,'Crema hidratante facial','Cuidado Personal','Hidratación profunda para la piel del rostro',30,12.99),(23,'Desodorante en barra','Cuidado Personal','Protección duradera contra el mal olor',40,7.99),(24,'Gel de baño suavizante','Cuidado Personal','Limpieza y suavidad para la piel',60,6.99),(25,'Crema corporal humectante','Cuidado Personal','Hidratación profunda para todo el cuerpo',35,10.99),(26,'Cepillo dental eléctrico','Cuidado Personal','Limpieza superior para una sonrisa saludable',45,24.99),(27,'Pasta dental blanqueadora','Cuidado Personal','Blanqueamiento dental y protección contra caries',25,8.99),(28,'Crema para manos y uñas','Cuidado Personal','Hidratación y fortalecimiento para manos y uñas',55,11.99),(29,'Protector solar SPF 50+','Cuidado Personal','Protección contra los rayos UVA y UVB',65,14.99),(30,'Gel para peinar','Cuidado Personal','Fijación y estilo para el cabello',20,7.99),(31,'Pañales desechables','Bebés y Niños','Absorción y comodidad para bebés',100,19.99),(32,'Toallitas húmedas','Bebés y Niños','Limpieza suave y delicada para el cambio de pañales',80,5.99),(33,'Crema para pañal','Bebés y Niños','Protección y prevención de irritaciones en la zona del pañal',50,8.99),(34,'Jabón líquido para bebés','Bebés y Niños','Limpieza suave para la piel sensible de los bebés',60,7.99),(35,'Shampoo para niños','Bebés y Niños','Limpieza y cuidado del cabello de los niños',45,6.99),(36,'Loción hidratante para bebés','Bebés y Niños','Hidratación suave y delicada para la piel de los bebés',30,9.99),(37,'Cepillo y peine para bebés','Bebés y Niños','Cuidado del cabello de los bebés',55,4.99),(38,'Chupete','Bebés y Niños','Satisfacción y calma para los bebés',70,3.99),(39,'Talco para bebés','Bebés y Niños','Suavidad y frescura para la piel del bebé',40,6.99),(40,'Biberón','Bebés y Niños','Alimentación cómoda para los bebés',25,9.99),(41,'Cepillo de dientes','Higiene Bucal','Cepillo de cerdas suaves para una limpieza efectiva',100,4.99),(42,'Pasta dental','Higiene Bucal','Pasta con flúor para prevenir caries y mantener dientes sanos',80,3.99),(43,'Enjuague bucal','Higiene Bucal','Enjuague refrescante para mantener el aliento fresco',50,6.99),(44,'Hilo dental','Higiene Bucal','Hilo dental para remover placa y residuos entre los dientes',60,2.99),(45,'Enjuague bucal sin alcohol','Higiene Bucal','Enjuague suave para personas con sensibilidad al alcohol',45,7.99),(46,'Cepillo interdental','Higiene Bucal','Cepillo para limpiar entre los espacios interdentales',30,4.99),(47,'Crema dental blanqueadora','Higiene Bucal','Pasta para blanquear y mantener los dientes más brillantes',55,5.99),(48,'Cepillo dental eléctrico','Higiene Bucal','Cepillo eléctrico para una limpieza más eficiente',70,19.99),(49,'Limpiador de lengua','Higiene Bucal','Instrumento para limpiar la lengua y mejorar la higiene bucal',40,3.99),(50,'Enjuague bucal para encías sensibles','Higiene Bucal','Enjuague suave para personas con encías sensibles',25,8.99),(51,'Multivitamínico','Suplementos','Suplemento vitamínico para cubrir necesidades diarias',50,14.99),(52,'Proteína en polvo','Suplementos','Suplemento para mejorar la recuperación muscular',30,24.99),(53,'Omega-3','Suplementos','Suplemento con ácidos grasos esenciales para la salud cardiovascular',40,19.99),(54,'Calcio + Vitamina D','Suplementos','Suplemento para fortalecer los huesos y dientes',60,12.99),(55,'Hierro','Suplementos','Suplemento para prevenir y tratar la deficiencia de hierro',55,9.99),(56,'Biotina','Suplementos','Suplemento para fortalecer cabello, piel y uñas',70,8.99),(57,'Probiótico','Suplementos','Suplemento para mejorar la salud digestiva',45,16.99),(58,'Suplemento de fibra','Suplementos','Suplemento para promover una digestión saludable',35,11.99),(59,'Coenzima Q10','Suplementos','Suplemento antioxidante para la salud cardiovascular',25,21.99),(60,'Vitamina C','Suplementos','Suplemento para reforzar el sistema inmunológico',50,7.99),(61,'Crema aclaradora de Piel','Cuidado de Piel','Hidratación intensiva para todo tipo de piel',50,9.50),(62,'Crema hidratante facial','Cuidado de Piel','Hidratación intensiva para todo tipo de piel',50,19.99),(63,'Limpiador facial suave','Cuidado de Piel','Limpieza profunda sin resecar la piel',40,12.99),(64,'Mascarilla facial revitalizante','Cuidado de Piel','Tratamiento para revitalizar y dar luminosidad a la piel',30,16.99),(65,'Serum antiarrugas','Cuidado de Piel','Tratamiento intensivo para reducir arrugas y líneas de expresión',35,24.99),(66,'Exfoliante facial suave','Cuidado de Piel','Elimina células muertas y renueva la piel',55,9.99),(67,'Tónico facial refrescante','Cuidado de Piel','Tonifica y refresca la piel después de la limpieza',45,11.99),(68,'Crema antiacné','Cuidado de Piel','Tratamiento para combatir el acné y reducir imperfecciones',40,18.99),(69,'Crema contorno de ojos','Cuidado de Piel','Hidratación y cuidado específico para el contorno de los ojos',50,17.99),(70,'Aceite facial nutritivo','Cuidado de Piel','Nutrición intensa para pieles secas y deshidratadas',30,22.99),(71,'Preservativos de látex','Salud Sexual','Preservativos lubricados para protección durante las relaciones sexuales',100,10.99),(72,'Lubricante íntimo a base de agua','Salud Sexual','Lubricante de larga duración para mayor comodidad durante las relaciones sexuales',50,15.99),(73,'Suplemento sexual masculino','Salud Sexual','Suplemento natural para mejorar el rendimiento sexual',40,39.99),(74,'Suplemento sexual femenino','Salud Sexual','Suplemento natural para aumentar el deseo y la satisfacción sexual en las mujeres',30,37.99),(75,'Pruebas de embarazo','Salud Sexual','Kit de pruebas de embarazo para detectar la presencia de hormona HCG en la orina',50,9.99),(76,'Pruebas de ovulación','Salud Sexual','Kit de pruebas de ovulación para determinar el momento más fértil del ciclo menstrual',40,12.99),(77,'Condones femeninos','Salud Sexual','Preservativos diseñados para ser utilizados por las mujeres',20,19.99),(78,'Suplemento para aumentar la libido','Salud Sexual','Suplemento natural para aumentar el deseo sexual en hombres y mujeres',35,29.99),(79,'Pastillas anticonceptivas','Salud Sexual','Pastillas hormonales para prevenir el embarazo',60,21.99),(80,'Aceite de masaje afrodisíaco','Salud Sexual','Aceite de masaje con ingredientes afrodisíacos para aumentar la estimulación sexual',25,16.99);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
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
