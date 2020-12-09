-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 09, 2020 at 03:11 AM
-- Server version: 5.7.26
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hippo_crates_general`
--
CREATE DATABASE IF NOT EXISTS `hippo_crates_general` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hippo_crates_general`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `addStaff`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addStaff` (IN `fname` VARBINARY(90), IN `lname` VARBINARY(90), IN `pos` VARBINARY(90), IN `username` VARBINARY(25), IN `pass` VARBINARY(40))  NO SQL
BEGIN
INSERT INTO vwdii(iqdph, oqdph, srvlwlrq, xvhuqdph, sdvvzrug)
VALUES (fname, lname, pos, username, pass);
END$$

DROP PROCEDURE IF EXISTS `CreatePaitent`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePaitent` (IN `fname` VARBINARY(150), IN `mname` VARBINARY(150), IN `lname` VARBINARY(150), IN `street` VARBINARY(120), IN `city` VARBINARY(120), IN `state` VARBINARY(25), IN `zip` VARBINARY(30), IN `phone` VARBINARY(40), IN `birthdate` VARBINARY(50), IN `ssn` VARBINARY(30), IN `email` VARBINARY(120), IN `username` VARBINARY(250))  NO SQL
BEGIN
CALL recordEvent('CreatePaitent', birthdate, username);



	INSERT INTO sdwlhqw(sdwlhqw.iqdph, sdwlhqw.pqdph, sdwlhqw.oqdph, sdwlhqw.vwuhhw, sdwlhqw.flwb, sdwlhqw.vwdwh, sdwlhqw.cls, sdwlhqw.skrqh, sdwlhqw.eluwkgdwh, sdwlhqw.vvq, sdwlhqw.hpdlo)
    VALUES(fname, mname, lname, street, city, state, zip, phone, birthdate, ssn, email);
END$$

DROP PROCEDURE IF EXISTS `CreateVisit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateVisit` (IN `username` VARBINARY(250), IN `paitentID` INT(25), IN `dateIn` VARCHAR(100), IN `dateOut` VARCHAR(100), IN `reason` VARBINARY(250))  NO SQL
BEGIN
CALL recordEvent('CreateVisit', paitentID, username);
INSERT INTO ylvlw(ylvlw.xvhuqdph, ylvlw.sdwlhqwqxp, ylvlw.gdwhlq, ylvlw.gdwhrxw, ylvlw.uhdvrq)
VALUES(username, paitentID, dateIn, dateOut, reason);
END$$

DROP PROCEDURE IF EXISTS `getPaitentData`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPaitentData` (IN `paitentID` INT(25), OUT `fName` VARBINARY(225), OUT `mName` VARBINARY(225), OUT `lName` VARBINARY(225), OUT `street` VARBINARY(225), OUT `city` VARBINARY(225), OUT `state` VARBINARY(225), OUT `zip` VARBINARY(225), OUT `phone` VARBINARY(225), OUT `bday` VARBINARY(225), OUT `ssn` VARBINARY(225), OUT `email` VARBINARY(225), OUT `dday` VARBINARY(225))  NO SQL
BEGIN
	SELECT sdwlhqw.iqdph, sdwlhqw.pqdph, sdwlhqw.oqdph, sdwlhqw.vwuhhw, sdwlhqw.flwb, sdwlhqw.vwuhhw, sdwlhqw.cls, sdwlhqw.skrqh, sdwlhqw.eluwkgdwh, sdwlhqw.vvq, sdwlhqw.hpdlo, sdwlhqw.ghdwkgdwh
    INTO fName, mName, lName, street, city, state, zip, phone, bday, ssn, email, dday
    FROM sdwlhqw
    WHERE paitentID = sdwlhqw.dffrxqwqxp;
END$$

DROP PROCEDURE IF EXISTS `GetPaitentID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPaitentID` (IN `fName` VARBINARY(250), IN `lName` VARBINARY(250), IN `bday` VARBINARY(250), OUT `paitentID` INT(25), IN `username` VARCHAR(100))  NO SQL
BEGIN
CALL recordEvent('GetPaitent', fName, username);
SELECT sdwlhqw.dffrxqwqxp
INTO paitentID
FROM sdwlhqw
WHERE sdwlhqw.iqdph = fName AND sdwlhqw.oqdph = lName AND sdwlhqw.eluwkgdwh = bday;
END$$

DROP PROCEDURE IF EXISTS `login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `axvhuqdph` VARBINARY(25), IN `asdvvzrug` VARBINARY(40), OUT `permission` VARBINARY(40))  NO SQL
BEGIN
DECLARE staffID int(10);
DECLARE accessID int(15);
DECLARE login datetime(6);
SET permission = "fail";
SELECT vwdii.srvlwlrq, vwdii.vwdiilg
INTO permission, staffID
FROM vwdii
WHERE vwdii.xvhuqdph = axvhuqdph AND vwdii.sdvvzrug = asdvvzrug;
IF permission IS NOT NULL THEN
    SELECT dffhvvorj.dffhvvlg, dffhvvorj.orjlq
    INTO accessID, login
    FROM dffhvvorj
    WHERE staffID = dffhvvorj.vwdiilg AND dffhvvorj.orjrxw IS NULL;
    IF accessID IS NOT NULL THEN
    	if DATE_ADD(login, INTERVAL 1 HOUR) < NOW() THEN
        	SET permission = "timeout";
        	UPDATE dffhvvorj
        	SET dffhvvorj.orjrxw = NOW()
        	WHERE dffhvvorj.dffhvvlg = accessID;
        END IF;
    ELSE
    	INSERT INTO dffhvvorj(dffhvvorj.vwdiilg, dffhvvorj.orjlq)
        VALUES(staffID, NOW());
    END IF;
