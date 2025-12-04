/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.27-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: revista_academica
-- ------------------------------------------------------
-- Server version	10.5.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Alertas_Plazos`
--

DROP TABLE IF EXISTS `Alertas_Plazos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alertas_Plazos` (
  `id_alerta` int(11) NOT NULL AUTO_INCREMENT,
  `id_asignacion` int(11) NOT NULL,
  `tipo_alerta` varchar(50) NOT NULL,
  `fecha_alerta` datetime DEFAULT current_timestamp(),
  `notificado` tinyint(1) DEFAULT 0,
  `fecha_notificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_alerta`),
  KEY `id_asignacion` (`id_asignacion`),
  CONSTRAINT `Alertas_Plazos_ibfk_1` FOREIGN KEY (`id_asignacion`) REFERENCES `Asignaciones_Revision` (`id_asignacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alertas_Plazos`
--

LOCK TABLES `Alertas_Plazos` WRITE;
/*!40000 ALTER TABLE `Alertas_Plazos` DISABLE KEYS */;
INSERT INTO `Alertas_Plazos` VALUES (1,3,'proximo_vencer','2025-11-23 20:02:02',0,NULL);
/*!40000 ALTER TABLE `Alertas_Plazos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Areas_Tematicas`
--

DROP TABLE IF EXISTS `Areas_Tematicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Areas_Tematicas` (
  `id_area` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `activa` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_area`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Areas_Tematicas`
--

LOCK TABLES `Areas_Tematicas` WRITE;
/*!40000 ALTER TABLE `Areas_Tematicas` DISABLE KEYS */;
INSERT INTO `Areas_Tematicas` VALUES (1,'IA','Inteligencia Artificial',NULL,1),(2,'BIO','Biotecnología',NULL,1),(3,'HIST','Historia Contemporánea',NULL,1);
/*!40000 ALTER TABLE `Areas_Tematicas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER areaTematicaNormalizaBI
BEFORE INSERT ON Areas_Tematicas
FOR EACH ROW
BEGIN
    SET NEW.nombre = CONCAT(
        UPPER(SUBSTRING(TRIM(NEW.nombre), 1, 1)),
        LOWER(SUBSTRING(TRIM(NEW.nombre), 2))
    );

    SET NEW.nombre = REGEXP_REPLACE(NEW.nombre, '\\s+', ' ');
    SET NEW.codigo = UPPER(REPLACE(TRIM(NEW.codigo), ' ', ''));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Articulos`
--

DROP TABLE IF EXISTS `Articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Articulos` (
  `id_articulo` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `resumen` text NOT NULL,
  `palabras_clave` varchar(255) DEFAULT NULL,
  `fecha_envio` datetime NOT NULL,
  `id_convocatoria` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_numero` int(11) DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_articulo`),
  KEY `id_convocatoria` (`id_convocatoria`),
  KEY `id_area` (`id_area`),
  KEY `id_numero` (`id_numero`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Articulos_ibfk_1` FOREIGN KEY (`id_convocatoria`) REFERENCES `Convocatorias` (`id_convocatoria`),
  CONSTRAINT `Articulos_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `Areas_Tematicas` (`id_area`),
  CONSTRAINT `Articulos_ibfk_3` FOREIGN KEY (`id_numero`) REFERENCES `Numeros_Revista` (`id_numero`),
  CONSTRAINT `Articulos_ibfk_4` FOREIGN KEY (`id_estado`) REFERENCES `Estados_Catalogo` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=889 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Articulos`
--

