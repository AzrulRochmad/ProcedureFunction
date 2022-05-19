/*
 Navicat Premium Data Transfer

 Source Server         : Praktik
 Source Server Type    : MySQL
 Source Server Version : 100421
 Source Host           : localhost:3306
 Source Schema         : prosedur1

 Target Server Type    : MySQL
 Target Server Version : 100421
 File Encoding         : 65001

 Date: 19/05/2022 12:11:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bagian
-- ----------------------------
DROP TABLE IF EXISTS `bagian`;
CREATE TABLE `bagian`  (
  `kd_bagian` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_bagian` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`kd_bagian`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bagian
-- ----------------------------
INSERT INTO `bagian` VALUES ('B001', 'Personalia');
INSERT INTO `bagian` VALUES ('B002', 'Keuangan');
INSERT INTO `bagian` VALUES ('B003', 'Pemasaran');
INSERT INTO `bagian` VALUES ('B004', 'Produksi');
INSERT INTO `bagian` VALUES ('B005', 'Keamanan');

-- ----------------------------
-- Table structure for gaji
-- ----------------------------
DROP TABLE IF EXISTS `gaji`;
CREATE TABLE `gaji`  (
  `nip` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kd_bagian` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gaji` double NULL DEFAULT NULL,
  PRIMARY KEY (`nip`) USING BTREE,
  INDEX `bagian`(`kd_bagian` ASC) USING BTREE,
  CONSTRAINT `bagian` FOREIGN KEY (`kd_bagian`) REFERENCES `bagian` (`kd_bagian`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `nip` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gaji
-- ----------------------------
INSERT INTO `gaji` VALUES ('810708', 'B002', 5400000);
INSERT INTO `gaji` VALUES ('850414', 'B001', 2500000);
INSERT INTO `gaji` VALUES ('871023', 'B001', 2000000);
INSERT INTO `gaji` VALUES ('871203', 'B003', 1500000);
INSERT INTO `gaji` VALUES ('890212', 'B003', 500000);

-- ----------------------------
-- Table structure for pegawai
-- ----------------------------
DROP TABLE IF EXISTS `pegawai`;
CREATE TABLE `pegawai`  (
  `nip` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nm_pegawai` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tempat_lhr` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telp` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pegawai
-- ----------------------------
INSERT INTO `pegawai` VALUES ('', '', '', '0000-00-00', '', NULL);
INSERT INTO `pegawai` VALUES ('810708', 'rodianto', 'sumbawa', '1981-07-08', 'sumbwa', '081916348753');
INSERT INTO `pegawai` VALUES ('850414', 'Israul Apriyanti', 'Selong ', '1985-04-14', 'Seruni, Kota', '081915175998');
INSERT INTO `pegawai` VALUES ('871023', 'Dwi Febria Sawitri', 'Bantul', '1987-10-23', 'Bantul, Yogy', '08988239949');
INSERT INTO `pegawai` VALUES ('871203', 'Yuli Febri Safitri', 'Manado', '1987-12-03', 'Srisak, Sula', '085237352777');
INSERT INTO `pegawai` VALUES ('890212', 'Kanul Yulianti', 'Dompu', '1989-02-12', 'Dompu Kota', '081915723623');

-- ----------------------------
-- Procedure structure for GajiBaru
-- ----------------------------
DROP PROCEDURE IF EXISTS `GajiBaru`;
delimiter ;;
CREATE PROCEDURE `GajiBaru`()
BEGIN
SELECT nip,gaji as "Gaji Lama",(gaji*20/100)+gaji as "Gaji Baru" from gaji;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for JPegawaiBagian
-- ----------------------------
DROP PROCEDURE IF EXISTS `JPegawaiBagian`;
delimiter ;;
CREATE PROCEDURE `JPegawaiBagian`()
BEGIN
SELECT bagian.nama_bagian as "Bagian",count(gaji.kd_bagian) as "Jumlah" from bagian left join gaji on bagian.kd_bagian=gaji.kd_bagian GROUP BY bagian.nama_bagian;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for lahir
-- ----------------------------
DROP PROCEDURE IF EXISTS `lahir`;
delimiter ;;
CREATE PROCEDURE `lahir`()
BEGIN
SELECT nip,tgl_lahir,nm_pegawai as "nama" from pegawai WHERE YEAR(tgl_lahir)>1986;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for TotalGajiPegawai
-- ----------------------------
DROP FUNCTION IF EXISTS `TotalGajiPegawai`;
delimiter ;;
CREATE FUNCTION `TotalGajiPegawai`()
 RETURNS int(11)
BEGIN
DECLARE jumlah INT;
SELECT SUM(gaji) as "Total" INTO jumlah FROM gaji;
RETURN jumlah;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for tunjangan
-- ----------------------------
DROP FUNCTION IF EXISTS `tunjangan`;
delimiter ;;
CREATE FUNCTION `tunjangan`()
 RETURNS int(11)
BEGIN
DECLARE jumlah INT;
SELECT pegawai.nm_pegawai as "Nama",gaji.gaji, gaji.gaji*0.5 as tunjangan INTO jumlah from pegawai JOIN gaji ON gaji.nip=pegawai.nip GROUP BY pegawai.nm_pegawai ;
RETURN jumlah;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
