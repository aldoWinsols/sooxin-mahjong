/*
SQLyog Enterprise - MySQL GUI v6.03
Host - 5.0.91-community-nt : Database - sooxin
*********************************************************************
Server version : 5.0.91-community-nt
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `sooxin`;

USE `sooxin`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `chongzhilog` */

DROP TABLE IF EXISTS `chongzhilog`;

CREATE TABLE `chongzhilog` (
  `ID` bigint(20) NOT NULL auto_increment,
  `playerName` varchar(50) default NULL,
  `chongzhiTime` datetime default NULL,
  `chongzhiMoney` double default NULL,
  `lastHaveMoney` double default NULL,
  `nowHaveMoney` double default NULL,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `chongzhilog` */

insert  into `chongzhilog`(`ID`,`playerName`,`chongzhiTime`,`chongzhiMoney`,`lastHaveMoney`,`nowHaveMoney`,`timestamp`) values (1,'sooxin','2012-03-16 00:00:00',67,567,567,NULL);

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `ID` int(11) NOT NULL auto_increment,
  `connectStr` varchar(50) default NULL COMMENT '连接地址',
  `connectType` varchar(50) default NULL COMMENT '连接类型',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `config` */

insert  into `config`(`ID`,`connectStr`,`connectType`) values (1,'rtmp://127.0.0.1/mahjongSyncServer5','mahjong5'),(2,'rtmp://127.0.0.1/mahjongSyncServer10','mahjong10'),(3,'rtmp://127.0.0.1/mahjongSyncServer20','mahjong20'),(4,'rtmp://127.0.0.1/mahjongSyncServer50','mahjong50'),(5,'rtmp://127.0.0.1/mahjongSyncServer100','mahjong100'),(6,'rtmp://127.0.0.1/mainSyncServer','main');

/*Table structure for table `duihuanlog` */

DROP TABLE IF EXISTS `duihuanlog`;

CREATE TABLE `duihuanlog` (
  `ID` bigint(20) NOT NULL auto_increment,
  `playerName` varchar(50) default NULL,
  `duihuanTime` datetime default NULL,
  `itemName` varchar(50) default NULL,
  `duihuanMoney` double default NULL,
  `lastHaveMoney` double default NULL,
  `nowHaveMoney` double default NULL,
  `contactName` varchar(10) default NULL,
  `contactTel` varchar(20) default NULL,
  `contactAddress` text,
  `state` int(11) default NULL,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `duihuanlog` */

insert  into `duihuanlog`(`ID`,`playerName`,`duihuanTime`,`itemName`,`duihuanMoney`,`lastHaveMoney`,`nowHaveMoney`,`contactName`,`contactTel`,`contactAddress`,`state`,`timestamp`) values (1,'sooxin','2012-03-16 00:00:00','标签',0,10285,10285,'5654','456','456',NULL,NULL),(2,'sooxin','2012-03-16 00:00:00','iPhone 4s 16G',0,10285,10285,'5654','456','456',NULL,NULL),(3,'sooxin','2012-03-22 10:46:36','iPhone 4s 16G',0,10285,10285,'ret','ert','ertret',NULL,'2012-03-22 10:46:36'),(21,'sooxin','2012-03-22 11:43:51','iPhone 4s 16G',7000,10000,3000,'wer','23435','345345',NULL,'2012-03-22 11:43:51'),(22,'sooxin','2012-03-22 11:52:16','iPhone 4s 16G',7000,10000,3000,'ert','ert','tryrty',NULL,'2012-03-22 11:52:16');

/*Table structure for table `gamehistory` */

DROP TABLE IF EXISTS `gamehistory`;

CREATE TABLE `gamehistory` (
  `ID` bigint(20) NOT NULL auto_increment,
  `playerName` varchar(50) default NULL,
  `lastMoney` double default NULL,
  `nowMoney` double default NULL,
  `gameContent` text,
  `timestamp` timestamp NULL default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gamehistory` */

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `ID` bigint(20) NOT NULL auto_increment,
  `noticeTime` datetime default NULL,
  `noticeContent` text,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `notice` */

insert  into `notice`(`ID`,`noticeTime`,`noticeContent`,`timestamp`) values (1,'2012-03-16 17:04:03','ertertert',NULL),(2,'2012-03-16 17:04:03','wrwerwerwrghgfhgf',NULL);

/*Table structure for table `player` */

DROP TABLE IF EXISTS `player`;

CREATE TABLE `player` (
  `ID` bigint(20) NOT NULL auto_increment,
  `playername` varchar(50) default NULL,
  `playerpwd` varchar(100) default NULL,
  `haveMoney` double default '0',
  `offlineGameNo` int(11) default NULL,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `player` */

insert  into `player`(`ID`,`playername`,`playerpwd`,`haveMoney`,`offlineGameNo`,`timestamp`) values (1,'sooxin','44a3abf7101da9dae304cc5d67f4f975',6100,0,'2012-03-22 16:55:05'),(2,'m001','44a3abf7101da9dae304cc5d67f4f975',1000440,0,'2012-03-22 21:25:41'),(3,'m002','44a3abf7101da9dae304cc5d67f4f975',1001050,0,'2012-03-22 21:25:41'),(4,'m003','44a3abf7101da9dae304cc5d67f4f975',999630,0,'2012-03-22 21:25:41'),(5,'123123','4297f44b13955235245b2497399d7a93',27280,0,'2012-03-22 21:25:41');

/*Table structure for table `playlog` */

DROP TABLE IF EXISTS `playlog`;

CREATE TABLE `playlog` (
  `ID` bigint(20) NOT NULL auto_increment,
  `playerName` varchar(20) collate utf8_unicode_ci NOT NULL COMMENT '會員名稱',
  `gameClass` int(11) NOT NULL COMMENT '遊戲類型-參考master_code表',
  `gameSubClass` int(11) NOT NULL,
  `gameName` varchar(20) collate utf8_unicode_ci NOT NULL COMMENT '遊戲名稱',
  `gameNo` varchar(50) collate utf8_unicode_ci NOT NULL COMMENT '遊戲局號',
  `gameTime` datetime NOT NULL COMMENT '遊戲時間',
  `gameContent` text collate utf8_unicode_ci NOT NULL COMMENT '遊戲內容',
  `allTouZhuMoney` double NOT NULL COMMENT '總投注',
  `preMoney` double NOT NULL default '0' COMMENT '起始點數',
  `winLossMoneyBeforeTax` double NOT NULL COMMENT '輸贏點數-稅前',
  `gameTaxaction` double NOT NULL COMMENT '棋牌時為公點(交稅);電玩時為總洗碼金',
  `winLossMoneyAfterTax` double NOT NULL COMMENT '輪贏點數-稅後',
  `afterMoney` double NOT NULL default '0' COMMENT '結束點數',
  `gameIp` varchar(50) collate utf8_unicode_ci NOT NULL COMMENT '游戏ip',
  `remarks` varchar(500) collate utf8_unicode_ci default NULL,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`),
  KEY `play_log_playerName_gameTime` (`playerName`(10),`gameTime`)
) ENGINE=InnoDB AUTO_INCREMENT=1078 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='遊戲記錄';

/*Data for the table `playlog` */

insert  into `playlog`(`ID`,`playerName`,`gameClass`,`gameSubClass`,`gameName`,`gameNo`,`gameTime`,`gameContent`,`allTouZhuMoney`,`preMoney`,`winLossMoneyBeforeTax`,`gameTaxaction`,`winLossMoneyAfterTax`,`afterMoney`,`gameIp`,`remarks`,`timestamp`) values (1074,'m002',1,50,'mahjong50','1332430145573','2012-03-22 23:37:17','rbg!1!18.22.6.23.13.2.23.5.18.22.5.21.22.;123123!2!11.3.12.6.15.11.25.24.1.19.7.5.6.;sot!3!4.13.18.13.29.4.25.3.19.15.9.19.3.;hai!4!17.11.4.12.27.16.18.14.28.28.26.12.2.;beg,1332430145573,3,50;get,3,55,24;sd,4;sd,2;sd,1;din,4,2;din,1,13;din,2,24;sd,3;din,3,24;put,3,24,1;get,4,54,5;put,4,2,1;get,1,53,24;put,1,13,1;so,3,peng;pen,3,13;put,3,25,0;get,4,52,29;put,4,4,0;so,3,peng;pen,3,4;put,3,29,0;get,4,51,9;put,4,5,0;so,1,peng;pen,1,5;put,1,18,0;get,2,50,4;put,2,24,1;get,3,49,28;put,3,28,0;get,4,48,17;put,4,9,0;get,1,47,12;put,1,18,0;get,2,46,8;put,2,25,0;get,3,45,26;put,3,26,0;get,4,44,1;put,4,1,0;get,1,43,23;put,1,12,0;so,4,peng;pen,4,12;put,4,11,0;so,2,peng;get,1,42,23;so,1,zigang;gan,1,23,1;get,1,41,7;put,1,2,0;get,2,40,24;put,2,24,0;get,3,39,21;put,3,21,0;get,4,38,25;put,4,14,0;get,1,37,29;put,1,21,0;get,2,36,16;put,2,16,0;get,3,35,17;put,3,9,0;get,4,34,29;put,4,17,0;get,1,33,15;put,1,15,0;get,2,32,27;put,2,27,0;get,3,31,9;put,3,9,0;get,4,30,17;put,4,17,0;get,1,29,8;put,1,29,0;so,4,hu,peng;huI,4,29,0,1,0,0;get,1,28,13;put,1,13,0;get,2,27,8;put,2,8,0;get,3,26,11;put,3,11,0;so,2,peng;get,1,25,6;put,1,24,0;get,2,24,27;put,2,27,0;get,3,23,14;put,3,19,0;get,1,22,2;put,1,2,0;get,2,21,16;put,2,16,0;so,3,hu;huI,3,16,0,1,0,0;get,1,20,16;put,1,16,0;get,2,19,8;put,2,19,0;get,1,18,26;put,1,26,0;get,2,17,21;put,2,21,0;get,1,16,1;put,1,1,0;get,2,15,28;put,2,28,0;get,1,14,2;put,1,2,0;get,2,13,22;put,2,22,0;so,1,gang,peng;gan,1,22,0;get,1,12,27;put,1,27,0;get,2,11,25;put,2,25,0;get,1,10,21;put,1,21,0;get,2,9,3;put,2,15,0;get,1,8,7;put,1,7,0;get,2,7,14;put,2,12,0;get,1,6,7;put,1,7,0;get,2,5,19;put,2,14,0;get,1,4,14;put,1,14,0;get,2,3,9;put,2,19,0;get,1,2,1;put,1,1,0;get,2,1,26;put,2,26,0;get,1,0,15;put,1,15,0;over,??:300.0:-100.0:-100.0:-100.0,??\n??  :-50.0:0.0:0.0:50.0,??\n??  :0.0:-50.0:50.0:0.0,??:100.0:-100.0:0.0:0.0,??:200.0:-200.0:0.0:0.0;0.0',550,1000500,550,0,550,1001050,'127.0.0.1',NULL,'2012-03-22 23:37:17'),(1075,'123123',1,50,'mahjong50','1332430145573','2012-03-22 23:37:17','rbg!1!18.22.6.23.13.2.23.5.18.22.5.21.22.;123123!2!11.3.12.6.15.11.25.24.1.19.7.5.6.;sot!3!4.13.18.13.29.4.25.3.19.15.9.19.3.;hai!4!17.11.4.12.27.16.18.14.28.28.26.12.2.;beg,1332430145573,3,50;get,3,55,24;sd,4;sd,2;sd,1;din,4,2;din,1,13;din,2,24;sd,3;din,3,24;put,3,24,1;get,4,54,5;put,4,2,1;get,1,53,24;put,1,13,1;so,3,peng;pen,3,13;put,3,25,0;get,4,52,29;put,4,4,0;so,3,peng;pen,3,4;put,3,29,0;get,4,51,9;put,4,5,0;so,1,peng;pen,1,5;put,1,18,0;get,2,50,4;put,2,24,1;get,3,49,28;put,3,28,0;get,4,48,17;put,4,9,0;get,1,47,12;put,1,18,0;get,2,46,8;put,2,25,0;get,3,45,26;put,3,26,0;get,4,44,1;put,4,1,0;get,1,43,23;put,1,12,0;so,4,peng;pen,4,12;put,4,11,0;so,2,peng;get,1,42,23;so,1,zigang;gan,1,23,1;get,1,41,7;put,1,2,0;get,2,40,24;put,2,24,0;get,3,39,21;put,3,21,0;get,4,38,25;put,4,14,0;get,1,37,29;put,1,21,0;get,2,36,16;put,2,16,0;get,3,35,17;put,3,9,0;get,4,34,29;put,4,17,0;get,1,33,15;put,1,15,0;get,2,32,27;put,2,27,0;get,3,31,9;put,3,9,0;get,4,30,17;put,4,17,0;get,1,29,8;put,1,29,0;so,4,hu,peng;huI,4,29,0,1,0,0;get,1,28,13;put,1,13,0;get,2,27,8;put,2,8,0;get,3,26,11;put,3,11,0;so,2,peng;get,1,25,6;put,1,24,0;get,2,24,27;put,2,27,0;get,3,23,14;put,3,19,0;get,1,22,2;put,1,2,0;get,2,21,16;put,2,16,0;so,3,hu;huI,3,16,0,1,0,0;get,1,20,16;put,1,16,0;get,2,19,8;put,2,19,0;get,1,18,26;put,1,26,0;get,2,17,21;put,2,21,0;get,1,16,1;put,1,1,0;get,2,15,28;put,2,28,0;get,1,14,2;put,1,2,0;get,2,13,22;put,2,22,0;so,1,gang,peng;gan,1,22,0;get,1,12,27;put,1,27,0;get,2,11,25;put,2,25,0;get,1,10,21;put,1,21,0;get,2,9,3;put,2,15,0;get,1,8,7;put,1,7,0;get,2,7,14;put,2,12,0;get,1,6,7;put,1,7,0;get,2,5,19;put,2,14,0;get,1,4,14;put,1,14,0;get,2,3,9;put,2,19,0;get,1,2,1;put,1,1,0;get,2,1,26;put,2,26,0;get,1,0,15;put,1,15,0;over,??:300.0:-100.0:-100.0:-100.0,??\n??  :-50.0:0.0:0.0:50.0,??\n??  :0.0:-50.0:50.0:0.0,??:100.0:-100.0:0.0:0.0,??:200.0:-200.0:0.0:0.0;0.0',550,27730,-450,0,-450,27280,'127.0.0.1',NULL,'2012-03-22 23:37:17'),(1076,'m001',1,50,'mahjong50','1332430145573','2012-03-22 23:37:17','rbg!1!18.22.6.23.13.2.23.5.18.22.5.21.22.;123123!2!11.3.12.6.15.11.25.24.1.19.7.5.6.;sot!3!4.13.18.13.29.4.25.3.19.15.9.19.3.;hai!4!17.11.4.12.27.16.18.14.28.28.26.12.2.;beg,1332430145573,3,50;get,3,55,24;sd,4;sd,2;sd,1;din,4,2;din,1,13;din,2,24;sd,3;din,3,24;put,3,24,1;get,4,54,5;put,4,2,1;get,1,53,24;put,1,13,1;so,3,peng;pen,3,13;put,3,25,0;get,4,52,29;put,4,4,0;so,3,peng;pen,3,4;put,3,29,0;get,4,51,9;put,4,5,0;so,1,peng;pen,1,5;put,1,18,0;get,2,50,4;put,2,24,1;get,3,49,28;put,3,28,0;get,4,48,17;put,4,9,0;get,1,47,12;put,1,18,0;get,2,46,8;put,2,25,0;get,3,45,26;put,3,26,0;get,4,44,1;put,4,1,0;get,1,43,23;put,1,12,0;so,4,peng;pen,4,12;put,4,11,0;so,2,peng;get,1,42,23;so,1,zigang;gan,1,23,1;get,1,41,7;put,1,2,0;get,2,40,24;put,2,24,0;get,3,39,21;put,3,21,0;get,4,38,25;put,4,14,0;get,1,37,29;put,1,21,0;get,2,36,16;put,2,16,0;get,3,35,17;put,3,9,0;get,4,34,29;put,4,17,0;get,1,33,15;put,1,15,0;get,2,32,27;put,2,27,0;get,3,31,9;put,3,9,0;get,4,30,17;put,4,17,0;get,1,29,8;put,1,29,0;so,4,hu,peng;huI,4,29,0,1,0,0;get,1,28,13;put,1,13,0;get,2,27,8;put,2,8,0;get,3,26,11;put,3,11,0;so,2,peng;get,1,25,6;put,1,24,0;get,2,24,27;put,2,27,0;get,3,23,14;put,3,19,0;get,1,22,2;put,1,2,0;get,2,21,16;put,2,16,0;so,3,hu;huI,3,16,0,1,0,0;get,1,20,16;put,1,16,0;get,2,19,8;put,2,19,0;get,1,18,26;put,1,26,0;get,2,17,21;put,2,21,0;get,1,16,1;put,1,1,0;get,2,15,28;put,2,28,0;get,1,14,2;put,1,2,0;get,2,13,22;put,2,22,0;so,1,gang,peng;gan,1,22,0;get,1,12,27;put,1,27,0;get,2,11,25;put,2,25,0;get,1,10,21;put,1,21,0;get,2,9,3;put,2,15,0;get,1,8,7;put,1,7,0;get,2,7,14;put,2,12,0;get,1,6,7;put,1,7,0;get,2,5,19;put,2,14,0;get,1,4,14;put,1,14,0;get,2,3,9;put,2,19,0;get,1,2,1;put,1,1,0;get,2,1,26;put,2,26,0;get,1,0,15;put,1,15,0;over,??:300.0:-100.0:-100.0:-100.0,??\n??  :-50.0:0.0:0.0:50.0,??\n??  :0.0:-50.0:50.0:0.0,??:100.0:-100.0:0.0:0.0,??:200.0:-200.0:0.0:0.0;0.0',550,1000490,-50,0,-50,1000440,'127.0.0.1',NULL,'2012-03-22 23:37:17'),(1077,'m003',1,50,'mahjong50','1332430145573','2012-03-22 23:37:17','rbg!1!18.22.6.23.13.2.23.5.18.22.5.21.22.;123123!2!11.3.12.6.15.11.25.24.1.19.7.5.6.;sot!3!4.13.18.13.29.4.25.3.19.15.9.19.3.;hai!4!17.11.4.12.27.16.18.14.28.28.26.12.2.;beg,1332430145573,3,50;get,3,55,24;sd,4;sd,2;sd,1;din,4,2;din,1,13;din,2,24;sd,3;din,3,24;put,3,24,1;get,4,54,5;put,4,2,1;get,1,53,24;put,1,13,1;so,3,peng;pen,3,13;put,3,25,0;get,4,52,29;put,4,4,0;so,3,peng;pen,3,4;put,3,29,0;get,4,51,9;put,4,5,0;so,1,peng;pen,1,5;put,1,18,0;get,2,50,4;put,2,24,1;get,3,49,28;put,3,28,0;get,4,48,17;put,4,9,0;get,1,47,12;put,1,18,0;get,2,46,8;put,2,25,0;get,3,45,26;put,3,26,0;get,4,44,1;put,4,1,0;get,1,43,23;put,1,12,0;so,4,peng;pen,4,12;put,4,11,0;so,2,peng;get,1,42,23;so,1,zigang;gan,1,23,1;get,1,41,7;put,1,2,0;get,2,40,24;put,2,24,0;get,3,39,21;put,3,21,0;get,4,38,25;put,4,14,0;get,1,37,29;put,1,21,0;get,2,36,16;put,2,16,0;get,3,35,17;put,3,9,0;get,4,34,29;put,4,17,0;get,1,33,15;put,1,15,0;get,2,32,27;put,2,27,0;get,3,31,9;put,3,9,0;get,4,30,17;put,4,17,0;get,1,29,8;put,1,29,0;so,4,hu,peng;huI,4,29,0,1,0,0;get,1,28,13;put,1,13,0;get,2,27,8;put,2,8,0;get,3,26,11;put,3,11,0;so,2,peng;get,1,25,6;put,1,24,0;get,2,24,27;put,2,27,0;get,3,23,14;put,3,19,0;get,1,22,2;put,1,2,0;get,2,21,16;put,2,16,0;so,3,hu;huI,3,16,0,1,0,0;get,1,20,16;put,1,16,0;get,2,19,8;put,2,19,0;get,1,18,26;put,1,26,0;get,2,17,21;put,2,21,0;get,1,16,1;put,1,1,0;get,2,15,28;put,2,28,0;get,1,14,2;put,1,2,0;get,2,13,22;put,2,22,0;so,1,gang,peng;gan,1,22,0;get,1,12,27;put,1,27,0;get,2,11,25;put,2,25,0;get,1,10,21;put,1,21,0;get,2,9,3;put,2,15,0;get,1,8,7;put,1,7,0;get,2,7,14;put,2,12,0;get,1,6,7;put,1,7,0;get,2,5,19;put,2,14,0;get,1,4,14;put,1,14,0;get,2,3,9;put,2,19,0;get,1,2,1;put,1,1,0;get,2,1,26;put,2,26,0;get,1,0,15;put,1,15,0;over,??:300.0:-100.0:-100.0:-100.0,??\n??  :-50.0:0.0:0.0:50.0,??\n??  :0.0:-50.0:50.0:0.0,??:100.0:-100.0:0.0:0.0,??:200.0:-200.0:0.0:0.0;0.0',550,999680,-50,0,-50,999630,'127.0.0.1',NULL,'2012-03-22 23:37:17');

/*Table structure for table `shangpin` */

DROP TABLE IF EXISTS `shangpin`;

CREATE TABLE `shangpin` (
  `ID` bigint(20) NOT NULL auto_increment,
  `shangpinName` varchar(100) default NULL,
  `price` double default NULL,
  `introdunce` text,
  `imgurl` varchar(50) default NULL,
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shangpin` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