END IF;
END$$

DROP PROCEDURE IF EXISTS `recordEvent`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `recordEvent` (IN `info` VARBINARY(250), IN `newaction` VARBINARY(250), IN `username` VARBINARY(250))  NO SQL
BEGIN
	INSERT INTO actionrecords(actionrecords.actiontime, actionrecords.username ,actionrecords.thisaction, actionrecords.additionalinfo)
    VALUES (NOW(), username, newaction, info);
END$$

DROP PROCEDURE IF EXISTS `updatePaitentData`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePaitentData` (IN `fName` VARBINARY(250), IN `mName` VARBINARY(250), IN `lName` VARBINARY(250), IN `street` VARBINARY(250), IN `city` VARBINARY(250), IN `state` VARBINARY(250), IN `zip` VARBINARY(250), IN `bday` VARBINARY(250), IN `ssn` VARBINARY(250), IN `phone` VARBINARY(250), IN `email` VARBINARY(250), IN `dday` VARBINARY(250), IN `paitentID` INT(25), IN `username` VARCHAR(100))  NO SQL
BEGIN
CALL recordEvent("Update Paitent", paitentID, username);

UPDATE sdwlhqw
SET
sdwlhqw.iqdph = fName,
sdwlhqw.pqdph = mName,
sdwlhqw.oqdph = lName,
sdwlhqw.vwuhhw = street,
sdwlhqw.flwb = city,
sdwlhqw.vwdwh = state,
sdwlhqw.cls = zip,
sdwlhqw.skrqh = phone,
sdwlhqw.eluwkgdwh = bday,
sdwlhqw.vvq = ssn,
sdwlhqw.hpdlo = email,
sdwlhqw.ghdwkgdwh = dday
WHERE sdwlhqw.dffrxqwqxp = paitentID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `actionrecords`
--

DROP TABLE IF EXISTS `actionrecords`;
CREATE TABLE IF NOT EXISTS `actionrecords` (
  `actionID` int(50) NOT NULL AUTO_INCREMENT,
  `username` varbinary(250) NOT NULL,
  `actiontime` datetime(6) NOT NULL,
  `thisaction` varchar(50) NOT NULL,
  `additionalinfo` varbinary(250) NOT NULL,
  PRIMARY KEY (`actionID`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `actionrecords`
--

INSERT INTO `actionrecords` (`actionID`, `username`, `actiontime`, `thisaction`, `additionalinfo`) VALUES
(12, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-25 01:22:31.000000', 'ãø7aZŒq„Ñò_þÕ *]y{³îËË\'p/r', 0x43726561746550616974656e74),
(11, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-24 20:19:31.000000', 'ƒë¡¬\r•“œÖg›­•/CZ2l¬çÓÆ$p', 0x43726561746550616974656e74),
(10, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-24 20:17:59.000000', 'test', 0x43726561746550616974656e74),
(13, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-27 13:11:55.000000', '¥@kwç@¿„TàÝHG%B}{³àËË$y\'|', 0x43726561746550616974656e74),
(14, 0x74657374, '2019-11-27 13:24:49.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(15, 0x74657374, '2019-11-27 13:26:20.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(16, 0x74657374, '2019-11-27 13:26:50.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(17, 0x74657374, '2019-11-27 13:27:16.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(18, 0x74657374, '2019-11-27 13:47:08.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(19, 0x74657374, '2019-11-27 15:42:47.000000', '²ÇgðÈŽqš0Ô¥Öý¬5*Ce:', 0x47657450616974656e74),
(20, 0x74657374, '2019-11-27 15:46:35.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(21, 0x74657374, '2019-11-27 15:48:27.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(22, 0x74657374, '2019-11-27 16:11:00.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(23, 0x74657374, '2019-11-27 16:16:26.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(24, 0x74657374, '2019-11-27 16:18:29.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(25, 0x74657374, '2019-11-27 17:06:11.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(26, 0x726f6f74, '2019-11-27 17:06:16.000000', '11', 0x5570646174652050616974656e74),
(27, 0x74657374, '2019-11-27 17:06:32.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(28, 0x74657374, '2019-11-27 17:07:18.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(29, 0x74657374, '2019-11-27 17:08:46.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(30, 0x74657374, '2019-11-27 17:09:30.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(31, 0x74657374, '2019-11-27 17:10:30.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(32, 0x74657374, '2019-11-27 17:10:56.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(33, 0x74657374, '2019-11-27 17:11:03.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(34, 0x74657374, '2019-11-27 17:13:25.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(35, 0x74657374, '2019-11-27 17:13:58.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(36, 0x74657374, '2019-11-27 17:15:25.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(37, 0x74657374, '2019-11-27 17:16:27.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(38, 0x74657374, '2019-11-27 17:17:36.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(39, 0x74657374, '2019-11-27 17:18:30.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(40, 0x74657374, '2019-11-27 17:19:25.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(41, 0x74657374, '2019-11-27 17:31:13.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(42, 0x74657374, '2019-11-27 17:33:28.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(43, 0x74657374, '2019-11-27 17:33:56.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(44, 0x74657374, '2019-11-27 17:34:54.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(45, 0x74657374, '2019-11-27 17:35:45.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(46, 0x74657374, '2019-11-27 17:37:45.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(47, 0x74657374, '2019-11-27 17:43:57.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(48, 0x74657374, '2019-11-27 17:45:01.000000', 'Aõ/z8ÄËð›ð´q°ë*Ly4ï', 0x47657450616974656e74),
(49, 0x726f6f74, '2019-11-27 17:45:14.000000', '11', 0x5570646174652050616974656e74),
(50, 0x74657374, '2019-11-27 17:45:55.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(51, 0x74657374, '2019-11-27 17:46:42.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(52, 0x726f6f74, '2019-11-27 17:46:44.000000', '11', 0x5570646174652050616974656e74),
(53, 0x74657374, '2019-11-27 23:52:05.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(54, 0x74657374, '2019-11-27 23:52:38.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(55, 0x726f6f74, '2019-11-27 23:53:05.000000', '11', 0x5570646174652050616974656e74),
(56, 0x74657374, '2019-11-27 23:54:22.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(57, 0x74657374, '2019-11-27 23:55:41.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(58, 0x74657374, '2019-11-27 23:58:07.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(59, 0x74657374, '2019-11-27 23:59:15.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(60, 0x74657374, '2019-11-27 23:59:34.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(61, 0x74657374, '2019-11-28 00:00:21.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(62, 0x74657374, '2019-11-28 00:00:40.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(63, 0x74657374, '2019-11-28 00:07:56.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(64, 0x74657374, '2019-11-28 00:08:10.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(65, 0x74657374, '2019-11-28 00:08:23.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(66, 0x74657374, '2019-11-28 00:09:30.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(67, 0x74657374, '2019-11-28 00:10:18.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(68, 0x74657374, '2019-11-28 00:11:57.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(69, 0x74657374, '2019-11-28 00:12:46.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(70, 0x74657374, '2019-11-28 00:13:23.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(71, 0x74657374, '2019-11-28 00:14:54.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(72, 0x74657374, '2019-11-28 00:16:17.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(73, 0x74657374, '2019-11-28 00:17:09.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(74, 0x74657374, '2019-11-28 00:17:27.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(75, 0x74657374, '2019-11-28 00:18:00.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(76, 0x74657374, '2019-11-28 00:18:27.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(77, 0x74657374, '2019-11-28 00:22:00.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(78, 0x74657374, '2019-11-28 00:23:02.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(79, 0x74657374, '2019-11-28 00:23:29.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(80, 0x74657374, '2019-11-28 00:24:20.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(81, 0x74657374, '2019-11-28 00:24:31.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(82, 0x74657374, '2019-11-28 00:24:44.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(83, 0x74657374, '2019-11-28 00:25:54.000000', '²ÇgðÈŽqš0Ô¥Öý¬5*Ce:', 0x47657450616974656e74),
(84, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-28 00:26:24.000000', '¸ÜûrÊ~ô\'ï¨mn%Â%B}{³ïËË$y\'|', 0x43726561746550616974656e74),
(85, 0x74657374, '2019-11-28 00:26:38.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(86, 0x74657374, '2019-11-28 00:26:46.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(87, 0x74657374, '2019-11-28 00:32:12.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(88, 0x74657374, '2019-11-28 00:34:57.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(89, 0x74657374, '2019-11-28 20:29:50.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(90, 0x74657374, '2019-11-28 20:32:35.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(91, 0x74657374, '2019-11-28 20:39:12.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(92, 0x74657374, '2019-11-28 20:43:24.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(93, 0x74657374, '2019-11-28 20:44:50.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(94, 0x74657374, '2019-11-28 20:46:23.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(95, 0x74657374, '2019-11-28 20:47:33.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(96, 0x74657374, '2019-11-28 20:48:42.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(97, 0x74657374, '2019-11-28 20:51:18.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(98, 0x74657374, '2019-11-28 20:53:26.000000', '5', 0x4372656174655669736974),
(99, 0x74657374, '2019-11-28 20:54:42.000000', '4', 0x4372656174655669736974),
(100, 0x74657374, '2019-11-28 21:03:06.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(101, 0x74657374, '2019-11-28 21:04:55.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(102, 0x74657374, '2019-11-28 21:06:19.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(103, 0x74657374, '2019-11-28 21:10:36.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(104, 0x74657374, '2019-11-28 21:10:42.000000', '5', 0x4372656174655669736974),
(105, 0x74657374, '2019-11-28 21:13:01.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(106, 0x74657374, '2019-11-28 21:13:08.000000', '5', 0x4372656174655669736974),
(107, 0x74657374, '2019-11-28 21:13:30.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(108, 0x74657374, '2019-11-28 21:15:58.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(109, 0x49599dce64e9353fafbcbd63929df2101f48782f, '2019-11-28 21:16:05.000000', '12', 0x4372656174655669736974),
(110, 0x74657374, '2019-11-28 21:29:14.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(111, 0x74657374, '2019-11-28 21:30:18.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(112, 0x74657374, '2019-11-28 21:30:49.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(113, 0x74657374, '2019-11-28 21:32:08.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(114, 0x74657374, '2019-11-28 21:33:22.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(115, 0x74657374, '2019-11-28 21:34:00.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(116, 0x74657374, '2019-11-28 21:49:37.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(117, 0x74657374, '2019-11-28 21:50:17.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74),
(118, 0x74657374, '2019-11-28 22:03:07.000000', 'IYÎdé5?¯¼½c’òHx/', 0x47657450616974656e74);

-- --------------------------------------------------------

--
-- Table structure for table `dffhvvorj`
--

DROP TABLE IF EXISTS `dffhvvorj`;
CREATE TABLE IF NOT EXISTS `dffhvvorj` (
  `dffhvvlg` int(15) NOT NULL AUTO_INCREMENT COMMENT 'accessid',
  `vwdiilg` int(15) NOT NULL COMMENT 'staffid',
  `orjlq` datetime(6) NOT NULL COMMENT 'login (date/time)',
  `orjrxw` datetime(6) DEFAULT NULL COMMENT 'logout (date/time)',
  PRIMARY KEY (`dffhvvlg`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dffhvvorj`
