CREATE DATABASE  IF NOT EXISTS `hummingdb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hummingdb`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win32 (x86)
--
-- Host: localhost    Database: hummingdb
-- ------------------------------------------------------
-- Server version	5.5.15

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
-- Table structure for table `cust_data`
--

DROP TABLE IF EXISTS `cust_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cust_data` (
  `ID` decimal(10,0) NOT NULL,
  `NAME` varchar(4000) DEFAULT NULL,
  `EMAILID` varchar(4000) DEFAULT NULL,
  `PROFESSION` varchar(4000) DEFAULT NULL,
  `AGE` int(11) DEFAULT NULL,
  `NATIONALITY` varchar(4000) DEFAULT NULL,
  `FAVORITE` varchar(4000) DEFAULT NULL,
  `PASSWORD` varchar(4000) DEFAULT NULL,
  `GENDER` varchar(4000) DEFAULT NULL,
  `CONFIRM_PASSWORD` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cust_data`
--

LOCK TABLES `cust_data` WRITE;
/*!40000 ALTER TABLE `cust_data` DISABLE KEYS */;
INSERT INTO `cust_data` VALUES (1,'Ajinkya','a@aa.com','adad',22,'India','scsc','a','Male','a'),(2,'mandar','mandar@gmail.com','Software devloper',22,'indain','rock','1234','Male','1234');
/*!40000 ALTER TABLE `cust_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qbsh_searchhistory`
--

DROP TABLE IF EXISTS `qbsh_searchhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qbsh_searchhistory` (
  `hid` int(11) NOT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `query` longblob,
  `songid` int(11) DEFAULT NULL,
  `songname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`hid`),
  KEY `fk_searchhistory_idx` (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qbsh_searchhistory`
--

LOCK TABLES `qbsh_searchhistory` WRITE;
/*!40000 ALTER TABLE `qbsh_searchhistory` DISABLE KEYS */;
INSERT INTO `qbsh_searchhistory` VALUES (1,'Ajinkya',' 57 0 0 -1 -1 1 0 -2 1 -1 3 0 -31 -3 -2 1 -5 -37',1,'sd\'\'');
/*!40000 ALTER TABLE `qbsh_searchhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query`
--

DROP TABLE IF EXISTS `query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query` (
  `CONTOUR` varchar(4000) DEFAULT NULL,
  `ID` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query`
--

LOCK TABLES `query` WRITE;
/*!40000 ALTER TABLE `query` DISABLE KEYS */;
INSERT INTO `query` VALUES ('',2);
/*!40000 ALTER TABLE `query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratigns`
--

DROP TABLE IF EXISTS `ratigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratigns` (
  `SONGID` decimal(10,0) DEFAULT NULL,
  `USERID` decimal(10,0) DEFAULT NULL,
  `CONTOURS` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratigns`
--

LOCK TABLES `ratigns` WRITE;
/*!40000 ALTER TABLE `ratigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `song` (
  `SONGID` decimal(10,0) NOT NULL,
  `SONGTITLE` varchar(4000) DEFAULT NULL,
  `SONG` longblob,
  `MIDI` blob,
  `CONTOUR` varchar(4000) DEFAULT NULL,
  `GENRE` varchar(4000) DEFAULT NULL,
  `YEAR` decimal(10,0) DEFAULT NULL,
  `TEMPO` varchar(4000) DEFAULT NULL,
  `S_GENDER` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`SONGID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-04 19:43:40
