-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bd_practica_1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_practica_1` ;

-- -----------------------------------------------------
-- Schema bd_practica_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_practica_1` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bd_practica_1` ;

-- -----------------------------------------------------
-- Table `bd_practica_1`.`tipo_filial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`tipo_filial` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`tipo_filial` (
  `id_tipo_filial` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_filial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`filial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`filial` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`filial` (
  `id_filial` INT NOT NULL AUTO_INCREMENT,
  `tipo_filial_id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_filial`),
  INDEX `fk_filial_tipo_filial1_idx` (`tipo_filial_id` ASC),
  CONSTRAINT `fk_filial_tipo_filial1`
    FOREIGN KEY (`tipo_filial_id`)
    REFERENCES `bd_practica_1`.`tipo_filial` (`id_tipo_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`trabajador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`trabajador` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`trabajador` (
  `id_trabajador` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(8) NULL,
  `nombres` VARCHAR(45) NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_trabajador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`cargo_trabajador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`cargo_trabajador` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`cargo_trabajador` (
  `id_cargo_trabajador` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cargo_trabajador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`contrato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`contrato` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`contrato` (
  `id_contrato` INT NOT NULL AUTO_INCREMENT,
  `filial_id` INT NOT NULL,
  `trabajador_id` INT NOT NULL,
  `pago_por_hora` DOUBLE NULL,
  `nro_horas_mensual` INT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_final` DATE NOT NULL,
  `cargo_trabajador_id` INT NULL,
  PRIMARY KEY (`id_contrato`),
  INDEX `fk_Contrato_Trabajador_idx` (`trabajador_id` ASC),
  INDEX `fk_Contrato_Filial1_idx` (`filial_id` ASC),
  INDEX `fk_contrato_cargo_trabajador1_idx` (`cargo_trabajador_id` ASC),
  CONSTRAINT `fk_Contrato_Trabajador`
    FOREIGN KEY (`trabajador_id`)
    REFERENCES `bd_practica_1`.`trabajador` (`id_trabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contrato_Filial1`
    FOREIGN KEY (`filial_id`)
    REFERENCES `bd_practica_1`.`filial` (`id_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_cargo_trabajador1`
    FOREIGN KEY (`cargo_trabajador_id`)
    REFERENCES `bd_practica_1`.`cargo_trabajador` (`id_cargo_trabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`horas_extras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`horas_extras` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`horas_extras` (
  `id_horas_extras` INT NOT NULL AUTO_INCREMENT,
  `contrato_id` INT NOT NULL,
  `filial_id` INT NOT NULL,
  `numero_horas` INT NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`id_horas_extras`),
  INDEX `fk_HorasExtras_Filial1_idx` (`filial_id` ASC),
  INDEX `fk_horas_extras_contrato1_idx` (`contrato_id` ASC),
  CONSTRAINT `fk_HorasExtras_Filial1`
    FOREIGN KEY (`filial_id`)
    REFERENCES `bd_practica_1`.`filial` (`id_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horas_extras_contrato1`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `bd_practica_1`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_practica_1`.`pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_practica_1`.`pago` ;

CREATE TABLE IF NOT EXISTS `bd_practica_1`.`pago` (
  `contrato_id` INT NOT NULL,
  `mes` INT NOT NULL,
  `anio` INT NOT NULL,
  `fecha_pago` DATE NULL,
  PRIMARY KEY (`contrato_id`, `mes`, `anio`),
  INDEX `fk_pago_contrato1_idx` (`contrato_id` ASC),
  CONSTRAINT `fk_pago_contrato1`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `bd_practica_1`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`tipo_filial`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`tipo_filial` (`id_tipo_filial`, `nombre`, `descripcion`) VALUES (1, 'Fabricación', NULL);
INSERT INTO `bd_practica_1`.`tipo_filial` (`id_tipo_filial`, `nombre`, `descripcion`) VALUES (2, 'Distribución', NULL);
INSERT INTO `bd_practica_1`.`tipo_filial` (`id_tipo_filial`, `nombre`, `descripcion`) VALUES (3, 'Venta', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`filial`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`filial` (`id_filial`, `tipo_filial_id`, `nombre`, `direccion`) VALUES (1, 1, 'Gamarra', NULL);
INSERT INTO `bd_practica_1`.`filial` (`id_filial`, `tipo_filial_id`, `nombre`, `direccion`) VALUES (2, 2, 'Wilson', NULL);
INSERT INTO `bd_practica_1`.`filial` (`id_filial`, `tipo_filial_id`, `nombre`, `direccion`) VALUES (3, 3, 'Grau', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`trabajador`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`trabajador` (`id_trabajador`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `telefono`, `direccion`) VALUES (1, '12365478', 'Juan', 'Perez', 'Picapiedra', '3514194', 'Av Girasoles 334');
INSERT INTO `bd_practica_1`.`trabajador` (`id_trabajador`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `telefono`, `direccion`) VALUES (2, '23456768', 'Giamarco', 'Luis', 'Pampañaupa', '96578415', 'Av La marina 666');
INSERT INTO `bd_practica_1`.`trabajador` (`id_trabajador`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `telefono`, `direccion`) VALUES (3, '35467464', 'Issac', 'Newton', 'Mamani', '98654326', 'Av Ingenieros 123');
INSERT INTO `bd_practica_1`.`trabajador` (`id_trabajador`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `telefono`, `direccion`) VALUES (4, '45675890', 'Michael', 'Jackson', 'Arevalo', '78964165', 'Av Sin nombre 11');
INSERT INTO `bd_practica_1`.`trabajador` (`id_trabajador`, `dni`, `nombres`, `apellido_paterno`, `apellido_materno`, `telefono`, `direccion`) VALUES (5, '56786796', 'Luis', 'Zuameta', 'Supo', '98794656', 'Av Lima');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`cargo_trabajador`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`cargo_trabajador` (`id_cargo_trabajador`, `nombre`) VALUES (1, 'Base');
INSERT INTO `bd_practica_1`.`cargo_trabajador` (`id_cargo_trabajador`, `nombre`) VALUES (2, 'Directivo');
INSERT INTO `bd_practica_1`.`cargo_trabajador` (`id_cargo_trabajador`, `nombre`) VALUES (3, 'Presidente');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`contrato`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (1, 1, 1, 3, 120, '2018-01-01', '2018-02-28', 3);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (2, 2, 2, 3.5, 150, '2018-02-01', '2019-04-30', 3);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (3, 3, 3, 2.1, 90, '2018-03-01', '2019-03-30', 3);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (4, 3, 4, 5, 100, '2018-01-01', '2019-04-30', 2);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (5, 1, 5, 3.3, 70, '2018-03-01', '2019-05-30', 2);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (6, 1, 1, 4, 120, '2018-03-01', '2018-04-30', 2);
INSERT INTO `bd_practica_1`.`contrato` (`id_contrato`, `filial_id`, `trabajador_id`, `pago_por_hora`, `nro_horas_mensual`, `fecha_inicio`, `fecha_final`, `cargo_trabajador_id`) VALUES (7, 3, 1, 4.1, 120, '2018-05-01', '2019-06-30', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`horas_extras`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (1, 1, 2, 3, '2018-01-15');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (2, 1, 3, 3, '2018-01-11');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (3, 2, 3, 1, '2018-01-18');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (4, 3, 1, 5, '2018-05-01');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (5, 5, 1, 6, '2018-03-15');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (6, 6, 3, 1, '2018-03-01');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (7, 6, 2, 4, '2018-03-17');
INSERT INTO `bd_practica_1`.`horas_extras` (`id_horas_extras`, `contrato_id`, `filial_id`, `numero_horas`, `fecha`) VALUES (8, 6, 1, 3, '2018-04-19');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_practica_1`.`pago`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_practica_1`;
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 1, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 2, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 3, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 4, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 3, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 4, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 3, 2018, '2018-01-01');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 2, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 4, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 3, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 3, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 4, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 5, 2018, '2018-01-15');
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 9, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 10, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 11, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 12, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 5, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 5, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 9, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 10, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 11, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 12, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 1, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 2, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 9, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 10, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 11, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 12, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 4, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 5, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 9, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 10, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 11, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 12, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 5, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 5, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (6, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 5, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 6, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 7, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 8, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 9, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 10, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 11, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 12, 2018, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 5, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (7, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 1, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 2, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 3, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 5, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 7, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 8, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 9, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 10, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 11, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (1, 12, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 7, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 8, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 9, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 10, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 11, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (2, 12, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 4, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 5, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 7, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 8, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 9, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 10, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 11, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (3, 12, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 5, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 7, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 8, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 9, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 10, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 11, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (4, 12, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 6, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 7, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 8, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 9, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 10, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 11, 2019, NULL);
INSERT INTO `bd_practica_1`.`pago` (`contrato_id`, `mes`, `anio`, `fecha_pago`) VALUES (5, 12, 2019, NULL);

COMMIT;











create or replace view con_reporte_anual 
as
    select   
			   tra.dni					as dni_trabajador
             , tra.nombres				as nombres_trabajador
             , tra.apellido_paterno		as apellido_paterno_trabajador
             , tra.apellido_materno		as apellido_materno_trabajador
             , fil.id_filial			as id_filial
             , fil.nombre				as nombre_filial
             , pag.mes					as mes_pagado
             , pag.anio					as anio_pagado
             /*, month(hex.fecha)*/
             /*, year(hex.fecha)*/
             , con.nro_horas_mensual	as numero_horas_mes_pagado
             , con.pago_por_hora		as pago_por_horas_mes_pagado
             , con.id_contrato
             , (select sum(hex2.numero_horas) from horas_extras hex2 where (con.id_contrato = hex2.contrato_id and month(hex2.fecha) = pag.mes and year(hex2.fecha) = pag.anio))
										as total_hora_extras
			 , con.nro_horas_mensual*con.pago_por_hora	as sueldo_mensual 
             , (select sum(hex2.numero_horas) from horas_extras hex2 where (con.id_contrato = hex2.contrato_id and month(hex2.fecha) = pag.mes and year(hex2.fecha) = pag.anio))*con.pago_por_hora	as pago_horas_extras 
             , (con.nro_horas_mensual + (select sum(hex2.numero_horas) from horas_extras hex2 where (con.id_contrato = hex2.contrato_id and month(hex2.fecha) = pag.mes and year(hex2.fecha) = pag.anio)))*con.pago_por_hora as pago_total
             /*, hex.**/
		from pago pag
        join contrato con on pag.contrato_id = con.id_contrato
        join trabajador tra on con.trabajador_id = tra.id_trabajador
/*left join horas_extras hex on con.id_contrato = hex.contrato_id and month(hex.fecha) = pag.mes and year(hex.fecha) = pag.anio*/
		join filial fil on fil.id_filial =  con.filial_id
        ;
        
        create or replace view con_horas_extras
as
	  select 
			 tra.dni 					as dni_trabajador
             , tra.nombres				as nombres_trabajador
             , tra.apellido_paterno		as apellido_paterno_trabajador
             , tra.apellido_materno		as apellido_materno_trabajador
             , fil.id_filial			as id_filial
             , fil.nombre				as nombre_filial
			 , month(hex.fecha) 		as mes_horas_extras
             , year(hex.fecha)		 	as anio_horas_extras
             , hex.fecha				as fecha_horas_extras
             , hex.numero_horas			as numero_horas_extras
             , con.pago_por_hora		as pago_por_hora
             , hex.numero_horas	 * con.pago_por_hora 		as pago_total_hora_extras
		from horas_extras hex
        join contrato con on con.id_contrato = hex.contrato_id
        join trabajador tra on tra.id_trabajador = con.trabajador_id
        join filial fil on fil.id_filial = con.filial_id
        ;
        
    /*se usa para seleccionar a los que se les puede dar horas extras*/
        create or replace view trabajadores_con_contrato_vigente as
		  select 
				 con.id_contrato				as id_contrato
                 , tra.dni						as dni_trabajador
                 , tra.nombres					as nombre_trabajador
                 , tra.apellido_paterno			as apellido_paterno_trabajador
                 , tra.apellido_materno			as apellido_materno_trabajador
                 , fil.id_filial				as id_filial
                 , fil.nombre					as nombre_filial
                 , con.pago_por_hora			as pago_por_hora
                 , con.nro_horas_mensual		as nro_horas_mensual
                 , con.fecha_inicio				as fecha_inicio
                 , con.fecha_final				as fecha_fin

			from trabajador tra
            join contrato con on con.trabajador_id = tra.id_trabajador
            join filial fil on con.filial_id = fil.id_filial
		   where curdate() BETWEEN con.fecha_inicio AND con.fecha_final;    
           
           
           create or replace view con_contratos as
        select 
             con.id_contrato
             , tra.dni					as dni_trabajador
             , fil.nombre				as nombre_filial
             , tra.nombres				as nombres_trabajador
             , fil.id_filial			as id_filial
             , con.nro_horas_mensual	as numero_horas_mes_pagado
             , con.pago_por_hora		as pago_por_horas_mes_pagado
			 , con.nro_horas_mensual*con.pago_por_hora	as sueldo_mensual 
             , con.fecha_inicio			as fecha_inicio
             , con.fecha_final			as fecha_fin
             
		  from bd_practica_1.contrato con
          join bd_practica_1.trabajador tra on tra.id_trabajador = con.trabajador_id
          join bd_practica_1.filial fil on fil.id_filial = con.filial_id
          
          ;

create or replace view con_total_horas_mensual as
        select 
				che.dni_trabajador				as dni_trabajador
			   ,che.mes_horas_extras 			as mes_horas_extras
               ,che.anio_horas_extras			as anio_horas_extras
               ,sum(che.numero_horas_extras)	as numero_horas_extras
               ,sum(pago_total_hora_extras)		as pago_total_horas_extras
        from bd_practica_1.con_horas_extras che
        /*where che.dni_trabajador = '11111111'  and che.mes_horas_extras = 04 and che.anio_horas_extras = 2018*/;