--

INSERT INTO `dffhvvorj` (`dffhvvlg`, `vwdiilg`, `orjlq`, `orjrxw`) VALUES
(1, 3, '2019-11-23 02:02:38.000000', '2019-11-24 02:03:10.000000'),
(2, 3, '2019-11-23 02:03:40.000000', '2019-11-24 02:04:05.000000'),
(3, 1, '2019-11-23 02:08:04.000000', '2019-11-24 02:09:57.000000'),
(4, 1, '2019-11-24 02:11:32.000000', '2019-11-24 15:31:32.000000'),
(5, 1, '2019-11-24 15:51:14.000000', '2019-11-24 17:35:07.000000'),
(6, 1, '2019-11-24 17:35:14.000000', '2019-11-24 19:36:34.000000'),
(7, 1, '2019-11-24 19:36:43.000000', '2019-11-24 21:03:00.000000'),
(8, 1, '2019-11-24 21:03:06.000000', '2019-11-24 22:35:21.000000'),
(9, 1, '2019-11-24 22:35:25.000000', '2019-11-24 23:51:36.000000'),
(10, 1, '2019-11-24 23:51:44.000000', '2019-11-25 00:53:08.000000'),
(11, 1, '2019-11-25 00:53:13.000000', '2019-11-27 12:54:49.000000'),
(12, 1, '2019-11-27 12:55:00.000000', '2019-11-27 15:42:09.000000'),
(13, 1, '2019-11-27 15:42:22.000000', '2019-11-27 17:02:56.000000'),
(14, 1, '2019-11-27 17:05:59.000000', '2019-11-27 23:41:19.000000'),
(15, 1, '2019-11-27 23:48:49.000000', '2019-11-28 20:29:20.000000'),
(16, 1, '2019-11-28 20:29:41.000000', '2019-11-28 21:29:59.000000'),
(17, 1, '2019-11-28 21:30:10.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sdwlhqw`
--

DROP TABLE IF EXISTS `sdwlhqw`;
CREATE TABLE IF NOT EXISTS `sdwlhqw` (
  `dffrxqwqxp` int(25) NOT NULL AUTO_INCREMENT COMMENT 'accountnum',
  `iqdph` varbinary(150) NOT NULL COMMENT 'fname',
  `pqdph` varbinary(150) NOT NULL COMMENT 'mname',
  `oqdph` varbinary(150) NOT NULL COMMENT 'lname',
  `vwuhhw` varbinary(120) NOT NULL COMMENT 'street',
  `flwb` varbinary(120) NOT NULL COMMENT 'city',
  `vwdwh` varbinary(25) NOT NULL COMMENT 'state',
  `cls` varbinary(30) NOT NULL COMMENT 'zip',
  `skrqh` varbinary(40) NOT NULL COMMENT 'phone',
  `eluwkgdwh` varbinary(50) NOT NULL COMMENT 'birthdate',
  `vvq` varbinary(30) NOT NULL COMMENT 'ssn',
  `hpdlo` varbinary(120) NOT NULL COMMENT 'email',
  `ghdwkgdwh` varbinary(50) DEFAULT NULL COMMENT 'deathdate',
  PRIMARY KEY (`dffrxqwqxp`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sdwlhqw`
--

INSERT INTO `sdwlhqw` (`dffrxqwqxp`, `iqdph`, `pqdph`, `oqdph`, `vwuhhw`, `flwb`, `vwdwh`, `cls`, `skrqh`, `eluwkgdwh`, `vvq`, `hpdlo`, `ghdwkgdwh`) VALUES
(12, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0xb813dcfb72ca907ef427efa86d6e25c225427d7bb3efcbcb2479277c, 0xc918b92c81c75a8b73c3e15c82cf3bdf1f48782fb3, 0xa3003b02dbcf007b9807957aa36684ba1f48782fc1a382986267752ac3, NULL),
(10, 0xb2c767f0c88e710c9a30d4a5d6fdac352a43653a, 0x0f19d86e32422b4f888eaf65752936db27426c, 0x2df7f10cbb1b2ec86979530788e07d033c446737e8b68a98, 0x83102eef7d9de4a6a6ab6489d34fc29c591c337bc0a59383633b3604d88b, 0x6f4a4f5cbdea398e5ccaa75f6ebfbc2121426335f2b889cb5520623c, 0xf7fc369343ec9c46517f18d5be7044ad2574, 0xdac854e7ac41e406a24bbbfd43081eaa5a1e3c62b1, 0xaf8ec135954c55f16d0859c35e570dfa5d1d3c69b2eeded22179, 0xe3f837615a8c717f9d84d1f25ffed5202a5d797bb3eecbcb27702f72, 0x5bcb507210d567195629da89b697ad815a1f386fb4e1d0d32f, 0xac3c9f38cabb3f629bba58f90bc910651c446737e8b6868956287a23dc8be1ff19599cf44adff017, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suhvfulswlrq`
--

DROP TABLE IF EXISTS `suhvfulswlrq`;
CREATE TABLE IF NOT EXISTS `suhvfulswlrq` (
  `suhvfulswlrqlg` int(50) NOT NULL AUTO_INCREMENT COMMENT 'prescriptionid',
  `sdwlhqwlg` int(25) NOT NULL COMMENT 'patientid',
  `suhvfulehgeb` int(10) NOT NULL COMMENT 'prescribedby(staffID)',
  `gdwhsuhvfulehg` datetime(6) NOT NULL COMMENT 'datePrescribed',
  `qdph` varchar(30) NOT NULL COMMENT 'name',
  `grvdjh` varchar(20) NOT NULL COMMENT 'dosage',
  `iuhtxhqfb` varchar(20) NOT NULL COMMENT 'frequency',
  `hqggdwh` datetime(6) NOT NULL COMMENT 'enddate',
  `uhiloo` tinyint(1) NOT NULL COMMENT 'refill',
  PRIMARY KEY (`suhvfulswlrqlg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vwdii`
--

DROP TABLE IF EXISTS `vwdii`;
CREATE TABLE IF NOT EXISTS `vwdii` (
  `vwdiilg` int(10) NOT NULL AUTO_INCREMENT COMMENT 'staffid',
  `iqdph` varbinary(250) NOT NULL COMMENT 'fname',
  `oqdph` varbinary(250) NOT NULL COMMENT 'lname',
  `srvlwlrq` varbinary(250) NOT NULL COMMENT 'position',
  `xvhuqdph` varbinary(250) NOT NULL COMMENT 'username',
  `sdvvzrug` varbinary(250) NOT NULL COMMENT 'password',
  PRIMARY KEY (`vwdiilg`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vwdii`
--

INSERT INTO `vwdii` (`vwdiilg`, `iqdph`, `oqdph`, `srvlwlrq`, `xvhuqdph`, `sdvvzrug`) VALUES
(1, 0xf5d3960276493a1f23b9694f369f34f2094269, 0x2cd0904833cbdca02d56b6760043ca0c0942693ef3a48885, 0x3f52ad1e3757bf9aeae8954dd2fd46840f5f, 0x49599dce64e9353fafbcbd63929df2101f48782f, 0xb31ff6566dd96474128342e5e0d7febe1b4c7828f6b8958f),
(3, 0x626f62, 0x626f626572736f6e, 0x6472, 0x74657374, 0x70617373776f7264);

-- --------------------------------------------------------

--
-- Table structure for table `ylvlw`
--

DROP TABLE IF EXISTS `ylvlw`;
CREATE TABLE IF NOT EXISTS `ylvlw` (
  `ylvlwlg` int(30) NOT NULL AUTO_INCREMENT COMMENT 'visitid',
  `xvhuqdph` varbinary(250) DEFAULT NULL COMMENT 'staff username',
  `sdwlhqwqxp` int(20) DEFAULT NULL COMMENT 'patientnum',
  `gdwhlq` varchar(100) DEFAULT NULL COMMENT 'datein',
  `gdwhrxw` varchar(100) DEFAULT NULL COMMENT 'dateout',
  `uhdvrq` varbinary(250) DEFAULT NULL COMMENT 'reason',
  PRIMARY KEY (`ylvlwlg`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ylvlw`
--

INSERT INTO `ylvlw` (`ylvlwlg`, `xvhuqdph`, `sdwlhqwqxp`, `gdwhlq`, `gdwhrxw`, `uhdvrq`) VALUES
(6, 0x49599dce64e9353fafbcbd63929df2101f48782f, 12, 'Nov 21, 2019', 'Nov 27, 2019', 0xca93e2b58c64d5668b6d6e62242f24c4385d793ae8b9828f3621772bca);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
