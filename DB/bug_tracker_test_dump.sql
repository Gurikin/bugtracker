-- MySQL dump 10.13  Distrib 5.7.23, for Win64 (x86_64)
--
-- Host: localhost    Database: bug_tracker_test
-- ------------------------------------------------------
-- Server version	5.7.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bug`
--

DROP TABLE IF EXISTS `bug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bug` (
  `bug_id` int(11) NOT NULL AUTO_INCREMENT,
  `find_date` date NOT NULL,
  `short_desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_desc` text COLLATE utf8mb4_unicode_ci,
  `status` enum('new','opened','solved','closed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `urgency` enum('immediately','urgently','unrushed','completly unrushed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `criticality` enum('crash','critical','dont critical','change request') COLLATE utf8mb4_unicode_ci NOT NULL,
  `usr_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`bug_id`),
  KEY `usr_email_idx` (`usr_email`),
  CONSTRAINT `usr_email` FOREIGN KEY (`usr_email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bug`
--

LOCK TABLES `bug` WRITE;
/*!40000 ALTER TABLE `bug` DISABLE KEYS */;
INSERT INTO `bug` VALUES (27,'2019-01-07','Bug # 1','Full description of bug # 1','opened','immediately','crash','igor@gmail.com'),(28,'2019-01-06','Bug # 2','Full description of bug # 2','opened','urgently','critical','igor@gmail.com'),(29,'2019-01-08','Bug # 3','Full description of bug # 3','solved','unrushed','dont critical','igor@gmail.com'),(30,'2019-01-09','Bug # 4','Full description of bug # 4','opened','completly unrushed','change request','igor@gmail.com'),(31,'2019-01-09','Bug # 5','Full description of bug # 5','opened','urgently','critical','jr@gmail.com'),(32,'2019-01-09','Bug # 6','Full description of bug # 6','new','urgently','dont critical','jr@gmail.com');
/*!40000 ALTER TABLE `bug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bug_history`
--

DROP TABLE IF EXISTS `bug_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bug_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bug_id` int(11) NOT NULL,
  `action` enum('new','opened','solved','closed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_date` datetime NOT NULL,
  `action_comment` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  KEY `bug_id_idx` (`bug_id`),
  CONSTRAINT `bug_id` FOREIGN KEY (`bug_id`) REFERENCES `bug` (`bug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_email` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bug_history`
--

LOCK TABLES `bug_history` WRITE;
/*!40000 ALTER TABLE `bug_history` DISABLE KEYS */;
INSERT INTO `bug_history` VALUES (16,27,'new','2019-01-08 23:21:34','Add bug to bugtracker list','igor@gmail.com'),(17,28,'new','2019-01-08 23:30:26','Add bug to bugtracker list','igor@gmail.com'),(18,29,'new','2019-01-08 23:30:42','Add bug to bugtracker list','igor@gmail.com'),(19,27,'opened','2019-01-08 23:31:14','Comment for open bug # 1','igor@gmail.com'),(20,28,'opened','2019-01-08 23:33:47','Comment for open bug # 2','igor@gmail.com'),(21,27,'solved','2019-01-08 23:46:15','Comment for solve bug # 1','igor@gmail.com'),(22,27,'opened','2019-01-08 23:52:46','Comment for reopen the bug # 1','igor@gmail.com'),(23,30,'new','2019-01-09 00:16:54','Add bug to bugtracker list','igor@gmail.com'),(24,30,'opened','2019-01-09 00:17:09','Comment for open bug # 4','igor@gmail.com'),(25,29,'opened','2019-01-09 00:17:50','Comment for open bug # 3 from JR','jr@gmail.com'),(26,31,'new','2019-01-09 00:23:40','Add bug to bugtracker list','jr@gmail.com'),(27,31,'opened','2019-01-09 00:29:32','Comment for open bug # 5 from JR','jr@gmail.com'),(28,32,'new','2019-01-09 00:37:13','Add bug to bugtracker list','jr@gmail.com'),(29,29,'solved','2019-01-09 13:55:23','Comment for solve bug # 3','jr@gmail.com');
/*!40000 ALTER TABLE `bug_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `fname` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `login` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('b@gmail.com','Bob','Anderson','Oz8FhgdAg1NMsai+KWGeCg=='),('fm@gmail.com','Freddie','Mercury','Oz8FhgdAg1NMsai+KWGeCg=='),('igor@gmail.com','Igor','Baggins','Oz8FhgdAg1NMsai+KWGeCg=='),('jr@gmail.com','Joan','Rowling','Oz8FhgdAg1NMsai+KWGeCg=='),('vano@gmail.com','Ivan','Ivanov','Oz8FhgdAg1NMsai+KWGeCg==');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-09 15:59:51