LOCK TABLES `Articulos` WRITE;
/*!40000 ALTER TABLE `Articulos` DISABLE KEYS */;
INSERT INTO `Articulos` VALUES (1,'Sobre la Electrodinámica de los Cuerpos en Movimiento','Un análisis sobre la relatividad especial.',NULL,'2023-02-15 10:00:00',1,1,1,5),(2,'Fotografía 51','Evidencia crucial sobre la estructura del ADN.',NULL,'2023-03-01 11:00:00',1,2,NULL,4),(3,'Estudios sobre la Radiación','Investigación sobre nuevos elementos.',NULL,'2023-08-10 09:00:00',2,2,1,5),(4,'Un nuevo modelo del cosmos','Propuesta sobre la expansión del universo',NULL,'2025-11-23 20:03:05',2,1,1,3),(5,'TÍTULO ANONIMIZADO - 2','RESUMEN ANONIMIZADO PARA REVISIÓN','ANONIMIZADO','2025-11-25 03:09:19',2,2,NULL,1),(6,'TÍTULO ANONIMIZADO - 2','RESUMEN ANONIMIZADO PARA REVISIÓN','ANONIMIZADO','2025-11-25 03:09:19',2,1,NULL,1),(7,'TÍTULO ANONIMIZADO - 2','RESUMEN ANONIMIZADO PARA REVISIÓN','ANONIMIZADO','2025-11-25 03:09:19',2,3,NULL,1),(8,'TÍTULO ANONIMIZADO - 2','RESUMEN ANONIMIZADO PARA REVISIÓN','ANONIMIZADO','2025-11-25 03:09:19',2,2,NULL,1),(9,'easd','asdsa','asd','2025-11-25 04:10:44',2,1,NULL,2),(10,'Mi envio','Resuemn basdasdncio de daosdiansoxopc','IA, Inteligencia Artificial, etc.','2025-11-25 04:13:36',2,1,NULL,2),(11,'Titureea','Resumen del articulo','IA, Intr','2025-11-25 04:18:55',2,3,NULL,2),(12,'a','a','a','2025-11-25 04:20:49',2,1,1,5),(13,'Un articulo con un nombre distinto','adsioas','asd','2025-11-25 05:19:41',2,2,NULL,1),(14,'Mi envio asd as','asdasdasdasddas','asd','2025-11-25 05:42:58',2,3,NULL,1),(15,'Teoría de la Tierra Plana Moderna','Un análisis controversial sobre la geografía.',NULL,'2025-02-01 10:00:00',2,3,NULL,4),(16,'Avances en Vacunas de ARN Mensajero','Estudio clínico fase 3.',NULL,'2025-01-10 09:00:00',2,2,1,5),(17,'Impacto de la IA en la Educación Superior','Análisis de herramientas LLM.',NULL,'2025-01-05 08:00:00',2,1,1,5),(888,'Hola','Crayola.',NULL,'2025-11-27 18:16:24',2,1,1,5);
/*!40000 ALTER TABLE `Articulos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER articuloAIUD_INSERT
AFTER INSERT ON Articulos
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada,
        id_registro,
        operacion,
        usuario_db,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        'Articulos',
        NEW.id_articulo,
        'INSERT',
        CURRENT_USER(),
        NULL,
        JSON_OBJECT(
            'id_articulo', NEW.id_articulo,
            'titulo', NEW.titulo,
            'resumen', NEW.resumen,
            'palabras_clave', NEW.palabras_clave,
            'fecha_envio', NEW.fecha_envio,
            'id_convocatoria', NEW.id_convocatoria,
            'id_area', NEW.id_area,
            'id_numero', NEW.id_numero,
            'id_estado', NEW.id_estado
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER articuloAIUD_UPDATE
    AFTER UPDATE ON Articulos
    FOR EACH ROW
    BEGIN
        INSERT INTO Log_Cambios (
            tabla_modificada,
            id_registro,
            operacion,
            usuario_db,
            datos_anteriores,
            datos_nuevos
        )
        VALUES (
            'Articulos',
            NEW.id_articulo,
            'UPDATE',
            CURRENT_USER(), 
            JSON_OBJECT(
                'id_articulo', OLD.id_articulo,
                'titulo', OLD.titulo,
                'resumen', OLD.resumen,
                'palabras_clave', OLD.palabras_clave,
                'fecha_envio', OLD.fecha_envio,
                'id_convocatoria', OLD.id_convocatoria,
                'id_area', OLD.id_area,
                'id_numero', OLD.id_numero,
                'id_estado', OLD.id_estado
            ),
            JSON_OBJECT(
                'id_articulo', NEW.id_articulo,
                'titulo', NEW.titulo,
                'resumen', NEW.resumen,
                'palabras_clave', NEW.palabras_clave,
                'fecha_envio', NEW.fecha_envio,
                'id_convocatoria', NEW.id_convocatoria,
                'id_area', NEW.id_area,
                'id_numero', NEW.id_numero,
                'id_estado', NEW.id_estado
            )
        );
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER articuloAIUD_DELETE
AFTER DELETE ON Articulos
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada,
        id_registro,
        operacion,
        usuario_db,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        'Articulos',
        OLD.id_articulo,
        'DELETE',
        CURRENT_USER(),
        JSON_OBJECT(
            'id_articulo', OLD.id_articulo,
            'titulo', OLD.titulo,
            'resumen', OLD.resumen,
            'palabras_clave', OLD.palabras_clave,
            'fecha_envio', OLD.fecha_envio,
            'id_convocatoria', OLD.id_convocatoria,
            'id_area', OLD.id_area,
            'id_numero', OLD.id_numero,
            'id_estado', OLD.id_estado
        ),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Articulos_Autores`
--

DROP TABLE IF EXISTS `Articulos_Autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Articulos_Autores` (
  `id_articulo` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  `orden_autoria` int(11) NOT NULL,
  `es_autor_correspondencia` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_articulo`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `Articulos_Autores_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `Articulos` (`id_articulo`),
  CONSTRAINT `Articulos_Autores_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `Perfiles_Autores` (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Articulos_Autores`
--

LOCK TABLES `Articulos_Autores` WRITE;
/*!40000 ALTER TABLE `Articulos_Autores` DISABLE KEYS */;
INSERT INTO `Articulos_Autores` VALUES (1,1,1,0),(2,3,1,0),(3,2,1,0),(4,1,2,0),(9,2,1,1),(10,5,1,1),(11,6,1,1),(12,6,1,1),(13,4,1,1),(14,7,1,1);
/*!40000 ALTER TABLE `Articulos_Autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Asignaciones_Revision`
--

DROP TABLE IF EXISTS `Asignaciones_Revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Asignaciones_Revision` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) NOT NULL,
  `id_revisor` int(11) NOT NULL,
  `id_version_asignada` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_asignacion`),
  UNIQUE KEY `id_articulo` (`id_articulo`,`id_revisor`),
  KEY `id_revisor` (`id_revisor`),
  KEY `id_version_asignada` (`id_version_asignada`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Asignaciones_Revision_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `Articulos` (`id_articulo`),
  CONSTRAINT `Asignaciones_Revision_ibfk_2` FOREIGN KEY (`id_revisor`) REFERENCES `Perfiles_Revisores` (`id_revisor`),
  CONSTRAINT `Asignaciones_Revision_ibfk_3` FOREIGN KEY (`id_version_asignada`) REFERENCES `Versiones_Articulo` (`id_version`),
  CONSTRAINT `Asignaciones_Revision_ibfk_4` FOREIGN KEY (`id_estado`) REFERENCES `Estados_Catalogo` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Asignaciones_Revision`
--

LOCK TABLES `Asignaciones_Revision` WRITE;
/*!40000 ALTER TABLE `Asignaciones_Revision` DISABLE KEYS */;
INSERT INTO `Asignaciones_Revision` VALUES (1,1,1,1,'2023-02-20 12:00:00','2023-03-20 12:00:00',10),(2,2,2,2,'2023-03-05 14:00:00','2023-04-05 14:00:00',10),(3,3,1,4,'2023-09-30 10:00:00','2023-10-30 10:00:00',9),(4,3,2,3,'2023-08-15 11:00:00','2025-11-23 14:17:15',13),(6,4,2,5,'2025-11-25 02:37:41','2025-12-25 02:37:41',10),(7,4,3,5,'2025-11-25 02:37:41','2025-12-25 02:37:41',10),(8,3,3,1,'2023-07-01 00:00:00','2023-08-01 00:00:00',10),(9,12,2,11,'2025-11-25 04:45:33','2025-12-25 04:45:33',8),(10,12,3,11,'2025-11-25 04:45:33','2025-12-25 04:45:33',10),(18,15,1,1,'2025-02-02 10:00:00','2025-03-02 10:00:00',10),(19,14,1,14,'2025-11-27 18:41:35','2025-12-27 18:41:35',8),(20,14,3,14,'2025-11-27 18:41:35','2025-12-27 18:41:35',8);
/*!40000 ALTER TABLE `Asignaciones_Revision` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER asignacionLimiteBI
BEFORE INSERT ON Asignaciones_Revision
FOR EACH ROW
BEGIN
    DECLARE carga INT;
    DECLARE max_carga INT;

    SELECT max_carga_activa INTO max_carga
    FROM Perfiles_Revisores
    WHERE id_revisor = NEW.id_revisor;

    SELECT COUNT(*) INTO carga
    FROM Asignaciones_Revision ar
    JOIN Estados_Catalogo e ON ar.id_estado = e.id_estado
    WHERE ar.id_revisor = NEW.id_revisor AND e.entidad = 'asignacion'
      AND e.codigo IN ('asignado', 'aceptada'); 

    IF carga >= COALESCE(max_carga, 3) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Límite de carga superado para este revisor (tiene demasiadas revisiones activas)';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER asignacionAIUD
AFTER INSERT ON Asignaciones_Revision
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada,
        id_registro,
        operacion,
        usuario_db,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        'Asignaciones_Revision',
        NEW.id_asignacion,
        'INSERT',
        CURRENT_USER(),
        NULL,
        JSON_OBJECT(
            'id_articulo', NEW.id_articulo,
            'id_revisor', NEW.id_revisor,
            'id_version_asignada', NEW.id_version_asignada,
            'fecha_asignacion', NEW.fecha_asignacion,
            'fecha_limite', NEW.fecha_limite,
            'id_estado', NEW.id_estado
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER plazoAlertaBU
BEFORE UPDATE ON Asignaciones_Revision
FOR EACH ROW
BEGIN
    DECLARE id_retraso INT;

    
    SELECT id_estado INTO id_retraso
    FROM Estados_Catalogo
    WHERE codigo = 'RETRASO'
    LIMIT 1;

    
    IF NEW.fecha_limite IS NOT NULL AND NEW.fecha_limite < NOW() THEN
        SET NEW.id_estado = id_retraso;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Conflictos_Interes`
--

DROP TABLE IF EXISTS `Conflictos_Interes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Conflictos_Interes` (
  `id_conflicto` int(11) NOT NULL AUTO_INCREMENT,
  `id_revisor` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  `id_tipo_conflicto` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_registro` datetime NOT NULL,
  `vigente` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_conflicto`),
  KEY `id_revisor` (`id_revisor`),
  KEY `id_autor` (`id_autor`),
  KEY `id_tipo_conflicto` (`id_tipo_conflicto`),
  CONSTRAINT `Conflictos_Interes_ibfk_1` FOREIGN KEY (`id_revisor`) REFERENCES `Perfiles_Revisores` (`id_revisor`),
  CONSTRAINT `Conflictos_Interes_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `Perfiles_Autores` (`id_autor`),
  CONSTRAINT `Conflictos_Interes_ibfk_3` FOREIGN KEY (`id_tipo_conflicto`) REFERENCES `Tipos_Conflicto_Catalogo` (`id_tipo_conflicto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Conflictos_Interes`
--

LOCK TABLES `Conflictos_Interes` WRITE;
/*!40000 ALTER TABLE `Conflictos_Interes` DISABLE KEYS */;
INSERT INTO `Conflictos_Interes` VALUES (1,1,1,1,'Disputa histórica sobre la invención del cálculo.','2023-01-01 00:00:00',1);
/*!40000 ALTER TABLE `Conflictos_Interes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Convocatorias`
--

DROP TABLE IF EXISTS `Convocatorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Convocatorias` (
  `id_convocatoria` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_convocatoria`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Convocatorias_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `Estados_Catalogo` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Convocatorias`
--

LOCK TABLES `Convocatorias` WRITE;
/*!40000 ALTER TABLE `Convocatorias` DISABLE KEYS */;
INSERT INTO `Convocatorias` VALUES (1,'Avances en Ciencia del Siglo XX',NULL,'2023-01-01','2023-06-30',7),(2,'Nuevas Fronteras de la Investigación',NULL,'2025-01-01','2026-12-31',6);
/*!40000 ALTER TABLE `Convocatorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Convocatorias_Areas`
--

DROP TABLE IF EXISTS `Convocatorias_Areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Convocatorias_Areas` (
  `id_convocatoria` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  PRIMARY KEY (`id_convocatoria`,`id_area`),
  KEY `id_area` (`id_area`),
  CONSTRAINT `Convocatorias_Areas_ibfk_1` FOREIGN KEY (`id_convocatoria`) REFERENCES `Convocatorias` (`id_convocatoria`),
  CONSTRAINT `Convocatorias_Areas_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `Areas_Tematicas` (`id_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Convocatorias_Areas`
--

LOCK TABLES `Convocatorias_Areas` WRITE;
/*!40000 ALTER TABLE `Convocatorias_Areas` DISABLE KEYS */;
INSERT INTO `Convocatorias_Areas` VALUES (1,1),(1,2),(2,1),(2,2),(2,3);
/*!40000 ALTER TABLE `Convocatorias_Areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Convocatorias_Responsables`
--

DROP TABLE IF EXISTS `Convocatorias_Responsables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Convocatorias_Responsables` (
  `id_responsable` int(11) NOT NULL AUTO_INCREMENT,
  `id_convocatoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_responsable`),
  UNIQUE KEY `id_convocatoria` (`id_convocatoria`,`id_usuario`,`id_rol`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `Convocatorias_Responsables_ibfk_1` FOREIGN KEY (`id_convocatoria`) REFERENCES `Convocatorias` (`id_convocatoria`),
  CONSTRAINT `Convocatorias_Responsables_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id_usuario`),
  CONSTRAINT `Convocatorias_Responsables_ibfk_3` FOREIGN KEY (`id_rol`) REFERENCES `Roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Convocatorias_Responsables`
--

LOCK TABLES `Convocatorias_Responsables` WRITE;
/*!40000 ALTER TABLE `Convocatorias_Responsables` DISABLE KEYS */;
INSERT INTO `Convocatorias_Responsables` VALUES (1,1,1,1,'2025-11-23 20:01:15'),(2,2,1,1,'2025-11-23 20:01:15');
/*!40000 ALTER TABLE `Convocatorias_Responsables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Decisiones_Dictamen_Catalogo`
--

DROP TABLE IF EXISTS `Decisiones_Dictamen_Catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Decisiones_Dictamen_Catalogo` (
  `id_decision` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_estado_resultante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_decision`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `id_estado_resultante` (`id_estado_resultante`),
  CONSTRAINT `Decisiones_Dictamen_Catalogo_ibfk_1` FOREIGN KEY (`id_estado_resultante`) REFERENCES `Estados_Catalogo` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Decisiones_Dictamen_Catalogo`
--

LOCK TABLES `Decisiones_Dictamen_Catalogo` WRITE;
/*!40000 ALTER TABLE `Decisiones_Dictamen_Catalogo` DISABLE KEYS */;
INSERT INTO `Decisiones_Dictamen_Catalogo` VALUES (1,'aceptar','Aceptar sin cambios',3),(2,'aceptar_con_cambios','Aceptar con cambios menores',2),(3,'rechazar','Rechazar artículo',4);
/*!40000 ALTER TABLE `Decisiones_Dictamen_Catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dictamenes`
--

DROP TABLE IF EXISTS `Dictamenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dictamenes` (
  `id_dictamen` int(11) NOT NULL AUTO_INCREMENT,
  `id_asignacion` int(11) NOT NULL,
  `id_decision` int(11) NOT NULL,
  `comentarios_para_autor` text DEFAULT NULL,
  `comentarios_para_editor` text DEFAULT NULL,
  `fecha_dictamen` datetime NOT NULL,
  PRIMARY KEY (`id_dictamen`),
  UNIQUE KEY `id_asignacion` (`id_asignacion`),
  KEY `id_decision` (`id_decision`),
  CONSTRAINT `Dictamenes_ibfk_1` FOREIGN KEY (`id_asignacion`) REFERENCES `Asignaciones_Revision` (`id_asignacion`),
  CONSTRAINT `Dictamenes_ibfk_2` FOREIGN KEY (`id_decision`) REFERENCES `Decisiones_Dictamen_Catalogo` (`id_decision`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dictamenes`
--

LOCK TABLES `Dictamenes` WRITE;
/*!40000 ALTER TABLE `Dictamenes` DISABLE KEYS */;
INSERT INTO `Dictamenes` VALUES (1,1,1,'Brillante, publicar de inmediato.',NULL,'2023-03-10 15:00:00'),(2,2,3,NULL,'Las imágenes son poco claras y las conclusiones no están bien fundamentadas.','2023-03-20 18:00:00'),(3,4,2,'Interesante, pero requiere aclarar la metodología en la sección 3.',NULL,'2023-09-12 16:00:00'),(4,7,1,'Esta es una prueba de aceptación de dictamen','lol','2025-11-25 02:41:18'),(7,8,1,NULL,NULL,'2023-07-05 00:00:00'),(8,10,1,'felicidades','todo buien','2025-11-25 05:15:59'),(9,18,3,'Carece de fundamento científico básico.',NULL,'2025-02-05 15:00:00'),(10,16,1,'Excelente trabajo, innovador.',NULL,'2025-01-20 10:00:00'),(11,6,1,'hola','uwu','2025-11-27 18:39:10');
/*!40000 ALTER TABLE `Dictamenes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER dictamenAUDAI
AFTER INSERT ON Dictamenes
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada,
        id_registro,
        operacion,
        usuario_db,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        'Dictamenes',
        NEW.id_dictamen,
        'INSERT',
        CURRENT_USER(),
        NULL,
        JSON_OBJECT(
            'id_asignacion', NEW.id_asignacion,
            'id_decision', NEW.id_decision,
            'comentarios_para_autor', NEW.comentarios_para_autor,
            'comentarios_para_editor', NEW.comentarios_para_editor,
            'fecha_dictamen', NEW.fecha_dictamen
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER articuloEstadoAIDictamen
AFTER INSERT ON Dictamenes
FOR EACH ROW
BEGIN
    DECLARE nuevo_estado INT;

    
    IF NEW.id_decision = 1 THEN 
        SET nuevo_estado = 3;
    ELSEIF NEW.id_decision = 3 THEN 
        SET nuevo_estado = 4;
    ELSEIF NEW.id_decision = 2 THEN 
        SET nuevo_estado = 3; 
    END IF;

    
    UPDATE Articulos
    SET id_estado = nuevo_estado
    WHERE id_articulo = (SELECT id_articulo FROM Asignaciones_Revision WHERE id_asignacion = NEW.id_asignacion LIMIT 1);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Estados_Catalogo`
--

DROP TABLE IF EXISTS `Estados_Catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estados_Catalogo` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `entidad` varchar(50) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE KEY `entidad` (`entidad`,`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estados_Catalogo`
--

LOCK TABLES `Estados_Catalogo` WRITE;
/*!40000 ALTER TABLE `Estados_Catalogo` DISABLE KEYS */;
INSERT INTO `Estados_Catalogo` VALUES (1,'articulo','enviado','Artículo Enviado por Autor'),(2,'articulo','en_revision','Artículo en Revisión por Pares'),(3,'articulo','aceptado','Artículo Aceptado para Publicación'),(4,'articulo','rechazado','Artículo Rechazado'),(5,'articulo','publicado','Artículo Publicado en un Número'),(6,'convocatoria','activa','Convocatoria Abierta para Recibir Artículos'),(7,'convocatoria','cerrada','Convocatoria Cerrada'),(8,'asignacion','asignado','Revisor Asignado, Pendiente de Aceptación'),(9,'asignacion','aceptada','Revisor Aceptó la Revisión'),(10,'asignacion','completada','Revisor Envió su Dictamen'),(11,'usuario','activo','Usuario con Acceso al Sistema'),(12,'usuario','bloqueado','Usuario sin Acceso al Sistema'),(13,'Asignaciones_Revision','RETRASO','Asignación con fecha limite pasada');
/*!40000 ALTER TABLE `Estados_Catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Historial_Estados`
--

DROP TABLE IF EXISTS `Historial_Estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Historial_Estados` (
  `id_historial` int(11) NOT NULL AUTO_INCREMENT,
  `entidad` varchar(50) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_estado_anterior` int(11) DEFAULT NULL,
  `id_estado_nuevo` int(11) NOT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp(),
  `id_usuario_responsable` int(11) DEFAULT NULL,
  `comentario` text DEFAULT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `id_estado_anterior` (`id_estado_anterior`),
  KEY `id_estado_nuevo` (`id_estado_nuevo`),
  KEY `id_usuario_responsable` (`id_usuario_responsable`),
  CONSTRAINT `Historial_Estados_ibfk_1` FOREIGN KEY (`id_estado_anterior`) REFERENCES `Estados_Catalogo` (`id_estado`),
  CONSTRAINT `Historial_Estados_ibfk_2` FOREIGN KEY (`id_estado_nuevo`) REFERENCES `Estados_Catalogo` (`id_estado`),
  CONSTRAINT `Historial_Estados_ibfk_3` FOREIGN KEY (`id_usuario_responsable`) REFERENCES `Usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Historial_Estados`
--

LOCK TABLES `Historial_Estados` WRITE;
/*!40000 ALTER TABLE `Historial_Estados` DISABLE KEYS */;
INSERT INTO `Historial_Estados` VALUES (1,'articulo',1,NULL,1,'2023-02-15 10:00:00',NULL,NULL),(2,'articulo',1,1,2,'2023-02-20 12:00:00',NULL,NULL),(3,'articulo',1,2,3,'2023-03-11 09:00:00',NULL,NULL),(4,'articulo',1,3,5,'2023-09-01 00:00:00',NULL,NULL),(5,'articulo',2,NULL,1,'2023-03-01 11:00:00',NULL,NULL),(6,'articulo',2,1,2,'2023-03-05 14:00:00',NULL,NULL),(7,'articulo',2,2,4,'2023-03-21 10:00:00',NULL,NULL),(8,'articulo',3,NULL,1,'2023-08-10 09:00:00',NULL,NULL),(9,'articulo',3,1,2,'2023-08-15 11:00:00',NULL,NULL),(10,'articulo',4,NULL,1,'2025-11-23 20:03:05',NULL,NULL),(11,'asignacion',6,NULL,8,'2025-11-25 02:37:41',1,'Asignación automática de revisor al artículo 4'),(12,'asignacion',7,NULL,8,'2025-11-25 02:37:41',1,'Asignación automática de revisor al artículo 4'),(13,'asignacion',7,8,10,'2025-11-25 02:41:18',3,'Revisión completada'),(14,'articulo',4,1,3,'2025-11-25 02:41:18',3,'Artículo aceptado según dictamen.'),(15,'articulo',99,NULL,1,'2023-09-01 10:00:00',NULL,NULL),(16,'articulo',99,1,2,'2023-09-05 10:00:00',NULL,NULL),(17,'articulo',99,2,3,'2023-09-25 10:00:00',NULL,NULL),(18,'articulo',99,3,5,'2023-10-01 10:00:00',NULL,NULL),(19,'articulo',9,NULL,1,'2025-11-25 04:10:44',3,'Registro de envío de artículo (alta inicial)'),(20,'articulo',10,NULL,1,'2025-11-25 04:13:36',9,'Registro de envío de artículo (alta inicial)'),(21,'ARTICULO',10,1,2,'2025-11-25 04:14:21',9,'Nueva versión del artículo: v2'),(22,'articulo',11,NULL,1,'2025-11-25 04:18:55',10,'Registro de envío de artículo (alta inicial)'),(23,'ARTICULO',11,1,2,'2025-11-25 04:19:39',10,'Nueva versión del artículo: v2'),(24,'articulo',12,NULL,1,'2025-11-25 04:20:49',10,'Registro de envío de artículo (alta inicial)'),(25,'asignacion',9,NULL,8,'2025-11-25 04:45:33',1,'Asignación automática de revisor al artículo 12'),(26,'asignacion',10,NULL,8,'2025-11-25 04:45:33',1,'Asignación automática de revisor al artículo 12'),(27,'asignacion',9,8,8,'2025-11-25 04:47:36',1,'Reasignación de revisor: de 1 a 2'),(28,'asignacion',10,8,10,'2025-11-25 05:15:59',3,'Revisión completada'),(29,'articulo',12,1,3,'2025-11-25 05:15:59',3,'Artículo aceptado según dictamen.'),(30,'articulo',13,NULL,1,'2025-11-25 05:19:41',8,'Registro de envío de artículo (alta inicial)'),(36,'ARTICULO',9,1,2,'2025-11-25 05:23:57',3,'Nueva versión del artículo: v2'),(37,'articulo',14,NULL,1,'2025-11-25 05:42:58',11,'Registro de envío de artículo (alta inicial)'),(40,'articulo',3,3,5,'2025-11-27 15:42:07',1,'Publicado en Número ID 1'),(41,'articulo',4,3,5,'2025-11-27 15:42:13',1,'Publicado en Número ID 1'),(42,'articulo',12,3,5,'2025-11-27 15:42:59',1,'Publicado en Número ID 1'),(43,'articulo',15,NULL,1,'2025-02-01 10:00:00',NULL,NULL),(44,'articulo',15,1,2,'2025-02-02 10:00:00',NULL,NULL),(45,'articulo',15,2,4,'2025-02-05 15:00:00',NULL,NULL),(46,'articulo',16,NULL,1,'2025-01-10 09:00:00',NULL,NULL),(47,'articulo',16,1,2,'2025-01-12 10:00:00',NULL,NULL),(48,'articulo',16,2,3,'2025-01-20 10:00:00',NULL,NULL),(49,'articulo',16,3,5,'2025-01-25 10:00:00',NULL,NULL),(50,'articulo',17,NULL,1,'2025-01-05 08:00:00',NULL,NULL),(51,'articulo',17,1,5,'2025-01-28 10:00:00',NULL,NULL),(52,'asignacion',6,8,10,'2025-11-27 18:39:10',5,'Revisión completada'),(53,'articulo',4,5,3,'2025-11-27 18:39:10',5,'Artículo aceptado según dictamen.'),(54,'asignacion',19,NULL,8,'2025-11-27 18:41:35',1,'Asignación automática de revisor al artículo 14'),(55,'asignacion',20,NULL,8,'2025-11-27 18:41:35',1,'Asignación automática de revisor al artículo 14');
/*!40000 ALTER TABLE `Historial_Estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Log_Cambios`
--

DROP TABLE IF EXISTS `Log_Cambios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Log_Cambios` (
  `id_log` bigint(20) NOT NULL AUTO_INCREMENT,
  `tabla_modificada` varchar(50) NOT NULL,
  `id_registro` int(11) NOT NULL,
  `operacion` varchar(10) NOT NULL,
  `fecha_operacion` datetime DEFAULT current_timestamp(),
  `usuario_db` varchar(100) DEFAULT NULL,
  `datos_anteriores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`datos_anteriores`)),
  `datos_nuevos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`datos_nuevos`)),
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Log_Cambios`
--

LOCK TABLES `Log_Cambios` WRITE;
/*!40000 ALTER TABLE `Log_Cambios` DISABLE KEYS */;
INSERT INTO `Log_Cambios` VALUES (1,'Asignaciones_Revision',6,'INSERT','2025-11-25 02:37:41','ra_usuario@localhost',NULL,'{\"id_articulo\": 4, \"id_revisor\": 2, \"id_version_asignada\": 5, \"fecha_asignacion\": \"2025-11-25 02:37:41\", \"fecha_limite\": \"2025-12-25 02:37:41\", \"id_estado\": 8}'),(2,'Asignaciones_Revision',7,'INSERT','2025-11-25 02:37:41','ra_usuario@localhost',NULL,'{\"id_articulo\": 4, \"id_revisor\": 3, \"id_version_asignada\": 5, \"fecha_asignacion\": \"2025-11-25 02:37:41\", \"fecha_limite\": \"2025-12-25 02:37:41\", \"id_estado\": 8}'),(3,'Dictamenes',4,'INSERT','2025-11-25 02:41:18','ra_usuario@localhost',NULL,'{\"id_asignacion\": 7, \"id_decision\": 1, \"comentarios_para_autor\": \"Esta es una prueba de aceptación de dictamen\", \"comentarios_para_editor\": \"lol\", \"fecha_dictamen\": \"2025-11-25 02:41:18\"}'),(4,'Articulos',4,'UPDATE','2025-11-25 02:41:18','ra_usuario@localhost','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}'),(5,'Articulos',4,'UPDATE','2025-11-25 02:41:18','ra_usuario@localhost','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}'),(6,'Articulos',5,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_articulo\": 5, \"titulo\": \"TÍTULO ANONIMIZADO - 2\", \"resumen\": \"RESUMEN ANONIMIZADO PARA REVISIÓN\", \"palabras_clave\": \"ANONIMIZADO\", \"fecha_envio\": \"2025-11-25 03:09:19\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 1}'),(7,'Articulos',6,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_articulo\": 6, \"titulo\": \"TÍTULO ANONIMIZADO - 2\", \"resumen\": \"RESUMEN ANONIMIZADO PARA REVISIÓN\", \"palabras_clave\": \"ANONIMIZADO\", \"fecha_envio\": \"2025-11-25 03:09:19\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}'),(8,'Articulos',7,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_articulo\": 7, \"titulo\": \"TÍTULO ANONIMIZADO - 2\", \"resumen\": \"RESUMEN ANONIMIZADO PARA REVISIÓN\", \"palabras_clave\": \"ANONIMIZADO\", \"fecha_envio\": \"2025-11-25 03:09:19\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 1}'),(9,'Articulos',8,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_articulo\": 8, \"titulo\": \"TÍTULO ANONIMIZADO - 2\", \"resumen\": \"RESUMEN ANONIMIZADO PARA REVISIÓN\", \"palabras_clave\": \"ANONIMIZADO\", \"fecha_envio\": \"2025-11-25 03:09:19\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 1}'),(12,'Asignaciones_Revision',8,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_articulo\": 3, \"id_revisor\": 3, \"id_version_asignada\": 1, \"fecha_asignacion\": \"2023-07-01 00:00:00\", \"fecha_limite\": \"2023-08-01 00:00:00\", \"id_estado\": 10}'),(13,'Dictamenes',7,'INSERT','2025-11-25 03:09:19','ra_usuario@localhost',NULL,'{\"id_asignacion\": 8, \"id_decision\": 1, \"comentarios_para_autor\": null, \"comentarios_para_editor\": null, \"fecha_dictamen\": \"2023-07-05 00:00:00\"}'),(14,'Articulos',3,'UPDATE','2025-11-25 03:09:19','ra_usuario@localhost','{\"id_articulo\": 3, \"titulo\": \"Estudios sobre la Radiación\", \"resumen\": \"Investigación sobre nuevos elementos.\", \"palabras_clave\": null, \"fecha_envio\": \"2023-08-10 09:00:00\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 2}','{\"id_articulo\": 3, \"titulo\": \"Estudios sobre la Radiación\", \"resumen\": \"Investigación sobre nuevos elementos.\", \"palabras_clave\": null, \"fecha_envio\": \"2023-08-10 09:00:00\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 3}'),(15,'Articulos',9,'INSERT','2025-11-25 04:10:44','ra_usuario@localhost',NULL,'{\"id_articulo\": 9, \"titulo\": \"easd\", \"resumen\": \"asdsa\", \"palabras_clave\": \"asd\", \"fecha_envio\": \"2025-11-25 04:10:44\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}'),(16,'Articulos',10,'INSERT','2025-11-25 04:13:36','ra_usuario@localhost',NULL,'{\"id_articulo\": 10, \"titulo\": \"Mi envio\", \"resumen\": \"Resuemn basdasdncio de daosdiansoxopc\", \"palabras_clave\": \"IA, Inteligencia Artificial, etc.\", \"fecha_envio\": \"2025-11-25 04:13:36\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}'),(17,'Articulos',10,'UPDATE','2025-11-25 04:14:21','ra_usuario@localhost','{\"id_articulo\": 10, \"titulo\": \"Mi envio\", \"resumen\": \"Resuemn basdasdncio de daosdiansoxopc\", \"palabras_clave\": \"IA, Inteligencia Artificial, etc.\", \"fecha_envio\": \"2025-11-25 04:13:36\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}','{\"id_articulo\": 10, \"titulo\": \"Mi envio\", \"resumen\": \"Resuemn basdasdncio de daosdiansoxopc\", \"palabras_clave\": \"IA, Inteligencia Artificial, etc.\", \"fecha_envio\": \"2025-11-25 04:13:36\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 2}'),(18,'Articulos',11,'INSERT','2025-11-25 04:18:55','ra_usuario@localhost',NULL,'{\"id_articulo\": 11, \"titulo\": \"Titureea\", \"resumen\": \"Resumen del articulo\", \"palabras_clave\": \"IA, Intr\", \"fecha_envio\": \"2025-11-25 04:18:55\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 1}'),(19,'Articulos',11,'UPDATE','2025-11-25 04:19:39','ra_usuario@localhost','{\"id_articulo\": 11, \"titulo\": \"Titureea\", \"resumen\": \"Resumen del articulo\", \"palabras_clave\": \"IA, Intr\", \"fecha_envio\": \"2025-11-25 04:18:55\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 1}','{\"id_articulo\": 11, \"titulo\": \"Titureea\", \"resumen\": \"Resumen del articulo\", \"palabras_clave\": \"IA, Intr\", \"fecha_envio\": \"2025-11-25 04:18:55\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 2}'),(20,'Articulos',12,'INSERT','2025-11-25 04:20:49','ra_usuario@localhost',NULL,'{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}'),(21,'Asignaciones_Revision',9,'INSERT','2025-11-25 04:45:33','ra_usuario@localhost',NULL,'{\"id_articulo\": 12, \"id_revisor\": 1, \"id_version_asignada\": 11, \"fecha_asignacion\": \"2025-11-25 04:45:33\", \"fecha_limite\": \"2025-12-25 04:45:33\", \"id_estado\": 8}'),(22,'Asignaciones_Revision',10,'INSERT','2025-11-25 04:45:33','ra_usuario@localhost',NULL,'{\"id_articulo\": 12, \"id_revisor\": 3, \"id_version_asignada\": 11, \"fecha_asignacion\": \"2025-11-25 04:45:33\", \"fecha_limite\": \"2025-12-25 04:45:33\", \"id_estado\": 8}'),(23,'Dictamenes',8,'INSERT','2025-11-25 05:15:59','ra_usuario@localhost',NULL,'{\"id_asignacion\": 10, \"id_decision\": 1, \"comentarios_para_autor\": \"felicidades\", \"comentarios_para_editor\": \"todo buien\", \"fecha_dictamen\": \"2025-11-25 05:15:59\"}'),(24,'Articulos',12,'UPDATE','2025-11-25 05:15:59','ra_usuario@localhost','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}'),(25,'Articulos',12,'UPDATE','2025-11-25 05:15:59','ra_usuario@localhost','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}'),(26,'Articulos',13,'INSERT','2025-11-25 05:19:41','ra_usuario@localhost',NULL,'{\"id_articulo\": 13, \"titulo\": \"Un articulo con un nombre distinto\", \"resumen\": \"adsioas\", \"palabras_clave\": \"asd\", \"fecha_envio\": \"2025-11-25 05:19:41\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 1}'),(32,'Articulos',9,'UPDATE','2025-11-25 05:23:57','ra_usuario@localhost','{\"id_articulo\": 9, \"titulo\": \"easd\", \"resumen\": \"asdsa\", \"palabras_clave\": \"asd\", \"fecha_envio\": \"2025-11-25 04:10:44\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 1}','{\"id_articulo\": 9, \"titulo\": \"easd\", \"resumen\": \"asdsa\", \"palabras_clave\": \"asd\", \"fecha_envio\": \"2025-11-25 04:10:44\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 2}'),(33,'Articulos',14,'INSERT','2025-11-25 05:42:58','ra_usuario@localhost',NULL,'{\"id_articulo\": 14, \"titulo\": \"Mi envio asd as\", \"resumen\": \"asdasdasdasddas\", \"palabras_clave\": \"asd\", \"fecha_envio\": \"2025-11-25 05:42:58\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 1}'),(36,'Articulos',3,'UPDATE','2025-11-27 15:42:07','ra_usuario@localhost','{\"id_articulo\": 3, \"titulo\": \"Estudios sobre la Radiación\", \"resumen\": \"Investigación sobre nuevos elementos.\", \"palabras_clave\": null, \"fecha_envio\": \"2023-08-10 09:00:00\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": null, \"id_estado\": 3}','{\"id_articulo\": 3, \"titulo\": \"Estudios sobre la Radiación\", \"resumen\": \"Investigación sobre nuevos elementos.\", \"palabras_clave\": null, \"fecha_envio\": \"2023-08-10 09:00:00\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": 1, \"id_estado\": 5}'),(37,'Articulos',4,'UPDATE','2025-11-27 15:42:13','ra_usuario@localhost','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 5}'),(38,'Articulos',12,'UPDATE','2025-11-27 15:42:59','ra_usuario@localhost','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": null, \"id_estado\": 3}','{\"id_articulo\": 12, \"titulo\": \"a\", \"resumen\": \"a\", \"palabras_clave\": \"a\", \"fecha_envio\": \"2025-11-25 04:20:49\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 5}'),(39,'Articulos',15,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_articulo\": 15, \"titulo\": \"Teoría de la Tierra Plana Moderna\", \"resumen\": \"Un análisis controversial sobre la geografía.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-02-01 10:00:00\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 4}'),(40,'Asignaciones_Revision',18,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_articulo\": 15, \"id_revisor\": 1, \"id_version_asignada\": 1, \"fecha_asignacion\": \"2025-02-02 10:00:00\", \"fecha_limite\": \"2025-03-02 10:00:00\", \"id_estado\": 10}'),(41,'Dictamenes',9,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_asignacion\": 18, \"id_decision\": 3, \"comentarios_para_autor\": \"Carece de fundamento científico básico.\", \"comentarios_para_editor\": null, \"fecha_dictamen\": \"2025-02-05 15:00:00\"}'),(42,'Articulos',15,'UPDATE','2025-11-27 15:46:01','ra_usuario@localhost','{\"id_articulo\": 15, \"titulo\": \"Teoría de la Tierra Plana Moderna\", \"resumen\": \"Un análisis controversial sobre la geografía.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-02-01 10:00:00\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 4}','{\"id_articulo\": 15, \"titulo\": \"Teoría de la Tierra Plana Moderna\", \"resumen\": \"Un análisis controversial sobre la geografía.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-02-01 10:00:00\", \"id_convocatoria\": 2, \"id_area\": 3, \"id_numero\": null, \"id_estado\": 4}'),(43,'Articulos',16,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_articulo\": 16, \"titulo\": \"Avances en Vacunas de ARN Mensajero\", \"resumen\": \"Estudio clínico fase 3.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-01-10 09:00:00\", \"id_convocatoria\": 2, \"id_area\": 2, \"id_numero\": 1, \"id_estado\": 5}'),(44,'Dictamenes',10,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_asignacion\": 16, \"id_decision\": 1, \"comentarios_para_autor\": \"Excelente trabajo, innovador.\", \"comentarios_para_editor\": null, \"fecha_dictamen\": \"2025-01-20 10:00:00\"}'),(45,'Articulos',17,'INSERT','2025-11-27 15:46:01','ra_usuario@localhost',NULL,'{\"id_articulo\": 17, \"titulo\": \"Impacto de la IA en la Educación Superior\", \"resumen\": \"Análisis de herramientas LLM.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-01-05 08:00:00\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 5}'),(46,'Articulos',888,'INSERT','2025-11-27 18:16:24','ra_usuario@localhost',NULL,'{\"id_articulo\": 888, \"titulo\": \"Hola\", \"resumen\": \"Crayola.\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-27 18:16:24\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 5}'),(47,'Numeros_Revista',1,'UPDATE','2025-11-27 18:26:51','ra_usuario@localhost','{\"id_numero\": 1, \"anio\": 2023, \"volumen\": 1, \"numero\": 1, \"fecha_publicacion\": \"2023-09-01\", \"id_convocatoria\": 1}','{\"id_numero\": 1, \"anio\": 2025, \"volumen\": 1, \"numero\": 1, \"fecha_publicacion\": \"2023-09-01\", \"id_convocatoria\": 1}'),(48,'Dictamenes',11,'INSERT','2025-11-27 18:39:10','ra_usuario@localhost',NULL,'{\"id_asignacion\": 6, \"id_decision\": 1, \"comentarios_para_autor\": \"hola\", \"comentarios_para_editor\": \"uwu\", \"fecha_dictamen\": \"2025-11-27 18:39:10\"}'),(49,'Articulos',4,'UPDATE','2025-11-27 18:39:10','ra_usuario@localhost','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 5}','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 3}'),(50,'Articulos',4,'UPDATE','2025-11-27 18:39:10','ra_usuario@localhost','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 3}','{\"id_articulo\": 4, \"titulo\": \"Un nuevo modelo del cosmos\", \"resumen\": \"Propuesta sobre la expansión del universo\", \"palabras_clave\": null, \"fecha_envio\": \"2025-11-23 20:03:05\", \"id_convocatoria\": 2, \"id_area\": 1, \"id_numero\": 1, \"id_estado\": 3}'),(51,'Asignaciones_Revision',19,'INSERT','2025-11-27 18:41:35','ra_usuario@localhost',NULL,'{\"id_articulo\": 14, \"id_revisor\": 1, \"id_version_asignada\": 14, \"fecha_asignacion\": \"2025-11-27 18:41:35\", \"fecha_limite\": \"2025-12-27 18:41:35\", \"id_estado\": 8}'),(52,'Asignaciones_Revision',20,'INSERT','2025-11-27 18:41:35','ra_usuario@localhost',NULL,'{\"id_articulo\": 14, \"id_revisor\": 3, \"id_version_asignada\": 14, \"fecha_asignacion\": \"2025-11-27 18:41:35\", \"fecha_limite\": \"2025-12-27 18:41:35\", \"id_estado\": 8}');
/*!40000 ALTER TABLE `Log_Cambios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Metricas_Tiempos`
--

DROP TABLE IF EXISTS `Metricas_Tiempos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Metricas_Tiempos` (
  `id_metrica` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) NOT NULL,
  `etapa` varchar(50) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `dias_transcurridos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_metrica`),
  KEY `id_articulo` (`id_articulo`),
  CONSTRAINT `Metricas_Tiempos_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `Articulos` (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Metricas_Tiempos`
--

LOCK TABLES `Metricas_Tiempos` WRITE;
/*!40000 ALTER TABLE `Metricas_Tiempos` DISABLE KEYS */;
INSERT INTO `Metricas_Tiempos` VALUES (1,1,'Recepcion-Asignacion','2023-02-15 10:00:00','2023-02-20 12:00:00',NULL),(2,1,'Asignacion-Dictamen','2023-02-20 12:00:00','2023-03-10 15:00:00',NULL),(3,9,'envio','2025-11-25 04:10:44',NULL,NULL),(4,10,'envio','2025-11-25 04:13:36',NULL,NULL),(5,11,'envio','2025-11-25 04:18:55',NULL,NULL),(6,12,'envio','2025-11-25 04:20:49',NULL,NULL),(7,13,'envio','2025-11-25 05:19:41',NULL,NULL),(8,14,'envio','2025-11-25 05:42:58',NULL,NULL);
/*!40000 ALTER TABLE `Metricas_Tiempos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Numeros_Revista`
--

DROP TABLE IF EXISTS `Numeros_Revista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Numeros_Revista` (
  `id_numero` int(11) NOT NULL AUTO_INCREMENT,
  `anio` int(11) NOT NULL,
  `volumen` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `id_convocatoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_numero`),
  UNIQUE KEY `anio` (`anio`,`volumen`,`numero`),
  KEY `id_convocatoria` (`id_convocatoria`),
  CONSTRAINT `Numeros_Revista_ibfk_1` FOREIGN KEY (`id_convocatoria`) REFERENCES `Convocatorias` (`id_convocatoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Numeros_Revista`
--

LOCK TABLES `Numeros_Revista` WRITE;
/*!40000 ALTER TABLE `Numeros_Revista` DISABLE KEYS */;
INSERT INTO `Numeros_Revista` VALUES (1,2025,1,1,'2023-09-01',1);
/*!40000 ALTER TABLE `Numeros_Revista` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER historialCambiosNumeroAIUD_INSERT
AFTER INSERT ON Numeros_Revista
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada, id_registro, operacion, usuario_db,
        datos_anteriores, datos_nuevos
    )
    VALUES (
        'Numeros_Revista',
        NEW.id_numero,
        'INSERT',
        CURRENT_USER(),
        NULL,
        JSON_OBJECT(
            'id_numero', NEW.id_numero,
            'anio', NEW.anio,
            'volumen', NEW.volumen,
            'numero', NEW.numero,
            'fecha_publicacion', NEW.fecha_publicacion,
            'id_convocatoria', NEW.id_convocatoria
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER historialCambiosNumeroAIUD_UPDATE
AFTER UPDATE ON Numeros_Revista
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada, id_registro, operacion, usuario_db,
        datos_anteriores, datos_nuevos
    )
    VALUES (
        'Numeros_Revista',
        NEW.id_numero,
        'UPDATE',
        CURRENT_USER(),
        JSON_OBJECT(
            'id_numero', OLD.id_numero,
            'anio', OLD.anio,
            'volumen', OLD.volumen,
            'numero', OLD.numero,
            'fecha_publicacion', OLD.fecha_publicacion,
            'id_convocatoria', OLD.id_convocatoria
        ),
        JSON_OBJECT(
            'id_numero', NEW.id_numero,
            'anio', NEW.anio,
            'volumen', NEW.volumen,
            'numero', NEW.numero,
            'fecha_publicacion', NEW.fecha_publicacion,
            'id_convocatoria', NEW.id_convocatoria
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ra_usuario`@`localhost`*/ /*!50003 TRIGGER historialCambiosNumeroAIUD_DELETE
AFTER DELETE ON Numeros_Revista
FOR EACH ROW
BEGIN
    INSERT INTO Log_Cambios (
        tabla_modificada, id_registro, operacion, usuario_db,
        datos_anteriores, datos_nuevos
    )
    VALUES (
        'Numeros_Revista',
        OLD.id_numero,
        'DELETE',
        CURRENT_USER(),
        JSON_OBJECT(
            'id_numero', OLD.id_numero,
            'anio', OLD.anio,
            'volumen', OLD.volumen,
            'numero', OLD.numero,
            'fecha_publicacion', OLD.fecha_publicacion,
            'id_convocatoria', OLD.id_convocatoria
        ),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Perfiles_Autores`
--

DROP TABLE IF EXISTS `Perfiles_Autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Perfiles_Autores` (
  `id_autor` int(11) NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) NOT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `biografia` text DEFAULT NULL,
  PRIMARY KEY (`id_autor`),
  UNIQUE KEY `id_persona` (`id_persona`),
  CONSTRAINT `Perfiles_Autores_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personas` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Perfiles_Autores`
--

LOCK TABLES `Perfiles_Autores` WRITE;
/*!40000 ALTER TABLE `Perfiles_Autores` DISABLE KEYS */;
INSERT INTO `Perfiles_Autores` VALUES (1,2,NULL,NULL),(2,3,NULL,NULL),(3,6,NULL,NULL),(4,7,NULL,NULL),(5,8,NULL,NULL),(6,9,NULL,NULL),(7,10,NULL,NULL);
/*!40000 ALTER TABLE `Perfiles_Autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Perfiles_Revisores`
--

DROP TABLE IF EXISTS `Perfiles_Revisores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Perfiles_Revisores` (
  `id_revisor` int(11) NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) NOT NULL,
  `especialidad` varchar(150) DEFAULT NULL,
  `max_carga_activa` int(11) DEFAULT 3,
  `disponible` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_revisor`),
  UNIQUE KEY `id_persona` (`id_persona`),
  CONSTRAINT `Perfiles_Revisores_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personas` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Perfiles_Revisores`
--

LOCK TABLES `Perfiles_Revisores` WRITE;
/*!40000 ALTER TABLE `Perfiles_Revisores` DISABLE KEYS */;
INSERT INTO `Perfiles_Revisores` VALUES (1,4,'Física Teórica',3,1),(2,5,'Astrofísica',3,1),(3,3,'Fisicoquímica',3,1);
/*!40000 ALTER TABLE `Perfiles_Revisores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personas`
--

DROP TABLE IF EXISTS `Personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personas` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `segundo_nombre` varchar(150) DEFAULT NULL,
  `apellido_paterno` varchar(150) NOT NULL,
  `apellido_materno` varchar(150) NOT NULL,
  `correo_contacto` varchar(150) NOT NULL,
  `afiliacion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `correo_contacto` (`correo_contacto`),
  CONSTRAINT `Personas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personas`
--

LOCK TABLES `Personas` WRITE;
/*!40000 ALTER TABLE `Personas` DISABLE KEYS */;
INSERT INTO `Personas` VALUES (1,1,'Perry',NULL,'White','','jefe@revista.com','Diario El Planeta'),(2,2,'Albert',NULL,'Einstein','','albert.e@relatividad.com','Universidad de Princeton'),(3,3,'Marie',NULL,'Curie','Skodowska','marie.c@radioactividad.com','Universidad de París'),(4,4,'Isaac',NULL,'Newton','','isaac.n@gravedad.com','Universidad de Cambridge'),(5,5,'Carl',NULL,'Sagan','','carl.s@cosmos.com','Universidad de Cornell'),(6,6,'Rosalind',NULL,'Franklin','','rosalind.f@adn.com','Kings College de Londres'),(7,8,'Jonathan',NULL,'Correa','Ascencio','aaaa@gmail.com','UDEM'),(8,9,'Usuario',NULL,'User','User','aaaaa@gmail.com','Universidad De Monterrey'),(9,10,'user23',NULL,'123','2321','usuario3@gmail.com','Universidad De Princeston'),(10,11,'sadasd',NULL,'sad','asdads','a@gmail.com','Universidad De Princeston');
/*!40000 ALTER TABLE `Personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Puntajes_Dictamen`
--

DROP TABLE IF EXISTS `Puntajes_Dictamen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Puntajes_Dictamen` (
  `id_puntaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_dictamen` int(11) NOT NULL,
  `criterio` varchar(100) NOT NULL,
  `puntaje` decimal(3,2) NOT NULL,
  `comentario` text DEFAULT NULL,
  PRIMARY KEY (`id_puntaje`),
  UNIQUE KEY `id_dictamen` (`id_dictamen`,`criterio`),
  CONSTRAINT `Puntajes_Dictamen_ibfk_1` FOREIGN KEY (`id_dictamen`) REFERENCES `Dictamenes` (`id_dictamen`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Puntajes_Dictamen`
--

LOCK TABLES `Puntajes_Dictamen` WRITE;
/*!40000 ALTER TABLE `Puntajes_Dictamen` DISABLE KEYS */;
INSERT INTO `Puntajes_Dictamen` VALUES (1,1,'Originalidad',5.00,NULL),(2,1,'Rigor Metodológico',5.00,NULL),(3,4,'puntaje_global',0.00,NULL),(4,8,'puntaje_global',0.00,NULL),(5,11,'puntaje_global',0.00,NULL);
/*!40000 ALTER TABLE `Puntajes_Dictamen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'EDITOR_JEFE','Editor Jefe','Responsable máximo de la revista'),(2,'AUTOR','Autor','Quien envía artículos para publicación'),(3,'REVISOR','Revisor','Experto que evalúa los artículos');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipos_Conflicto_Catalogo`
--

DROP TABLE IF EXISTS `Tipos_Conflicto_Catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tipos_Conflicto_Catalogo` (
  `id_tipo_conflicto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_conflicto`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipos_Conflicto_Catalogo`
--

LOCK TABLES `Tipos_Conflicto_Catalogo` WRITE;
/*!40000 ALTER TABLE `Tipos_Conflicto_Catalogo` DISABLE KEYS */;
INSERT INTO `Tipos_Conflicto_Catalogo` VALUES (1,'personal','Relación personal o de amistad/enemistad'),(2,'laboral','Trabajan o trabajaron en la misma institución recientemente'),(3,'economico','Intereses económicos compartidos o en competencia');
/*!40000 ALTER TABLE `Tipos_Conflicto_Catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuarios`
--

DROP TABLE IF EXISTS `Usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(80) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `Usuarios_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `Estados_Catalogo` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuarios`
--

LOCK TABLES `Usuarios` WRITE;
/*!40000 ALTER TABLE `Usuarios` DISABLE KEYS */;
INSERT INTO `Usuarios` VALUES (1,'editorjefe','jefe@revista.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(2,'a.einstein','albert.e@relatividad.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(3,'m.curie','marie.c@radioactividad.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(4,'i.newton','isaac.n@gravedad.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(5,'c.sagan','carl.s@cosmos.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(6,'r.franklin','rosalind.f@adn.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-23 20:00:06','2025-11-23 20:00:06'),(7,'socio','socios@gmail.com','password123',11,1,'2025-11-23 20:43:46','2025-11-23 20:43:46'),(8,'usuario','aaaa@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-25 02:03:04','2025-11-25 02:03:04'),(9,'usuario2','aaaaa@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-25 04:12:17','2025-11-25 04:12:17'),(10,'usuario3','usuario3@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-25 04:17:42','2025-11-25 04:17:42'),(11,'asdas','a@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',11,1,'2025-11-25 05:42:02','2025-11-25 05:42:02');
/*!40000 ALTER TABLE `Usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuarios_Roles`
--

DROP TABLE IF EXISTS `Usuarios_Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuarios_Roles` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `Usuarios_Roles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id_usuario`),
  CONSTRAINT `Usuarios_Roles_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `Roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuarios_Roles`
--

LOCK TABLES `Usuarios_Roles` WRITE;
/*!40000 ALTER TABLE `Usuarios_Roles` DISABLE KEYS */;
INSERT INTO `Usuarios_Roles` VALUES (1,1,'2025-11-23 20:01:15',1),(2,2,'2025-11-23 20:01:15',1),(3,2,'2025-11-23 20:01:15',1),(3,3,'2025-11-23 20:01:15',1),(4,3,'2025-11-23 20:01:15',1),(5,3,'2025-11-23 20:01:15',1),(6,2,'2025-11-23 20:01:15',1),(8,2,'2025-11-25 02:03:04',1),(9,2,'2025-11-25 04:12:17',1),(10,2,'2025-11-25 04:17:42',1),(11,2,'2025-11-25 05:42:02',1);
/*!40000 ALTER TABLE `Usuarios_Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Versiones_Articulo`
--

DROP TABLE IF EXISTS `Versiones_Articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Versiones_Articulo` (
  `id_version` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) NOT NULL,
  `numero_version` int(11) NOT NULL,
  `ruta_archivo` varchar(255) NOT NULL,
  `fecha_subida` datetime NOT NULL,
  `comentario_autor` text DEFAULT NULL,
  `es_version_actual` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_version`),
  UNIQUE KEY `id_articulo` (`id_articulo`,`numero_version`),
  CONSTRAINT `Versiones_Articulo_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `Articulos` (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Versiones_Articulo`
--

LOCK TABLES `Versiones_Articulo` WRITE;
/*!40000 ALTER TABLE `Versiones_Articulo` DISABLE KEYS */;
INSERT INTO `Versiones_Articulo` VALUES (1,1,1,'/docs/einstein_v1.pdf','2023-02-15 10:00:00',NULL,1),(2,2,1,'/docs/franklin_v1.pdf','2023-03-01 11:00:00',NULL,1),(3,3,1,'/docs/curie_v1.pdf','2023-08-10 09:00:00',NULL,0),(4,3,2,'/docs/curie_v2_corregido.pdf','2023-09-25 17:00:00',NULL,1),(5,4,1,'/docs/sagan_nuevo.pdf','2025-11-23 20:03:05',NULL,1),(6,9,1,'static/uploads/Proyecto_Final.pdf','2025-11-25 04:10:44','asdasd',0),(7,10,1,'static/uploads/Laboratorio_6_1.pdf','2025-11-25 04:13:36','Mi primer envio ',0),(8,10,2,'static/uploads/Proyecto_Final.pdf','2025-11-25 04:14:21','Otro pdf',1),(9,11,1,'static/uploads/Laboratorio_6_1.pdf','2025-11-25 04:18:55','COmentarioS',0),(10,11,2,'static/uploads/Proyecto_Final.pdf','2025-11-25 04:19:39','Comentario',1),(11,12,1,'static/uploads/Laboratorio_6_1.pdf','2025-11-25 04:20:49','a',1),(12,13,1,'static/uploads/Proyecto_Final.pdf','2025-11-25 05:19:41','asd',1),(13,9,2,'static/uploads/Laboratorio_6_1.pdf','2025-11-25 05:23:57','',1),(14,14,1,'static/uploads/Laboratorio_6_1.pdf','2025-11-25 05:42:58','asd',1);
/*!40000 ALTER TABLE `Versiones_Articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vAceptacionPorConvocatoria`
--

DROP TABLE IF EXISTS `vAceptacionPorConvocatoria`;
/*!50001 DROP VIEW IF EXISTS `vAceptacionPorConvocatoria`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vAceptacionPorConvocatoria` AS SELECT
 1 AS `id_convocatoria`,
  1 AS `convocatoria`,
  1 AS `total_articulos`,
  1 AS `aceptados`,
  1 AS `tasa_aceptacion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vArticulosParaPublicar`
--

DROP TABLE IF EXISTS `vArticulosParaPublicar`;
/*!50001 DROP VIEW IF EXISTS `vArticulosParaPublicar`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vArticulosParaPublicar` AS SELECT
 1 AS `id_articulo`,
  1 AS `titulo`,
  1 AS `convocatoria`,
  1 AS `fecha_envio` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vArticulosPorEstado`
--

DROP TABLE IF EXISTS `vArticulosPorEstado`;
/*!50001 DROP VIEW IF EXISTS `vArticulosPorEstado`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vArticulosPorEstado` AS SELECT
 1 AS `id_articulo`,
  1 AS `titulo`,
  1 AS `estado` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vCargaRevisores`
--

DROP TABLE IF EXISTS `vCargaRevisores`;
/*!50001 DROP VIEW IF EXISTS `vCargaRevisores`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vCargaRevisores` AS SELECT
 1 AS `id_revisor`,
  1 AS `revisor`,
  1 AS `max_carga_activa`,
  1 AS `disponible`,
  1 AS `asignaciones_activas`,
  1 AS `dictamenes_completados` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vEnviosPorArea`
--

DROP TABLE IF EXISTS `vEnviosPorArea`;
/*!50001 DROP VIEW IF EXISTS `vEnviosPorArea`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vEnviosPorArea` AS SELECT
 1 AS `id_area`,
  1 AS `area`,
  1 AS `total_articulos` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vHistorialPublicacionesAutor`
--

DROP TABLE IF EXISTS `vHistorialPublicacionesAutor`;
/*!50001 DROP VIEW IF EXISTS `vHistorialPublicacionesAutor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vHistorialPublicacionesAutor` AS SELECT
 1 AS `id_autor`,
  1 AS `autor`,
  1 AS `id_articulo`,
  1 AS `articulo`,
  1 AS `id_numero`,
  1 AS `numero_revista`,
  1 AS `fecha_publicacion`,
  1 AS `estado_final` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vProductividadRevisor`
--

DROP TABLE IF EXISTS `vProductividadRevisor`;
/*!50001 DROP VIEW IF EXISTS `vProductividadRevisor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vProductividadRevisor` AS SELECT
 1 AS `id_revisor`,
  1 AS `revisor`,
  1 AS `total_dictamenes`,
  1 AS `dias_promedio` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vTiempoRevisionPromedio`
--

DROP TABLE IF EXISTS `vTiempoRevisionPromedio`;
/*!50001 DROP VIEW IF EXISTS `vTiempoRevisionPromedio`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vTiempoRevisionPromedio` AS SELECT
 1 AS `id_revisor`,
  1 AS `revisor`,
  1 AS `dias_promedio`,
  1 AS `total_revisiones` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vTiemposPorEtapa`
--

DROP TABLE IF EXISTS `vTiemposPorEtapa`;
/*!50001 DROP VIEW IF EXISTS `vTiemposPorEtapa`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vTiemposPorEtapa` AS SELECT
 1 AS `etapa_inicial`,
  1 AS `etapa_final`,
  1 AS `transicion`,
  1 AS `dias_promedio`,
  1 AS `total_mediciones` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'revista_academica'
--

--
-- Dumping routines for database 'revista_academica'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `areasPorConvocatoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `areasPorConvocatoria`(IN p_id_convocatoria INT)
BEGIN
    SELECT 
        at.id_area,
        at.nombre
    FROM Convocatorias_Areas ca
    JOIN Areas_Tematicas at 
        ON at.id_area = ca.id_area
    WHERE ca.id_convocatoria = p_id_convocatoria
      AND at.activa = TRUE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articuloEnviar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `articuloEnviar`(
    IN p_titulo VARCHAR(255),
    IN p_resumen TEXT,
    IN p_palabras_clave VARCHAR(255),
    IN p_id_convocatoria INT,
    IN p_id_area INT,
    IN p_ruta_archivo VARCHAR(255),
    IN p_comentario_autor TEXT,
    IN p_id_autor_principal INT,
    IN p_id_usuario_responsable INT,
    IN p_codigo_estado_articulo VARCHAR(50),
    
    OUT p_id_articulo_nuevo INT
)
BEGIN DECLARE v_id_estado_articulo INT;

DECLARE v_id_estado_conv_act INT;

DECLARE v_count INT;


DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;

RESIGNAL;

END;

START TRANSACTION;



SELECT
    id_estado INTO v_id_estado_conv_act
FROM
    Estados_Catalogo
WHERE
    entidad = 'convocatoria'
    AND codigo = 'activa'
LIMIT
    1;

IF v_id_estado_conv_act IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Estado ACTIVA para CONVOCATORIA no definido en Estados_Catalogo';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Convocatorias c
WHERE
    c.id_convocatoria = p_id_convocatoria
    AND c.fecha_inicio <= CURDATE()
    AND c.fecha_fin >= CURDATE()
    AND c.id_estado = v_id_estado_conv_act;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Convocatoria inválida, fuera de vigencia o no activa';

END IF;



SELECT
    COUNT(*) INTO v_count
FROM
    Areas_Tematicas a
WHERE
    a.id_area = p_id_area
    AND a.activa = TRUE;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Área temática inválida o inactiva';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Convocatorias_Areas ca
WHERE
    ca.id_convocatoria = p_id_convocatoria
    AND ca.id_area = p_id_area;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El área temática no está permitida para esta convocatoria';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Perfiles_Autores pa
WHERE
    pa.id_autor = p_id_autor_principal;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Autor principal no existe en Perfiles_Autores';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Articulos a
WHERE
    a.titulo = p_titulo
    AND a.id_convocatoria = p_id_convocatoria;

IF v_count > 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Ya existe un artículo con el mismo título en esta convocatoria';

END IF;


SELECT
    id_estado INTO v_id_estado_articulo
FROM
    Estados_Catalogo
WHERE
    entidad = 'articulo'
    AND codigo = p_codigo_estado_articulo
LIMIT
    1;

IF v_id_estado_articulo IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Estado inicial de articulo no encontrado en Estados_Catalogo';

END IF;


INSERT INTO
    Articulos (
        titulo,
        resumen,
        palabras_clave,
        fecha_envio,
        id_convocatoria,
        id_area,
        id_numero,
        id_estado
    )
VALUES
    (
        p_titulo,
        p_resumen,
        p_palabras_clave,
        NOW(),
        p_id_convocatoria,
        p_id_area,
        NULL,
        
        v_id_estado_articulo
    );

SET
    p_id_articulo_nuevo = LAST_INSERT_ID();


INSERT INTO
    Versiones_Articulo (
        id_articulo,
        numero_version,
        ruta_archivo,
        fecha_subida,
        comentario_autor,
        es_version_actual
    )
VALUES
    (
        p_id_articulo_nuevo,
        1,
        p_ruta_archivo,
        NOW(),
        p_comentario_autor,
        TRUE
    );


INSERT INTO
    Articulos_Autores (
        id_articulo,
        id_autor,
        orden_autoria,
        es_autor_correspondencia
    )
VALUES
    (
        p_id_articulo_nuevo,
        p_id_autor_principal,
        1,
        TRUE
    );


INSERT INTO
    Historial_Estados (
        entidad,
        id_entidad,
        id_estado_anterior,
        id_estado_nuevo,
        fecha_cambio,
        id_usuario_responsable,
        comentario
    )
VALUES
    (
        'articulo',
        p_id_articulo_nuevo,
        NULL,
        v_id_estado_articulo,
        NOW(),
        p_id_usuario_responsable,
        'Registro de envío de artículo (alta inicial)'
    );


INSERT INTO
    Metricas_Tiempos (
        id_articulo,
        etapa,
        fecha_inicio
    )
VALUES
    (
        p_id_articulo_nuevo,
        'envio',
        NOW()
    );

COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulosPendientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `articulosPendientes`()
BEGIN
    SELECT 
        a.id_articulo,
        a.titulo,
        area.nombre AS area,
        a.fecha_envio,
        ec.descripcion AS descripcion_estado
    FROM Articulos a
    JOIN Estados_Catalogo ec ON a.id_estado = ec.id_estado
    JOIN Areas_Tematicas area ON a.id_area = area.id_area
    WHERE 
        ec.entidad = 'articulo' AND ec.codigo = 'enviado'
    ORDER BY
        a.fecha_envio ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulosPendientesGestion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `articulosPendientesGestion`()
BEGIN
SELECT
    a.id_articulo,
    a.titulo,
    at.nombre AS area,              
    a.fecha_envio,
    e.id_estado,
    e.codigo      AS codigo_estado,
    e.descripcion AS descripcion_estado
        FROM Articulos a
        JOIN Areas_Tematicas   at ON at.id_area = a.id_area
        JOIN Estados_Catalogo  e  ON e.id_estado = a.id_estado
        WHERE e.entidad = 'articulo'
            AND e.codigo IN ('enviado', 'en_revision')   
            ORDER BY a.fecha_envio DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articulosPorAutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `articulosPorAutor`(IN p_id_autor INT)
BEGIN
    SELECT
        a.id_articulo,
        a.titulo,
        ec.codigo AS codigo_estado,
        ec.descripcion AS descripcion_estado,
        
        a.fecha_envio AS fecha_ultima_modificacion,
        c.titulo AS convocatoria
    FROM
        Articulos a
        JOIN Articulos_Autores aa ON a.id_articulo = aa.id_articulo
        JOIN Estados_Catalogo ec ON a.id_estado = ec.id_estado
        JOIN Convocatorias c ON a.id_convocatoria = c.id_convocatoria
    WHERE
        aa.id_autor = p_id_autor
    ORDER BY
        a.fecha_envio DESC; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `articuloVersionar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `articuloVersionar`(
    IN p_id_articulo INT,
    IN p_ruta_archivo VARCHAR(255),
    IN p_comentario_autor TEXT,
    IN p_id_usuario_responsable INT,
    
    IN p_codigo_estado_nuevo VARCHAR(50),
    OUT p_nueva_version INT
)
BEGIN DECLARE v_count INT;

DECLARE v_ultima_version INT;

DECLARE v_id_estado_actual INT;

DECLARE v_id_estado_nuevo INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;

RESIGNAL;

END;

START TRANSACTION;


SELECT
    COUNT(*) INTO v_count
FROM
    Articulos a
WHERE
    a.id_articulo = p_id_articulo;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El artículo especificado no existe';

END IF;


SELECT
    id_estado INTO v_id_estado_actual
FROM
    Articulos
WHERE
    id_articulo = p_id_articulo FOR
UPDATE
;


IF p_codigo_estado_nuevo IS NULL
OR p_codigo_estado_nuevo = '' THEN 
SET
    v_id_estado_nuevo = v_id_estado_actual;

ELSE
SELECT
    ec.id_estado INTO v_id_estado_nuevo
FROM
    Estados_Catalogo ec
WHERE
    ec.entidad = 'ARTICULO'
    AND ec.codigo = p_codigo_estado_nuevo
LIMIT
    1;

IF v_id_estado_nuevo IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Código de estado nuevo de ARTICULO no encontrado en Estados_Catalogo';

END IF;

END IF;


SELECT
    COALESCE(MAX(numero_version), 0) INTO v_ultima_version
FROM
    Versiones_Articulo va
WHERE
    va.id_articulo = p_id_articulo FOR
UPDATE
;

SET
    p_nueva_version = v_ultima_version + 1;


UPDATE
    Versiones_Articulo
SET
    es_version_actual = FALSE
WHERE
    id_articulo = p_id_articulo
    AND es_version_actual = TRUE;


INSERT INTO
    Versiones_Articulo (
        id_articulo,
        numero_version,
        ruta_archivo,
        fecha_subida,
        comentario_autor,
        es_version_actual
    )
VALUES
    (
        p_id_articulo,
        p_nueva_version,
        p_ruta_archivo,
        NOW(),
        p_comentario_autor,
        TRUE
    );


IF v_id_estado_nuevo <> v_id_estado_actual THEN
UPDATE
    Articulos
SET
    id_estado = v_id_estado_nuevo
WHERE
    id_articulo = p_id_articulo;


INSERT INTO
    Historial_Estados (
        entidad,
        id_entidad,
        id_estado_anterior,
        id_estado_nuevo,
        fecha_cambio,
        id_usuario_responsable,
        comentario
    )
VALUES
    (
        'ARTICULO',
        p_id_articulo,
        v_id_estado_actual,
        v_id_estado_nuevo,
        NOW(),
        p_id_usuario_responsable,
        CONCAT('Nueva versión del artículo: v', p_nueva_version)
    );

END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `asignacionesArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `asignacionesArticulo`(IN p_id_articulo INT)
BEGIN
    SELECT
        ar.id_asignacion,
        ar.id_revisor,
        CONCAT(pe.nombre, ' ', pe.apellido_paterno, ' ', pe.apellido_materno)
            AS nombre_revisor,
        est.descripcion AS estado_asignacion,
        ar.fecha_asignacion
    FROM Asignaciones_Revision ar
    JOIN Perfiles_Revisores pr
        ON pr.id_revisor = ar.id_revisor
    JOIN Personas pe
        ON pe.id_persona = pr.id_persona
    JOIN Estados_Catalogo est
        ON est.id_estado = ar.id_estado
       AND est.entidad   = 'asignacion'
    WHERE ar.id_articulo = p_id_articulo
    ORDER BY ar.fecha_asignacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `asignacionesPorRevisor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `asignacionesPorRevisor`(IN p_id_revisor INT)
BEGIN
    SELECT 
        ar.id_asignacion,
        ar.id_articulo,
        ar.fecha_asignacion,
        ar.fecha_limite,
        e.codigo AS codigo_estado_asignacion,
        e.descripcion AS estado_asignacion,
        
        a.titulo AS titulo_articulo,
        at.nombre AS area_tematica
    FROM Asignaciones_Revision ar  
    JOIN Articulos a ON ar.id_articulo = a.id_articulo 
    JOIN Areas_Tematicas at ON a.id_area = at.id_area
    JOIN Estados_Catalogo e        
        ON e.id_estado = ar.id_estado
       AND e.entidad  = 'asignacion'
    WHERE ar.id_revisor = p_id_revisor
      
      AND e.codigo IN ('asignado', 'aceptada', 'en_revision')
    ORDER BY 
        ar.fecha_limite IS NULL,
        ar.fecha_limite ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `asignarRevisores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `asignarRevisores`(
    IN p_id_articulo INT,
    IN p_num_revisores INT,
    IN p_codigo_estado_asignacion VARCHAR(50),
    
    IN p_id_usuario_responsable INT,
    IN p_dias_plazo INT 
)
BEGIN 
DECLARE v_id_estado_asignacion INT;

DECLARE v_id_version_actual INT;

DECLARE v_count INT;

DECLARE v_total_disponibles INT;

DECLARE v_asignados INT DEFAULT 0;

DECLARE v_id_revisor INT;

DECLARE v_carga_actual INT;

DECLARE v_id_asignacion_nueva INT;

DECLARE v_done INT DEFAULT 0;


DECLARE cur_revisores CURSOR FOR
SELECT
    pr.id_revisor,
    COALESCE(COUNT(ar.id_asignacion), 0) AS carga_actual
FROM
    Perfiles_Revisores pr
    LEFT JOIN Asignaciones_Revision ar ON ar.id_revisor = pr.id_revisor
    AND ar.id_estado = v_id_estado_asignacion
WHERE
    pr.disponible = TRUE 
    AND NOT EXISTS (
        SELECT
            1
        FROM
            Articulos_Autores aa
            JOIN Conflictos_Interes ci ON ci.id_autor = aa.id_autor
        WHERE
            aa.id_articulo = p_id_articulo
            AND ci.id_revisor = pr.id_revisor
            AND ci.vigente = TRUE
    ) 
    AND NOT EXISTS (
        SELECT
            1
        FROM
            Asignaciones_Revision ar2
        WHERE
            ar2.id_articulo = p_id_articulo
            AND ar2.id_revisor = pr.id_revisor
    )
GROUP BY
    pr.id_revisor,
    pr.max_carga_activa
HAVING
    COALESCE(COUNT(ar.id_asignacion), 0) < COALESCE(pr.max_carga_activa, 99999)
ORDER BY
    carga_actual ASC,
    pr.id_revisor ASC;


DECLARE CONTINUE HANDLER FOR NOT FOUND
SET
    v_done = 1;


DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;

RESIGNAL;

END;


START TRANSACTION;


IF p_num_revisores IS NULL
OR p_num_revisores <= 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'p_num_revisores debe ser mayor que 0';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Articulos
WHERE
    id_articulo = p_id_articulo;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El artículo especificado no existe';

END IF;


SELECT
    id_version INTO v_id_version_actual
FROM
    Versiones_Articulo
WHERE
    id_articulo = p_id_articulo
    AND es_version_actual = TRUE
LIMIT
    1;

IF v_id_version_actual IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El artículo no tiene una versión actual registrada';

END IF;


SELECT
    id_estado INTO v_id_estado_asignacion
FROM
    Estados_Catalogo
WHERE
    entidad = 'asignacion'
    AND codigo = p_codigo_estado_asignacion
LIMIT
    1;

IF v_id_estado_asignacion IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Estado de asignación no encontrado en Estados_Catalogo';

END IF;


SELECT
    COUNT(*) INTO v_total_disponibles
FROM
    (
        SELECT
            pr.id_revisor
        FROM
            Perfiles_Revisores pr
            LEFT JOIN Asignaciones_Revision ar ON ar.id_revisor = pr.id_revisor
            AND ar.id_estado = v_id_estado_asignacion
        WHERE
            pr.disponible = TRUE
            AND NOT EXISTS (
                SELECT
                    1
                FROM
                    Articulos_Autores aa
                    JOIN Conflictos_Interes ci ON ci.id_autor = aa.id_autor
                WHERE
                    aa.id_articulo = p_id_articulo
                    AND ci.id_revisor = pr.id_revisor
                    AND ci.vigente = TRUE
            )
            AND NOT EXISTS (
                SELECT
                    1
                FROM
                    Asignaciones_Revision ar2
                WHERE
                    ar2.id_articulo = p_id_articulo
                    AND ar2.id_revisor = pr.id_revisor
            )
        GROUP BY
            pr.id_revisor,
            pr.max_carga_activa
        HAVING
            COALESCE(COUNT(ar.id_asignacion), 0) < COALESCE(pr.max_carga_activa, 99999)
    ) AS candidatos;

IF v_total_disponibles < p_num_revisores THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'No hay suficientes revisores disponibles para cumplir la cantidad solicitada';

END IF;


SET
    v_asignados = 0;

SET
    v_done = 0;

OPEN cur_revisores;

read_loop: LOOP FETCH cur_revisores INTO v_id_revisor,
v_carga_actual;

IF v_done = 1 THEN LEAVE read_loop;

END IF;

IF v_asignados >= p_num_revisores THEN LEAVE read_loop;

END IF;


INSERT INTO
    Asignaciones_Revision (
        id_articulo,
        id_revisor,
        id_version_asignada,
        fecha_asignacion,
        fecha_limite,
        id_estado
    )
VALUES
    (
        p_id_articulo,
        v_id_revisor,
        v_id_version_actual,
        NOW(),
        CASE
            WHEN p_dias_plazo IS NULL THEN NULL
            ELSE DATE_ADD(NOW(), INTERVAL p_dias_plazo DAY)
        END,
        v_id_estado_asignacion
    );

SET
    v_id_asignacion_nueva = LAST_INSERT_ID();

SET
    v_asignados = v_asignados + 1;


INSERT INTO
    Historial_Estados (
        entidad,
        id_entidad,
        id_estado_anterior,
        id_estado_nuevo,
        fecha_cambio,
        id_usuario_responsable,
        comentario
    )
VALUES
    (
        'asignacion',
        v_id_asignacion_nueva,
        NULL,
        v_id_estado_asignacion,
        NOW(),
        p_id_usuario_responsable,
        CONCAT(
            'Asignación automática de revisor al artículo ',
            p_id_articulo
        )
    );

END LOOP;

CLOSE cur_revisores;


COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `auditoriaEditorial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `auditoriaEditorial`(
    IN p_desde DATETIME,
    IN p_hasta DATETIME
)
BEGIN
    DECLARE v_desde DATETIME;
    DECLARE v_hasta DATETIME;
    SET v_desde = IFNULL(p_desde, '1900-01-01 00:00:00');
    SET v_hasta = IFNULL(p_hasta, NOW());

    SELECT h.id_historial, h.entidad, h.id_entidad, e_ant.codigo AS estado_anterior_codigo, e_ant.descripcion AS estado_anterior_desc,
        e_nue.codigo AS estado_nuevo_codigo, e_nue.descripcion AS estado_nuevo_desc, h.fecha_cambio,
        
        CASE
            WHEN h.entidad = 'articulo' THEN 
                CAST(a.titulo AS CHAR CHARACTER SET utf8mb4)
                
            WHEN h.entidad = 'convocatoria' THEN 
                CAST(c.titulo AS CHAR CHARACTER SET utf8mb4)
                
            WHEN h.entidad = 'asignacion' THEN 
                CAST(CONCAT(
                    'Asignación #', ar.id_asignacion,
                    ' | Art. ', ar.id_articulo,
                    ' | Revisor ', ar.id_revisor
                ) AS CHAR CHARACTER SET utf8mb4)
                
            WHEN h.entidad = 'numero' THEN 
                CAST(CONCAT(
                    'Número revista ', nr.anio,
                    '-', nr.volumen,
                    '-', nr.numero
                ) AS CHAR CHARACTER SET utf8mb4)
                
            ELSE NULL
        END AS detalle_entidad
        
    FROM
        Historial_Estados h
        LEFT JOIN Estados_Catalogo e_ant ON h.id_estado_anterior = e_ant.id_estado
        LEFT JOIN Estados_Catalogo e_nue ON h.id_estado_nuevo = e_nue.id_estado
        LEFT JOIN Articulos a ON h.entidad = 'articulo' AND h.id_entidad = a.id_articulo
        LEFT JOIN Convocatorias c ON h.entidad = 'convocatoria' AND h.id_entidad = c.id_convocatoria
        LEFT JOIN Asignaciones_Revision ar ON h.entidad = 'asignacion' AND h.id_entidad = ar.id_asignacion
        LEFT JOIN Numeros_Revista nr ON h.entidad = 'numero' AND h.id_entidad = nr.id_numero
    WHERE
        h.fecha_cambio BETWEEN v_desde AND v_hasta
    ORDER BY
        h.fecha_cambio DESC, 
        h.id_historial DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `categoriasActivas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `categoriasActivas`()
BEGIN
    SELECT id_area, nombre FROM Areas_Tematicas
    WHERE activa = TRUE
    ORDER BY nombre ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `convocatoriasActivas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `convocatoriasActivas`()
BEGIN
    
    DECLARE v_id_estado_activa INT;
    SELECT id_estado 
    INTO v_id_estado_activa
    FROM Estados_Catalogo 
    WHERE entidad = 'convocatoria' AND codigo = 'activa'
    LIMIT 1;
    IF v_id_estado_activa IS NOT NULL THEN
        SELECT 
            id_convocatoria, 
            titulo
        FROM Convocatorias
        WHERE 
            id_estado = v_id_estado_activa
            AND CURDATE() BETWEEN fecha_inicio AND fecha_fin 
        ORDER BY 
            fecha_fin ASC;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crearNumeroRevista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `crearNumeroRevista`(
    IN p_anio INT,
    IN p_volumen INT,
    IN p_numero INT,
    IN p_id_convocatoria INT,
    IN p_fecha_publicacion DATE
)
BEGIN
    INSERT INTO Numeros_Revista (anio, volumen, numero, id_convocatoria, fecha_publicacion)
    VALUES (p_anio, p_volumen, p_numero, p_id_convocatoria, p_fecha_publicacion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `datosArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `datosArticulo`(IN num_articulo INT)
BEGIN
SELECT
    a.id_articulo,
    a.titulo,
    a.resumen,
    a.palabras_clave,
    ca.nombre AS area_tematica,
    va.id_version,
    va.ruta_archivo,
    va.numero_version
FROM
    Articulos AS a
    JOIN Areas_Tematicas AS ca ON a.id_area = ca.id_area
    JOIN Versiones_Articulo AS va ON a.id_articulo = va.id_articulo
    AND va.es_version_actual = TRUE
WHERE
    a.id_articulo = num_articulo;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dictaminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `dictaminar`(
    IN p_id_asignacion        INT,
    IN p_codigo_decision      VARCHAR(50),  
    IN p_comentarios_autor    TEXT,
    IN p_comentarios_editor   TEXT,
    IN p_puntaje_global       DECIMAL(3,2),
    IN p_id_usuario_responsable INT
)
BEGIN
    
    DECLARE v_id_articulo                   INT;
    DECLARE v_count                         INT;
    DECLARE v_id_decision                   INT;
    DECLARE v_id_estado_resultante          INT;
    DECLARE v_id_estado_articulo_anterior   INT;
    DECLARE v_id_estado_articulo_nuevo      INT;
    DECLARE v_id_estado_asignacion_anterior INT;
    DECLARE v_id_estado_asignacion_completa INT;
    DECLARE v_id_dictamen                   INT;
    DECLARE v_comentario_historial          TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    
    SELECT 
        ar.id_articulo,
        ar.id_estado
    INTO 
        v_id_articulo,
        v_id_estado_asignacion_anterior
    FROM Asignaciones_Revision ar
    JOIN Estados_Catalogo ec ON ec.id_estado = ar.id_estado AND ec.entidad = 'asignacion'
    WHERE ar.id_asignacion = p_id_asignacion AND ec.codigo IN ('asignado','aceptada')
    LIMIT 1;

    IF v_id_articulo IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La asignación no existe o ya no está activa.';
    END IF;

    
    

    
    SELECT id_decision, id_estado_resultante
    INTO v_id_decision, v_id_estado_resultante
    FROM Decisiones_Dictamen_Catalogo
    WHERE codigo = p_codigo_decision LIMIT 1;

    IF v_id_decision IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código de decisión no válido.'; END IF;
    IF v_id_estado_resultante IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La decisión no tiene estado resultante configurado.'; END IF;
    
    SET v_id_estado_articulo_nuevo = v_id_estado_resultante;
    
    
    SELECT id_estado INTO v_id_estado_asignacion_completa
    FROM Estados_Catalogo WHERE entidad = 'asignacion' AND codigo = 'completada' LIMIT 1;
    IF v_id_estado_asignacion_completa IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estado "completada" no encontrado.'; END IF;

    
    SELECT id_estado INTO v_id_estado_articulo_anterior FROM Articulos WHERE id_articulo = v_id_articulo;

    
    INSERT INTO Dictamenes (
        id_asignacion,
        id_decision,
        comentarios_para_autor, 
        comentarios_para_editor, 
        fecha_dictamen
    ) VALUES (
        p_id_asignacion,
        v_id_decision,
        p_comentarios_autor,
        p_comentarios_editor,
        NOW()
    );

    SET v_id_dictamen = LAST_INSERT_ID();

    
    
    
    INSERT INTO Puntajes_Dictamen (id_dictamen, criterio, puntaje) VALUES (v_id_dictamen, 'puntaje_global', p_puntaje_global);
    UPDATE Asignaciones_Revision SET id_estado = v_id_estado_asignacion_completa WHERE id_asignacion = p_id_asignacion;
    UPDATE Articulos SET id_estado = v_id_estado_articulo_nuevo WHERE id_articulo = v_id_articulo;

    
    SET v_comentario_historial = CASE p_codigo_decision
        WHEN 'aceptar' THEN 'Artículo aceptado según dictamen.'
        WHEN 'aceptar_con_cambios' THEN 'Artículo aceptado con cambios, según dictamen.'
        WHEN 'rechazar' THEN 'Artículo rechazado según dictamen.'
        ELSE CONCAT('Dictamen registrado con decisión: ', p_codigo_decision)
    END;

    
    INSERT INTO Historial_Estados (entidad, id_entidad, id_estado_anterior, id_estado_nuevo, fecha_cambio, id_usuario_responsable, comentario) VALUES
    ('asignacion', p_id_asignacion, v_id_estado_asignacion_anterior, v_id_estado_asignacion_completa, NOW(), p_id_usuario_responsable, 'Revisión completada'),
    ('articulo', v_id_articulo, v_id_estado_articulo_anterior, v_id_estado_articulo_nuevo, NOW(), p_id_usuario_responsable, v_comentario_historial);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `disponibilidadRevision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `disponibilidadRevision`(IN p_id_articulo INT)
BEGIN
    SELECT
        pr.id_revisor,
        CONCAT(p.nombre, ' ', p.apellido_paterno) as nombre_completo,
        COALESCE(COUNT(ar_carga.id_asignacion), 0) AS carga_actual
    FROM Perfiles_Revisores pr
    JOIN Personas p ON pr.id_persona = p.id_persona
    LEFT JOIN Asignaciones_Revision ar_carga ON pr.id_revisor = ar_carga.id_revisor AND ar_carga.id_estado IN (SELECT id_estado FROM Estados_Catalogo WHERE codigo IN ('asignado', 'aceptada'))
    WHERE
        pr.disponible = TRUE
        AND NOT EXISTS (
            SELECT 1 FROM Articulos_Autores aa
            JOIN Conflictos_Interes ci ON ci.id_autor = aa.id_autor
            WHERE aa.id_articulo = p_id_articulo AND ci.id_revisor = pr.id_revisor AND ci.vigente = TRUE
        )
        AND NOT EXISTS (
            SELECT 1 FROM Asignaciones_Revision ar2
            WHERE ar2.id_articulo = p_id_articulo AND ar2.id_revisor = pr.id_revisor
        )
    GROUP BY pr.id_revisor, p.nombre, p.apellido_paterno, pr.max_carga_activa
    HAVING carga_actual < pr.max_carga_activa
    ORDER BY carga_actual ASC, nombre_completo ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `enviadosPorArea` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `enviadosPorArea`(IN p_desde DATE, IN p_hasta DATE)
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmpEnviosArea;
    CREATE TEMPORARY TABLE tmpEnviosArea AS
    SELECT
        at.nombre AS area,
        COUNT(a.id_articulo) AS total_articulos
    FROM Areas_Tematicas at
    LEFT JOIN Articulos a ON at.id_area = a.id_area AND a.fecha_envio BETWEEN p_desde AND p_hasta
    GROUP BY at.id_area, at.nombre;

    SELECT * FROM tmpEnviosArea;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `indiceNumero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `indiceNumero`(IN p_id_numero INT)
BEGIN
SELECT n.id_numero,
        CONCAT('Vol.', n.volumen, ' Núm.', n.numero, ' (', n.anio, ')') AS numero_revista,
        COALESCE(a.titulo, 'Sin artículos asignados') AS articulo,
        COALESCE(e.descripcion, 'N/A') AS estado,
        COALESCE(GROUP_CONCAT(CONCAT_WS(' ', p.nombre, p.apellido_paterno) SEPARATOR ', '), 'Sin autor') as autores
    FROM Numeros_Revista n
    LEFT JOIN Articulos a ON n.id_numero = a.id_numero
    LEFT JOIN Estados_Catalogo e ON a.id_estado = e.id_estado
    LEFT JOIN Articulos_Autores aa ON a.id_articulo = aa.id_articulo
    LEFT JOIN Perfiles_Autores pa ON aa.id_autor = pa.id_autor
    LEFT JOIN Personas p ON pa.id_persona = p.id_persona
    WHERE n.id_numero = p_id_numero
    GROUP BY n.id_numero, numero_revista, a.id_articulo, a.titulo, e.descripcion
    ORDER BY a.titulo ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `loginUsuarioRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `loginUsuarioRol`(
    IN p_usuario_o_email VARCHAR(150),
    IN p_contrasena_plana VARCHAR(255)
)
BEGIN
    DECLARE v_id_usuario INT;
    DECLARE v_nombre_usuario VARCHAR(80);
    DECLARE v_hash_guardado VARCHAR(255);
    DECLARE v_id_estado INT;
    DECLARE v_id_estado_activo INT;
    DECLARE v_roles_usuario TEXT;
    
    
    SELECT id_estado INTO v_id_estado_activo 
    FROM Estados_Catalogo 
    WHERE entidad = 'usuario' AND codigo = 'activo' 
    LIMIT 1;

    
    SELECT
        id_usuario,
        nombre_usuario,
        contrasena,
        id_estado INTO v_id_usuario,
        v_nombre_usuario,
        v_hash_guardado,
        v_id_estado
    FROM
        Usuarios
    WHERE
        nombre_usuario = TRIM(p_usuario_o_email)
        OR email = TRIM(p_usuario_o_email)
    LIMIT 1;

    
    IF v_id_usuario IS NULL THEN
        SELECT 'ERROR' AS status, 'Usuario no encontrado.' AS mensaje, NULL, NULL, NULL;
        
    ELSEIF v_id_estado != v_id_estado_activo THEN
        SELECT 'ERROR' AS status, 'La cuenta de usuario no está activa o está suspendida.' AS mensaje, NULL, NULL, NULL;
        
    ELSEIF v_hash_guardado = SHA2(TRIM(p_contrasena_plana), 256) THEN
        
        SELECT GROUP_CONCAT(r.codigo SEPARATOR ',') INTO v_roles_usuario
        FROM Usuarios_Roles ur
        JOIN Roles r ON ur.id_rol = r.id_rol
        WHERE ur.id_usuario = v_id_usuario AND ur.activo = TRUE;

        SELECT
            'OK' AS status,
            'Login exitoso.' AS mensaje,
            v_id_usuario AS id_usuario,
            v_nombre_usuario AS nombre_usuario,
            COALESCE(v_roles_usuario, 'SIN_ROLES') AS roles;
    ELSE
        SELECT 'ERROR' AS status, 'Contraseña incorrecta.' AS mensaje, NULL, NULL, NULL;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerArticuloAutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerArticuloAutor`(IN p_id_articulo INT)
BEGIN
    SELECT 
        a.*, 
        aa.id_autor
    FROM Articulos a
    JOIN Articulos_Autores aa ON a.id_articulo = aa.id_articulo
    WHERE a.id_articulo = p_id_articulo
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerAsignacionPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerAsignacionPorID`(IN p_id_asignacion INT)
BEGIN
    SELECT 
        id_articulo, 
        id_revisor
    FROM Asignaciones_Revision
    WHERE id_asignacion = p_id_asignacion
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerAuditoriaArticulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerAuditoriaArticulos`()
BEGIN
    SELECT 
        id_log,
        id_registro,
        operacion,
        fecha_operacion,
        usuario_db,
        datos_anteriores,
        datos_nuevos
    FROM Log_Cambios
    WHERE tabla_modificada = 'Articulos'
    ORDER BY fecha_operacion DESC, id_log DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerAutorPorUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerAutorPorUsuario`(
    IN p_id_usuario INT
)
BEGIN
    SELECT pa.id_autor 
    FROM Perfiles_Autores pa
    JOIN Personas p ON pa.id_persona = p.id_persona
    WHERE p.id_usuario = p_id_usuario
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerNumerosRevista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerNumerosRevista`()
BEGIN
    SELECT * FROM Numeros_Revista 
    ORDER BY anio DESC, numero DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerRevisorPorUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `obtenerRevisorPorUsuario`(IN p_id_usuario INT)
BEGIN
    SELECT pr.id_revisor
    FROM Personas p
    JOIN Perfiles_Revisores pr ON pr.id_persona = p.id_persona
    WHERE p.id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `productividadRevisor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `productividadRevisor`(IN p_desde DATE, IN p_hasta DATE)
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmpProductividad;
    CREATE TEMPORARY TABLE tmpProductividad AS
    SELECT 
        pr.id_revisor,
        CONCAT_WS(' ', p.nombre, p.apellido_paterno) AS revisor,
        COUNT(d.id_dictamen) AS total_dictamenes,
        ROUND(AVG(TIMESTAMPDIFF(DAY, ar.fecha_asignacion, d.fecha_dictamen)), 2) AS dias_promedio
    FROM Perfiles_Revisores pr
    JOIN Personas p ON pr.id_persona = p.id_persona
    LEFT JOIN Asignaciones_Revision ar ON pr.id_revisor = ar.id_revisor AND ar.fecha_asignacion BETWEEN p_desde AND p_hasta
    LEFT JOIN Dictamenes d ON ar.id_asignacion = d.id_asignacion
    GROUP BY pr.id_revisor, revisor;

    SELECT * FROM tmpProductividad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `publicarArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `publicarArticulo`(
    IN p_id_articulo INT,
    IN p_id_numero INT,
    IN p_id_usuario INT
)
BEGIN
    DECLARE v_estado_actual INT;
    SELECT id_estado INTO v_estado_actual FROM Articulos WHERE id_articulo = p_id_articulo;
    IF v_estado_actual != 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solo se pueden publicar artículos en estado ACEPTADO.';
    END IF;
    UPDATE Articulos
    SET id_estado = 5,
        id_numero = p_id_numero
    WHERE id_articulo = p_id_articulo;
    INSERT INTO Historial_Estados (entidad, id_entidad, id_estado_anterior, id_estado_nuevo, fecha_cambio, id_usuario_responsable, comentario)
    VALUES ('articulo', p_id_articulo, 3, 5, NOW(), p_id_usuario, CONCAT('Publicado en Número ID ', p_id_numero));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `revisorReasignar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `revisorReasignar`(
    IN p_id_articulo INT,
    IN p_id_revisor_nuevo INT,
    IN p_id_usuario_responsable INT
)
BEGIN 
DECLARE v_id_asignacion_actual INT;

DECLARE v_id_revisor_actual INT;

DECLARE v_id_version_asignada INT;

DECLARE v_id_estado_actual INT;

DECLARE v_count INT;


DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;

RESIGNAL;

END;


START TRANSACTION;


SELECT
    COUNT(*) INTO v_count
FROM
    Articulos
WHERE
    id_articulo = p_id_articulo;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El artículo especificado no existe';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Perfiles_Revisores
WHERE
    id_revisor = p_id_revisor_nuevo;

IF v_count = 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El revisor nuevo no existe en Perfiles_Revisores';

END IF;


SELECT
    ar.id_asignacion,
    ar.id_revisor,
    ar.id_version_asignada,
    ar.id_estado INTO v_id_asignacion_actual,
    v_id_revisor_actual,
    v_id_version_asignada,
    v_id_estado_actual
FROM
    Asignaciones_Revision ar
    JOIN Estados_Catalogo ec ON ec.id_estado = ar.id_estado
WHERE
    ar.id_articulo = p_id_articulo
    AND ec.entidad = 'asignacion'
    AND ec.codigo IN ('asignado', 'aceptada') 
ORDER BY
    ar.fecha_asignacion DESC
LIMIT
    1;

IF v_id_asignacion_actual IS NULL THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El artículo no tiene una asignación activa para reasignar';

END IF;


IF v_id_revisor_actual = p_id_revisor_nuevo THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'El revisor nuevo es el mismo que el revisor actual';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Asignaciones_Revision
WHERE
    id_articulo = p_id_articulo
    AND id_revisor = p_id_revisor_nuevo;

IF v_count > 0 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Este revisor ya tiene una asignación para este artículo';

END IF;


SELECT
    COUNT(*) INTO v_count
FROM
    Asignaciones_Revision ar
    JOIN Estados_Catalogo ec ON ec.id_estado = ar.id_estado
WHERE
    ar.id_revisor = p_id_revisor_nuevo
    AND ec.entidad = 'asignacion'
    AND ec.codigo IN ('asignado', 'aceptada');


IF v_count >= (
    SELECT
        COALESCE(max_carga_activa, 99999)
    FROM
        Perfiles_Revisores
    WHERE
        id_revisor = p_id_revisor_nuevo
) THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Límite de carga superado para el revisor nuevo';

END IF;


UPDATE
    Asignaciones_Revision
SET
    id_revisor = p_id_revisor_nuevo
WHERE
    id_asignacion = v_id_asignacion_actual;


INSERT INTO
    Historial_Estados (
        entidad,
        id_entidad,
        id_estado_anterior,
        id_estado_nuevo,
        fecha_cambio,
        id_usuario_responsable,
        comentario
    )
VALUES
    (
        'asignacion',
        v_id_asignacion_actual,
        v_id_estado_actual,
        v_id_estado_actual,
        NOW(),
        p_id_usuario_responsable,
        CONCAT(
            'Reasignación de revisor: de ',
            v_id_revisor_actual,
            ' a ',
            p_id_revisor_nuevo
        )
    );

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `sp_registrar_usuario`(
    IN p_nombre_usuario     VARCHAR(80),
    IN p_email              VARCHAR(150),
    IN p_contrasena_plana   VARCHAR(255),
    IN p_primer_nombre      VARCHAR(150),
    IN p_apellido_paterno   VARCHAR(150),
    IN p_apellido_materno   VARCHAR(150),
    IN p_afiliacion         VARCHAR(200),
    
    IN p_roles_csv          VARCHAR(255),
    OUT p_id_usuario_nuevo  INT
)
BEGIN
    DECLARE v_id_usuario_nuevo INT;
    DECLARE v_id_persona_nueva INT;
    DECLARE v_id_autor_nuevo   INT;
    DECLARE v_count            INT;
    DECLARE v_id_rol           INT;
    DECLARE v_rol_codigo       VARCHAR(50);
    DECLARE v_resto_csv        TEXT;
    DECLARE v_pos              INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        RESIGNAL; 
    END;

    START TRANSACTION;

    
    SELECT COUNT(*) INTO v_count FROM Usuarios WHERE nombre_usuario = p_nombre_usuario;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de usuario ya está en uso.';
    END IF;

    SELECT COUNT(*) INTO v_count FROM Usuarios WHERE email = p_email;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico ya está registrado.';
    END IF;

    
    INSERT INTO Usuarios (nombre_usuario, email, contrasena, id_estado, activo)
    VALUES (
        p_nombre_usuario,
        p_email,
        SHA2(p_contrasena_plana, 256),
        (SELECT id_estado FROM Estados_Catalogo WHERE entidad = 'usuario' AND codigo = 'activo' LIMIT 1),
        TRUE
    );
    SET v_id_usuario_nuevo = LAST_INSERT_ID();
    SET p_id_usuario_nuevo = v_id_usuario_nuevo;

    INSERT INTO Personas (id_usuario, nombre, apellido_paterno, apellido_materno, correo_contacto, afiliacion)
    VALUES (
        v_id_usuario_nuevo,
        p_primer_nombre,
        p_apellido_paterno,
        p_apellido_materno,
        p_email,
        p_afiliacion
    );
    SET v_id_persona_nueva = LAST_INSERT_ID();

    
    SET v_resto_csv = CONCAT(p_roles_csv, ',');

    WHILE LENGTH(v_resto_csv) > 0 DO
        SET v_pos = LOCATE(',', v_resto_csv);
        SET v_rol_codigo = TRIM(SUBSTRING(v_resto_csv, 1, v_pos - 1));
        SET v_resto_csv = SUBSTRING(v_resto_csv, v_pos + 1);

        IF v_rol_codigo != '' THEN
            SELECT id_rol INTO v_id_rol FROM Roles WHERE codigo = v_rol_codigo;
            
            IF v_id_rol IS NOT NULL THEN
                INSERT INTO Usuarios_Roles (id_usuario, id_rol, activo)
                VALUES (v_id_usuario_nuevo, v_id_rol, TRUE);
                IF v_rol_codigo = 'AUTOR' THEN
                    SELECT COUNT(*) INTO v_count FROM Perfiles_Autores WHERE id_persona = v_id_persona_nueva;
                    IF v_count = 0 THEN
                        INSERT INTO Perfiles_Autores (id_persona) VALUES (v_id_persona_nueva);
                    END IF;
                END IF;

                IF v_rol_codigo = 'REVISOR' THEN
                    SELECT COUNT(*) INTO v_count FROM Perfiles_Revisores WHERE id_persona = v_id_persona_nueva;
                    IF v_count = 0 THEN
                        INSERT INTO Perfiles_Revisores (id_persona) VALUES (v_id_persona_nueva);
                    END IF;
                END IF;
            END IF;
        END IF;
    END WHILE;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tasaAceptacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `tasaAceptacion`(IN p_desde DATE, IN p_hasta DATE)
BEGIN
    DROP TEMPORARY TABLE IF EXISTS tmpAceptacion;
    CREATE TEMPORARY TABLE tmpAceptacion AS
    SELECT
        c.titulo AS convocatoria,
        COUNT(a.id_articulo) AS total_articulos,
        SUM(CASE WHEN e.codigo IN ('aceptado', 'publicado') THEN 1 ELSE 0 END) AS aceptados,
        ROUND(
            (SUM(CASE WHEN e.codigo IN ('aceptado', 'publicado') THEN 1 ELSE 0 END) / COUNT(a.id_articulo)) * 100,
            2
        ) AS tasa_aceptacion
    FROM Convocatorias c
    LEFT JOIN Articulos a ON c.id_convocatoria = a.id_convocatoria AND a.fecha_envio BETWEEN p_desde AND p_hasta
    LEFT JOIN Estados_Catalogo e ON a.id_estado = e.id_estado
    GROUP BY c.id_convocatoria, c.titulo;

    SELECT * FROM tmpAceptacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tiemposPorEtapa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `tiemposPorEtapa`(IN p_desde DATE, IN p_hasta DATE)
BEGIN
    
    DROP TEMPORARY TABLE IF EXISTS tmpTiempos;
    CREATE TEMPORARY TABLE tmpTiempos AS
    SELECT 
        e.codigo AS estado, 
        ROUND(AVG(
            DATEDIFF(
                (SELECT MIN(h2.fecha_cambio) 
                 FROM Historial_Estados h2 
                 WHERE h2.id_entidad = h1.id_entidad 
                   AND h2.entidad = h1.entidad 
                   AND h2.fecha_cambio > h1.fecha_cambio),
                h1.fecha_cambio
            )
        ), 1) AS dias_en_etapa 
    FROM Historial_Estados h1
    JOIN Estados_Catalogo e ON h1.id_estado_nuevo = e.id_estado
    WHERE 
        h1.entidad = 'articulo'
        AND h1.fecha_cambio BETWEEN p_desde AND p_hasta 
    GROUP BY e.codigo;

    
    SELECT * FROM tmpTiempos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioRolID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`ra_usuario`@`localhost` PROCEDURE `usuarioRolID`(IN p_id_usuario INT)
BEGIN
    SELECT 
        u.id_usuario,
        u.nombre_usuario,
        GROUP_CONCAT(r.codigo SEPARATOR ',') AS roles
    FROM Usuarios u
    LEFT JOIN Usuarios_Roles ur ON u.id_usuario = ur.id_usuario AND ur.activo = TRUE
    LEFT JOIN Roles r ON ur.id_rol = r.id_rol
    WHERE u.id_usuario = p_id_usuario
    GROUP BY u.id_usuario, u.nombre_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vAceptacionPorConvocatoria`
--

/*!50001 DROP VIEW IF EXISTS `vAceptacionPorConvocatoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vAceptacionPorConvocatoria` AS select `c`.`id_convocatoria` AS `id_convocatoria`,`c`.`titulo` AS `convocatoria`,count(`a`.`id_articulo`) AS `total_articulos`,sum(case when `e`.`codigo` in ('aceptado','aceptado_con_cambios') then 1 else 0 end) AS `aceptados`,round(sum(case when `e`.`codigo` in ('aceptado','aceptado_con_cambios') then 1 else 0 end) / count(`a`.`id_articulo`) * 100,2) AS `tasa_aceptacion` from ((`Convocatorias` `c` left join `Articulos` `a` on(`a`.`id_convocatoria` = `c`.`id_convocatoria`)) left join `Estados_Catalogo` `e` on(`a`.`id_estado` = `e`.`id_estado`)) group by `c`.`id_convocatoria`,`c`.`titulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vArticulosParaPublicar`
--

/*!50001 DROP VIEW IF EXISTS `vArticulosParaPublicar`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vArticulosParaPublicar` AS select `a`.`id_articulo` AS `id_articulo`,`a`.`titulo` AS `titulo`,`c`.`titulo` AS `convocatoria`,`a`.`fecha_envio` AS `fecha_envio` from (`Articulos` `a` join `Convocatorias` `c` on(`a`.`id_convocatoria` = `c`.`id_convocatoria`)) where `a`.`id_estado` = 3 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vArticulosPorEstado`
--

/*!50001 DROP VIEW IF EXISTS `vArticulosPorEstado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vArticulosPorEstado` AS select `a`.`id_articulo` AS `id_articulo`,`a`.`titulo` AS `titulo`,`e`.`descripcion` AS `estado` from (`Articulos` `a` join `Estados_Catalogo` `e` on(`a`.`id_estado` = `e`.`id_estado`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vCargaRevisores`
--

/*!50001 DROP VIEW IF EXISTS `vCargaRevisores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vCargaRevisores` AS select `pr`.`id_revisor` AS `id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) AS `revisor`,`pr`.`max_carga_activa` AS `max_carga_activa`,`pr`.`disponible` AS `disponible`,count(case when `ec`.`codigo` in ('asignado','aceptada') then `ar`.`id_asignacion` end) AS `asignaciones_activas`,count(`d`.`id_dictamen`) AS `dictamenes_completados` from ((((`Perfiles_Revisores` `pr` join `Personas` `p` on(`pr`.`id_persona` = `p`.`id_persona`)) left join `Asignaciones_Revision` `ar` on(`pr`.`id_revisor` = `ar`.`id_revisor`)) left join `Estados_Catalogo` `ec` on(`ar`.`id_estado` = `ec`.`id_estado` and `ec`.`entidad` = 'asignacion')) left join `Dictamenes` `d` on(`ar`.`id_asignacion` = `d`.`id_asignacion`)) group by `pr`.`id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`),`pr`.`max_carga_activa`,`pr`.`disponible` order by count(case when `ec`.`codigo` in ('asignado','aceptada') then `ar`.`id_asignacion` end) desc,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vEnviosPorArea`
--

/*!50001 DROP VIEW IF EXISTS `vEnviosPorArea`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vEnviosPorArea` AS select `at`.`id_area` AS `id_area`,`at`.`nombre` AS `area`,count(`a`.`id_articulo`) AS `total_articulos` from (`Areas_Tematicas` `at` left join `Articulos` `a` on(`at`.`id_area` = `a`.`id_area`)) group by `at`.`id_area`,`at`.`nombre` order by count(`a`.`id_articulo`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vHistorialPublicacionesAutor`
--

/*!50001 DROP VIEW IF EXISTS `vHistorialPublicacionesAutor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vHistorialPublicacionesAutor` AS select `pa`.`id_autor` AS `id_autor`,concat_ws(' ',`pers`.`nombre`,`pers`.`apellido_paterno`) AS `autor`,`art`.`id_articulo` AS `id_articulo`,`art`.`titulo` AS `articulo`,`nr`.`id_numero` AS `id_numero`,concat('Vol.',`nr`.`volumen`,', Núm.',`nr`.`numero`,' (',`nr`.`anio`,')') AS `numero_revista`,`nr`.`fecha_publicacion` AS `fecha_publicacion`,`ec`.`descripcion` AS `estado_final` from (((((`Articulos_Autores` `aa` join `Articulos` `art` on(`aa`.`id_articulo` = `art`.`id_articulo`)) join `Perfiles_Autores` `pa` on(`aa`.`id_autor` = `pa`.`id_autor`)) join `Personas` `pers` on(`pa`.`id_persona` = `pers`.`id_persona`)) join `Numeros_Revista` `nr` on(`art`.`id_numero` = `nr`.`id_numero`)) join `Estados_Catalogo` `ec` on(`art`.`id_estado` = `ec`.`id_estado` and `ec`.`codigo` = 'publicado')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vProductividadRevisor`
--

/*!50001 DROP VIEW IF EXISTS `vProductividadRevisor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vProductividadRevisor` AS select `pr`.`id_revisor` AS `id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) AS `revisor`,count(`d`.`id_dictamen`) AS `total_dictamenes`,round(avg(timestampdiff(DAY,`ar`.`fecha_asignacion`,`d`.`fecha_dictamen`)),1) AS `dias_promedio` from (((`Perfiles_Revisores` `pr` join `Personas` `p` on(`pr`.`id_persona` = `p`.`id_persona`)) left join `Asignaciones_Revision` `ar` on(`pr`.`id_revisor` = `ar`.`id_revisor`)) left join `Dictamenes` `d` on(`ar`.`id_asignacion` = `d`.`id_asignacion`)) group by `pr`.`id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) order by count(`d`.`id_dictamen`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vTiempoRevisionPromedio`
--

/*!50001 DROP VIEW IF EXISTS `vTiempoRevisionPromedio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vTiempoRevisionPromedio` AS select `ar`.`id_revisor` AS `id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) AS `revisor`,round(avg(timestampdiff(DAY,`ar`.`fecha_asignacion`,`d`.`fecha_dictamen`)),1) AS `dias_promedio`,count(`d`.`id_dictamen`) AS `total_revisiones` from (((`Asignaciones_Revision` `ar` join `Dictamenes` `d` on(`ar`.`id_asignacion` = `d`.`id_asignacion`)) join `Perfiles_Revisores` `pr` on(`ar`.`id_revisor` = `pr`.`id_revisor`)) join `Personas` `p` on(`pr`.`id_persona` = `p`.`id_persona`)) group by `ar`.`id_revisor`,concat_ws(' ',`p`.`nombre`,`p`.`apellido_paterno`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vTiemposPorEtapa`
--

/*!50001 DROP VIEW IF EXISTS `vTiemposPorEtapa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ra_usuario`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vTiemposPorEtapa` AS select `e1`.`descripcion` AS `etapa_inicial`,`e2`.`descripcion` AS `etapa_final`,concat(`e1`.`codigo`,' → ',`e2`.`codigo`) AS `transicion`,round(avg(timestampdiff(DAY,`h1`.`fecha_cambio`,`h2`.`fecha_cambio`)),1) AS `dias_promedio`,count(`h1`.`id_historial`) AS `total_mediciones` from ((((`Historial_Estados` `h1` join `Historial_Estados` `h2` on(`h1`.`id_entidad` = `h2`.`id_entidad` and `h1`.`entidad` = `h2`.`entidad` and `h2`.`fecha_cambio` > `h1`.`fecha_cambio`)) left join `Historial_Estados` `h_intermedio` on(`h1`.`id_entidad` = `h_intermedio`.`id_entidad` and `h1`.`entidad` = `h_intermedio`.`entidad` and `h_intermedio`.`fecha_cambio` > `h1`.`fecha_cambio` and `h_intermedio`.`fecha_cambio` < `h2`.`fecha_cambio`)) join `Estados_Catalogo` `e1` on(`h1`.`id_estado_nuevo` = `e1`.`id_estado`)) join `Estados_Catalogo` `e2` on(`h2`.`id_estado_nuevo` = `e2`.`id_estado`)) where `h1`.`entidad` = 'articulo' and `h_intermedio`.`id_historial` is null group by `e1`.`descripcion`,`e2`.`descripcion`,concat(`e1`.`codigo`,' → ',`e2`.`codigo`) order by round(avg(timestampdiff(DAY,`h1`.`fecha_cambio`,`h2`.`fecha_cambio`)),1) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-27 21:40:26
