CREATE DATABASE IF NOT EXISTS `kassza`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_hungarian_ci;

USE `kassza`;

CREATE TABLE `elado` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nev` varchar(40) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE `blokk` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `vasarlas_ideje` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `elado_id` int NOT NULL,
  `fizetesi_mod` varchar(10) NOT NULL,
  FOREIGN KEY (`elado_id`) REFERENCES `elado`(`id`)
) ENGINE=InnoDB;

CREATE TABLE `cikk` (
  `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `blokk_id` int NOT NULL,
  `nev` varchar(50) NOT NULL,
  `mennyiseg` double NOT NULL,
  `mertekegyseg` varchar(10) NOT NULL,
  `egysegar` int NOT NULL,
  `afa` double NOT NULL,
  FOREIGN KEY (`blokk_id`) REFERENCES `blokk`(`id`)
) ENGINE=InnoDB;


-- Eladók
START TRANSACTION;

INSERT INTO `elado` (`id`, `nev`) VALUES (1, 'Kováts Beáta');
INSERT INTO `elado` (`id`, `nev`) VALUES (2, 'Németh Gizella');
INSERT INTO `elado` (`id`, `nev`) VALUES (3, 'Nagy Péter');
INSERT INTO `elado` (`id`, `nev`) VALUES (4, 'Tóth Erzsébet');

COMMIT;


-- 1. blokk
START TRANSACTION;

INSERT INTO `blokk` (`elado_id`, `fizetesi_mod`) VALUES (1, 'kp');
SET @blokk_id = LAST_INSERT_ID();

INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Tej', 1, 'liter', 266, 0.05);

COMMIT;


-- 2. blokk
START TRANSACTION;

INSERT INTO `blokk` (`elado_id`, `fizetesi_mod`, `vasarlas_ideje`)
VALUES (1, 'kártya', '2026-08-30 12:51:38');
SET @blokk_id = LAST_INSERT_ID();

INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Kenyér', 2, 'kg', 500, 0.18);

COMMIT;


-- 3. blokk
START TRANSACTION;

INSERT INTO `blokk` (`elado_id`, `fizetesi_mod`, `vasarlas_ideje`)
VALUES (2, 'kártya', '2026-08-30 13:21:50');
SET @blokk_id = LAST_INSERT_ID();

INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Tej', 1, 'liter', 350, 0.18);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Kenyér', 1, 'kg', 500, 0.18);

COMMIT;


-- 4. blokk
START TRANSACTION;

INSERT INTO `blokk` (`elado_id`, `fizetesi_mod`) VALUES (3, 'kp');
SET @blokk_id = LAST_INSERT_ID();

INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'SSD', 1, 'db', 18000, 0.27);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Egér és Billentyűzet', 1, 'db', 25000, 0.27);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Alaplap', 1, 'db', 26000, 0.27);

COMMIT;


-- 5. blokk
START TRANSACTION;

INSERT INTO `blokk` (`elado_id`, `fizetesi_mod`) VALUES (4, 'kp');
SET @blokk_id = LAST_INSERT_ID();

INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Paradicsom', 1, 'kg', 750, 0.18);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Kenyér', 1, 'kg', 500, 0.18);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Tej', 1, 'liter', 360, 0.18);
INSERT INTO `cikk` (`blokk_id`, `nev`, `mennyiseg`, `mertekegyseg`, `egysegar`, `afa`)
VALUES (@blokk_id, 'Kóla', 2, 'liter', 550, 0.18);

COMMIT;