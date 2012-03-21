/*
SQLyog Enterprise - MySQL GUI v7.14 
MySQL - 5.1.54-community : Database - sooxin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`sooxin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sooxin`;

/*Table structure for table `chongzhilog` */

DROP TABLE IF EXISTS `chongzhilog`;

CREATE TABLE `chongzhilog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playerName` varchar(50) DEFAULT NULL,
  `chongzhiTime` datetime DEFAULT NULL,
  `chongzhiMoney` double DEFAULT NULL,
  `lastHaveMoney` double DEFAULT NULL,
  `nowHaveMoney` double DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `chongzhilog` */

insert  into `chongzhilog`(`ID`,`playerName`,`chongzhiTime`,`chongzhiMoney`,`lastHaveMoney`,`nowHaveMoney`,`timestamp`) values (1,'sooxin','2012-03-16 00:00:00',67,567,567,NULL);

/*Table structure for table `duihuanlog` */

DROP TABLE IF EXISTS `duihuanlog`;

CREATE TABLE `duihuanlog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playerName` varchar(50) DEFAULT NULL,
  `duihuanTime` datetime DEFAULT NULL,
  `itemName` varchar(50) DEFAULT NULL,
  `duihuanMoney` double DEFAULT NULL,
  `lastHaveMoney` double DEFAULT NULL,
  `nowHaveMoney` double DEFAULT NULL,
  `contactName` varchar(10) DEFAULT NULL,
  `contactTel` varchar(20) DEFAULT NULL,
  `contactAddress` text,
  `state` int(11) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `duihuanlog` */

insert  into `duihuanlog`(`ID`,`playerName`,`duihuanTime`,`itemName`,`duihuanMoney`,`lastHaveMoney`,`nowHaveMoney`,`contactName`,`contactTel`,`contactAddress`,`state`,`timestamp`) values (1,'sooxin','2012-03-16 00:00:00','标签',0,10285,10285,'5654','456','456',NULL,NULL),(2,'sooxin','2012-03-16 00:00:00','iPhone 4s 16G',0,10285,10285,'5654','456','456',NULL,NULL);

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `noticeTime` datetime DEFAULT NULL,
  `noticeContent` text,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `notice` */

insert  into `notice`(`ID`,`noticeTime`,`noticeContent`,`timestamp`) values (1,'2012-03-16 17:04:03','ertertert',NULL),(2,'2012-03-16 17:04:03','wrwerwerwrghgfhgf',NULL);

/*Table structure for table `player` */

DROP TABLE IF EXISTS `player`;

