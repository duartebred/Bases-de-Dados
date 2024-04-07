-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aula
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aula
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aula` DEFAULT CHARACTER SET utf8 ;
USE `aula` ;

-- -----------------------------------------------------
-- Table `aula`.`Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Alunos` (
  `nr_aluno` INT NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  `dta_nascimento` DATE NOT NULL,
  `CC` CHAR(8) NULL,
  `NIF` CHAR(9) NULL,
  `rua` VARCHAR(100) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  `cod_postal` CHAR(8) NOT NULL,
  PRIMARY KEY (`nr_aluno`),
  UNIQUE INDEX `CC_UNIQUE` (`CC` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Telefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Telefones` (
  `telefone` CHAR(9) NOT NULL,
  `nr_aluno` INT NOT NULL,
  PRIMARY KEY (`telefone`, `nr_aluno`),
  INDEX `fk_Telefones_Alunos_idx` (`nr_aluno` ASC) VISIBLE,
  CONSTRAINT `fk_Telefones_Alunos`
    FOREIGN KEY (`nr_aluno`)
    REFERENCES `aula`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Emails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Emails` (
  `email` VARCHAR(100) NOT NULL,
  `nr_aluno` INT NOT NULL,
  PRIMARY KEY (`email`, `nr_aluno`),
  INDEX `fk_Emails_Alunos1_idx` (`nr_aluno` ASC) VISIBLE,
  CONSTRAINT `fk_Emails_Alunos1`
    FOREIGN KEY (`nr_aluno`)
    REFERENCES `aula`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`UCs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`UCs` (
  `cod_uc` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cod_uc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Departamento` (
  `idDep` INT NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idDep`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Professores` (
  `idProf` INT NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  `idDep` INT NOT NULL,
  PRIMARY KEY (`idProf`),
  INDEX `fk_Professores_Departamento1_idx` (`idDep` ASC) VISIBLE,
  CONSTRAINT `fk_Professores_Departamento1`
    FOREIGN KEY (`idDep`)
    REFERENCES `aula`.`Departamento` (`idDep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Turma` (
  `id_turma` INT NOT NULL,
  `semestre` VARCHAR(45) NOT NULL,
  `ano letivo` CHAR(5) NOT NULL,
  `nr_aluno` INT NOT NULL,
  `cod_uc` INT NOT NULL,
  PRIMARY KEY (`id_turma`),
  INDEX `fk_Turma_Alunos1_idx` (`nr_aluno` ASC) VISIBLE,
  INDEX `fk_Turma_UCs1_idx` (`cod_uc` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_Alunos1`
    FOREIGN KEY (`nr_aluno`)
    REFERENCES `aula`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_UCs1`
    FOREIGN KEY (`cod_uc`)
    REFERENCES `aula`.`UCs` (`cod_uc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula`.`Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula`.`Aula` (
  `idProf` INT NOT NULL,
  `id_turma` INT NOT NULL,
  `turno` VARCHAR(45) NOT NULL,
  `horas` VARCHAR(45) NOT NULL,
  `sumario` VARCHAR(200) NULL,
  `nr_presencas` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProf`, `id_turma`),
  INDEX `fk_Professores_has_Turma_Turma1_idx` (`id_turma` ASC) VISIBLE,
  INDEX `fk_Professores_has_Turma_Professores1_idx` (`idProf` ASC) VISIBLE,
  CONSTRAINT `fk_Professores_has_Turma_Professores1`
    FOREIGN KEY (`idProf`)
    REFERENCES `aula`.`Professores` (`idProf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professores_has_Turma_Turma1`
    FOREIGN KEY (`id_turma`)
    REFERENCES `aula`.`Turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
