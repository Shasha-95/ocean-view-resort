CREATE DATABASE  IF NOT EXISTS `ocean_view` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ocean_view`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ocean_view
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `help_section`
--

DROP TABLE IF EXISTS `help_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_section` (
  `help_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_section`
--

LOCK TABLES `help_section` WRITE;
/*!40000 ALTER TABLE `help_section` DISABLE KEYS */;
INSERT INTO `help_section` VALUES (1,'Login','Enter your username and password provided by the administrator.'),(2,'Add Reservation','Select Register Guest and enter details, room type, and dates.'),(3,'Exit System','Always click Exit to safely log out of the system.');
/*!40000 ALTER TABLE `help_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `reservation_number` int NOT NULL AUTO_INCREMENT,
  `guest_name` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `room_type_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  PRIMARY KEY (`reservation_number`),
  KEY `room_type_id` (`room_type_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,'Shashika Dissanayake','No 1, Alfred House Avenue, Colombo 3.','Sri Lanka','0111234567',2,'2026-03-07','2026-03-08'),(101,'Arjun Fernando','No 45, Galle Road, Colombo 03','Sri Lanka','0771234567',1,'2026-03-10','2026-03-12'),(102,'Sarah Jenkins','12 Baker Street, London','United Kingdom','+4478901234',3,'2026-03-12','2026-03-18'),(103,'Hiroshi Tanaka','5-1-2 Shinjuku, Tokyo','Japan','+8190123456',4,'2026-03-15','2026-03-20'),(104,'Malini Perera','Main Street, Kandy','Sri Lanka','0719876543',2,'2026-03-18','2026-03-19'),(105,'John Smith','500 Fifth Ave, New York','USA','+1212555019',3,'2026-03-20','2026-03-25'),(106,'Elena Rossi','Via Roma 10, Milan','Italy','+3933312345',2,'2026-03-22','2026-03-24'),(107,'Liam O-Brien','22 Grafton St, Dublin','Ireland','+3538612345',1,'2026-04-01','2026-04-05'),(108,'Saman Kumara','Beach Road, Matara','Sri Lanka','0765432109',2,'2026-04-02','2026-04-04'),(109,'Chloe Lefebvre','Rue de Rivoli, Paris','France','+3361234567',4,'2026-04-05','2026-04-12'),(110,'David Miller','George St, Sydney','Australia','+6141234567',3,'2026-04-10','2026-04-15'),(111,'Fathima Rizwan','Hill Street, Nuwara Eliya','Sri Lanka','0722334455',1,'2026-04-12','2026-04-14'),(112,'Hans Schmidt','Alexanderplatz 1, Berlin','Germany','+4917012345',3,'2026-04-15','2026-04-22'),(113,'Chen Wei','Nanjing Road, Shanghai','China','+8613800138',2,'2026-04-18','2026-04-20'),(114,'Kasun Jayasuriya','Negombo Road, Kurunegala','Sri Lanka','0779988776',4,'2026-04-20','2026-04-25'),(115,'Sofia Hernandez','Paseo de la Reforma, Mexico City','Mexico','+5255123456',1,'2026-05-01','2026-05-03'),(116,'Anura Bandara','Temple Road, Anuradhapura','Sri Lanka','0711223344',2,'2026-05-05','2026-05-07'),(117,'Emily Watson','Queen Street, Toronto','Canada','+1416555012',3,'2026-05-10','2026-05-17'),(118,'Ravi Shankar','MG Road, Bangalore','India','+9198450123',2,'2026-05-12','2026-05-15'),(119,'Dimitri Volkov','Nevsky Prospect, St. Petersburg','Russia','+7911123456',4,'2026-05-15','2026-05-25'),(120,'Thilini Silva','Galle Face Terrace, Colombo 03','Sri Lanka','0755667788',3,'2026-05-20','2026-05-22');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_types` (
  `room_type_id` int NOT NULL AUTO_INCREMENT,
  `room_type_name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`room_type_id`),
  UNIQUE KEY `room_type_name` (`room_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,'Single',15000.00),(2,'Double',25000.00),(3,'Master Suite',45000.00),(4,'Luxury Villa',65000.00);
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` enum('Admin','Staff') DEFAULT 'Staff',
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('STF001','Admin User','Hotel Manager Quarters, Galle','admin@oceanview.com','0771112223','admin','admin123','Admin'),('STF002','Kasun Perera','12/A, Beach Road, Galle','kasun@oceanview.com','0714455667','kasun_p','staff123','Staff'),('STF003','Nilmini Silva','No 45, Wakwella Road, Galle','nilmini@oceanview.com','0767788990','nilmini_s','staff123','Staff'),('STF004','Dilshan Fernando','Fort View, Galle','dilshan@oceanview.com','0721122334','dilshan_f','staff123','Staff'),('STF005','Priyantha Kumara','Karapitiya, Galle','priyantha@oceanview.com','0773344556','priyantha_k','staff123','Staff'),('STF006','Anoma Jayasinghe','Unawatuna, Galle','anoma@oceanview.com','0715566778','anoma_j','staff123','Staff'),('STF007','Roshan Wickramasinghe','Hikkaduwa, Galle','roshan@oceanview.com','0769988776','roshan_w','staff123','Staff'),('STF008','Sanduni de Silva','Matara Road, Koggala','sanduni@oceanview.com','0778899001','sanduni_d','staff123','Staff'),('STF009','Nuwan Rathnayake','Pinnaduwa, Galle','nuwan@oceanview.com','0723344556','nuwan_r','staff123','Staff'),('STF010','Ishara Madushani','Habaraduwa, Galle','ishara@oceanview.com','0712233445','ishara_m','staff123','Staff');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-07  7:39:46
