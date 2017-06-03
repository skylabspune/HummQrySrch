/*
SQLyog Trial v12.15 (32 bit)
MySQL - 5.5.15 : Database - hummingdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hummingdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `hummingdb`;

/*Table structure for table `cust_data` */

DROP TABLE IF EXISTS `cust_data`;

CREATE TABLE `cust_data` (
  `ID` decimal(10,0) NOT NULL,
  `NAME` varchar(4000) DEFAULT NULL,
  `EMAILID` varchar(4000) DEFAULT NULL,
  `PROFESSION` varchar(4000) DEFAULT NULL,
  `AGE` decimal(10,0) DEFAULT NULL,
  `NATIONALITY` varchar(4000) DEFAULT NULL,
  `FAVORITE` varchar(4000) DEFAULT NULL,
  `PASSWORD` varchar(4000) DEFAULT NULL,
  `GENDER` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cust_data` */

insert  into `cust_data`(`ID`,`NAME`,`EMAILID`,`PROFESSION`,`AGE`,`NATIONALITY`,`FAVORITE`,`PASSWORD`,`GENDER`) values 
('1','Ajinkya','a@a.com','a','12','indian','pop','a','a');

/*Table structure for table `query` */

DROP TABLE IF EXISTS `query`;

CREATE TABLE `query` (
  `CONTOUR` varchar(4000) DEFAULT NULL,
  `ID` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `query` */

/*Table structure for table `ratigns` */

DROP TABLE IF EXISTS `ratigns`;

CREATE TABLE `ratigns` (
  `SONGID` decimal(10,0) DEFAULT NULL,
  `USERID` decimal(10,0) DEFAULT NULL,
  `CONTOURS` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ratigns` */

/*Table structure for table `song` */

DROP TABLE IF EXISTS `song`;

CREATE TABLE `song` (
  `SONGID` decimal(10,0) NOT NULL,
  `SONGTITLE` varchar(4000) DEFAULT NULL,
  `SONG` blob,
  `MIDI` blob,
  `CONTOUR` varchar(4000) DEFAULT NULL,
  `GENRE` varchar(4000) DEFAULT NULL,
  `YEAR` decimal(10,0) DEFAULT NULL,
  `TEMPO` varchar(4000) DEFAULT NULL,
  `S_GENDER` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`SONGID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `song` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
