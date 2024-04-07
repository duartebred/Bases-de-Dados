-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Clinica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Clinica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Clinica` DEFAULT CHARACTER SET utf8 ;
USE `Clinica` ;

-- -----------------------------------------------------
-- Table `Clinica`.`ESPECIALIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica`.`ESPECIALIDADE` (
  `id_especialidade` INT(3) NOT NULL,
  `designacao` VARCHAR(250) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica`.`CODIGO_POSTAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica`.`CODIGO_POSTAL` (
  `codigo_postal` VARCHAR(8) NOT NULL,
  `localidade` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`codigo_postal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica`.`MEDICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica`.`MEDICO` (
  `id_medico` INT(6) NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  `morada` VARCHAR(250) NOT NULL,
  `codigo_postal` VARCHAR(8) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `especialidade` INT(3) NOT NULL,
  `data_inicio_servico` DATE NOT NULL,
  INDEX `fk_med_idx` (`especialidade` ASC) VISIBLE,
  INDEX `fk_cp_idx` (`codigo_postal` ASC) VISIBLE,
  PRIMARY KEY (`id_medico`),
  CONSTRAINT `fk_especialidade1`
    FOREIGN KEY (`especialidade`)
    REFERENCES `Clinica`.`ESPECIALIDADE` (`id_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_codigo_postal1`
    FOREIGN KEY (`codigo_postal`)
    REFERENCES `Clinica`.`CODIGO_POSTAL` (`codigo_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica`.`PACIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica`.`PACIENTE` (
  `id_paciente` INT(6) NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  `morada` VARCHAR(250) NOT NULL,
  `codigo_postal` VARCHAR(8) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  INDEX `fk_paci_idx` (`codigo_postal` ASC) VISIBLE,
  PRIMARY KEY (`id_paciente`),
  CONSTRAINT `fk_codigo_postal2`
    FOREIGN KEY (`codigo_postal`)
    REFERENCES `Clinica`.`CODIGO_POSTAL` (`codigo_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica`.`CONSULTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica`.`CONSULTA` (
  `id_medico` INT(6) NOT NULL,
  `id_paciente` INT(6) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id_medico`, `id_paciente`, `data_hora`),
  INDEX `FK_cons02_idx` (`id_paciente` ASC) VISIBLE,
  CONSTRAINT `fk_medico1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `Clinica`.`MEDICO` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente1`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `Clinica`.`PACIENTE` (`id_paciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
