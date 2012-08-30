/*
SQLyog Enterprise - MySQL GUI v7.14 
MySQL - 5.1.54-community : Database - stock
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`stock` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `stock`;

/*Table structure for table `bag` */

DROP TABLE IF EXISTS `bag`;

CREATE TABLE `bag` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playerName` varchar(20) DEFAULT NULL,
  `stockNum` varchar(6) DEFAULT NULL,
  `haveNum` int(11) DEFAULT '0',
  `elPrice` double DEFAULT '0',
  `clockNum` int(11) DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `playerName` (`playerName`,`stockNum`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

/*Table structure for table `bshistory` */

DROP TABLE IF EXISTS `bshistory`;

CREATE TABLE `bshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `num` varchar(50) DEFAULT NULL,
  `playerName` varchar(20) DEFAULT NULL,
  `stockNum` varchar(6) DEFAULT NULL,
  `bsSort` varchar(4) DEFAULT NULL,
  `bsNum` int(11) DEFAULT NULL,
  `bsWtPrice` double DEFAULT NULL,
  `bsCjPrice` double DEFAULT NULL,
  `taxStamp` double DEFAULT NULL,
  `commision` double DEFAULT NULL,
  `bsTime` datetime DEFAULT NULL,
  `haveCjNum` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=861 DEFAULT CHARSET=utf8;

/*Table structure for table `cjhistory` */

DROP TABLE IF EXISTS `cjhistory`;

CREATE TABLE `cjhistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockNum` varchar(6) DEFAULT NULL,
  `cjSort` varchar(1) DEFAULT NULL,
  `cjNum` int(11) DEFAULT NULL,
  `cjPrice` double DEFAULT NULL,
  `cjTime` datetime DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Table structure for table `dline` */

DROP TABLE IF EXISTS `dline`;

CREATE TABLE `dline` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `buildDate` datetime DEFAULT NULL,
  `finistNum` double DEFAULT NULL,
  `startNum` double DEFAULT NULL,
  `topNum` double DEFAULT NULL,
  `lastNum` double DEFAULT NULL,
  `turnover` double DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Table structure for table `hline` */

DROP TABLE IF EXISTS `hline`;

CREATE TABLE `hline` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `buildDate` datetime DEFAULT NULL,
  `finistNum` double DEFAULT NULL,
  `startNum` double DEFAULT NULL,
  `topNum` double DEFAULT NULL,
  `lastNum` double DEFAULT NULL,
  `turnover` double DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mline` */

DROP TABLE IF EXISTS `mline`;

CREATE TABLE `mline` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `buildDate` datetime DEFAULT NULL,
  `price` double DEFAULT NULL,
  `turnover` double DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1978 DEFAULT CHARSET=utf8;

/*Table structure for table `player` */

DROP TABLE IF EXISTS `player`;

CREATE TABLE `player` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playerName` varchar(12) DEFAULT NULL,
  `playerPwd` varchar(32) DEFAULT NULL,
  `haveMoney` double DEFAULT '0',
  `clockMoney` double DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8;

/*Table structure for table `stock` */

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `stockName` varchar(20) DEFAULT NULL,
  `allNum` int(11) DEFAULT NULL,
  `busNum` int(11) DEFAULT NULL,
  `jinzhi` double DEFAULT NULL,
  `shouyi` double DEFAULT NULL,
  `pe` double DEFAULT NULL,
  `lastDayEndPrice` double DEFAULT NULL,
  `xinxinLv` double DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `stockpricehistory` */

DROP TABLE IF EXISTS `stockpricehistory`;

CREATE TABLE `stockpricehistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockNum` varchar(6) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `priceTime` datetime DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tenplayer` */

DROP TABLE IF EXISTS `tenplayer`;

CREATE TABLE `tenplayer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `playerName` varchar(20) DEFAULT NULL,
  `haveNum` int(11) DEFAULT NULL,
  `zhanbi` double DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Table structure for table `wline` */

DROP TABLE IF EXISTS `wline`;

CREATE TABLE `wline` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `stockCode` varchar(6) DEFAULT NULL,
  `buildDate` datetime DEFAULT NULL,
  `finistNum` double DEFAULT NULL,
  `startNum` double DEFAULT NULL,
  `topNum` double DEFAULT NULL,
  `lastNum` double DEFAULT NULL,
  `turnover` double DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
