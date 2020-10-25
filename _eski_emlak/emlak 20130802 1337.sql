-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.28-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema emlak
--

CREATE DATABASE IF NOT EXISTS emlak;
USE emlak;

--
-- Definition of table `elmah_error`
--

DROP TABLE IF EXISTS `elmah_error`;
CREATE TABLE `elmah_error` (
  `ErrorId` char(36) NOT NULL,
  `Application` varchar(60) NOT NULL,
  `Host` varchar(50) NOT NULL,
  `Type` varchar(100) NOT NULL,
  `Source` varchar(60) NOT NULL,
  `Message` varchar(500) NOT NULL,
  `User` varchar(50) NOT NULL,
  `StatusCode` int(10) NOT NULL,
  `TimeUtc` datetime NOT NULL,
  `Sequence` int(10) NOT NULL AUTO_INCREMENT,
  `AllXml` text NOT NULL,
  PRIMARY KEY (`Sequence`),
  UNIQUE KEY `IX_ErrorId` (`ErrorId`(8)),
  KEY `IX_ELMAH_Error_App_Time_Seql` (`Application`(10),`TimeUtc`,`Sequence`),
  KEY `IX_ErrorId_App` (`ErrorId`(8),`Application`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `elmah_error`
--

/*!40000 ALTER TABLE `elmah_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `elmah_error` ENABLE KEYS */;


--
-- Definition of table `haber`
--

DROP TABLE IF EXISTS `haber`;
CREATE TABLE `haber` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Baslik` varchar(255) DEFAULT NULL,
  `Ozet` text,
  `Detay` text,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EkleyenID` (`EkleyenID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  KEY `ID` (`ID`),
  KEY `Onay` (`Onay`),
  CONSTRAINT `haber_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `haber_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `haber`
--

/*!40000 ALTER TABLE `haber` DISABLE KEYS */;
/*!40000 ALTER TABLE `haber` ENABLE KEYS */;


--
-- Definition of table `ilan`
--

DROP TABLE IF EXISTS `ilan`;
CREATE TABLE `ilan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KatID` int(11) DEFAULT NULL,
  `IlanTur` varchar(255) DEFAULT NULL,
  `Kod` varchar(255) DEFAULT NULL,
  `Baslik` text,
  `Fiyat` int(11) DEFAULT NULL,
  `FiyatTur` varchar(255) DEFAULT NULL,
  `IlanSure` int(11) DEFAULT NULL,
  `Il` int(11) DEFAULT NULL,
  `Ilce` int(11) DEFAULT NULL,
  `Semt` int(11) DEFAULT NULL,
  `Mevki` varchar(255) DEFAULT NULL,
  `Adres` text,
  `AdresGoster` int(11) DEFAULT NULL,
  `Ozellik` text,
  `Vitrin` int(11) DEFAULT NULL,
  `Arsiv` int(11) DEFAULT NULL,
  `Koordinat` varchar(255) DEFAULT NULL,
  `Satis` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `KatID` (`KatID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `ilan_ibfk_2` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `ilan_ibfk_1` FOREIGN KEY (`KatID`) REFERENCES `kategori` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ibfk_2` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ibfk_3` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan`
--

/*!40000 ALTER TABLE `ilan` DISABLE KEYS */;
INSERT INTO `ilan` (`ID`,`KatID`,`IlanTur`,`Kod`,`Baslik`,`Fiyat`,`FiyatTur`,`IlanSure`,`Il`,`Ilce`,`Semt`,`Mevki`,`Adres`,`AdresGoster`,`Ozellik`,`Vitrin`,`Arsiv`,`Koordinat`,`Satis`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,1,'Satılık','32-0001','Satılık 240 mt2 süper lüx apartman dairesi',150000,'TL',60,1,7,2,'','',0,'8,9,10,11,16,17,18,19,20,24,25,26,27,28,32,33,34,35,36,40,41,42,43,44,50,51,54,55,56,57,58,59,60,62,63,64,65,70,71,72,74,75,78,79,80,82,83,86,87',1,0,'36.84897665004891, 30.761087552436834',0,1,'2012-02-10 15:55:45','2012-03-09 11:16:58',1,NULL),
 (2,1,'Kiralık','32-0002','Satılık 240 mt2 4+1 apartman dairesi',800,'TL',60,1,7,3,'','Bağlar Mh. 215 Sk. No:3',1,'8,9,10,11,16,17,18,19,20,24,25,26,27,28,32,33,34,35,36,40,41,42,43,44,50,51,54,55,56,57,58,59,60,62,63,64,65,70,71,72,74,75,78,79,80,82,83,86,87',1,0,'36.84452927376792, 31.094577328094488',0,1,'2012-02-10 16:02:14','2012-03-13 13:33:17',1,1),
 (10,2,'Kiralık','32-0010','Kurtuluş&#39;da L&#252;x Ofis',700,'TL',30,1,7,29,'','',0,'8,9,10,11,16,17,18,19,20,24,25,26,27,28,32,33,34,35,36,40,41,42,43,44,50,51,54,55,56,57,58,59,60,62,63,64,65,70,71,72,74,75,78,79,80,82,83,86,87',1,0,'36.84782619527471, 30.765813604721075',0,1,'2012-03-06 17:17:58','2012-03-24 01:48:25',1,1);
/*!40000 ALTER TABLE `ilan` ENABLE KEYS */;


--
-- Definition of table `ilan_degisken`
--

DROP TABLE IF EXISTS `ilan_degisken`;
CREATE TABLE `ilan_degisken` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UstID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Değer` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UstID` (`UstID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `ilan_degisken_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_degisken_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_degisken`
--

/*!40000 ALTER TABLE `ilan_degisken` DISABLE KEYS */;
INSERT INTO `ilan_degisken` (`ID`,`UstID`,`Baslik`,`Değer`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,0,'Para Birimi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (2,1,'TL','TL',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (3,1,'EUR','EUR',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (4,1,'USD','USD',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (5,1,'GBP','GBP',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (6,0,'İlan Süresi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (7,6,'1 Hafta','7',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (8,6,'2 Hafta','14',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (9,6,'3 Hafta','21',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (10,6,'1 Ay','30',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (11,6,'2 Ay','60',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (12,6,'3 Ay','90',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (13,0,'Bulunduğu Kat',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (14,13,'Kot 2','Kot 2',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (15,13,'Kot 1','Kot 1',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (16,13,'Bodrum','Bodrum',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (17,13,'Yarı Bodrum','Yarı Bodrum',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (18,13,'Zemin','Zemin',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (19,13,'Bodrum ve Zemin','Bodrum ve Zemin',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (20,13,'Bahçe Katı','Bahçe Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (21,13,'Giriş Katı','Giriş Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (22,13,'Yüksek Giriş','Yüksek Giriş',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (23,13,'Villa Katı','Villa Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (24,13,'Asma Kat','Asma Kat',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (25,13,'Çatı Katı','Çatı Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (26,13,'Teras Katı','Teras Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (27,13,'En Üst Kat','En Üst Kat',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (28,13,'1','1',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (29,13,'2','2',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (30,13,'3','3',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (31,13,'4','4',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (32,13,'5','5',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (33,13,'6','6',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (34,13,'7','7',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (35,13,'8','8',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (36,13,'9','9',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (37,13,'10','10',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (38,13,'11','11',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (39,13,'12','12',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (40,13,'13','13',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (41,13,'14','14',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (42,13,'15','15',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (43,13,'16','16',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (44,13,'17','17',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (45,13,'18','18',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (46,13,'19','19',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (47,13,'20','20',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (48,13,'21','21',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (49,13,'21 ve üzeri','21 ve üzeri',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (50,0,'Isınma Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (51,50,'Güneş Enerjisi','Güneş Enerjisi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (52,50,'Kat Kaloriferi','Kat Kaloriferi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (53,50,'Klima','Klima',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (54,50,'Kombi','Kombi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (55,50,'Merkezi','Merkezi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (56,50,'Soba','Soba',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (57,50,'Jeotermal Isıtma','Jeotermal Isıtma',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (58,50,'Yok','Yok',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (59,50,'Belirtilmemiş','Belirtilmemiş',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (60,0,'Yakıt Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (61,60,'Doğalgaz','Doğalgaz',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (62,60,'Kömür-Odun','Kömür-Odun',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (63,60,'Akaryakıt','Akaryakıt',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (64,60,'Elektrik','Elektrik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (65,0,'Yapı Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (66,65,'Ahşap','Ahşap',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (67,65,'Betonarme','Betonarme',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (68,65,'Çelik','Çelik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (69,65,'Kagir','Kagir',1,'2012-02-24 07:00:00','2012-02-28 17:18:03',1,1),
 (70,65,'Kütük','Kütük',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (71,65,'Prefabrik','Prefabrik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (72,65,'Taş Bina','Taş Bina',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (73,65,'Yığma','Yığma',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (74,0,'Yapının Durumu',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (75,74,'Sıfır','Sıfır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (76,74,'İkinci El','İkinci El',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (77,74,'Yapım Aşamasında','Yapım Aşamasında',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (78,0,'Kullanım Durumu',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (79,78,'Boş','Boş',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (80,78,'Kiracı Oturuyor','Kiracı Oturuyor',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (81,78,'Ev Sahibi Oturuyor','Ev Sahibi Oturuyor',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (82,0,'Tapu Durumu',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (83,82,'Arsa','Arsa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (84,82,'Kat İrtifakı','Kat İrtifakı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (85,82,'Kat Mülkiyeti','Kat Mülkiyeti',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (86,0,'Krediye Uygunluk',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (87,86,'Bilinmiyor','Bilinmiyor',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (88,86,'Uygun','Uygun',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (89,86,'Uygun Değil','Uygun Değil',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (90,0,'Öğrenciye/Bekara Uygun',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (91,90,'Evet','Evet',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (92,90,'Hayır','Hayır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (93,0,'Takas',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (94,93,'Yapılır','Yapılır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (95,93,'Yapılmaz','Yapılmaz',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (96,0,'Devre',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (97,96,'Ocak','Ocak',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (98,96,'Şubat','Şubat',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (99,96,'Mart','Mart',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (100,96,'Nisan','Nisan',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (101,96,'Mayıs','Mayıs',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (102,96,'Haziran','Haziran',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (103,96,'Temmuz','Temmuz',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (104,96,'Ağustos','Ağustos',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (105,96,'Eylül','Eylül',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (106,96,'Ekim','Ekim',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (107,96,'Kasım','Kasım',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (108,96,'Aralık','Aralık',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (109,0,'Devren',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (110,109,'Evet','Evet',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (111,109,'Hayır','Hayır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (112,0,'Kat Karşılığı',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (113,112,'Evet','Evet',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (114,112,'Hayır','Hayır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (115,0,'Tapu Durumu (Arsa)',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (116,115,'Hisseli Tapu','Hisseli Tapu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (117,115,'Müstakil Parsel','Müstakil Parsel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (118,115,'Tahsis','Tahsis',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (119,115,'Zilliyet','Zilliyet',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (120,115,'Bilinmiyor','Bilinmiyor',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (121,0,'İskan Durumu',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (122,121,'İskan Alınmış','İskan Alınmış',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (123,121,'İskan Alınmamış','İskan Alınmamış',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (124,0,'Yıldız Sayısı',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (125,124,'5 Yıldız','5 Yıldız',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (126,124,'4 Yıldız','4 Yıldız',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (127,124,'3 Yıldız','3 Yıldız',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (128,124,'2 Yıldız','2 Yıldız',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (129,124,'1 Yıldız','1 Yıldız',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (130,124,'1. Sınıf TK','1. Sınıf TK',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (131,124,'2. Sınıf TK','2. Sınıf TK',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (132,124,'Özel Belgeli','Özel Belgeli',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (133,124,'Diğer','Diğer',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (134,0,'Konut Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (135,134,'Apartman Dairesi','Apartman Dairesi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (136,134,'Çiftlik Evi','Çiftlik Evi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (137,134,'Dağ Evi','Dağ Evi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (138,134,'Komple Bina','Komple Bina',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (139,134,'Kooperatif','Kooperatif',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (140,134,'Köşk','Köşk',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (141,134,'Köy Evi','Köy Evi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (142,134,'Müstakil Ev','Müstakil Ev',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (143,134,'Residence','Residence',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (144,134,'Villa','Villa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (145,134,'Yalı','Yalı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (146,134,'Yalı Dairesi','Yalı Dairesi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (147,134,'Yazlık','Yazlık',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (148,0,'Konut Şekli',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (149,148,'Bahçe Dubleksi','Bahçe Dubleksi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (150,148,'Bahçe Katı','Bahçe Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (151,148,'Çatı Dubleksi','Çatı Dubleksi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (152,148,'Daire','Daire',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (153,148,'Dubleks','Dubleks',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (154,148,'İkiz Ev','İkiz Ev',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (155,148,'Müstakil Ev','Müstakil Ev',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (156,148,'Tripleks','Tripleks',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (157,148,'Fourlex','Fourlex',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (158,0,'Devremülk Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (159,158,'Apartman Dairesi','Apartman Dairesi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (160,158,'Villa','Villa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (161,158,'Dublex','Dublex',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (162,158,'Triplex','Triplex',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (163,158,'Bungalov','Bungalov',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (164,0,'Cephe Seçenekleri',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (165,164,'Kuzey Cephe','Kuzey Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (166,164,'Güney Cephe','Güney Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (167,164,'Doğu Cephe','Doğu Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (168,164,'Batı Cephe','Batı Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (169,0,'İş Yeri Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (170,169,'Apartman Dairesi','Apartman Dairesi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (171,169,'Atölye','Atölye',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (172,169,'Benzin İstasyonu','Benzin İstasyonu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (173,169,'Bina','Bina',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (174,169,'Depo','Depo',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (175,169,'Dükkan','Dükkan',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (176,169,'Fabrika','Fabrika',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (177,169,'Genel','Genel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (178,169,'Hastane','Hastane',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (179,169,'İş Hanı','İş Hanı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (180,169,'İş Hanı Katı','İş Hanı Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (181,169,'Komple Bina','Komple Bina',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (182,169,'Mağaza','Mağaza',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (183,169,'Ofis','Ofis',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (184,169,'Plaza','Plaza',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (185,169,'Plaza Katı','Plaza Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (186,169,'Villa','Villa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (187,169,'Villa Katı','Villa Katı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (188,169,'Turistik İşletme','Turistik İşletme',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (189,0,'Arsa Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (190,189,'Bağ','Bağ',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (191,189,'Bahçe','Bahçe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (192,189,'Çiftlik','Çiftlik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (193,189,'Depo, Antrepo İzinli','Depo, Antrepo İzinli',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (194,189,'Hastane (Sağlık Tesisi)','Hastane (Sağlık Tesisi)',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (195,189,'İmarlı - Konut','İmarlı - Konut',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (196,189,'İmarlı - Sanayi','İmarlı - Sanayi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (197,189,'İmarlı - Ticari','İmarlı - Ticari',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (198,189,'Konut+Ticaret','Konut+Ticaret',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (199,189,'Maden Ocağı','Maden Ocağı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (200,189,'Muhtelif Arsa','Muhtelif Arsa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (201,189,'Okul (Eğitim Tesisi)','Okul (Eğitim Tesisi)',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (202,189,'Özel Kullanım','Özel Kullanım',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (203,189,'Sit Alanı','Sit Alanı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (204,189,'Tarla','Tarla',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (205,189,'Toplu Konut için Tahsis','Toplu Konut için Tahsis',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (206,189,'Turistik Arsa','Turistik Arsa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (207,189,'Zeytinlik','Zeytinlik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (208,0,'Tesis Tipi',NULL,1,'2012-02-24 07:00:00',NULL,1,NULL),
 (209,208,'Apart','Apart',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (210,208,'Butik Otel','Butik Otel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (211,208,'Kaplıca Tesisi','Kaplıca Tesisi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (212,208,'Mocamp','Mocamp',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (213,208,'Motel','Motel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (214,208,'Otel','Otel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (215,208,'Pansiyon','Pansiyon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (216,208,'Tatil Köyü','Tatil Köyü',1,'2012-02-24 07:00:00',NULL,1,NULL);
/*!40000 ALTER TABLE `ilan_degisken` ENABLE KEYS */;


--
-- Definition of table `ilan_detay`
--

DROP TABLE IF EXISTS `ilan_detay`;
CREATE TABLE `ilan_detay` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IlanID` int(11) DEFAULT NULL,
  `SabitID` int(11) DEFAULT NULL,
  `Deger` varchar(255) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `ilan_detay_ibfk_1` (`IlanID`),
  KEY `ilan_detay_ibfk_2` (`SabitID`),
  KEY `EkleyenID` (`EkleyenID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  CONSTRAINT `ilan_detay_ibfk_1` FOREIGN KEY (`IlanID`) REFERENCES `ilan` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ilan_detay_ibfk_2` FOREIGN KEY (`SabitID`) REFERENCES `ilan_sabit` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ilan_detay_ibfk_3` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ilan_detay_ibfk_4` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_detay`
--

/*!40000 ALTER TABLE `ilan_detay` DISABLE KEYS */;
INSERT INTO `ilan_detay` (`ID`,`IlanID`,`SabitID`,`Deger`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (116,1,1,'Apartman Dairesi',NULL,NULL,NULL,NULL),
 (117,1,2,'Daire',NULL,NULL,NULL,NULL),
 (118,1,3,'4',NULL,NULL,NULL,NULL),
 (119,1,4,'2',NULL,NULL,NULL,NULL),
 (120,1,5,'2',NULL,NULL,NULL,NULL),
 (121,1,6,'240',NULL,NULL,NULL,NULL),
 (122,1,8,'4',NULL,NULL,NULL,NULL),
 (123,1,9,'3',NULL,NULL,NULL,NULL),
 (124,1,10,'Klima',NULL,NULL,NULL,NULL),
 (125,1,11,'Elektrik',NULL,NULL,NULL,NULL),
 (126,1,12,'Sıfır',NULL,NULL,NULL,NULL),
 (127,1,13,'Boş',NULL,NULL,NULL,NULL),
 (128,1,18,'Hayır',NULL,NULL,NULL,NULL),
 (129,1,19,'Kuzey Cephe',NULL,NULL,NULL,NULL),
 (412,2,1,'Apartman Dairesi','2012-03-13 13:33:22',NULL,1,NULL),
 (413,2,2,'Daire','2012-03-13 13:33:22',NULL,1,NULL),
 (414,2,3,'4','2012-03-13 13:33:22',NULL,1,NULL),
 (415,2,4,'1','2012-03-13 13:33:22',NULL,1,NULL),
 (416,2,5,'2','2012-03-13 13:33:22',NULL,1,NULL),
 (417,2,6,'240','2012-03-13 13:33:22',NULL,1,NULL),
 (418,2,7,'4','2012-03-13 13:33:23',NULL,1,NULL),
 (419,2,8,'5','2012-03-13 13:33:23',NULL,1,NULL),
 (420,2,9,'3','2012-03-13 13:33:23',NULL,1,NULL),
 (421,2,10,'Kat Kaloriferi','2012-03-13 13:33:23',NULL,1,NULL),
 (422,2,11,'Doğalgaz','2012-03-13 13:33:23',NULL,1,NULL),
 (423,2,12,'İkinci El','2012-03-13 13:33:23',NULL,1,NULL),
 (424,2,13,'Boş','2012-03-13 13:33:23',NULL,1,NULL),
 (425,2,18,'Hayır','2012-03-13 13:33:23',NULL,1,NULL),
 (426,2,19,'Batı Cephe','2012-03-13 13:33:23',NULL,1,NULL),
 (443,10,25,'Plaza Katı','2012-03-24 01:40:48',NULL,1,NULL),
 (444,10,3,'7','2012-03-24 01:40:48',NULL,1,NULL),
 (445,10,6,'500','2012-03-24 01:40:48',NULL,1,NULL),
 (446,10,9,'6','2012-03-24 01:40:48',NULL,1,NULL),
 (447,10,7,'8','2012-03-24 01:40:48',NULL,1,NULL),
 (448,10,10,'Klima','2012-03-24 01:40:48',NULL,1,NULL),
 (449,10,11,'Elektrik','2012-03-24 01:40:48',NULL,1,NULL),
 (450,10,12,'İkinci El','2012-03-24 01:40:48',NULL,1,NULL),
 (451,10,13,'Boş','2012-03-24 01:40:48',NULL,1,NULL),
 (452,10,26,'500 TL','2012-03-24 01:40:48',NULL,1,NULL),
 (453,10,15,'Uygun','2012-03-24 01:40:48',NULL,1,NULL),
 (454,10,17,'Yapılmaz','2012-03-24 01:40:48',NULL,1,NULL),
 (455,10,24,'Evet','2012-03-24 01:40:48',NULL,1,NULL),
 (456,10,27,'Evet','2012-03-24 01:40:48',NULL,1,NULL),
 (457,10,28,'800 TL','2012-03-24 01:40:48',NULL,1,NULL),
 (458,10,21,'güzel olabilecek bir ofis','2012-03-24 01:40:48',NULL,1,NULL);
/*!40000 ALTER TABLE `ilan_detay` ENABLE KEYS */;


--
-- Definition of table `ilan_ozellik`
--

DROP TABLE IF EXISTS `ilan_ozellik`;
CREATE TABLE `ilan_ozellik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UstID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UstID` (`UstID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `ilan_ozellik_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ozellik_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_ozellik`
--

/*!40000 ALTER TABLE `ilan_ozellik` DISABLE KEYS */;
INSERT INTO `ilan_ozellik` (`ID`,`UstID`,`Baslik`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (3,0,'İç Özellikler',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (4,0,'Dış Özellikler',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (5,0,'Konum',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (6,0,'Oda Özellikleri',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (7,0,'Sosyal',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (8,3,'ADSL',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (9,3,'Ahşap Doğrama',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (10,3,'Alarm',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (11,3,'Ankstre Mutfak',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (12,3,'Balkon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (13,3,'Barbekü',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (14,3,'Beyaz Eşyalı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (15,3,'Çamaşır Odası',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (16,3,'Çelik Kapı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (17,3,'Duşakabin',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (18,3,'Duvar Kağıdı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (19,3,'Ebeveyn Banyolu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (20,3,'Giyinme Odası',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (21,3,'Gömme Dolap',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (22,3,'Görüntülü Diafon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (23,3,'Halı Kaplama',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (24,3,'Hazır Mutfak',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (25,3,'Hilton Banyo',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (26,3,'Isıcam',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (27,3,'Jakuzi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (28,3,'Kablo TV-Uydu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (29,3,'Kapalı Balkon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (30,3,'Kartonpiyer',1,'2012-02-24 07:00:00','2012-02-28 12:45:05',1,1),
 (31,3,'Klima',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (32,3,'Laminant Mutfak',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (33,3,'Marley',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (34,3,'Mermer Zemin',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (35,3,'Mobilyalı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (36,3,'Mutfak Doğalgazı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (37,3,'Panel Kapı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (38,3,'Panjur',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (39,3,'Parke',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (40,3,'Parke - Laminant',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (41,3,'Saten Alçı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (42,3,'Saten Boya',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (43,3,'Sauna',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (44,3,'Seramik Zemin',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (45,3,'Spot Işık',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (46,3,'Şömine',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (47,3,'Teras',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (48,3,'Vestiyer',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (49,3,'Yerden Isıtma',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (50,4,'Ahşap Doğrama',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (51,4,'Asansör',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (52,4,'Bahçeli',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (53,4,'Cam Mozaik Kaplama',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (54,4,'Fitness',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (55,4,'Güvenlik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (56,4,'Hidrofor',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (57,4,'Isı Yalıtım',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (58,4,'Jeneratör',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (59,4,'Kapıcı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (60,4,'Otopark - Açık',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (61,4,'Otopark - Kapalı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (62,4,'Oyun Parkı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (63,4,'PVC Doğrama',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (64,4,'Siding',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (65,4,'Site İçerisinde',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (66,4,'Su Deposu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (67,4,'Tenis Kortu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (68,4,'Yangın Merdiveni',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (69,4,'Yüzme Havuzu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (70,5,'Arka Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (71,5,'Caddeye Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (72,5,'Deniz Ulaşımına Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (73,5,'Denize Sıfır',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (74,5,'Denize Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (75,5,'Havaalanına Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (76,5,'Manzara',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (77,5,'Manzara - Boğaz',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (78,5,'Manzara - Deniz',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (79,5,'Manzara - Doğa',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (80,5,'Manzara - Göl',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (81,5,'Manzara - Şehir',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (82,5,'Merkezde',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (83,5,'Metrobüse Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (84,5,'Metroya Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (85,5,'Otobana Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (86,5,'Ön Cephe',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (87,5,'Toplu Ulaşıma Yakın',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (89,0,'Kullanım Amacı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (90,89,'Atölye',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (91,89,'Banka',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (92,89,'Depo',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (93,89,'Dershane',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (94,89,'Dükkan',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (95,89,'Fabrika',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (96,89,'Galeri / Showroom',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (97,89,'Genel',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (98,89,'Hastane',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (99,89,'Kafe - Bar',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (100,89,'Mağaza',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (101,89,'Market',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (102,89,'Muayenehane',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (103,89,'Ofis',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (104,89,'Otopark',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (105,89,'Pastane',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (106,89,'Poliklinik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (107,89,'Restoran',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (108,89,'Üretim Tesisi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (109,0,'Altyapı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (110,109,'Doğalgaz Mevcut',1,'2012-02-24 07:00:00','2012-02-28 14:32:32',1,1),
 (111,109,'Elektrik Hattı',1,'2012-02-24 07:00:00','2012-03-13 14:20:46',1,1),
 (112,109,'Kanalizasyon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (113,109,'Parselli',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (114,109,'Projeli (Ruhsatlı)',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (115,109,'Sanayi Elektriği',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (116,109,'Su Hattı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (117,109,'Telefon Hattı',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (118,109,'Yolu Açılmış',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (119,109,'Zemin Etüdlü',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (120,6,'Duş / WC',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (121,6,'Jakuzi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (122,6,'Klima',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (123,6,'Küvetli Banyo',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (124,6,'Mini Bar',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (125,6,'Müzik Yayını',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (126,6,'Telefon',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (127,6,'TV',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (128,7,'Basketbol',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (129,7,'Bilardo',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (130,7,'Binicilik',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (131,7,'Bowling',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (132,7,'Fitness Merkezi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (133,7,'Futbol',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (134,7,'Golf',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (135,7,'Jimnastik Salonu',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (136,7,'Kayak',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (137,7,'Masa Tenisi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (138,7,'Mini Golf',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (139,7,'Spor Kompleksi',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (140,7,'Squash',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (141,7,'Su Sporları',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (142,7,'Tenis',1,'2012-02-24 07:00:00',NULL,1,NULL),
 (143,7,'Voleybol',1,'2012-02-24 07:00:00',NULL,1,NULL);
/*!40000 ALTER TABLE `ilan_ozellik` ENABLE KEYS */;


--
-- Definition of table `ilan_ozellik2`
--

DROP TABLE IF EXISTS `ilan_ozellik2`;
CREATE TABLE `ilan_ozellik2` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KatID` int(11) DEFAULT NULL,
  `OzellikID` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `KatID` (`KatID`),
  KEY `OzellikID` (`OzellikID`),
  KEY `EkleyenID` (`EkleyenID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  KEY `ID` (`ID`),
  CONSTRAINT `ilan_ozellik2_ibfk_1` FOREIGN KEY (`KatID`) REFERENCES `kategori` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ozellik2_ibfk_2` FOREIGN KEY (`OzellikID`) REFERENCES `ilan_ozellik` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ozellik2_ibfk_3` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_ozellik2_ibfk_4` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_ozellik2`
--

/*!40000 ALTER TABLE `ilan_ozellik2` DISABLE KEYS */;
INSERT INTO `ilan_ozellik2` (`ID`,`KatID`,`OzellikID`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,1,3,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (2,1,4,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (3,1,5,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (4,3,3,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (5,3,4,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (6,3,5,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (7,2,3,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (8,2,4,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (9,2,5,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (10,2,89,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (11,4,5,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (12,4,109,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (13,5,3,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (14,5,4,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (15,5,5,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (16,5,6,1,'2012-03-06 22:21:23',NULL,1,NULL),
 (17,5,7,1,'2012-03-06 22:21:23',NULL,1,NULL);
/*!40000 ALTER TABLE `ilan_ozellik2` ENABLE KEYS */;


--
-- Definition of table `ilan_resim`
--

DROP TABLE IF EXISTS `ilan_resim`;
CREATE TABLE `ilan_resim` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IlanID` int(11) DEFAULT NULL,
  `Resim` text,
  `Varsayilan` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IlanID` (`IlanID`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  CONSTRAINT `ilan_resim_ibfk_1` FOREIGN KEY (`IlanID`) REFERENCES `ilan` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_resim_ibfk_2` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_resim_ibfk_3` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_resim`
--

/*!40000 ALTER TABLE `ilan_resim` DISABLE KEYS */;
INSERT INTO `ilan_resim` (`ID`,`IlanID`,`Resim`,`Varsayilan`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,1,'1.jpg',1,1,'2012-02-10 16:52:52',NULL,1,NULL),
 (2,1,'2.jpg',0,1,'2012-02-10 16:52:55',NULL,1,NULL),
 (3,1,'3.jpg',0,1,'2012-02-10 16:52:57',NULL,1,NULL),
 (4,2,'4.jpg',1,1,'2012-02-10 16:52:59',NULL,1,NULL),
 (5,2,'5.jpg',0,1,'2012-02-10 16:53:02',NULL,1,NULL),
 (6,2,'6.jpg',0,1,'2012-02-10 16:53:09',NULL,1,NULL),
 (7,10,'0cc3e0ce-8f37-483d-b6aa-5fd1cab7a11e.jpg',1,1,'2012-03-24 01:24:05',NULL,NULL,NULL),
 (8,10,'26fbd70d-b20a-4d1f-ae9e-51386532e258.jpg',0,1,'2012-03-24 01:24:06',NULL,NULL,NULL),
 (9,10,'daa56411-a55a-4c21-8f68-1e018897129a.jpg',0,1,'2012-03-24 01:24:06',NULL,NULL,NULL),
 (12,10,'a87c8df1-77f1-4b1e-a525-272f5f0bfa21.jpg',0,1,'2012-03-24 01:26:18',NULL,NULL,NULL),
 (15,10,'5720d026-38d2-40a4-a661-1786a81bbe27.jpg',0,1,'2012-03-24 01:29:44',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ilan_resim` ENABLE KEYS */;


--
-- Definition of table `ilan_sabit`
--

DROP TABLE IF EXISTS `ilan_sabit`;
CREATE TABLE `ilan_sabit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Sabit` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_sabit`
--

/*!40000 ALTER TABLE `ilan_sabit` DISABLE KEYS */;
INSERT INTO `ilan_sabit` (`ID`,`Sabit`) VALUES 
 (1,'Konut Tipi'),
 (2,'Konut Şekli'),
 (3,'Oda Sayısı'),
 (4,'Salon Sayısı'),
 (5,'Banyo Sayısı'),
 (6,'m2'),
 (7,'Bina Yaşı'),
 (8,'Kat Sayısı'),
 (9,'Bulunduğu Kat'),
 (10,'Isınma Tipi'),
 (11,'Yakıt Tipi'),
 (12,'Yapının Durumu'),
 (13,'Kullanım Durumu'),
 (14,'Tapu Durumu'),
 (15,'Krediye Uygunluk'),
 (16,'Aidat'),
 (17,'Takas'),
 (18,'Öğrenciye/Bekara Uygun'),
 (19,'Cephe Seçenekleri'),
 (21,'Yorum'),
 (22,'Devremülk Adı'),
 (23,'Devremülk Tipi'),
 (24,'Devre'),
 (25,'İş Yeri Tipi'),
 (26,'Depozito'),
 (27,'Devren'),
 (28,'Kira Getirisi'),
 (29,'Arsa Tipi'),
 (30,'İlgili Belediye'),
 (31,'Ada'),
 (32,'Parsel'),
 (33,'m2BirimFiyat'),
 (34,'Kat Karşılığı'),
 (35,'Tesis Tipi'),
 (36,'Yatak Sayısı'),
 (37,'Yıldız Sayısı'),
 (38,'Kapalı Alan m2'),
 (39,'Açık Alan m2'),
 (40,'İskan Durumu');
/*!40000 ALTER TABLE `ilan_sabit` ENABLE KEYS */;


--
-- Definition of table `ilan_sabit2`
--

DROP TABLE IF EXISTS `ilan_sabit2`;
CREATE TABLE `ilan_sabit2` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SabitID` int(11) DEFAULT NULL,
  `KatID` int(11) DEFAULT NULL,
  `Tip` varchar(255) DEFAULT NULL,
  `IlanDegiskenID` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SabitID` (`SabitID`),
  KEY `KatID` (`KatID`),
  KEY `ID` (`ID`),
  KEY `IlanDegiskenID` (`IlanDegiskenID`),
  KEY `EkleyenID` (`EkleyenID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  CONSTRAINT `ilan_sabit2_ibfk_1` FOREIGN KEY (`SabitID`) REFERENCES `ilan_sabit` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_sabit2_ibfk_2` FOREIGN KEY (`KatID`) REFERENCES `kategori` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_sabit2_ibfk_3` FOREIGN KEY (`IlanDegiskenID`) REFERENCES `ilan_degisken` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_sabit2_ibfk_4` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ilan_sabit2_ibfk_5` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilan_sabit2`
--

/*!40000 ALTER TABLE `ilan_sabit2` DISABLE KEYS */;
INSERT INTO `ilan_sabit2` (`ID`,`SabitID`,`KatID`,`Tip`,`IlanDegiskenID`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,1,1,'dropdown',134,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (2,2,1,'dropdown',148,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (3,3,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (4,4,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (5,5,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (6,6,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (7,7,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (8,8,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (9,9,1,'dropdown',13,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (10,10,1,'dropdown',50,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (11,11,1,'dropdown',60,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (12,12,1,'dropdown',74,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (13,13,1,'dropdown',78,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (14,14,1,'dropdown',82,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (15,15,1,'dropdown',86,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (16,16,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (17,17,1,'dropdown',93,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (18,18,1,'dropdown',90,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (19,19,1,'dropdown',164,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (21,21,1,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (22,22,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (23,23,3,'dropdown',158,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (24,24,3,'dropdown',96,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (25,3,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (26,4,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (27,5,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (28,6,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (29,9,3,'dropdown',13,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (30,7,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (31,10,3,'dropdown',50,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (32,11,3,'dropdown',60,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (33,12,3,'dropdown',74,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (34,16,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (35,17,3,'dropdown',93,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (37,21,3,'textbox',NULL,1,'2012-03-06 12:17:27',NULL,1,NULL),
 (38,25,2,'dropdown',169,1,'2012-03-06 13:50:40',NULL,1,NULL),
 (39,3,2,'textbox',NULL,1,'2012-03-06 14:01:01',NULL,1,NULL),
 (40,6,2,'textbox',NULL,1,'2012-03-06 14:01:24',NULL,1,NULL),
 (41,9,2,'dropdown',13,1,'2012-03-06 14:01:41',NULL,1,NULL),
 (42,7,2,'textbox',NULL,1,'2012-03-06 14:02:03',NULL,1,NULL),
 (43,10,2,'dropdown',50,1,'2012-03-06 14:02:21',NULL,1,NULL),
 (44,11,2,'dropdown',60,1,'2012-03-06 14:02:40',NULL,1,NULL),
 (45,12,2,'dropdown',74,1,'2012-03-06 14:02:53',NULL,1,NULL),
 (46,13,2,'dropdown',78,1,'2012-03-06 14:03:05',NULL,1,NULL),
 (47,26,2,'textbox',NULL,1,'2012-03-06 14:03:22',NULL,1,NULL),
 (48,15,2,'dropdown',86,1,'2012-03-06 14:04:14',NULL,1,NULL),
 (49,17,2,'dropdown',93,1,'2012-03-06 14:04:26',NULL,1,NULL),
 (50,27,2,'dropdown',109,1,'2012-03-06 14:04:37',NULL,1,NULL),
 (51,28,2,'textbox',NULL,1,'2012-03-06 14:04:52',NULL,1,NULL),
 (52,21,2,'textbox',NULL,1,'2012-03-06 14:05:15',NULL,1,NULL),
 (53,29,4,'dropdown',189,1,'2012-03-06 14:06:14',NULL,1,NULL),
 (54,30,4,'textbox',NULL,1,'2012-03-06 14:06:26',NULL,1,NULL),
 (55,31,4,'textbox',NULL,1,'2012-03-06 14:06:45',NULL,1,NULL),
 (56,32,4,'textbox',NULL,1,'2012-03-06 14:07:00',NULL,1,NULL),
 (57,6,4,'textbox',NULL,1,'2012-03-06 14:07:08',NULL,1,NULL),
 (58,33,4,'textbox',NULL,1,'2012-03-06 14:07:19',NULL,1,NULL),
 (59,34,4,'dropdown',112,1,'2012-03-06 14:07:34',NULL,1,NULL),
 (60,17,4,'dropdown',93,1,'2012-03-06 14:07:50',NULL,1,NULL),
 (61,14,4,'dropdown',115,1,'2012-03-06 14:13:20',NULL,1,NULL),
 (62,15,4,'dropdown',86,1,'2012-03-06 14:13:35',NULL,1,NULL),
 (63,28,4,'textbox',NULL,1,'2012-03-06 14:13:47',NULL,1,NULL),
 (64,21,4,'textbox',NULL,1,'2012-03-06 14:14:23',NULL,1,NULL),
 (65,35,5,'dropdown',208,1,'2012-03-14 10:14:38',NULL,1,NULL),
 (66,3,5,'textbox',NULL,1,'2012-03-14 10:15:17',NULL,1,NULL),
 (67,36,5,'textbox',NULL,1,'2012-03-14 10:15:32',NULL,1,NULL),
 (68,37,5,'dropdown',124,1,'2012-03-14 10:15:50',NULL,1,NULL),
 (69,38,5,'textbox',NULL,1,'2012-03-14 10:16:15',NULL,1,NULL),
 (70,39,5,'textbox',NULL,1,'2012-03-14 10:16:23',NULL,1,NULL),
 (71,14,5,'dropdown',82,1,'2012-03-14 10:17:10',NULL,1,NULL),
 (72,40,5,'dropdown',121,1,'2012-03-14 10:17:29',NULL,1,NULL),
 (73,17,5,'dropdown',93,1,'2012-03-14 10:18:03',NULL,1,NULL),
 (74,21,5,'textbox',NULL,1,'2012-03-14 10:18:52',NULL,1,NULL);
/*!40000 ALTER TABLE `ilan_sabit2` ENABLE KEYS */;


--
-- Definition of table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Baslik` varchar(255) DEFAULT NULL,
  `AltMenu` int(11) DEFAULT NULL,
  `Sira` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `kategori_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `kategori_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kategori`
--

/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` (`ID`,`Baslik`,`AltMenu`,`Sira`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,'Konut',1,1,1,'2012-02-06 22:08:27',NULL,1,NULL),
 (2,'İşyeri',1,2,1,'2012-02-06 22:08:37',NULL,1,NULL),
 (3,'Devremülk',1,3,1,'2012-02-06 22:09:01',NULL,1,NULL),
 (4,'Arsa',1,4,1,'2012-02-06 22:09:17','2012-02-27 16:39:29',1,1),
 (5,'Turistik İşletme',1,5,1,'2012-02-06 22:09:33','2012-02-27 16:36:49',1,1);
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;


--
-- Definition of table `kullanici`
--

DROP TABLE IF EXISTS `kullanici`;
CREATE TABLE `kullanici` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Adi` varchar(255) DEFAULT NULL,
  `EPosta` varchar(255) DEFAULT NULL,
  `Sifre` varchar(255) DEFAULT NULL,
  `Telefon` varchar(255) DEFAULT NULL,
  `SonGiris` datetime DEFAULT NULL,
  `SonIP` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `kullanici_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `kullanici_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kullanici`
--

/*!40000 ALTER TABLE `kullanici` DISABLE KEYS */;
INSERT INTO `kullanici` (`ID`,`Adi`,`EPosta`,`Sifre`,`Telefon`,`SonGiris`,`SonIP`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,'Hüseyin Yıldırım','huseyinyildirim@hotmail.com','1B623485EDAA217744AD154C8BEC91A4','453453','2012-03-25 14:26:56','127.0.0.1',1,'2012-02-06 22:12:16','2012-03-02 23:25:32',1,1);
/*!40000 ALTER TABLE `kullanici` ENABLE KEYS */;


--
-- Definition of table `mesaj_kutu`
--

DROP TABLE IF EXISTS `mesaj_kutu`;
CREATE TABLE `mesaj_kutu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GonderenID` int(11) DEFAULT NULL,
  `AliciID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Detay` text,
  `Okundu` int(11) DEFAULT NULL COMMENT '1 okundu, 0 okunmadı',
  `KayitTarih` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `GonderenID` (`GonderenID`),
  KEY `AliciID` (`AliciID`),
  CONSTRAINT `mesaj_kutu_ibfk_1` FOREIGN KEY (`GonderenID`) REFERENCES `kullanici` (`ID`),
  CONSTRAINT `mesaj_kutu_ibfk_2` FOREIGN KEY (`AliciID`) REFERENCES `kullanici` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mesaj_kutu`
--

/*!40000 ALTER TABLE `mesaj_kutu` DISABLE KEYS */;
INSERT INTO `mesaj_kutu` (`ID`,`GonderenID`,`AliciID`,`Baslik`,`Detay`,`Okundu`,`KayitTarih`) VALUES 
 (1,1,1,'denememe','dedfsdfa df adad adf adf adf ',1,'2012-03-13 17:52:15'),
 (2,1,1,'sdfadfad','asdfadfa',1,'2012-03-13 17:53:15'),
 (3,1,1,'adfadfadfad','sdafadfadf<br />\r\n<br />\r\n<em>Alıntı ----------------------------------------</em><br />\r\n<br />\r\n<strong>G&ouml;nderen:</strong> H&uuml;seyin Yıldırım<br />\r\n<br />\r\ndedfsdfa df adad adf adf adf ',1,'2012-03-16 10:21:39');
/*!40000 ALTER TABLE `mesaj_kutu` ENABLE KEYS */;


--
-- Definition of table `musteri`
--

DROP TABLE IF EXISTS `musteri`;
CREATE TABLE `musteri` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ad` varchar(255) DEFAULT NULL,
  `Telefon` varchar(255) DEFAULT NULL,
  `Adres` text,
  `Not` text,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EkleyenID` (`EkleyenID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  KEY `ID` (`ID`),
  CONSTRAINT `musteri_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `musteri_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `musteri`
--

/*!40000 ALTER TABLE `musteri` DISABLE KEYS */;
INSERT INTO `musteri` (`ID`,`Ad`,`Telefon`,`Adres`,`Not`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,'Cafer Kazmaz','0 532 123 45 67','Yeni Mh. 1945 Sk. No:15 Isparta','Göl kenarında dubleks ev istiyor.','2012-02-29 09:52:20',NULL,1,NULL),
 (2,'Salih Çakar','0 535 123 45 67','Atatürk Mh. 152 Sk. No:12 Isparta','Çarşı içinde lüx apartman dairesi istiyor','2012-02-29 09:55:50',NULL,1,NULL);
/*!40000 ALTER TABLE `musteri` ENABLE KEYS */;


--
-- Definition of table `olay_giriscikis`
--

DROP TABLE IF EXISTS `olay_giriscikis`;
CREATE TABLE `olay_giriscikis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KullaniciID` int(11) DEFAULT NULL,
  `Islem` varchar(255) DEFAULT NULL,
  `Ip` varchar(255) DEFAULT NULL,
  `All_http` text,
  `All_raw` text,
  `KayitTarih` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `KullaniciID` (`KullaniciID`),
  CONSTRAINT `olay_giriscikis_ibfk_1` FOREIGN KEY (`KullaniciID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `olay_giriscikis`
--

/*!40000 ALTER TABLE `olay_giriscikis` DISABLE KEYS */;
INSERT INTO `olay_giriscikis` (`ID`,`KullaniciID`,`Islem`,`Ip`,`All_http`,`All_raw`,`KayitTarih`) VALUES 
 (1,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=vb4dmvsnn2ne25lgjc3zpouy; __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmb=111872281.33.10.1330419764; __utmc=111872281; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=vb4dmvsnn2ne25lgjc3zpouy; __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmb=111872281.33.10.1330419764; __utmc=111872281; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-02-28 11:26:36'),
 (2,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=tcsqohxuunqeucgjx3bnzatv\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=tcsqohxuunqeucgjx3bnzatv\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-02-29 09:26:06'),
 (3,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=qdmcp4oxb0xghmclmnf2v0vf\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=qdmcp4oxb0xghmclmnf2v0vf\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-02-29 22:17:07'),
 (4,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=1a2gvqggelhy3lsop1vcd3is\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=1a2gvqggelhy3lsop1vcd3is\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-01 09:15:34'),
 (5,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=xb5cuinmun5cac0yohum3umu\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=xb5cuinmun5cac0yohum3umu\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-02 09:12:26'),
 (6,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=5v5mb5wbgcsrbnabvod2r3lh\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=5v5mb5wbgcsrbnabvod2r3lh\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-02 21:23:57'),
 (7,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=1ybgpdnqspgwrasa2qoxpfw1\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=1ybgpdnqspgwrasa2qoxpfw1\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-03 09:44:36'),
 (8,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=rmvmnz3fdn3mpg3bisfkv2ed\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=rmvmnz3fdn3mpg3bisfkv2ed\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-05 09:37:23'),
 (9,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=ks2aqk0vho4jmaxx0ghtg5jb\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=ks2aqk0vho4jmaxx0ghtg5jb\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-06 09:12:23'),
 (10,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=en2wcra3p4b2pqabmlg4n3ve\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=en2wcra3p4b2pqabmlg4n3ve\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-06 21:30:07'),
 (11,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=e2qskgtjkewlyhbql0jad2dp\r\nHTTP_HOST:localhost:1322\r\nHTTP_REFERER:http://localhost:1322/emlak/Yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=e2qskgtjkewlyhbql0jad2dp\r\nHost: localhost:1322\r\nReferer: http://localhost:1322/emlak/Yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-07 10:50:18'),
 (12,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=ttvznyold0dgfwce5ipynxgy\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=ttvznyold0dgfwce5ipynxgy\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-07 15:25:58'),
 (13,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:305\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=vdruetknr4cr1e0uwfwfbljv\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 305\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=vdruetknr4cr1e0uwfwfbljv\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-08 09:12:21'),
 (14,NULL,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:287\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=2fagf1b5bqkffinkweuum4l3\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 287\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=2fagf1b5bqkffinkweuum4l3\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-08 17:28:33'),
 (15,NULL,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:287\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=a4pxj04da2hjjzkaysbdx2ge\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 287\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=a4pxj04da2hjjzkaysbdx2ge\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-09 09:16:46'),
 (16,NULL,'Çıkış','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=a4pxj04da2hjjzkaysbdx2ge; 4cea1313c8c557791cc230774704e5b3Giris=7777777; 4cea1313c8c557791cc230774704e5b3KullaniciID=5\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/AyarParametre.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.1786319043.1330419764.1330419764.1330419764.1; __utmz=111872281.1330419764.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CKFinder_Path=Images%3A%2F%3A1; ASP.NET_SessionId=a4pxj04da2hjjzkaysbdx2ge; 4cea1313c8c557791cc230774704e5b3Giris=7777777; 4cea1313c8c557791cc230774704e5b3KullaniciID=5\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/AyarParametre.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-09 11:52:32'),
 (17,NULL,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:551\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=izmdbjeg2ybvy1d5b4whbphz\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 551\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=izmdbjeg2ybvy1d5b4whbphz\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-09 12:23:31'),
 (18,NULL,'Çıkış','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=izmdbjeg2ybvy1d5b4whbphz; 4cea1313c8c557791cc230774704e5b3Giris=7777777; 4cea1313c8c557791cc230774704e5b3KullaniciID=5\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/OlayGirisHata.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=izmdbjeg2ybvy1d5b4whbphz; 4cea1313c8c557791cc230774704e5b3Giris=7777777; 4cea1313c8c557791cc230774704e5b3KullaniciID=5\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/OlayGirisHata.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-09 12:23:53'),
 (19,NULL,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:552\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=zz21ehx4ezywphkktw412w3l\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 552\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=zz21ehx4ezywphkktw412w3l\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-09 12:25:20'),
 (20,NULL,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:547\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=0jsr4fcqlesvdjkefk3afldg\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 547\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=0jsr4fcqlesvdjkefk3afldg\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-12 09:57:56'),
 (21,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:544\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=wgq1yhcp1ait5qi2spnyfzfw\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 544\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=wgq1yhcp1ait5qi2spnyfzfw\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-13 09:43:47'),
 (22,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:543\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=mei4lzi1cqqxvrx213stcc25\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 543\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=mei4lzi1cqqxvrx213stcc25\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-14 09:20:42'),
 (23,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:544\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:ASP.NET_SessionId=uzqrrynw013rtshr043eaalo\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 544\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: ASP.NET_SessionId=uzqrrynw013rtshr043eaalo\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-15 15:36:57'),
 (24,1,'Giriş','::1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:551\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:SERASMAC=logo; ASP.NET_SessionId=f55b0jdyh5ymwkyzlbxkeywf\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','Connection: keep-alive\r\nContent-Length: 551\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: SERASMAC=logo; ASP.NET_SessionId=f55b0jdyh5ymwkyzlbxkeywf\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2\r\n','2012-03-16 09:07:20'),
 (25,1,'Giriş','127.0.0.1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:548\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmb=111872281.1.10.1332543163; ASP.NET_SessionId=0gpwhyhpcghnbi5k0pdtrcon\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','Connection: keep-alive\r\nContent-Length: 548\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmb=111872281.1.10.1332543163; ASP.NET_SessionId=0gpwhyhpcghnbi5k0pdtrcon\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','2012-03-24 01:20:01'),
 (26,1,'Giriş','127.0.0.1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:546\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=yr3yoblpxkrq1ru1p5d3ruqp\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','Connection: keep-alive\r\nContent-Length: 546\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=yr3yoblpxkrq1ru1p5d3ruqp\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','2012-03-24 10:16:49'),
 (27,1,'Giriş','127.0.0.1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:547\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=te1ucy0qv1guju5tfdnr3uwk\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','Connection: keep-alive\r\nContent-Length: 547\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=te1ucy0qv1guju5tfdnr3uwk\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','2012-03-25 00:15:20'),
 (28,1,'Giriş','127.0.0.1','HTTP_CONNECTION:keep-alive\r\nHTTP_CONTENT_LENGTH:546\r\nHTTP_CONTENT_TYPE:application/x-www-form-urlencoded\r\nHTTP_ACCEPT:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nHTTP_ACCEPT_ENCODING:gzip, deflate\r\nHTTP_ACCEPT_LANGUAGE:tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nHTTP_COOKIE:__utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=gxn4qburvegicrhosopg4x2a\r\nHTTP_HOST:localhost:90\r\nHTTP_REFERER:http://localhost:90/yonetim/Giris.aspx\r\nHTTP_USER_AGENT:Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','Connection: keep-alive\r\nContent-Length: 546\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3\r\nCookie: __utma=111872281.978857877.1332501739.1332535395.1332543163.4; __utmz=111872281.1332501739.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); ASP.NET_SessionId=gxn4qburvegicrhosopg4x2a\r\nHost: localhost:90\r\nReferer: http://localhost:90/yonetim/Giris.aspx\r\nUser-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0\r\n','2012-03-25 14:26:56');
/*!40000 ALTER TABLE `olay_giriscikis` ENABLE KEYS */;


--
-- Definition of table `olay_girishata`
--

DROP TABLE IF EXISTS `olay_girishata`;
CREATE TABLE `olay_girishata` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Kullanici` varchar(255) DEFAULT NULL,
  `Islem` varchar(255) DEFAULT NULL,
  `Ip` varchar(255) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `olay_girishata`
--

/*!40000 ALTER TABLE `olay_girishata` DISABLE KEYS */;
INSERT INTO `olay_girishata` (`ID`,`Kullanici`,`Islem`,`Ip`,`KayitTarih`) VALUES 
 (1,'huseyinyildirim@hotmail.com','Güvenlik Kodu Hatası','::1','2012-03-09 12:23:10'),
 (2,'demo','Güvenlik Kodu Hatası','127.0.0.1','2012-06-16 00:07:05');
/*!40000 ALTER TABLE `olay_girishata` ENABLE KEYS */;


--
-- Definition of table `olay_islem`
--

DROP TABLE IF EXISTS `olay_islem`;
CREATE TABLE `olay_islem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KullaniciID` int(11) DEFAULT NULL,
  `Tablo` varchar(255) DEFAULT NULL,
  `Islem` varchar(255) DEFAULT NULL,
  `KayıtID` varchar(255) DEFAULT NULL,
  `Ip` varchar(255) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `KullaniciID` (`KullaniciID`),
  CONSTRAINT `olay_islem_ibfk_1` FOREIGN KEY (`KullaniciID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=445 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `olay_islem`
--

/*!40000 ALTER TABLE `olay_islem` DISABLE KEYS */;
INSERT INTO `olay_islem` (`ID`,`KullaniciID`,`Tablo`,`Islem`,`KayıtID`,`Ip`,`KayitTarih`) VALUES 
 (166,1,'olay_islem','Silindi','Hepsi','::1','2012-02-27 14:51:32'),
 (167,1,'kategori','Güncellendi','5','::1','2012-02-27 15:19:27'),
 (168,1,'kategori','Güncellendi','4','::1','2012-02-27 15:19:31'),
 (169,1,'kategori','Güncellendi','3','::1','2012-02-27 15:19:34'),
 (170,1,'kategori','Güncellendi','5','::1','2012-02-27 15:20:16'),
 (171,1,'kategori','Güncellendi','4','::1','2012-02-27 15:20:19'),
 (172,1,'kategori','Güncellendi','3','::1','2012-02-27 15:20:23'),
 (173,1,'kategori','Güncellendi','14','::1','2012-02-27 15:43:26'),
 (174,1,'kategori','Güncellendi','7','::1','2012-02-27 15:43:31'),
 (175,1,'kategori','Güncellendi','14','::1','2012-02-27 15:43:56'),
 (176,1,'kategori','Silindi','14','::1','2012-02-27 15:44:00'),
 (177,1,'kategori','Silindi','13','::1','2012-02-27 15:44:06'),
 (178,1,'kategori','Silindi','6','::1','2012-02-27 15:44:15'),
 (179,1,'kategori','Silindi','11','::1','2012-02-27 15:44:15'),
 (180,1,'kategori','Silindi','10','::1','2012-02-27 15:44:15'),
 (181,1,'kategori','Silindi','9','::1','2012-02-27 15:44:15'),
 (182,1,'kategori','Silindi','8','::1','2012-02-27 15:44:15'),
 (183,1,'kategori','Silindi','7','::1','2012-02-27 15:44:16'),
 (184,1,'kategori','Silindi','12','::1','2012-02-27 15:44:16'),
 (185,1,'kategori','Yeni Kayıt','','::1','2012-02-27 16:18:05'),
 (186,1,'kategori','Silindi','15','::1','2012-02-27 16:18:15'),
 (187,1,'kategori','Yeni Kayıt','','::1','2012-02-27 16:19:31'),
 (188,1,'kategori','Yeni Kayıt','','::1','2012-02-27 16:21:41'),
 (189,1,'kategori','Silindi','17','::1','2012-02-27 16:21:58'),
 (190,1,'kategori','Silindi','16','::1','2012-02-27 16:21:58'),
 (191,1,'kategori','Güncellendi','5','::1','2012-02-27 16:36:49'),
 (192,1,'kategori','Güncellendi','4','::1','2012-02-27 16:38:38'),
 (193,1,'kategori','Güncellendi','4','::1','2012-02-27 16:39:27'),
 (194,1,'kategori','Güncellendi','4','::1','2012-02-27 16:39:29'),
 (195,1,'kategori','Yeni Kayıt','','::1','2012-02-27 16:47:25'),
 (196,1,'kategori','Güncellendi','18','::1','2012-02-27 16:47:35'),
 (197,1,'kategori','Güncellendi','18','::1','2012-02-27 16:47:39'),
 (198,1,'kategori','Güncellendi','18','::1','2012-02-27 16:47:45'),
 (199,1,'kategori','Silindi','18','::1','2012-02-27 16:48:42'),
 (200,1,'kategoritip','Güncellendi','16','::1','2012-02-27 17:42:32'),
 (201,1,'kategoritip','Güncellendi','16','::1','2012-02-27 17:42:36'),
 (202,1,'kategori','Yeni Kayıt','','::1','2012-02-27 17:57:15'),
 (203,1,'kategoritip','Silindi','64','::1','2012-02-27 17:57:32'),
 (204,1,'kategori','Yeni Kayıt','','::1','2012-02-28 11:31:51'),
 (205,1,'kategoritip','Güncellendi','64','::1','2012-02-28 11:32:00'),
 (206,1,'kategoritip','Güncellendi','64','::1','2012-02-28 11:32:04'),
 (207,1,'kategoritip','Silindi','64','::1','2012-02-28 11:32:09'),
 (208,1,'kategoritip','Güncellendi','15','::1','2012-02-28 11:40:14'),
 (209,1,'kategoritip','Güncellendi','15','::1','2012-02-28 11:40:18'),
 (210,1,'kategoritip','Güncellendi','15','::1','2012-02-28 11:40:27'),
 (211,1,'kategoritip','Güncellendi','15','::1','2012-02-28 11:40:31'),
 (212,1,'kategoritip','Güncellendi','15','::1','2012-02-28 11:40:40'),
 (213,1,'kategoritip','Güncellendi','38','::1','2012-02-28 11:40:50'),
 (214,1,'kategoritip','Güncellendi','38','::1','2012-02-28 11:40:53'),
 (215,1,'kategoritip','Güncellendi','14','::1','2012-02-28 11:40:59'),
 (216,1,'kategoritip','Güncellendi','14','::1','2012-02-28 11:43:14'),
 (217,1,'kategori','Yeni Kayıt','','::1','2012-02-28 11:49:12'),
 (218,1,'kategoritip','Güncellendi','65','::1','2012-02-28 11:49:22'),
 (219,1,'kategoritip','Silindi','65','::1','2012-02-28 11:49:40'),
 (220,1,'kategorisekil','Güncellendi','1','::1','2012-02-28 12:04:36'),
 (221,1,'kategorisekil','Güncellendi','1','::1','2012-02-28 12:04:41'),
 (222,1,'kategorisekil','Yeni Kayıt','','::1','2012-02-28 12:22:44'),
 (223,1,'kategorisekil','Güncellendi','10','::1','2012-02-28 12:22:52'),
 (224,1,'kategorisekil','Güncellendi','10','::1','2012-02-28 12:22:57'),
 (225,1,'kategorisekil','Yeni Kayıt','','::1','2012-02-28 12:23:15'),
 (226,1,'kategorisekil','Yeni Kayıt','','::1','2012-02-28 12:23:23'),
 (227,1,'kategorisekil','Silindi','10','::1','2012-02-28 12:23:29'),
 (228,1,'kategorisekil','Silindi','11','::1','2012-02-28 12:23:35'),
 (229,1,'kategorisekil','Silindi','12','::1','2012-02-28 12:23:35'),
 (230,1,'ilanozellik','Güncellendi','30','::1','2012-02-28 12:44:57'),
 (231,1,'ilanozellik','Güncellendi','30','::1','2012-02-28 12:45:05'),
 (232,1,'ilanozellik','Yeni Kayıt','','::1','2012-02-28 13:18:47'),
 (233,1,'ilanozellik','Silindi','144','::1','2012-02-28 13:19:07'),
 (234,1,'ilanozellik','Güncellendi','110','::1','2012-02-28 14:32:19'),
 (235,1,'ilanozellik','Güncellendi','110','::1','2012-02-28 14:32:32'),
 (236,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 15:27:59'),
 (237,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 15:28:04'),
 (238,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 16:27:06'),
 (239,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 16:27:11'),
 (240,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 16:28:10'),
 (241,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 16:28:13'),
 (242,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 17:17:37'),
 (243,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 17:17:45'),
 (244,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 17:17:54'),
 (245,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 17:17:59'),
 (246,1,'ilandegisken','Güncellendi','69','::1','2012-02-28 17:18:03'),
 (247,1,'ilandegisken','Yeni Kayıt','','::1','2012-02-28 17:18:25'),
 (248,1,'ilandegisken','Güncellendi','134','::1','2012-02-28 17:18:45'),
 (249,1,'ilandegisken','Yeni Kayıt','','::1','2012-02-28 17:19:10'),
 (250,1,'ilandegisken','Yeni Kayıt','','::1','2012-02-28 17:19:18'),
 (251,1,'ilandegisken','Silindi','135','::1','2012-02-28 17:19:32'),
 (252,1,'ilandegisken','Silindi','136','::1','2012-02-28 17:19:32'),
 (253,1,'ilandegisken','Silindi','134','::1','2012-02-28 17:19:42'),
 (254,1,'musteri','Silindi','11','::1','2012-02-29 10:11:36'),
 (255,1,'musteri','Silindi','7','::1','2012-02-29 10:11:43'),
 (256,1,'musteri','Silindi','8','::1','2012-02-29 10:11:43'),
 (257,1,'musteri','Silindi','9','::1','2012-02-29 10:11:43'),
 (258,1,'musteri','Silindi','10','::1','2012-02-29 10:11:43'),
 (259,1,'musteri','Silindi','3','::1','2012-02-29 10:12:04'),
 (260,1,'musteri','Silindi','4','::1','2012-02-29 10:12:04'),
 (261,1,'musteri','Silindi','5','::1','2012-02-29 10:12:04'),
 (262,1,'musteri','Silindi','6','::1','2012-02-29 10:12:04'),
 (263,1,'musteri','Yeni Kayıt','','::1','2012-02-29 10:24:11'),
 (264,1,'musteri','Güncellendi','12','::1','2012-02-29 10:32:04'),
 (265,1,'musteri','Güncellendi','12','::1','2012-02-29 10:33:36'),
 (266,1,'musteri','Silindi','12','::1','2012-02-29 10:34:23'),
 (267,1,'musteri','Yeni Kayıt','','::1','2012-02-29 10:34:40'),
 (268,1,'musteri','Yeni Kayıt','','::1','2012-02-29 10:34:49'),
 (269,1,'musteri','Silindi','14','::1','2012-02-29 10:34:56'),
 (270,1,'musteri','Silindi','13','::1','2012-02-29 10:34:56'),
 (271,1,'sayfa','Güncellendi','1','::1','2012-02-29 10:47:39'),
 (272,1,'sayfa','Güncellendi','1','::1','2012-02-29 10:47:43'),
 (273,1,'sayfa','Güncellendi','1','::1','2012-02-29 12:04:38'),
 (274,1,'sayfa','Güncellendi','1','::1','2012-02-29 12:04:43'),
 (275,1,'sayfa','Güncellendi','1','::1','2012-02-29 12:05:03'),
 (276,1,'sayfa','Güncellendi','1','::1','2012-02-29 12:05:06'),
 (277,1,'sayfa','Güncellendi','1','::1','2012-02-29 13:46:16'),
 (278,1,'sayfa','Güncellendi','1','::1','2012-02-29 13:46:29'),
 (279,1,'sayfa','Güncellendi','1','::1','2012-02-29 13:55:29'),
 (280,1,'sayfa','Güncellendi','1','::1','2012-02-29 14:04:06'),
 (281,1,'sayfa','Yeni Kayıt','','::1','2012-02-29 14:41:51'),
 (282,1,'sayfa','Güncellendi','2','::1','2012-02-29 14:42:24'),
 (283,1,'sayfa','Güncellendi','2','::1','2012-02-29 14:42:27'),
 (284,1,'sayfa','Güncellendi','2','::1','2012-02-29 14:42:35'),
 (285,1,'sayfa','Güncellendi','2','::1','2012-02-29 14:42:39'),
 (286,1,'sayfa','Yeni Kayıt','','::1','2012-02-29 14:43:02'),
 (287,1,'sayfa','Yeni Kayıt','','::1','2012-02-29 14:43:18'),
 (288,1,'sayfa','Silindi','4','::1','2012-02-29 14:43:26'),
 (289,1,'sayfa','Silindi','2','::1','2012-02-29 14:43:34'),
 (290,1,'sayfa','Silindi','3','::1','2012-02-29 14:43:34'),
 (291,1,'parametre','Güncellendi','1','::1','2012-02-29 15:27:29'),
 (292,1,'parametre','Güncellendi','1','::1','2012-02-29 15:27:39'),
 (293,1,'parametre','Güncellendi','1','::1','2012-02-29 15:27:50'),
 (294,1,'parametre','Güncellendi','1','::1','2012-02-29 15:43:26'),
 (295,1,'parametre','Güncellendi','1','::1','2012-02-29 15:43:32'),
 (296,1,'ilan','Güncellendi','6','::1','2012-03-02 22:44:21'),
 (297,1,'kullanici','Güncellendi','1','::1','2012-03-02 23:25:32'),
 (298,1,'ilan','Güncellendi','3','::1','2012-03-03 10:24:14'),
 (299,1,'ilan','Güncellendi','4','::1','2012-03-03 10:24:14'),
 (300,1,'ilan','Güncellendi','5','::1','2012-03-03 10:24:14'),
 (301,1,'ilan','Güncellendi','3','::1','2012-03-03 10:28:41'),
 (302,1,'ilan','Güncellendi','4','::1','2012-03-03 10:28:41'),
 (303,1,'ilan','Güncellendi','5','::1','2012-03-03 10:28:41'),
 (304,1,'ilan','Güncellendi','6','::1','2012-03-03 10:32:33'),
 (305,1,'ilan','Güncellendi','4','::1','2012-03-03 10:34:01'),
 (306,1,'ilan','Güncellendi','5','::1','2012-03-03 10:34:01'),
 (307,1,'ilan','Güncellendi','4','::1','2012-03-03 10:34:30'),
 (308,1,'ilan','Güncellendi','5','::1','2012-03-03 10:34:30'),
 (309,1,'ilan','Güncellendi','6','::1','2012-03-03 10:34:30'),
 (310,1,'ilan','Güncellendi','6','::1','2012-03-03 10:34:38'),
 (311,1,'ilan','Silindi','8','::1','2012-03-06 09:43:39'),
 (312,1,'ilan','Silindi','9','::1','2012-03-06 09:43:39'),
 (313,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 13:50:40'),
 (314,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:01:01'),
 (315,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:01:24'),
 (316,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:01:41'),
 (317,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:02:03'),
 (318,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:02:21'),
 (319,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:02:40'),
 (320,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:02:53'),
 (321,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:03:05'),
 (322,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:03:22'),
 (323,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:04:14'),
 (324,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:04:26'),
 (325,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:04:37'),
 (326,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:04:52'),
 (327,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:05:15'),
 (328,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:06:14'),
 (329,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:06:26'),
 (330,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:06:45'),
 (331,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:07:00'),
 (332,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:07:08'),
 (333,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:07:19'),
 (334,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:07:34'),
 (335,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:07:50'),
 (336,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:13:20'),
 (337,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:13:35'),
 (338,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:13:47'),
 (339,1,'ilansabit','Yeni Kayıt','','::1','2012-03-06 14:14:23'),
 (340,1,'ilan','Güncellendi','7','::1','2012-03-06 15:08:32'),
 (341,1,'ilan','Güncellendi','6','::1','2012-03-06 15:10:24'),
 (342,1,'ilan','Güncellendi','6','::1','2012-03-06 15:12:13'),
 (343,1,'ilan','Güncellendi','6','::1','2012-03-06 15:27:27'),
 (344,1,'ilan','Güncellendi','5','::1','2012-03-06 15:33:37'),
 (345,1,'ilan','Güncellendi','4','::1','2012-03-06 15:34:42'),
 (346,1,'ilan','Güncellendi','4','::1','2012-03-06 15:35:36'),
 (347,1,'ilan','Güncellendi','3','::1','2012-03-06 15:36:23'),
 (348,1,'ilan','Güncellendi','2','::1','2012-03-06 15:52:57'),
 (349,1,'ilan','Güncellendi','1','::1','2012-03-06 15:53:58'),
 (350,1,'ilan','Silindi','7','::1','2012-03-06 15:54:43'),
 (351,1,'ilan','Güncellendi','6','::1','2012-03-06 17:05:58'),
 (352,1,'ilan','Yeni Kayıt','','::1','2012-03-06 17:17:58'),
 (353,1,'ilan','Güncellendi','6','::1','2012-03-06 17:28:28'),
 (354,1,'ilan','Güncellendi','6','::1','2012-03-06 21:37:24'),
 (355,1,'ilan','Güncellendi','6','::1','2012-03-07 15:26:14'),
 (356,1,'ilan','Güncellendi','6','::1','2012-03-07 15:45:33'),
 (357,1,'ilan','Güncellendi','6','::1','2012-03-07 16:18:04'),
 (358,1,'ilan','Güncellendi','6','::1','2012-03-07 16:24:04'),
 (359,1,'ilan','Güncellendi','6','::1','2012-03-08 09:14:08'),
 (360,1,'ilan','Güncellendi','6','::1','2012-03-08 14:19:10'),
 (361,1,'ilan','Güncellendi','6','::1','2012-03-08 14:32:54'),
 (362,1,'ilan','Güncellendi','4','::1','2012-03-08 15:30:50'),
 (363,1,'ilan','Güncellendi','6','::1','2012-03-08 15:34:53'),
 (364,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-08 16:35:33'),
 (365,NULL,'parametre','Güncellendi','1','::1','2012-03-08 17:29:16'),
 (366,NULL,'ilan','Güncellendi','6','::1','2012-03-09 10:06:49'),
 (367,NULL,'ilan','Silindi','6','::1','2012-03-09 10:13:36'),
 (368,NULL,'ilan_detay','Silindi','6','::1','2012-03-09 10:13:36'),
 (369,NULL,'ilan','Güncellendi','5','::1','2012-03-09 10:15:42'),
 (370,NULL,'ilan_resim','Silindi','13','::1','2012-03-09 10:16:26'),
 (371,NULL,'ilan_resim','Silindi','14','::1','2012-03-09 10:16:26'),
 (372,NULL,'ilan_resim','Silindi','15','::1','2012-03-09 10:16:26'),
 (373,NULL,'ilan_resim','Silindi','16','::1','2012-03-09 10:16:26'),
 (374,NULL,'ilan_resim','Silindi','17','::1','2012-03-09 10:16:26'),
 (375,NULL,'ilan_resim','Silindi','18','::1','2012-03-09 10:16:26'),
 (376,NULL,'ilan_resim','Silindi','19','::1','2012-03-09 10:16:26'),
 (377,NULL,'ilan_resim','Silindi','20','::1','2012-03-09 10:16:26'),
 (378,NULL,'ilan_resim','Silindi','21','::1','2012-03-09 10:16:26'),
 (379,NULL,'ilan_resim','Silindi','22','::1','2012-03-09 10:16:26'),
 (380,NULL,'ilan_resim','Silindi','23','::1','2012-03-09 10:16:26'),
 (381,NULL,'ilan_resim','Silindi','24','::1','2012-03-09 10:16:26'),
 (382,NULL,'ilan_resim','Silindi','25','::1','2012-03-09 10:16:26'),
 (383,NULL,'ilan_resim','Silindi','26','::1','2012-03-09 10:16:26'),
 (384,NULL,'ilan_resim','Silindi','27','::1','2012-03-09 10:16:26'),
 (385,NULL,'ilan_resim','Silindi','28','::1','2012-03-09 10:16:26'),
 (386,NULL,'ilan_resim','Silindi','29','::1','2012-03-09 10:16:26'),
 (387,NULL,'ilan_resim','Silindi','30','::1','2012-03-09 10:16:26'),
 (388,NULL,'ilan_resim','Silindi','31','::1','2012-03-09 10:16:26'),
 (389,NULL,'ilan_resim','Silindi','32','::1','2012-03-09 10:16:26'),
 (390,NULL,'ilan_resim','Silindi','33','::1','2012-03-09 10:16:26'),
 (391,NULL,'ilan_detay','Silindi','5','::1','2012-03-09 10:16:26'),
 (392,NULL,'ilan','Silindi','5','::1','2012-03-09 10:16:26'),
 (393,NULL,'ilan_resim','Silindi','7','::1','2012-03-09 10:25:46'),
 (394,NULL,'ilan_resim','Silindi','8','::1','2012-03-09 10:25:46'),
 (395,NULL,'ilan_resim','Silindi','9','::1','2012-03-09 10:25:46'),
 (396,NULL,'ilan_detay','Silindi','3','::1','2012-03-09 10:25:46'),
 (397,NULL,'ilan','Silindi','3','::1','2012-03-09 10:25:46'),
 (398,NULL,'ilan_resim','Silindi','10','::1','2012-03-09 10:25:46'),
 (399,NULL,'ilan_resim','Silindi','11','::1','2012-03-09 10:25:46'),
 (400,NULL,'ilan_resim','Silindi','12','::1','2012-03-09 10:25:46'),
 (401,NULL,'ilan_detay','Silindi','4','::1','2012-03-09 10:25:46'),
 (402,NULL,'ilan','Silindi','4','::1','2012-03-09 10:25:46'),
 (403,NULL,'ilan','Güncellendi','2','::1','2012-03-09 10:53:45'),
 (404,NULL,'ilan','Güncellendi','2','::1','2012-03-09 12:26:47'),
 (405,NULL,'ilan_resim','Silindi','34','::1','2012-03-09 12:33:29'),
 (406,NULL,'ilan_resim','Silindi','35','::1','2012-03-09 12:33:34'),
 (407,1,'talep','Güncellendi','1','::1','2012-03-13 10:29:01'),
 (408,1,'ilan_degisken','Yeni Kayıt','','::1','2012-03-13 11:06:29'),
 (409,1,'ilan_ozellik','Yeni Kayıt','','::1','2012-03-13 11:17:08'),
 (410,1,'ilan','Güncellendi','2','::1','2012-03-13 13:33:18'),
 (411,1,'ilan_ozellik','Güncellendi','111','::1','2012-03-13 14:20:46'),
 (412,1,'parametre','Güncellendi','1','::1','2012-03-13 14:39:06'),
 (413,1,'parametre','Güncellendi','1','::1','2012-03-13 14:39:16'),
 (414,1,'mesaj','Yeni Kayıt','','::1','2012-03-13 17:52:15'),
 (415,1,'mesaj','Yeni Kayıt','','::1','2012-03-13 17:53:15'),
 (416,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:14:38'),
 (417,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:15:17'),
 (418,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:15:32'),
 (419,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:15:50'),
 (420,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:16:15'),
 (421,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:16:23'),
 (422,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:17:10'),
 (423,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:17:29'),
 (424,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:18:03'),
 (425,1,'ilan_sabit','Yeni Kayıt','','::1','2012-03-14 10:18:52'),
 (426,1,'ilan','Yeni Kayıt','','::1','2012-03-14 11:26:39'),
 (427,1,'ilan_resim','Silindi','7','::1','2012-03-14 11:47:11'),
 (428,1,'ilan_resim','Silindi','8','::1','2012-03-14 11:47:11'),
 (429,1,'ilan_resim','Silindi','9','::1','2012-03-14 11:47:11'),
 (430,1,'ilan_resim','Silindi','10','::1','2012-03-14 11:47:11'),
 (431,1,'ilan_resim','Silindi','11','::1','2012-03-14 11:47:11'),
 (432,1,'ilan_resim','Silindi','12','::1','2012-03-14 11:47:11'),
 (433,1,'ilan_detay','Silindi','11','::1','2012-03-14 11:47:11'),
 (434,1,'ilan','Silindi','11','::1','2012-03-14 11:47:11'),
 (435,1,'ilan','Güncellendi','10','::1','2012-03-14 11:59:29'),
 (436,1,'parametre','Güncellendi','1','::1','2012-03-15 17:17:48'),
 (437,1,'parametre','Güncellendi','1','::1','2012-03-15 17:18:21'),
 (438,1,'mesaj','Yeni Kayıt','','::1','2012-03-16 10:21:39'),
 (439,1,'ilan','Güncellendi','10','127.0.0.1','2012-03-24 01:23:19'),
 (440,1,'ilan_resim','Silindi','14','127.0.0.1','2012-03-24 01:29:25'),
 (441,1,'ilan_resim','Silindi','13','127.0.0.1','2012-03-24 01:29:29'),
 (442,1,'ilan_resim','Silindi','11','127.0.0.1','2012-03-24 01:29:32'),
 (443,1,'ilan_resim','Silindi','10','127.0.0.1','2012-03-24 01:29:36'),
 (444,1,'ilan','Güncellendi','10','127.0.0.1','2012-03-24 01:40:45');
/*!40000 ALTER TABLE `olay_islem` ENABLE KEYS */;


--
-- Definition of table `parametre`
--

DROP TABLE IF EXISTS `parametre`;
CREATE TABLE `parametre` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Firma` varchar(500) DEFAULT NULL,
  `Telefon` varchar(500) DEFAULT NULL,
  `CepTelefon` varchar(500) DEFAULT NULL,
  `Faks` varchar(500) DEFAULT NULL,
  `Adres` varchar(500) DEFAULT NULL,
  `EPosta` varchar(255) DEFAULT NULL,
  `SiteAdres` varchar(255) DEFAULT NULL,
  `Smtp` varchar(255) DEFAULT NULL,
  `SmtpEPosta` varchar(255) DEFAULT NULL,
  `SmtpEPostaSifre` varchar(255) DEFAULT NULL,
  `SmtpPort` varchar(255) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Aciklama` text,
  `Anahtar` text,
  `Facebook` varchar(255) DEFAULT NULL,
  `Twitter` varchar(255) DEFAULT NULL,
  `GuvenlikKodu` varchar(255) DEFAULT NULL,
  `GoogleMapApi` varchar(255) DEFAULT NULL,
  `ReCaptchaPublicKey` varchar(255) DEFAULT NULL,
  `ReCaptchaPrivateKey` varchar(255) DEFAULT NULL,
  `YoneticiListeKayitSayi` varchar(255) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  CONSTRAINT `parametre_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `parametre_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `parametre`
--

/*!40000 ALTER TABLE `parametre` DISABLE KEYS */;
INSERT INTO `parametre` (`ID`,`Firma`,`Telefon`,`CepTelefon`,`Faks`,`Adres`,`EPosta`,`SiteAdres`,`Smtp`,`SmtpEPosta`,`SmtpEPostaSifre`,`SmtpPort`,`Baslik`,`Aciklama`,`Anahtar`,`Facebook`,`Twitter`,`GuvenlikKodu`,`GoogleMapApi`,`ReCaptchaPublicKey`,`ReCaptchaPrivateKey`,`YoneticiListeKayitSayi`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,'Emlak Firması','02423216549','05323216549','02423216500','Fener Mh. 1964 Sk. No:4 Antalya','info@emlaksitesi.com','http://www.localhost','mail.emlaksitesi.com','info@emlaksitesi.com','es0707es','587','Emlak Sitesi | kiralık daire, satılık daire, kiralık ofis, satılık ofis','Emlak firmaları için tasarlanmış, gelişmiş özellikleri bulunan emlak yönetim sistemidir.','emlak, emlak sitesi, kiralık ev, satılık ev, satılık ofis, kiralık ofis, arsa','http://www.facebook.com','http://www.twitter.com','4cea1313c8c557791cc230774704e5b3','AIzaSyDy6RU4CWM6IqoO0J8-EvfoPu-us10ticY','6LfQs84SAAAAAKhzM23uEFTwZmOvpgRGvtGsIGc6','6LfQs84SAAAAADPij_NDsvx24xLKy54N3mk7RBUK','30','2012-02-10 09:33:20','2012-03-15 17:18:21',1,1);
/*!40000 ALTER TABLE `parametre` ENABLE KEYS */;


--
-- Definition of table `sayac`
--

DROP TABLE IF EXISTS `sayac`;
CREATE TABLE `sayac` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ip` varchar(255) DEFAULT NULL,
  `Cogul` int(11) DEFAULT NULL,
  `Agent` varchar(255) DEFAULT NULL,
  `Tarayici` varchar(255) DEFAULT NULL,
  `IsletimSistemi` varchar(255) DEFAULT NULL,
  `Dil` varchar(255) DEFAULT NULL,
  `Referans` varchar(500) DEFAULT NULL,
  `UlkeKod` varchar(255) DEFAULT NULL,
  `UlkeAd` varchar(255) DEFAULT NULL,
  `Il` varchar(255) DEFAULT NULL,
  `Ilce` varchar(255) DEFAULT NULL,
  `Enlem` varchar(255) DEFAULT NULL,
  `Boylam` varchar(255) DEFAULT NULL,
  `Bot` int(11) DEFAULT NULL,
  `Tarih` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sayac`
--

/*!40000 ALTER TABLE `sayac` DISABLE KEYS */;
INSERT INTO `sayac` (`ID`,`Ip`,`Cogul`,`Agent`,`Tarayici`,`IsletimSistemi`,`Dil`,`Referans`,`UlkeKod`,`UlkeAd`,`Il`,`Ilce`,`Enlem`,`Boylam`,`Bot`,`Tarih`) VALUES 
 (1,'::1',15,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-02-29'),
 (3,'::1',5,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://localhost:90/','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-01'),
 (4,'88.225.225.119',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-01'),
 (5,'88.225.220.254',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-01'),
 (6,'150.70.172.204',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-01'),
 (7,'94.123.40.52',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=ispartaemlak.com.tr&source=web&cd=1&ved=0CCQQFjAA&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=2L1PT4nEC8z4mAXu5qmjCg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-01'),
 (8,'78.169.157.14',1,'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11','Chrome 17.0','Windows 7','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+emlak&source=web&cd=8&ved=0CGYQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=B9ZPT53DHomN8gOcvJjwBQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-01'),
 (9,'95.10.50.253',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20%20emlak&source=web&cd=8&ved=0CHEQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=re9PT5OTN7HN4QTCuZi0DQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-01'),
 (10,'95.10.50.253',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://www.ispartaemlak.com.tr/','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-02'),
 (11,'76.72.167.163',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'US','United States','Pennsylvania','Philadelphia','39.9968','-75.1485',1,'2012-03-02'),
 (12,'88.225.225.119',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-02'),
 (13,'150.70.172.204',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-02'),
 (14,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-02'),
 (15,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-02'),
 (16,'95.8.85.31',5,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.3; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; eSobiSubscriber 2.0.4.16; InfoPath.1; .NET4.0C; .NET4.0E)','IE 8.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+emlak&source=web&cd=8&ved=0CGwQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=iLtQT6m2Dcik8QOzmI3wBQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-02'),
 (17,'180.76.5.155',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-03'),
 (18,'180.76.5.51',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-03'),
 (19,'180.76.5.111',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-03'),
 (20,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-04'),
 (21,'95.108.150.235',5,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-04'),
 (22,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-04'),
 (23,'180.76.5.164',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-04'),
 (24,'180.76.5.103',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-04'),
 (25,'180.76.5.183',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-05'),
 (26,'94.23.42.135',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'FR','France','','','46','2',1,'2012-03-05'),
 (27,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-05'),
 (28,'180.76.6.231',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-06'),
 (29,'66.226.77.39',1,'Mozilla/5.0 (Windows NT 6.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1','Firefox 7.0','Windows 7','en-us;q=0.7, en;q=0.3',NULL,'US','United States','Kansas','Overland Park','38.9247','-94.7029',0,'2012-03-06'),
 (30,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-06'),
 (31,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-06'),
 (32,'88.250.236.193',2,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 1.1.4322; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; OfficeLiveConnector.1.3; OfficeLivePatch.0.0; .NET4.0C)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGcQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=qMtVT8eDHaem0QXl6pDiCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Izmir','Izmir','38.4104','27.142',0,'2012-03-06'),
 (33,'88.225.232.230',1,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&ved=0CGwQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=8OFVT9jhKqHU0QXu1-XgCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Isparta','Isparta','37.7644','30.5522',0,'2012-03-06'),
 (34,'64.246.161.190',1,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','Firefox 3.5','Windows XP','en-us,fr-be;q=0.5','http://whois.domaintools.com/ispartaemlak.com.tr','US','United States','Washington','Seattle','47.6145','-122.348',0,'2012-03-06'),
 (35,'95.108.151.244',2,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-06'),
 (36,'78.164.255.66',6,'Mozilla/5.0 (Windows; U; Windows NT 6.1; tr; rv:1.9) Gecko/2008052906 Firefox/3.0','Firefox 3.0','Windows 7','tr-TR,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&ved=0CGkQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=nWhWT_yhIcTXsgbbvuTqBg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw&cad=rja','TR','Turkey','Icel','Mersin','36.7328','34.6442',0,'2012-03-06'),
 (37,'85.106.151.194',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-06'),
 (38,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-07'),
 (39,'88.225.220.254',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-07'),
 (40,'88.225.225.119',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-07'),
 (41,'150.70.75.30',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-07'),
 (42,'150.70.172.103',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-07'),
 (43,'180.76.5.142',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-07'),
 (44,'88.250.71.141',1,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-07'),
 (45,'88.250.71.141',1,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; OfficeLiveConnector.1.3; OfficeLivePatch.0.0)','IE 7.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-07'),
 (46,'78.186.234.54',1,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.2)','IE 7.0','Windows XP','tr','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','TR','Turkey','Bursa','Bursa','40.1917','29.0611',0,'2012-03-07'),
 (47,'88.225.227.8',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11','Chrome 17.0','Windows 7','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-07'),
 (48,'180.76.5.95',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-07'),
 (49,'180.76.5.58',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-07'),
 (50,'180.76.5.168',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-08'),
 (51,'94.23.42.135',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'FR','France','','','46','2',1,'2012-03-08'),
 (52,'180.76.5.159',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-08'),
 (53,'193.140.181.20',3,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.1; .NET4.0C; .NET4.0E)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+emlak&source=web&cd=8&ved=0CGwQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=q2RYT5atDcL_4QTFptjfDw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Manisa','Süleyman','38.9819','27.6006',0,'2012-03-08'),
 (54,'180.76.5.149',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-08'),
 (55,'174.143.151.116',1,'Mozilla/5.0','Mozilla 0.0','Unknown','en-us',NULL,'US','United States','Texas','San Antonio','29.3884','-98.5311',1,'2012-03-08'),
 (56,'78.164.225.43',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; OfficeLiveConnector.1.3; OfficeLivePatch.0.0; .NET CLR 1.1.4322; msn OptimizedIE8;TRTR)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=9&sqi=2&ved=0CHEQFjAI&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=-MZYT7rdFqLD0QW4uY3JDQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-08'),
 (57,'180.76.5.189',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-08'),
 (58,'180.76.5.48',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-08'),
 (59,'94.123.40.52',2,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-08'),
 (60,'88.236.247.71',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 1.1.4322; .NET4.0C; .NET4.0E)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak%20ve%20kira%20fiyatlar%C4%B1&source=web&cd=10&sqi=2&ved=0CHYQFjAJ&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=OQFZT-yKKOSB4ASn3Oi2Dw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-08'),
 (61,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-09'),
 (62,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-09'),
 (63,'188.41.243.245',1,'Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaN95_8GB/35.0.001; Profile/MIDP-2.0 Configuration/CLDC-1.1 ) AppleWebKit/413 (KHTML, like Gecko) Safari/413','Safari 0.0','Unknown','tr;q=1.0,en;q=0.5,fr;q=0.5,de;q=0.5,it;q=0.5,nl;q=0.5','http://www.google.com.tr/m?q=isparta+emlak','TR','Turkey','','','39','35',1,'2012-03-09'),
 (64,'180.76.5.176',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-09'),
 (65,'180.76.6.225',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-09'),
 (66,'31.167.39.18',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB7.2; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0)','IE 8.0','Windows 7','tr-TR','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','US','United States','Ohio','Columbus','39.9968','-82.9882',0,'2012-03-09'),
 (67,'::1',3,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-12'),
 (68,'88.225.225.119',6,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-13'),
 (69,'150.70.172.204',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-13'),
 (70,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-13'),
 (71,'175.158.29.208',1,'Yeti/1.0 (NHN Corp.; http://help.naver.com/robots/)','Unknown 0.0','Unknown','tr,en;q=0.5',NULL,'KR','Korea  Republic of','','','37','127.5',1,'2012-03-13'),
 (72,'88.225.220.254',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-13'),
 (73,'94.123.46.185',20,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-13'),
 (74,'::1',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://localhost:90/yonetim/IstatistikTarayici.aspx','TR','Turkey','','','','',0,'2012-03-13'),
 (75,'95.15.235.69',1,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=isparta%20emlak&source=web&cd=7&ved=0CFgQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=eV9fT-bTKoPB0QX42tyZBw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-13'),
 (76,'84.168.121.94',7,'Mozilla/5.0 (Linux; U; Android 2.2; de-de; p7901a Build/FRF85B) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1','Safari 4.0','Linux','de-DE, en-US','http://www.google.com/m?hl=de&gl=de&source=android-browser-type&q=www.isparta+emlak.com.tr','DE','Germany','Bayern','Stegaurach','49.8667','10.8333',0,'2012-03-13'),
 (77,'95.10.61.179',9,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7','Chrome 16.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGkQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=wmBfT8WbLIa90QWq-vmDBw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-13'),
 (78,'188.3.196.177',5,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows 7','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGkQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=bGhfT9fIDYXP4QT6u43XBw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-13'),
 (79,'180.76.6.233',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-13'),
 (80,'95.10.52.4',1,'Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','Firefox 9.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+sat%C4%B1l%C4%B1k+daire&source=web&cd=29&ved=0CGoQFjAIOBQ&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=ZXVfT6rDC42S8gOWg7zaBw&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-13'),
 (81,'46.104.155.178',1,'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; tr-tr) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5','Safari 5.0','iPhone','tr-tr','http://www.google.com.tr/search?q=%C4%B1spartada+kiralik+evler&hl=tr&prmd=imvns&ei=e3lfT4SbJ5CG8gPF0unNBw&start=40&sa=N&biw=320&bih=416','TR','Turkey','','','39','35',0,'2012-03-13'),
 (82,'150.70.172.103',2,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-13'),
 (83,'88.225.225.119',5,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-14'),
 (84,'150.70.172.103',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-14'),
 (85,'88.225.220.254',4,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-14'),
 (86,'76.72.167.164',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'US','United States','Pennsylvania','Philadelphia','39.9968','-75.1485',1,'2012-03-14'),
 (87,'78.189.166.219',7,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.1; .NET4.0C; .NET4.0E)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGgQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=koRgT_7tK62N4gSAtaG1Dg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Denizli','Denizli','37.7742','29.0875',0,'2012-03-14'),
 (88,'150.70.75.30',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-14'),
 (89,'180.76.5.151',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-14'),
 (90,'180.76.5.167',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-14'),
 (91,'78.187.13.69',7,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; .NET4.0C; BRI/2)','IE 8.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&ved=0CGgQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=Kd5gT5aPBNHFtAbHvvG7CQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Isparta','Isparta','37.7644','30.5522',0,'2012-03-14'),
 (92,'180.76.6.21',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-14'),
 (93,'94.123.46.185',3,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-14'),
 (94,'94.123.46.185',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-14'),
 (95,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-14'),
 (96,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-14'),
 (97,'95.15.124.227',1,'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows 7','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=isparta%20kiral%C4%B1k%20konut&source=web&cd=82&ved=0CDkQFjABOFA&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2Filan%2F4%2Fsatilik-110-mt2-apartman-dairesi.aspx&ei=JhphT6ctqczRBeWw4f4G&usg=AFQjCNHLloDIdIVdzyvE7VWth2YIX2dH7Q&cad=rja','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-15'),
 (98,'180.76.6.26',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-15'),
 (99,'180.76.5.149',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-15'),
 (100,'88.225.220.254',1,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; MAAU; .NET4.0C; .NET4.0E; MS-RTC LM 8; Windows Live Messenger 15.4.3538.0513)','IE 7.0','Windows 7','tr-TR',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-15'),
 (101,'88.240.200.171',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Bursa','Bursa','40.1917','29.0611',0,'2012-03-15'),
 (102,'88.225.225.119',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-15'),
 (103,'150.70.64.195',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-15'),
 (104,'78.187.209.59',4,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','TR','Turkey','Gaziantep','Gaziantep','37.0594','37.3825',0,'2012-03-15'),
 (105,'150.70.75.30',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-15'),
 (106,'94.123.46.185',6,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-15'),
 (107,'180.76.5.164',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-15'),
 (108,'88.225.225.119',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-16'),
 (109,'88.225.220.254',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://ispartaemlak.com.tr/','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-16'),
 (110,'150.70.172.103',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-16'),
 (111,'150.70.172.204',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-16'),
 (112,'180.76.5.103',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-16'),
 (113,'94.123.37.144',2,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-16'),
 (114,'78.165.80.42',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)','IE 8.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGcQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=bxBjT7qwBMqa0QWzr_mLCA&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Samsun','Samsun','41.2867','36.33',0,'2012-03-16'),
 (115,'180.76.5.97',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-16'),
 (116,'95.15.202.184',6,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-16'),
 (117,'94.123.52.181',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0; MAAU)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGwQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=um1jT6brG5DqOcj71IsI&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-16'),
 (118,'180.76.5.110',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-16'),
 (119,'95.10.37.224',2,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGcQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=NI9jT__HGJOt8QPa0-23CA&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Icel','Mersin','36.7328','34.6442',0,'2012-03-16'),
 (120,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-16'),
 (121,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-16'),
 (122,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-17'),
 (123,'94.123.35.232',13,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-17'),
 (124,'88.225.220.254',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2','Firefox 10.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-17'),
 (125,'150.70.172.103',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-17'),
 (126,'76.72.167.162',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'US','United States','Pennsylvania','Philadelphia','39.9968','-75.1485',1,'2012-03-17'),
 (127,'85.105.150.232',1,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=isparta%20emlak%2C&source=web&cd=7&ved=0CFcQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=fF5kT8rJF87LswbFlqSzCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw&cad=rja','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-17'),
 (128,'213.43.22.96',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Adana','Adana','37.0017','35.3289',0,'2012-03-17'),
 (129,'150.70.172.204',1,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-17'),
 (130,'180.76.5.166',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-18'),
 (131,'216.145.17.190',1,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)','Firefox 3.5','Windows XP','en-us,fr-be;q=0.5','http://whois.domaintools.com/ispartaemlak.com.tr','US','United States','Washington','Seattle','47.6102','-122.304',0,'2012-03-18'),
 (132,'95.108.150.235',5,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-18'),
 (133,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-18'),
 (134,'94.123.47.79',4,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-18'),
 (135,'180.76.5.137',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-19'),
 (136,'94.123.47.79',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-19'),
 (137,'88.225.225.119',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-19'),
 (138,'94.235.214.152',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&ved=0CG0QFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=FfhmT-P9MMaX0QXukuGzCA&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','GE','Georgia','','','42','43.5',0,'2012-03-19'),
 (139,'95.10.39.236',9,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4',NULL,'TR','Turkey','Icel','Mersin','36.7328','34.6442',0,'2012-03-19'),
 (140,'95.10.37.20',2,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)','IE 8.0','Windows XP','tr','http://www.gazetekeyfi.com.tr/isparta/isparta-emlakcidan-sahibinden-satilik-kiralik-daire-isparta-ev-arsa-isyeri-buro-fiyatlari-daire-ilanlari.asp','TR','Turkey','Icel','Mersin','36.7328','34.6442',0,'2012-03-19'),
 (141,'88.225.220.254',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-19'),
 (142,'180.76.5.194',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-19'),
 (143,'95.108.151.244',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-19'),
 (144,'95.108.151.244',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-19'),
 (145,'95.108.151.244',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-19'),
 (146,'180.76.5.141',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','tr-TR',NULL,'CN','China','','','35','105',1,'2012-03-20'),
 (147,'180.76.5.172',1,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-20'),
 (148,'94.123.39.45',2,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; BTRS119457; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.3)','IE 8.0','Windows XP','tr',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-20'),
 (149,'95.10.62.230',3,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)','IE 8.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+emlak&source=web&cd=8&ved=0CGkQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=3zxoT4LKCpLJ8gOS-oWRCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-20'),
 (150,'95.10.62.66',3,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=8&sqi=2&ved=0CGkQFjAH&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=ekxoT6btA-ay0QXL_YTvCA&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-20'),
 (151,'76.72.167.164',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'US','United States','Pennsylvania','Philadelphia','39.9968','-75.1485',1,'2012-03-20'),
 (152,'95.15.233.50',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.3; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0)','IE 8.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=www.isparta%20emlak.com&source=web&cd=5&sqi=2&ved=0CGkQFjAE&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=ilhoT7a2IKmk0QXS0NT0CA&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-20'),
 (153,'95.15.87.44',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=www%C4%B1sparta%20emlak%20com%20tr&source=web&cd=3&ved=0CEoQFjAC&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2Filan%2F21%2Fsatilik-mustakil-ev.aspx&ei=KGNoT4-bFsuk8gPk9ZChCQ&usg=AFQjCNEL--Qmp_P3RudpZbNz5t_ONblh3g','TR','Turkey','Malatya','Malatya','38.3533','38.3119',0,'2012-03-20'),
 (154,'176.40.29.70',3,'Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows XP','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'KR','Korea  Republic of','','','37','127.5',0,'2012-03-20'),
 (155,'85.104.5.71',2,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7','Chrome 16.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=ispartaemlak&source=web&cd=3&ved=0CF8QFjAC&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=1HtoT72CNYKk8gOx6ImYCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-20'),
 (156,'88.255.153.110',2,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB7.3; .NET4.0C; .NET CLR 2.0.50727; .NET4.0E; .NET CLR 3.5.30729)','IE 7.0','Windows XP','tr','http://www.google.com.tr/search?hl=tr&rlz=1T4ADSA_trTR345TR351&gs_upl=0l0l0l5312lllllllllll0&q=%C4%B1sparta%20emlak&ct=broad-revision&cd=3&ie=UTF-8&sa=X','TR','Turkey','Izmir','Izmir','38.4104','27.142',0,'2012-03-20'),
 (157,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-20'),
 (158,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-20'),
 (159,'188.119.45.119',7,'Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows XP','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta+emlak&source=web&cd=7&ved=0CGEQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=q4JpT6yhB4X-4QSE-aGgCQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw&cad=rja','AT','Austria','','','47.3333','13.3333',0,'2012-03-21'),
 (160,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-21'),
 (161,'95.0.195.7',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; InfoPath.2; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&sqi=2&ved=0CFYQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=-yhrT8LyBeXe4QTmlPSwBg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','','','39','35',0,'2012-03-22'),
 (162,'95.0.195.7',1,'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; InfoPath.2; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','IE 8.0','Windows XP','tr','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&sqi=2&ved=0CFYQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=-yhrT8LyBeXe4QTmlPSwBg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','','','39','35',0,'2012-03-22'),
 (163,'95.108.150.235',3,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-22'),
 (164,'95.108.150.235',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','ru, uk;q=0.8, be;q=0.8, en;q=0.7, *;q=0.01',NULL,'RU','Russian Federation','','','60','100',1,'2012-03-22'),
 (165,'85.98.70.175',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&ved=0CGAQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=mY5rT6iLOoOe0QWh3uW2Bg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Izmir','Izmir','38.4104','27.142',0,'2012-03-22'),
 (166,'95.15.237.32',1,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB7.3; BTRS129463; InfoPath.1)','IE 7.0','Windows XP','tr','http://www.google.com.tr/search?hl=tr&rlz=1T4ADFA_trTR439TR439&gs_upl=0l0l0l14281lllllllllll0&q=%C4%B1sparta%20emlak&spell=1&sa=X','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-22'),
 (167,'180.76.5.64',2,'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)','Mozilla 0.0','Unknown','zh-cn',NULL,'CN','China','','','35','105',1,'2012-03-23'),
 (168,'85.98.70.157',1,'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11','Chrome 17.0','Windows XP','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&ved=0CF4QFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=wEZsT5XlL8Ti8APor_i_DQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Izmir','Izmir','38.4104','27.142',0,'2012-03-23'),
 (169,'88.225.220.254',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Antalya','Antalya','36.9125','30.6897',0,'2012-03-23'),
 (170,'76.72.167.164',2,'Mozilla/5.0 (compatible; MJ12bot/v1.4.2; http://www.majestic12.co.uk/bot.php?+)','Mozilla 0.0','Unknown','en',NULL,'US','United States','Pennsylvania','Philadelphia','39.9968','-75.1485',1,'2012-03-23'),
 (171,'88.255.153.110',3,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB7.3; .NET4.0C; .NET CLR 2.0.50727; .NET4.0E; .NET CLR 3.5.30729)','IE 7.0','Windows XP','tr','http://www.google.com.tr/search?sourceid=navclient&aq=24&oq=sahibinden+kiral%c4%b1k+daire+%c4%b1sparta&hl=tr&ie=UTF-8&rlz=1T4ADSA_trTR345TR351&q=%c4%b1sparta+emlak&gs_upl=0l0l4l19016lllllllllll0&aqi=s204','TR','Turkey','Izmir','Izmir','38.4104','27.142',0,'2012-03-23'),
 (172,'150.70.75.30',2,'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)','IE 6.0','Windows XP','en-us',NULL,'JP','Japan','','','36','138',0,'2012-03-23'),
 (173,'95.10.57.228',1,'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.83 Safari/535.11','Chrome 17.0','Windows 7','tr-TR,tr;q=0.8,en-US;q=0.6,en;q=0.4','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&sqi=2&ved=0CGMQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=z5RsT52FGqmh0QXs2ZHABg&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-23'),
 (174,'46.154.125.150',1,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)','IE 9.0','Windows 7','tr-TR','http://www.google.com.tr/url?sa=t&rct=j&q=%C4%B1sparta%20emlak&source=web&cd=7&ved=0CGUQFjAG&url=http%3A%2F%2Fwww.ispartaemlak.com.tr%2F&ei=kM9sT9LGJZCx8QOAzdi_DQ&usg=AFQjCNEK83PZukvU-LhHiXby6ob0g72zFw','TR','Turkey','','','39','35',0,'2012-03-23'),
 (175,'100.43.83.134',1,'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','Mozilla 0.0','Unknown','en-us, en;q=0.7, *;q=0.01',NULL,'RD','Reserved','','','0','0',1,'2012-03-23'),
 (176,'78.181.237.64',1,'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB7.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)','IE 7.0','Windows XP','tr','http://www.google.com.tr/search?q=%C4%B1sparta+emlak&hl=tr&gbv=2&rlz=1R2ADRA_trTR464&gs_l=hp.3..0l10.2562l11078l0l12765l14l14l0l7l7l0l157l1096l0j7l7l0.llsin.&oq=%C4%B1sparta+emlak&aq=f&aqi=g6&aql=','TR','Turkey','Istanbul','Istanbul','41.0186','28.9647',0,'2012-03-23'),
 (177,'213.43.41.64',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'TR','Turkey','Ankara','Ankara','39.9272','32.8644',0,'2012-03-24'),
 (178,'127.0.0.1',3,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'RD','Reserved','','','0','0',0,'2012-03-24'),
 (179,'127.0.0.1',8,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3','http://localhost:90/','RD','Reserved','','','0','0',0,'2012-03-25'),
 (180,'127.0.0.1',2,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20100101 Firefox/11.0','Firefox 11.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'RD','Reserved','','','0','0',0,'2012-03-26'),
 (181,'127.0.0.1',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0','Firefox 12.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'RD','Reserved','','','0','0',0,'2012-06-15'),
 (182,'127.0.0.1',1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20100101 Firefox/13.0.1','Firefox 13.0','Windows 7','tr-tr,tr;q=0.8,en-us;q=0.5,en;q=0.3',NULL,'RD','Reserved','','','0','0',0,'2012-07-03');
/*!40000 ALTER TABLE `sayac` ENABLE KEYS */;


--
-- Definition of table `sayac_sayfa`
--

DROP TABLE IF EXISTS `sayac_sayfa`;
CREATE TABLE `sayac_sayfa` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ip` varchar(255) DEFAULT NULL,
  `Sayfa` varchar(255) DEFAULT NULL,
  `Hit` int(11) DEFAULT NULL,
  `Tarih` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=274 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sayac_sayfa`
--

/*!40000 ALTER TABLE `sayac_sayfa` DISABLE KEYS */;
INSERT INTO `sayac_sayfa` (`ID`,`Ip`,`Sayfa`,`Hit`,`Tarih`) VALUES 
 (12,'::1','http://localhost:90/kategori/2/isyeri.aspx',2,'2012-02-29'),
 (13,'::1','http://localhost:90/kategori/3/devremulk.aspx',24,'2012-02-29'),
 (14,'::1','http://localhost:90/kategori/4/arsa.aspx',21,'2012-02-29'),
 (15,'::1','http://localhost:90/kategori/5/turistik-isletme.aspx',32,'2012-02-29'),
 (16,'::1','http://localhost:90/kategori/1/konut.aspx',43,'2012-02-29'),
 (17,'::1','http://localhost:90/default.aspx',9,'2012-02-29'),
 (18,'::1','http://localhost:90/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',3,'2012-02-29'),
 (19,'::1','http://localhost:90/ilan/5/satilik-135-mt2-super-lux-apartman-dairesi.aspx',54,'2012-02-29'),
 (20,'::1','http://localhost:90/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',4,'2012-02-29'),
 (21,'::1','http://localhost:90/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-02-29'),
 (22,'::1','http://localhost:90/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',3,'2012-02-29'),
 (23,'::1','http://localhost:90/kategori/2/isyeri.aspx',3,'2012-03-01'),
 (24,'::1','http://localhost:90/kategori/3/devremulk.aspx',2,'2012-03-01'),
 (25,'::1','http://localhost:90/kategori/4/arsa.aspx',1,'2012-03-01'),
 (26,'::1','http://localhost:90/kategori/5/turistik-isletme.aspx',1,'2012-03-01'),
 (27,'::1','http://localhost:90/kategori/1/konut.aspx',2,'2012-03-01'),
 (28,'::1','http://localhost:90/default.aspx',7,'2012-03-01'),
 (29,'::1','http://localhost:90/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',3,'2012-03-01'),
 (30,'::1','http://localhost:90/ilan/5/satilik-135-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-01'),
 (31,'::1','http://localhost:90/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',4,'2012-03-01'),
 (32,'::1','http://localhost:90/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-01'),
 (33,'::1','http://localhost:90/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',3,'2012-03-01'),
 (34,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-01'),
 (35,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-01'),
 (36,'88.225.220.254','http://ispartaemlak.com.tr/kategori/1/konut.aspx',1,'2012-03-01'),
 (37,'88.225.225.119','http://ispartaemlak.com.tr/kategori/2/isyeri.aspx',1,'2012-03-01'),
 (38,'88.225.225.119','http://ispartaemlak.com.tr/kategori/3/devremulk.aspx',1,'2012-03-01'),
 (39,'88.225.225.119','http://ispartaemlak.com.tr/kategori/4/arsa.aspx',1,'2012-03-01'),
 (40,'88.225.220.254','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-01'),
 (41,'150.70.172.204','http://ispartaemlak.com.tr/kategori/3/devremulk.aspx',2,'2012-03-01'),
 (42,'150.70.172.204','http://ispartaemlak.com.tr/kategori/4/arsa.aspx',2,'2012-03-01'),
 (43,'94.123.40.52','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-01'),
 (44,'94.123.40.52','http://ispartaemlak.com.tr/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',1,'2012-03-01'),
 (45,'94.123.40.52','http://ispartaemlak.com.tr/Iletisim.aspx',1,'2012-03-01'),
 (46,'94.123.40.52','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-01'),
 (47,'78.169.157.14','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-01'),
 (48,'78.169.157.14','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',2,'2012-03-01'),
 (49,'95.10.50.253','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-01'),
 (50,'95.10.50.253','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-02'),
 (51,'95.10.50.253','http://ispartaemlak.com.tr/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-02'),
 (52,'76.72.167.163','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-02'),
 (53,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-02'),
 (54,'150.70.172.204','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-02'),
 (55,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-02'),
 (56,'95.8.85.31','http://ispartaemlak.com.tr/default.aspx',5,'2012-03-02'),
 (57,'180.76.5.155','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-03'),
 (58,'180.76.5.51','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-03'),
 (59,'180.76.5.111','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-03'),
 (60,'100.43.83.134','http://ispartaemlak.com.tr/ilan/5/satilik-135-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-04'),
 (61,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-04'),
 (62,'100.43.83.134','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-04'),
 (63,'100.43.83.134','http://ispartaemlak.com.tr/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',1,'2012-03-04'),
 (64,'100.43.83.134','http://ispartaemlak.com.tr/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-04'),
 (65,'180.76.5.164','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-04'),
 (66,'100.43.83.134','http://ispartaemlak.com.tr/ilan/1/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-04'),
 (67,'180.76.5.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-04'),
 (68,'100.43.83.134','http://ispartaemlak.com.tr/Iletisim.aspx',1,'2012-03-04'),
 (69,'100.43.83.134','http://ispartaemlak.com.tr/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-04'),
 (70,'180.76.5.183','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-05'),
 (71,'94.23.42.135','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-05'),
 (72,'100.43.83.134','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-05'),
 (73,'100.43.83.134','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-05'),
 (74,'100.43.83.134','http://ispartaemlak.com.tr/kategori/3/devremulk.aspx',1,'2012-03-05'),
 (75,'100.43.83.134','http://ispartaemlak.com.tr/kategori/4/arsa.aspx',1,'2012-03-05'),
 (76,'100.43.83.134','http://ispartaemlak.com.tr/kategori/1/konut.aspx',1,'2012-03-05'),
 (77,'100.43.83.134','http://ispartaemlak.com.tr/kategori/2/isyeri.aspx',1,'2012-03-05'),
 (78,'180.76.6.231','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-06'),
 (79,'66.226.77.39','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-06'),
 (80,'66.226.77.39','http://ispartaemlak.com.tr/ilan/1/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (81,'66.226.77.39','http://ispartaemlak.com.tr/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-06'),
 (82,'66.226.77.39','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (83,'66.226.77.39','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-06'),
 (84,'66.226.77.39','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-06'),
 (85,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-06'),
 (86,'88.250.236.193','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-06'),
 (87,'88.250.236.193','http://ispartaemlak.com.tr/ilan/1/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (88,'88.225.232.230','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-06'),
 (89,'88.225.232.230','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (90,'88.225.232.230','http://ispartaemlak.com.tr/ilan/5/satilik-135-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (91,'64.246.161.190','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-06'),
 (92,'95.108.151.244','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-06'),
 (93,'78.164.255.66','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-06'),
 (94,'85.106.151.194','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-06'),
 (95,'85.106.151.194','http://ispartaemlak.com.tr/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-06'),
 (96,'100.43.83.134','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (97,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (98,'88.225.220.254','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-07'),
 (99,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (100,'150.70.75.30','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-07'),
 (101,'150.70.172.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (102,'180.76.5.142','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (103,'88.250.71.141','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-07'),
 (104,'78.186.234.54','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (105,'88.225.227.8','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (106,'180.76.5.95','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (107,'180.76.5.58','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-07'),
 (108,'180.76.5.168','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (109,'94.23.42.135','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-08'),
 (110,'180.76.5.159','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (111,'193.140.181.20','http://ispartaemlak.com.tr/default.aspx',3,'2012-03-08'),
 (112,'180.76.5.149','http://ispartaemlak.com.tr/kategori/3/devremulk.aspx',1,'2012-03-08'),
 (113,'174.143.151.116','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (114,'78.164.225.43','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (115,'78.164.225.43','http://ispartaemlak.com.tr/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',1,'2012-03-08'),
 (116,'180.76.5.189','http://ispartaemlak.com.tr/ilan/1/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-08'),
 (117,'180.76.5.48','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (118,'94.123.40.52','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-08'),
 (119,'94.123.40.52','http://ispartaemlak.com.tr/ilan/5/satilik-135-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-08'),
 (120,'88.236.247.71','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-08'),
 (121,'88.236.247.71','http://ispartaemlak.com.tr/ilan/1/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-08'),
 (122,'88.236.247.71','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-08'),
 (123,'88.236.247.71','http://ispartaemlak.com.tr/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',1,'2012-03-08'),
 (124,'88.236.247.71','http://ispartaemlak.com.tr/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-08'),
 (125,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-09'),
 (126,'188.41.243.245','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-09'),
 (127,'180.76.5.176','http://ispartaemlak.com.tr/ilan/6/satilik-140-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-09'),
 (128,'180.76.6.225','http://ispartaemlak.com.tr/ilan/3/satilik-240-mt2-super-lux-apartman-dairesi.aspx',1,'2012-03-09'),
 (129,'31.167.39.18','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-09'),
 (130,'::1','http://localhost:90/default.aspx',3,'2012-03-12'),
 (131,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-13'),
 (132,'150.70.172.204','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-13'),
 (133,'100.43.83.134','http://ispartaemlak.com.tr/ilan/10/kurtulus-mh-lux-ofis.aspx',1,'2012-03-13'),
 (134,'175.158.29.208','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-13'),
 (135,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-13'),
 (136,'94.123.46.185','http://ispartaemlak.com.tr/default.aspx',20,'2012-03-13'),
 (137,'88.225.220.254','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-13'),
 (138,'88.225.220.254','http://ispartaemlak.com.tr/kategori/3/devremulk.aspx',1,'2012-03-13'),
 (139,'::1','http://localhost:90/default.aspx',1,'2012-03-13'),
 (140,'95.15.235.69','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-13'),
 (141,'84.168.121.94','http://ispartaemlak.com.tr/default.aspx',7,'2012-03-13'),
 (142,'84.168.121.94','http://ispartaemlak.com.tr/kategori/2/isyeri.aspx',1,'2012-03-13'),
 (143,'95.10.61.179','http://ispartaemlak.com.tr/default.aspx',9,'2012-03-13'),
 (144,'84.168.121.94','http://ispartaemlak.com.tr/kategori/1/konut.aspx',1,'2012-03-13'),
 (145,'188.3.196.177','http://ispartaemlak.com.tr/default.aspx',5,'2012-03-13'),
 (146,'180.76.6.233','http://ispartaemlak.com.tr/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-13'),
 (147,'95.10.52.4','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-13'),
 (148,'46.104.155.178','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-13'),
 (149,'46.104.155.178','http://ispartaemlak.com.tr/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-13'),
 (150,'150.70.172.103','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-13'),
 (151,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',5,'2012-03-14'),
 (152,'88.225.225.119','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',2,'2012-03-14'),
 (153,'150.70.172.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-14'),
 (154,'150.70.172.103','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-14'),
 (155,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-14'),
 (156,'76.72.167.164','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-14'),
 (157,'78.189.166.219','http://ispartaemlak.com.tr/default.aspx',7,'2012-03-14'),
 (158,'78.189.166.219','http://ispartaemlak.com.tr/kategori/1/konut.aspx',1,'2012-03-14'),
 (159,'150.70.75.30','http://ispartaemlak.com.tr/kategori/1/konut.aspx',1,'2012-03-14'),
 (160,'180.76.5.151','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-14'),
 (161,'180.76.5.167','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-14'),
 (162,'78.187.13.69','http://ispartaemlak.com.tr/default.aspx',7,'2012-03-14'),
 (163,'180.76.6.21','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-14'),
 (164,'94.123.46.185','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-14'),
 (165,'94.123.46.185','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',3,'2012-03-14'),
 (166,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-14'),
 (167,'95.15.124.227','http://ispartaemlak.com.tr/ilan/4/satilik-110-mt2-apartman-dairesi.aspx',3,'2012-03-15'),
 (168,'95.15.124.227','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-15'),
 (169,'180.76.6.26','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-15'),
 (170,'180.76.5.149','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (171,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (172,'88.240.200.171','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (173,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-15'),
 (174,'150.70.64.195','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (175,'78.187.209.59','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-15'),
 (176,'150.70.75.30','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (177,'94.123.46.185','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-15'),
 (178,'180.76.5.164','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-15'),
 (179,'94.123.46.185','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-15'),
 (180,'94.123.46.185','http://ispartaemlak.com.tr/ilan/18/satilik-mustakil-ev-tarihi.aspx',1,'2012-03-15'),
 (181,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-16'),
 (182,'88.225.220.254','http://ispartaemlak.com.tr/ilan/18/satilik-mustakil-ev-tarihi.aspx',1,'2012-03-16'),
 (183,'88.225.220.254','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-16'),
 (184,'150.70.172.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (185,'150.70.172.103','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-16'),
 (186,'150.70.172.103','http://ispartaemlak.com.tr/ilan/18/satilik-mustakil-ev-tarihi.aspx',1,'2012-03-16'),
 (187,'88.225.225.119','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-16'),
 (188,'150.70.172.204','http://ispartaemlak.com.tr/kategori/5/turistik-isletme.aspx',1,'2012-03-16'),
 (189,'180.76.5.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (190,'94.123.37.144','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-16'),
 (191,'78.165.80.42','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (192,'180.76.5.97','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (193,'95.15.202.184','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-16'),
 (194,'94.123.52.181','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (195,'180.76.5.110','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-16'),
 (196,'95.10.37.224','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-16'),
 (197,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-16'),
 (198,'100.43.83.134','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-17'),
 (199,'94.123.35.232','http://ispartaemlak.com.tr/default.aspx',13,'2012-03-17'),
 (200,'94.123.35.232','http://ispartaemlak.com.tr/ilan/18/satilik-mustakil-ev-tarihi.aspx',1,'2012-03-17'),
 (201,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-17'),
 (202,'150.70.172.103','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-17'),
 (203,'76.72.167.162','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-17'),
 (204,'94.123.35.232','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',1,'2012-03-17'),
 (205,'85.105.150.232','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-17'),
 (206,'213.43.22.96','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-17'),
 (207,'213.43.22.96','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-17'),
 (208,'150.70.172.204','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-17'),
 (209,'180.76.5.166','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-18'),
 (210,'216.145.17.190','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-18'),
 (211,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',6,'2012-03-18'),
 (212,'94.123.47.79','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-18'),
 (213,'180.76.5.137','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (214,'94.123.47.79','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (215,'88.225.225.119','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (216,'94.235.214.152','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (217,'95.10.39.236','http://ispartaemlak.com.tr/default.aspx',9,'2012-03-19'),
 (218,'95.10.39.236','http://ispartaemlak.com.tr/ilan/22/satilik-imar-sinirina-bitisik-tarla-tam-yatirimlik.aspx',4,'2012-03-19'),
 (219,'95.10.39.236','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',2,'2012-03-19'),
 (220,'95.10.37.20','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-19'),
 (221,'95.10.37.20','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',1,'2012-03-19'),
 (222,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (223,'88.225.220.254','http://ispartaemlak.com.tr/ilan/25/satilik-tarla.aspx',1,'2012-03-19'),
 (224,'180.76.5.194','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (225,'95.108.151.244','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (226,'95.108.151.244','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (227,'95.108.151.244','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-19'),
 (228,'180.76.5.141','http://ispartaemlak.com.tr/ilan/12/satilik-arsa.aspx',1,'2012-03-20'),
 (229,'180.76.5.172','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-20'),
 (230,'94.123.39.45','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-20'),
 (231,'95.10.62.230','http://ispartaemlak.com.tr/default.aspx',3,'2012-03-20'),
 (232,'95.10.62.66','http://ispartaemlak.com.tr/default.aspx',3,'2012-03-20'),
 (233,'95.10.62.66','http://ispartaemlak.com.tr/sayfa/1/hakkimizda.aspx',1,'2012-03-20'),
 (234,'76.72.167.164','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-20'),
 (235,'95.15.233.50','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-20'),
 (236,'95.15.87.44','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',1,'2012-03-20'),
 (237,'176.40.29.70','http://ispartaemlak.com.tr/default.aspx',3,'2012-03-20'),
 (238,'176.40.29.70','http://ispartaemlak.com.tr/ilan/26/satilik-arsa.aspx',1,'2012-03-20'),
 (239,'176.40.29.70','http://ispartaemlak.com.tr/ilan/25/satilik-tarla.aspx',1,'2012-03-20'),
 (240,'176.40.29.70','http://ispartaemlak.com.tr/ilan/22/satilik-imar-sinirina-bitisik-tarla-tam-yatirimlik.aspx',3,'2012-03-20'),
 (241,'176.40.29.70','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',1,'2012-03-20'),
 (242,'176.40.29.70','http://ispartaemlak.com.tr/Iletisim.aspx',1,'2012-03-20'),
 (243,'85.104.5.71','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-20'),
 (244,'88.255.153.110','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-20'),
 (245,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-20'),
 (246,'188.119.45.119','http://ispartaemlak.com.tr/default.aspx',7,'2012-03-21'),
 (247,'100.43.83.134','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-21'),
 (248,'95.0.195.7','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-22'),
 (249,'95.0.195.7','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-22'),
 (250,'95.108.150.235','http://ispartaemlak.com.tr/default.aspx',4,'2012-03-22'),
 (251,'85.98.70.175','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-22'),
 (252,'95.15.237.32','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-22'),
 (253,'95.15.237.32','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',2,'2012-03-22'),
 (254,'180.76.5.64','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-23'),
 (255,'85.98.70.157','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-23'),
 (256,'88.225.220.254','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-23'),
 (257,'76.72.167.164','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-23'),
 (258,'88.255.153.110','http://ispartaemlak.com.tr/default.aspx',3,'2012-03-23'),
 (259,'150.70.75.30','http://ispartaemlak.com.tr/default.aspx',2,'2012-03-23'),
 (260,'95.10.57.228','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-23'),
 (261,'46.154.125.150','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-23'),
 (262,'100.43.83.134','http://ispartaemlak.com.tr/ilan/21/satilik-mustakil-ev.aspx',1,'2012-03-23'),
 (263,'78.181.237.64','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-23'),
 (264,'213.43.41.64','http://ispartaemlak.com.tr/default.aspx',1,'2012-03-24'),
 (265,'127.0.0.1','http://localhost:90/default.aspx',3,'2012-03-24'),
 (266,'127.0.0.1','http://localhost:90/kategori/1/konut.aspx',1,'2012-03-25'),
 (267,'127.0.0.1','http://localhost:90/Arama.aspx',2,'2012-03-25'),
 (268,'127.0.0.1','http://localhost:90/default.aspx',7,'2012-03-25'),
 (269,'127.0.0.1','http://localhost:90/EmlakTalep.aspx',29,'2012-03-25'),
 (270,'127.0.0.1','http://localhost:90/default.aspx',2,'2012-03-26'),
 (271,'127.0.0.1','http://localhost:90/ilan/2/satilik-240-mt2-4-1-apartman-dairesi.aspx',1,'2012-03-26'),
 (272,'127.0.0.1','http://localhost:90/default.aspx',1,'2012-06-15'),
 (273,'127.0.0.1','http://localhost:90/default.aspx',1,'2012-07-03');
/*!40000 ALTER TABLE `sayac_sayfa` ENABLE KEYS */;


--
-- Definition of table `sayfa`
--

DROP TABLE IF EXISTS `sayfa`;
CREATE TABLE `sayfa` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UstID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Ozet` text,
  `Detay` text,
  `AnaMenu` int(11) DEFAULT NULL,
  `AltMenu` int(11) DEFAULT NULL,
  `Sira` int(11) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  CONSTRAINT `sayfa_ibfk_1` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sayfa_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sayfa`
--

/*!40000 ALTER TABLE `sayfa` DISABLE KEYS */;
INSERT INTO `sayfa` (`ID`,`UstID`,`Baslik`,`Ozet`,`Detay`,`AnaMenu`,`AltMenu`,`Sira`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,0,'Hakkımızda','<p>\r\n	Hakkımızda &ouml;zeti</p>\r\n','<p>\r\n	Hakkımızda detayı</p>\r\n',1,1,1,1,'2012-02-10 22:11:15','2012-02-29 14:04:06',1,1);
/*!40000 ALTER TABLE `sayfa` ENABLE KEYS */;


--
-- Definition of table `sehir_il`
--

DROP TABLE IF EXISTS `sehir_il`;
CREATE TABLE `sehir_il` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Baslik` varchar(255) DEFAULT NULL,
  `Plaka` varchar(255) DEFAULT NULL,
  `AlanKod` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  CONSTRAINT `sehir_il_ibfk_1` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sehir_il_ibfk_2` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sehir_il`
--

/*!40000 ALTER TABLE `sehir_il` DISABLE KEYS */;
INSERT INTO `sehir_il` (`ID`,`Baslik`,`Plaka`,`AlanKod`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,'Isparta','32',NULL,1,'2012-02-07 00:49:54',NULL,1,NULL),
 (2,'Antalya','07','242',1,'2012-02-10 08:57:50',NULL,1,NULL),
 (3,'İstanbul','34',NULL,1,'2012-02-10 09:01:23',NULL,1,NULL),
 (4,'Ankara','06',NULL,1,'2012-02-10 09:01:25',NULL,1,NULL),
 (5,'İzmir','35','232',1,'2012-02-10 09:01:27',NULL,1,NULL),
 (6,'Adana','01',NULL,1,'2012-02-10 09:01:31',NULL,1,NULL),
 (7,'Adıyaman','02',NULL,1,'2012-02-10 09:01:34',NULL,1,NULL),
 (8,'Afyonkarahisar','03',NULL,1,'2012-02-10 09:01:37',NULL,1,NULL),
 (9,'Ağrı','04',NULL,1,'2012-02-10 09:01:39',NULL,1,NULL),
 (10,'Aksaray','68',NULL,1,'2012-02-10 09:01:41',NULL,1,NULL),
 (11,'Amasya','05',NULL,1,'2012-02-10 09:01:43',NULL,1,NULL),
 (13,'Ardahan','75',NULL,1,'2012-02-10 09:01:49',NULL,1,NULL),
 (14,'Artvin','08',NULL,1,'2012-02-10 09:01:52',NULL,1,NULL),
 (15,'Aydın','09',NULL,1,'2012-02-10 09:01:54',NULL,1,NULL),
 (16,'Balıkesir','10',NULL,1,'2012-02-10 09:01:57',NULL,1,NULL),
 (17,'Bartın','74',NULL,1,'2012-02-10 09:01:59',NULL,1,NULL),
 (18,'Batman','72',NULL,1,'2012-02-10 09:02:02',NULL,1,NULL),
 (19,'Bayburt','69',NULL,1,'2012-02-10 09:02:04',NULL,1,NULL),
 (20,'Bilecik','11',NULL,1,'2012-02-10 09:02:06',NULL,1,NULL),
 (21,'Bingöl','12',NULL,1,'2012-02-10 09:02:13',NULL,1,NULL),
 (22,'Bitlis','13',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (23,'Bolu','14',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (24,'Burdur','15',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (25,'Bursa','16',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (26,'Çanakkale','17',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (27,'Çankırı','18',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (28,'Çorum','19',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (29,'Denizli','20',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (30,'Diyarbakır','21',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (31,'Düzce','81',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (32,'Edirne','22',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (33,'Elazığ','23',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (34,'Erzincan','24',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (35,'Erzurum','25',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (36,'Eskişehir','26',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (37,'Gaziantep','27',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (38,'Giresun','28',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (39,'Gümüşhane','29',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (40,'Hakkari','30',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (41,'Hatay','31',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (42,'Iğdır','76',NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (43,'Kahramanmaraş',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (44,'Karabük',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (45,'Karaman',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (46,'Kars',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (47,'Kastamonu',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (48,'Kayseri',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (49,'Kırıkkale',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (50,'Kırklareli',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (51,'Kırşehir',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (52,'Kilis',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (53,'Kocaeli',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (54,'Konya',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (55,'Kütahya',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (56,'Malatya',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (57,'Manisa',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (58,'Mardin',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (59,'Mersin (İçel)',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (60,'Muğla',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (61,'Muş',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (62,'Nevşehir',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (63,'Niğde',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (64,'Ordu',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (65,'Osmaniye',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (66,'Rize',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (67,'Sakarya',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (68,'Samsun',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (69,'Siirt',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (70,'Sinop',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (71,'Sivas',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (72,'Şanlıurfa',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (73,'Şırnak',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (74,'Tekirdağ',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (75,'Tokat',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (76,'Trabzon',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (77,'Tunceli',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (78,'Uşak',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (79,'Van',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (80,'Yalova',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (81,'Yozgat',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL),
 (82,'Zonguldak',NULL,NULL,1,'2012-03-12 16:50:38',NULL,1,NULL);
/*!40000 ALTER TABLE `sehir_il` ENABLE KEYS */;


--
-- Definition of table `sehir_ilce`
--

DROP TABLE IF EXISTS `sehir_ilce`;
CREATE TABLE `sehir_ilce` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IlID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IlID` (`IlID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  CONSTRAINT `sehir_ilce_ibfk_1` FOREIGN KEY (`IlID`) REFERENCES `sehir_il` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sehir_ilce_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sehir_ilce_ibfk_3` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sehir_ilce`
--

/*!40000 ALTER TABLE `sehir_ilce` DISABLE KEYS */;
INSERT INTO `sehir_ilce` (`ID`,`IlID`,`Baslik`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,1,'Aksu',1,'2012-02-07 00:51:45',NULL,1,NULL),
 (2,1,'Atabey',1,'2012-02-07 00:51:48',NULL,1,NULL),
 (3,1,'Eğirdir',1,'2012-02-07 00:51:51',NULL,1,NULL),
 (4,1,'Gelendost',1,'2012-02-07 00:51:53',NULL,1,NULL),
 (5,1,'Gönen',1,'2012-02-07 00:51:55',NULL,1,NULL),
 (6,1,'Keçiborlu',1,'2012-02-07 00:51:58',NULL,1,NULL),
 (7,1,'Merkez',1,'2012-02-07 00:52:02',NULL,1,NULL),
 (8,1,'Senirkent',1,'2012-02-07 00:52:05',NULL,1,NULL),
 (9,1,'Sütçüler',1,'2012-02-07 00:52:07',NULL,1,NULL),
 (10,1,'Şarkikaraağaç',1,'2012-02-07 00:52:09',NULL,1,NULL),
 (11,1,'Uluborlu',1,'2012-02-07 00:52:14',NULL,1,NULL),
 (12,1,'Yalvaç',1,'2012-02-07 00:52:18',NULL,1,NULL),
 (13,1,'Yenişarbademli',1,'2012-02-07 00:52:22',NULL,1,NULL),
 (14,2,'Akseki',1,'2012-02-10 09:04:17',NULL,1,NULL),
 (15,2,'Aksu',1,'2012-02-10 09:04:20',NULL,1,NULL),
 (16,2,'Alanya',1,'2012-02-10 09:04:22',NULL,1,NULL),
 (17,2,'Demre',1,'2012-02-10 09:04:25',NULL,1,NULL),
 (18,2,'Döşemealtı',1,'2012-02-10 09:04:28',NULL,1,NULL),
 (19,2,'Elmalı',1,'2012-02-10 09:04:31',NULL,1,NULL),
 (20,2,'Finike',1,'2012-02-10 09:04:33',NULL,1,NULL),
 (21,2,'Gazipaşa',1,'2012-02-10 09:04:35',NULL,1,NULL),
 (22,2,'Gündoğmuş',1,'2012-02-10 09:04:38',NULL,1,NULL),
 (23,2,'İbradi',1,'2012-02-10 09:04:40',NULL,1,NULL),
 (24,2,'Kaş',1,'2012-02-10 09:04:43',NULL,1,NULL),
 (25,2,'Kemer',1,'2012-02-10 09:04:46',NULL,1,NULL),
 (26,2,'Kepez',1,'2012-02-10 09:04:48',NULL,1,NULL),
 (27,2,'Konyaaltı',1,'2012-02-10 09:04:50',NULL,1,NULL),
 (28,2,'Korkuteli',1,'2012-02-10 09:04:53',NULL,1,NULL),
 (29,2,'Kumluca',1,'2012-02-10 09:04:55',NULL,1,NULL),
 (30,2,'Manavgat',1,'2012-02-10 09:04:57',NULL,1,NULL),
 (31,2,'Muratpaşa',1,'2012-02-10 09:05:00',NULL,1,NULL),
 (32,2,'Serik',1,'2012-02-10 09:05:05',NULL,1,NULL);
/*!40000 ALTER TABLE `sehir_ilce` ENABLE KEYS */;


--
-- Definition of table `sehir_semt`
--

DROP TABLE IF EXISTS `sehir_semt`;
CREATE TABLE `sehir_semt` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IlceID` int(11) DEFAULT NULL,
  `Baslik` varchar(255) DEFAULT NULL,
  `Onay` int(11) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `EkleyenID` int(11) DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IlceID` (`IlceID`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE,
  KEY `Onay` (`Onay`) USING BTREE,
  KEY `GuncelleyenID` (`GuncelleyenID`) USING BTREE,
  KEY `EkleyenID` (`EkleyenID`) USING BTREE,
  CONSTRAINT `sehir_semt_ibfk_1` FOREIGN KEY (`IlceID`) REFERENCES `sehir_ilce` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sehir_semt_ibfk_2` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sehir_semt_ibfk_3` FOREIGN KEY (`EkleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sehir_semt`
--

/*!40000 ALTER TABLE `sehir_semt` DISABLE KEYS */;
INSERT INTO `sehir_semt` (`ID`,`IlceID`,`Baslik`,`Onay`,`KayitTarih`,`DegisTarih`,`EkleyenID`,`GuncelleyenID`) VALUES 
 (1,7,'Ayazmana Mh.',1,'2012-02-10 09:11:42',NULL,1,NULL),
 (2,7,'Bağlar Mh.',1,'2012-02-10 09:11:44',NULL,1,NULL),
 (3,7,'Bahçelievler Mh.',1,'2012-02-10 09:11:47',NULL,1,NULL),
 (4,7,'Batıkent Mh.',1,'2012-02-10 09:11:49',NULL,1,NULL),
 (5,7,'Binbirevler Mh.',1,'2012-02-10 09:12:08',NULL,1,NULL),
 (6,7,'Büyükgökçeli',1,'2012-02-10 09:12:12',NULL,1,NULL),
 (7,7,'Çelebiler Mh.',1,'2012-02-10 09:12:14',NULL,1,NULL),
 (8,7,'Çünür Mh.',1,'2012-02-10 09:12:17',NULL,1,NULL),
 (9,7,'Davraz Mh.',1,'2012-02-10 09:12:19',NULL,1,NULL),
 (10,7,'Dere Mh.',1,'2012-02-10 09:12:21',NULL,1,NULL),
 (11,7,'Doğancı Mh.',1,'2012-02-10 09:12:24',NULL,1,NULL),
 (12,7,'Emre Mh.',1,'2012-02-10 09:12:26',NULL,1,NULL),
 (13,7,'Fatih Mh.',1,'2012-02-10 09:12:28',NULL,1,NULL),
 (14,7,'Gazi Kemal Mh.',1,'2012-02-10 09:12:31',NULL,1,NULL),
 (15,7,'Gülcü Mh.',1,'2012-02-10 09:12:33',NULL,1,NULL),
 (16,7,'Gülevler Mh.',1,'2012-02-10 09:12:36',NULL,1,NULL),
 (17,7,'Gülistan Mh.',1,'2012-02-10 09:12:38',NULL,1,NULL),
 (18,7,'Halıkent Mh.',1,'2012-02-10 09:12:41',NULL,1,NULL),
 (19,7,'Halife Sultan Mh.',1,'2012-02-10 09:12:46',NULL,1,NULL),
 (20,7,'Hızırbey Mh.',1,'2012-02-10 09:12:48',NULL,1,NULL),
 (21,7,'Hisar Mh.',1,'2012-02-10 09:12:51',NULL,1,NULL),
 (22,7,'Işıkkent Mh.',1,'2012-02-10 09:12:53',NULL,1,NULL),
 (23,7,'İskender Mh.',1,'2012-02-10 09:12:55',NULL,1,NULL),
 (24,7,'İstiklal Mh.',1,'2012-02-10 09:12:58',NULL,1,NULL),
 (25,7,'Karaağaç Mh.',1,'2012-02-10 09:13:01',NULL,1,NULL),
 (26,7,'Keçeci Mh.',1,'2012-02-10 09:13:03',NULL,1,NULL),
 (27,7,'Kepeci Mh.',1,'2012-02-10 09:13:05',NULL,1,NULL),
 (28,7,'Kuleönü Mh.',1,'2012-02-10 09:13:08',NULL,1,NULL),
 (29,7,'Kurtuluş Mh.',1,'2012-02-10 09:13:12',NULL,1,NULL),
 (30,7,'Kutlubey Mh.',1,'2012-02-10 09:13:14',NULL,1,NULL),
 (31,1,'Akçasar Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (32,1,'Bahçeli Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (33,1,'Çay Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (34,1,'Hürriyet Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (35,1,'İstiklal Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (36,1,'Kurtuluş Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (37,1,'Orta Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (38,1,'Pazarcık Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (39,1,'Tepe Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (40,1,'Yakaafşar Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (41,1,'Eldere',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (42,1,'Elecik',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (43,1,'Karacahisar',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (44,1,'Karağı',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (45,1,'Katipköy',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (46,1,'Koçular',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (47,1,'Kösre',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (48,1,'Sofular',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (49,1,'Terziler',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (50,1,'Yakaköy',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (51,1,'Yılanlı',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (52,1,'Yukarıyaylabel',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (53,2,'Altunba Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (54,2,'Çeşme Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (55,2,'Gezirler Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (56,2,'İslamköy',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (57,2,'Müftü Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (58,2,'Onaç Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (59,2,'Pazar Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (60,2,'Sinan Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (61,2,'Sökmen Mh.',1,'2012-03-12 16:58:41',NULL,1,NULL),
 (62,2,'Yeni Mh.',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (63,2,'Bayat',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (64,2,'Harmanören',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (65,2,'Kapıcak',1,'2012-03-12 16:58:44',NULL,1,NULL),
 (66,2,'Penbeli',1,'2012-03-12 16:58:44',NULL,1,NULL);
/*!40000 ALTER TABLE `sehir_semt` ENABLE KEYS */;


--
-- Definition of table `talep`
--

DROP TABLE IF EXISTS `talep`;
CREATE TABLE `talep` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Il` int(11) DEFAULT NULL,
  `Ilce` int(11) DEFAULT NULL,
  `Semt` int(11) DEFAULT NULL,
  `KatID` int(11) DEFAULT NULL,
  `IlanTur` varchar(255) DEFAULT NULL,
  `Adi` varchar(255) DEFAULT NULL,
  `Telefon` varchar(255) DEFAULT NULL,
  `EPosta` varchar(255) DEFAULT NULL,
  `Mesaj` text,
  `YoneticiMesaj` text,
  `IPAdres` varchar(255) DEFAULT NULL,
  `Durum` varchar(255) DEFAULT NULL,
  `KayitTarih` datetime DEFAULT NULL,
  `DegisTarih` datetime DEFAULT NULL,
  `GuncelleyenID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Il` (`Il`),
  KEY `Ilce` (`Ilce`),
  KEY `Semt` (`Semt`),
  KEY `KatID` (`KatID`),
  KEY `ID` (`ID`),
  KEY `GuncelleyenID` (`GuncelleyenID`),
  CONSTRAINT `talep_ibfk_1` FOREIGN KEY (`Il`) REFERENCES `sehir_il` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_2` FOREIGN KEY (`Ilce`) REFERENCES `sehir_ilce` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_3` FOREIGN KEY (`Semt`) REFERENCES `sehir_semt` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_4` FOREIGN KEY (`KatID`) REFERENCES `kategori` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_5` FOREIGN KEY (`GuncelleyenID`) REFERENCES `kullanici` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `talep`
--

/*!40000 ALTER TABLE `talep` DISABLE KEYS */;
INSERT INTO `talep` (`ID`,`Il`,`Ilce`,`Semt`,`KatID`,`IlanTur`,`Adi`,`Telefon`,`EPosta`,`Mesaj`,`YoneticiMesaj`,`IPAdres`,`Durum`,`KayitTarih`,`DegisTarih`,`GuncelleyenID`) VALUES 
 (1,1,7,2,1,'Satılık','Emre Özkan','0 242 123 45 67','deneme@deneme.com','140 mt2 3+1 ebeveyn banyolu satılık apartman dairesi istiyorum','deneme','192.168.1.1','İptal Edildi','2012-03-12 17:07:06','2012-03-13 10:29:01',1),
 (2,1,7,3,1,'Kiralık','Hüseyin Yıldırım','0 543 123 45 67','huseyin@hotmail.com','Öğrenciye uygun studio daire istiyorum',NULL,'85.25.45.52','Cevaplandı','2012-03-12 17:07:58',NULL,NULL),
 (3,1,7,16,1,'Satılık','Hüseyin Yıldırım','0 242 321 17 48','hye@hotmail.com.tr','bana acil bir ev lazım :)',NULL,'127.0.0.1','Bekliyor','2012-03-25 16:12:49',NULL,NULL);
/*!40000 ALTER TABLE `talep` ENABLE KEYS */;


--
-- Definition of procedure `elmah_GetErrorsXml`
--

DROP PROCEDURE IF EXISTS `elmah_GetErrorsXml`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE `elmah_GetErrorsXml`(
  IN App VARCHAR(60),
  IN PageIndex INT(10),
  IN PageSize INT(10),
  OUT TotalCount INT(10)
)
    READS SQL DATA
BEGIN
    
    SELECT  count(*) INTO TotalCount
    FROM    `elmah_error`
    WHERE   `Application` = App;

    SET @index = PageIndex * PageSize;
    SET @count = PageSize;
    SET @app = App;
    PREPARE STMT FROM '
    SELECT
        `ErrorId`,
        `Application`,
        `Host`,
        `Type`,
        `Source`,
        `Message`,
        `User`,
        `StatusCode`,
        CONCAT(`TimeUtc`, '' Z'') AS `TimeUtc`
    FROM
        `elmah_error` error
    WHERE
        `Application` = ?
    ORDER BY
        `TimeUtc` DESC,
        `Sequence` DESC
    LIMIT
        ?, ?';
    EXECUTE STMT USING @app, @index, @count;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `elmah_GetErrorXml`
--

DROP PROCEDURE IF EXISTS `elmah_GetErrorXml`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE `elmah_GetErrorXml`(
  IN Id CHAR(36),
  IN App VARCHAR(60)
)
    READS SQL DATA
BEGIN
    SELECT  `AllXml`
    FROM    `elmah_error`
    WHERE   `ErrorId` = Id AND `Application` = App;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `elmah_LogError`
--

DROP PROCEDURE IF EXISTS `elmah_LogError`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`%` PROCEDURE `elmah_LogError`(
    IN ErrorId CHAR(36), 
    IN Application varchar(60), 
    IN Host VARCHAR(30), 
    IN Type VARCHAR(100), 
    IN Source VARCHAR(60), 
    IN Message VARCHAR(500), 
    IN User VARCHAR(50), 
    IN AllXml TEXT, 
    IN StatusCode INT(10), 
    IN TimeUtc DATETIME
)
    MODIFIES SQL DATA
BEGIN
    INSERT INTO `elmah_error` (
        `ErrorId`, 
        `Application`, 
        `Host`, 
        `Type`, 
        `Source`, 
        `Message`, 
        `User`, 
        `AllXml`, 
        `StatusCode`, 
        `TimeUtc`
    ) VALUES (
        ErrorId, 
        Application, 
        Host, 
        Type, 
        Source, 
        Message, 
        User, 
        AllXml, 
        StatusCode, 
        TimeUtc
    );
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