CREATE TABLE `player` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playername` varchar(50) DEFAULT NULL,
  `playerpwd` varchar(100) DEFAULT NULL,
  `haveMoney` double DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `player` */

insert  into `player`(`ID`,`playername`,`playerpwd`,`haveMoney`,`timestamp`) values (4,'sooxin','e10adc3949ba59abbe56e057f20f883e',10285,NULL),(5,'m001',NULL,9995,NULL),(6,'m002',NULL,10015,NULL),(7,'m003',NULL,10005,NULL),(8,'123','202cb962ac59075b964b07152d234b70',10000,NULL),(9,'','d41d8cd98f00b204e9800998ecf8427e',NULL,NULL),(10,'s456','e10adc3949ba59abbe56e057f20f883e',NULL,NULL),(11,'sooxiner','e10adc3949ba59abbe56e057f20f883e',NULL,NULL),(12,'sooxinr','e10adc3949ba59abbe56e057f20f883e',NULL,NULL),(13,'sooxinry','e10adc3949ba59abbe56e057f20f883e',0,NULL);

/*Table structure for table `playlog` */

DROP TABLE IF EXISTS `playlog`;

CREATE TABLE `playlog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `playerName` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '會員名稱',
  `gameClass` int(11) NOT NULL COMMENT '遊戲類型-參考master_code表',
  `gameSubClass` int(11) NOT NULL,
  `gameName` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '遊戲名稱',
  `gameNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '遊戲局號',
  `gameTime` datetime NOT NULL COMMENT '遊戲時間',
  `gameContent` text COLLATE utf8_unicode_ci NOT NULL COMMENT '遊戲內容',
  `allTouZhuMoney` double NOT NULL COMMENT '總投注',
  `preMoney` double NOT NULL DEFAULT '0' COMMENT '起始點數',
  `winLossMoneyBeforeTax` double NOT NULL COMMENT '輸贏點數-稅前',
  `gameTaxaction` double NOT NULL COMMENT '棋牌時為公點(交稅);電玩時為總洗碼金',
  `winLossMoneyAfterTax` double NOT NULL COMMENT '輪贏點數-稅後',
  `afterMoney` double NOT NULL DEFAULT '0' COMMENT '結束點數',
  `gameIp` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '游戏ip',
  `remarks` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `play_log_playerName_gameTime` (`playerName`(10),`gameTime`)
) ENGINE=InnoDB AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='遊戲記錄';

/*Data for the table `playlog` */

insert  into `playlog`(`ID`,`playerName`,`gameClass`,`gameSubClass`,`gameName`,`gameNo`,`gameTime`,`gameContent`,`allTouZhuMoney`,`preMoney`,`winLossMoneyBeforeTax`,`gameTaxaction`,`winLossMoneyAfterTax`,`afterMoney`,`gameIp`,`remarks`,`timestamp`) values (1014,'m003',1,1,'mahjong5','1331888352406','2012-03-16 17:04:03','vix!1!28.25.26.19.2.17.4.15.24.6.23.22.26.;sooxin!2!4.2.27.8.5.13.18.14.23.2.4.18.4.;ciy!3!6.24.14.13.7.29.28.25.13.29.28.3.16.;rgm!4!7.15.16.5.6.25.19.23.6.11.9.24.5.;beg,1331888352406,5,5;get,3,12;sd,4;sd,2;sd,1;din,1,15;din,4,23;din,2,23;sd,3;din,3,3;put,3,3,1;get,4,1;put,4,23,1;get,1,19;put,1,15,1;get,2,14;put,2,23,1;get,3,9;put,3,6,0;so,4,peng;pen,4,6;put,4,24,0;get,1,27;put,1,17,0;get,2,9;put,2,27,0;get,3,3;put,3,7,0;get,4,11;put,4,25,0;get,1,8;put,1,19,0;get,2,29;put,2,29,0;so,3,peng;pen,3,29;put,3,3,0;get,4,9;put,4,1,0;get,1,23;put,1,19,0;get,2,15;put,2,9,0;so,4,peng;pen,4,9;put,4,7,0;get,1,3;put,1,22,0;get,2,1;put,2,1,0;get,3,16;put,3,9,0;get,4,17;put,4,19,0;get,1,29;put,1,29,0;get,2,25;put,2,25,0;get,3,8;put,3,8,0;get,4,7;put,4,7,0;so,1,hu;huI,1,7,0,1,0,0;get,2,22;put,2,22,0;get,3,14;put,3,14,0;so,2,peng;pen,2,14;put,2,8,0;get,3,28;put,3,13,0;get,4,5;so,4,zihu;huI,4,5,1,0,0,0;get,2,21;put,2,21,0;get,3,8;put,3,8,0;get,2,1;put,2,1,0;get,3,24;put,3,24,0;get,2,1;put,2,1,0;get,3,11;put,3,11,0;get,2,12;put,2,15,0;get,3,27;put,3,27,0;get,2,21;put,2,21,0;get,3,13;put,3,13,0;get,2,16;put,2,16,0;so,3,peng;pen,3,16;put,3,28,0;get,2,12;put,2,13,0;get,3,7;put,3,7,0;get,2,26;put,2,26,0;so,3,hu;huI,3,26,0,1,0,0;over,放炮\n平胡  :5.0:0.0:0.0:-5.0,自摸\n平胡  :0.0:-10.0:-10.0:20.0,放炮\n平胡  :0.0:-5.0:5.0:0.0;0.0',20,10000,5,0,5,10005,'127.0.0.1',NULL,'2012-03-16 17:04:03'),(1015,'sooxin',1,1,'mahjong5','1331888352406','2012-03-16 17:04:03','vix!1!28.25.26.19.2.17.4.15.24.6.23.22.26.;sooxin!2!4.2.27.8.5.13.18.14.23.2.4.18.4.;ciy!3!6.24.14.13.7.29.28.25.13.29.28.3.16.;rgm!4!7.15.16.5.6.25.19.23.6.11.9.24.5.;beg,1331888352406,5,5;get,3,12;sd,4;sd,2;sd,1;din,1,15;din,4,23;din,2,23;sd,3;din,3,3;put,3,3,1;get,4,1;put,4,23,1;get,1,19;put,1,15,1;get,2,14;put,2,23,1;get,3,9;put,3,6,0;so,4,peng;pen,4,6;put,4,24,0;get,1,27;put,1,17,0;get,2,9;put,2,27,0;get,3,3;put,3,7,0;get,4,11;put,4,25,0;get,1,8;put,1,19,0;get,2,29;put,2,29,0;so,3,peng;pen,3,29;put,3,3,0;get,4,9;put,4,1,0;get,1,23;put,1,19,0;get,2,15;put,2,9,0;so,4,peng;pen,4,9;put,4,7,0;get,1,3;put,1,22,0;get,2,1;put,2,1,0;get,3,16;put,3,9,0;get,4,17;put,4,19,0;get,1,29;put,1,29,0;get,2,25;put,2,25,0;get,3,8;put,3,8,0;get,4,7;put,4,7,0;so,1,hu;huI,1,7,0,1,0,0;get,2,22;put,2,22,0;get,3,14;put,3,14,0;so,2,peng;pen,2,14;put,2,8,0;get,3,28;put,3,13,0;get,4,5;so,4,zihu;huI,4,5,1,0,0,0;get,2,21;put,2,21,0;get,3,8;put,3,8,0;get,2,1;put,2,1,0;get,3,24;put,3,24,0;get,2,1;put,2,1,0;get,3,11;put,3,11,0;get,2,12;put,2,15,0;get,3,27;put,3,27,0;get,2,21;put,2,21,0;get,3,13;put,3,13,0;get,2,16;put,2,16,0;so,3,peng;pen,3,16;put,3,28,0;get,2,12;put,2,13,0;get,3,7;put,3,7,0;get,2,26;put,2,26,0;so,3,hu;huI,3,26,0,1,0,0;over,放炮\n平胡  :5.0:0.0:0.0:-5.0,自摸\n平胡  :0.0:-10.0:-10.0:20.0,放炮\n平胡  :0.0:-5.0:5.0:0.0;0.0',20,10300,-15,0,-15,10285,'127.0.0.1',NULL,'2012-03-16 17:04:03'),(1016,'m001',1,1,'mahjong5','1331888352406','2012-03-16 17:04:03','vix!1!28.25.26.19.2.17.4.15.24.6.23.22.26.;sooxin!2!4.2.27.8.5.13.18.14.23.2.4.18.4.;ciy!3!6.24.14.13.7.29.28.25.13.29.28.3.16.;rgm!4!7.15.16.5.6.25.19.23.6.11.9.24.5.;beg,1331888352406,5,5;get,3,12;sd,4;sd,2;sd,1;din,1,15;din,4,23;din,2,23;sd,3;din,3,3;put,3,3,1;get,4,1;put,4,23,1;get,1,19;put,1,15,1;get,2,14;put,2,23,1;get,3,9;put,3,6,0;so,4,peng;pen,4,6;put,4,24,0;get,1,27;put,1,17,0;get,2,9;put,2,27,0;get,3,3;put,3,7,0;get,4,11;put,4,25,0;get,1,8;put,1,19,0;get,2,29;put,2,29,0;so,3,peng;pen,3,29;put,3,3,0;get,4,9;put,4,1,0;get,1,23;put,1,19,0;get,2,15;put,2,9,0;so,4,peng;pen,4,9;put,4,7,0;get,1,3;put,1,22,0;get,2,1;put,2,1,0;get,3,16;put,3,9,0;get,4,17;put,4,19,0;get,1,29;put,1,29,0;get,2,25;put,2,25,0;get,3,8;put,3,8,0;get,4,7;put,4,7,0;so,1,hu;huI,1,7,0,1,0,0;get,2,22;put,2,22,0;get,3,14;put,3,14,0;so,2,peng;pen,2,14;put,2,8,0;get,3,28;put,3,13,0;get,4,5;so,4,zihu;huI,4,5,1,0,0,0;get,2,21;put,2,21,0;get,3,8;put,3,8,0;get,2,1;put,2,1,0;get,3,24;put,3,24,0;get,2,1;put,2,1,0;get,3,11;put,3,11,0;get,2,12;put,2,15,0;get,3,27;put,3,27,0;get,2,21;put,2,21,0;get,3,13;put,3,13,0;get,2,16;put,2,16,0;so,3,peng;pen,3,16;put,3,28,0;get,2,12;put,2,13,0;get,3,7;put,3,7,0;get,2,26;put,2,26,0;so,3,hu;huI,3,26,0,1,0,0;over,放炮\n平胡  :5.0:0.0:0.0:-5.0,自摸\n平胡  :0.0:-10.0:-10.0:20.0,放炮\n平胡  :0.0:-5.0:5.0:0.0;0.0',20,10000,-5,0,-5,9995,'127.0.0.1',NULL,'2012-03-16 17:04:03'),(1017,'m002',1,1,'mahjong5','1331888352406','2012-03-16 17:04:04','vix!1!28.25.26.19.2.17.4.15.24.6.23.22.26.;sooxin!2!4.2.27.8.5.13.18.14.23.2.4.18.4.;ciy!3!6.24.14.13.7.29.28.25.13.29.28.3.16.;rgm!4!7.15.16.5.6.25.19.23.6.11.9.24.5.;beg,1331888352406,5,5;get,3,12;sd,4;sd,2;sd,1;din,1,15;din,4,23;din,2,23;sd,3;din,3,3;put,3,3,1;get,4,1;put,4,23,1;get,1,19;put,1,15,1;get,2,14;put,2,23,1;get,3,9;put,3,6,0;so,4,peng;pen,4,6;put,4,24,0;get,1,27;put,1,17,0;get,2,9;put,2,27,0;get,3,3;put,3,7,0;get,4,11;put,4,25,0;get,1,8;put,1,19,0;get,2,29;put,2,29,0;so,3,peng;pen,3,29;put,3,3,0;get,4,9;put,4,1,0;get,1,23;put,1,19,0;get,2,15;put,2,9,0;so,4,peng;pen,4,9;put,4,7,0;get,1,3;put,1,22,0;get,2,1;put,2,1,0;get,3,16;put,3,9,0;get,4,17;put,4,19,0;get,1,29;put,1,29,0;get,2,25;put,2,25,0;get,3,8;put,3,8,0;get,4,7;put,4,7,0;so,1,hu;huI,1,7,0,1,0,0;get,2,22;put,2,22,0;get,3,14;put,3,14,0;so,2,peng;pen,2,14;put,2,8,0;get,3,28;put,3,13,0;get,4,5;so,4,zihu;huI,4,5,1,0,0,0;get,2,21;put,2,21,0;get,3,8;put,3,8,0;get,2,1;put,2,1,0;get,3,24;put,3,24,0;get,2,1;put,2,1,0;get,3,11;put,3,11,0;get,2,12;put,2,15,0;get,3,27;put,3,27,0;get,2,21;put,2,21,0;get,3,13;put,3,13,0;get,2,16;put,2,16,0;so,3,peng;pen,3,16;put,3,28,0;get,2,12;put,2,13,0;get,3,7;put,3,7,0;get,2,26;put,2,26,0;so,3,hu;huI,3,26,0,1,0,0;over,放炮\n平胡  :5.0:0.0:0.0:-5.0,自摸\n平胡  :0.0:-10.0:-10.0:20.0,放炮\n平胡  :0.0:-5.0:5.0:0.0;0.0',20,10000,15,0,15,10015,'127.0.0.1',NULL,'2012-03-16 17:04:04');

/*Table structure for table `shangpin` */

DROP TABLE IF EXISTS `shangpin`;

CREATE TABLE `shangpin` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `shangpinName` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `introdunce` text,
  `imgurl` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shangpin` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
