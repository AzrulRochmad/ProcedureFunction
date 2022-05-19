/*
 Navicat Premium Data Transfer

 Source Server         : Praktik
 Source Server Type    : MySQL
 Source Server Version : 100421
 Source Host           : localhost:3306
 Source Schema         : prosedur2

 Target Server Type    : MySQL
 Target Server Version : 100421
 File Encoding         : 65001

 Date: 19/05/2022 12:11:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for data_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `data_pegawai`;
CREATE TABLE `data_pegawai`  (
  `nik` int NOT NULL,
  `nama` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_jabatan` int NOT NULL,
  `dd_divisi` int NOT NULL,
  PRIMARY KEY (`nik`) USING BTREE,
  INDEX `id_jabatan`(`id_jabatan` ASC) USING BTREE,
  INDEX `dd_divisi`(`dd_divisi` ASC) USING BTREE,
  CONSTRAINT `dd_divisi` FOREIGN KEY (`dd_divisi`) REFERENCES `tabel_divisi` (`id_divisi`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `id_jabatan` FOREIGN KEY (`id_jabatan`) REFERENCES `tabel_jabatan` (`id_jabatan`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of data_pegawai
-- ----------------------------
INSERT INTO `data_pegawai` VALUES (200000065, 'Aji Firmansyah', 'Surabaya', 1002, 2003);
INSERT INTO `data_pegawai` VALUES (200000066, 'Rudi Hartono', 'Bandung', 1001, 2002);
INSERT INTO `data_pegawai` VALUES (200000067, 'Aisyah Nila', 'Semarang', 1003, 2001);

-- ----------------------------
-- Table structure for tabel_divisi
-- ----------------------------
DROP TABLE IF EXISTS `tabel_divisi`;
CREATE TABLE `tabel_divisi`  (
  `id_divisi` int NOT NULL,
  `nama_divisi` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_divisi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tabel_divisi
-- ----------------------------
INSERT INTO `tabel_divisi` VALUES (2001, 'Training');
INSERT INTO `tabel_divisi` VALUES (2002, 'Sistem dan jaringan');
INSERT INTO `tabel_divisi` VALUES (2003, 'Karyawan');

-- ----------------------------
-- Table structure for tabel_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `tabel_jabatan`;
CREATE TABLE `tabel_jabatan`  (
  `id_jabatan` int NOT NULL,
  `nama_jabatan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_jabatan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tabel_jabatan
-- ----------------------------
INSERT INTO `tabel_jabatan` VALUES (1001, 'Kepala Divisi');
INSERT INTO `tabel_jabatan` VALUES (1002, 'Manager');
INSERT INTO `tabel_jabatan` VALUES (1003, 'Karyawan');

-- ----------------------------
-- Procedure structure for pegawai
-- ----------------------------
DROP PROCEDURE IF EXISTS `pegawai`;
delimiter ;;
CREATE PROCEDURE `pegawai`()
BEGIN
SELECT data_pegawai.nik, data_pegawai.nama,tabel_jabatan.nama_jabatan as jabatan, tabel_divisi.nama_divisi as divisi from data_pegawai join tabel_jabatan on data_pegawai.id_jabatan=tabel_jabatan.id_jabatan join tabel_divisi on data_pegawai.dd_divisi=tabel_divisi.id_divisi;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
