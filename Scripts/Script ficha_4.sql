create database ficha_4;
create table ficha_4.Departamento(
	id_departamento int primary key,
    designação varchar(45));
    
create table ficha_4.Docentes(
	id_docente int,
    nome varchar(100),
    categoria varchar(45),
    departamento_id int,
    primary key(id_docente),
    foreign key(departamento_id)
    references departamento (id_departamento)
    );
    
create table ficha_4.Cursos(
	id_curso int primary key,
    nr_alunos varchar(45),
    ciclo varchar(45),
    grau varchar(45),
    designacao varchar(45),
    foreign key(Docentes_nr_docente),
    foreign key(Docentes_Departamento_id_dep));

    
create table ficha_4.Alunos(
	id_aluno int primary key,
    nome varchar(45),
    cc varchar(45),
    nif varchar(45),
    data_nascimento varchar(45),
	nome_pai varchar(45)
    nome_mãe varchar(45)
    nome_enc);
        

insert into ficha_4.Departamento (id_departamento, designação) values (10, 'Departamento de Informática');
insert into ficha_4.Departamento values (20, 'Departamento de XPTO');

select * from ficha_4.Departamento;
    
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ficha_3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ficha_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ficha_3` DEFAULT CHARACTER SET utf8 ;
USE `Ficha_3` ;

-- -----------------------------------------------------
-- Table `Ficha_3`.`Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Alunos` (
  `nr_aluno` INT NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  `nif` CHAR(9) NULL,
  `data_nascimento` DATE NOT NULL,
  `cc` CHAR(9) NULL,
  `nome_mae` VARCHAR(100) NOT NULL,
  `nome_pai` VARCHAR(100) NOT NULL,
  `nome_enc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`nr_aluno`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `cc_UNIQUE` (`cc` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Departamento` (
  `id_dep` INT NOT NULL,
  `designacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dep`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Docentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Docentes` (
  `nr_docente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `Departamento_id_dep` INT NOT NULL,
  PRIMARY KEY (`nr_docente`, `Departamento_id_dep`),
  INDEX `fk_Docentes_Departamento1_idx` (`Departamento_id_dep` ASC) VISIBLE,
  CONSTRAINT `fk_Docentes_Departamento1`
    FOREIGN KEY (`Departamento_id_dep`)
    REFERENCES `Ficha_3`.`Departamento` (`id_dep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Cursos` (
  `id_curso` INT NOT NULL,
  `nr_alunos` INT NOT NULL,
  `ciclo` VARCHAR(45) NOT NULL,
  `grau` VARCHAR(45) NOT NULL,
  `designacao` VARCHAR(45) NOT NULL,
  `Docentes_nr_docente` INT NOT NULL,
  `Docentes_Departamento_id_dep` INT NOT NULL,
  PRIMARY KEY (`id_curso`),
  INDEX `fk_Cursos_Docentes1_idx` (`Docentes_nr_docente` ASC, `Docentes_Departamento_id_dep` ASC) VISIBLE,
  CONSTRAINT `fk_Cursos_Docentes1`
    FOREIGN KEY (`Docentes_nr_docente` , `Docentes_Departamento_id_dep`)
    REFERENCES `Ficha_3`.`Docentes` (`nr_docente` , `Departamento_id_dep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`UCs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`UCs` (
  `id_uc` INT NOT NULL,
  `semestre` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `ano_letivo` VARCHAR(45) NOT NULL,
  `Docentes_nr_docente` INT NOT NULL,
  `Cursos_id_curso` INT NOT NULL,
  PRIMARY KEY (`id_uc`),
  INDEX `fk_UCs_Docentes1_idx` (`Docentes_nr_docente` ASC) VISIBLE,
  INDEX `fk_UCs_Cursos1_idx` (`Cursos_id_curso` ASC) VISIBLE,
  CONSTRAINT `fk_UCs_Docentes1`
    FOREIGN KEY (`Docentes_nr_docente`)
    REFERENCES `Ficha_3`.`Docentes` (`nr_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UCs_Cursos1`
    FOREIGN KEY (`Cursos_id_curso`)
    REFERENCES `Ficha_3`.`Cursos` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Contacto` (
  `Contacto` CHAR(9) NOT NULL,
  `Ãlunos_nr_aluno` INT NOT NULL,
  PRIMARY KEY (`Contacto`, `Ãlunos_nr_aluno`),
  INDEX `fk_Contacto_Ãlunos_idx` (`Ãlunos_nr_aluno` ASC) VISIBLE,
  CONSTRAINT `fk_Contacto_Ãlunos`
    FOREIGN KEY (`Ãlunos_nr_aluno`)
    REFERENCES `Ficha_3`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Inscritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Inscritos` (
  `Cursos_id_curso` INT NOT NULL,
  `Alunos_nr_aluno` INT NOT NULL,
  PRIMARY KEY (`Cursos_id_curso`, `Alunos_nr_aluno`),
  INDEX `fk_Cursos_has_Alunos_Alunos1_idx` (`Alunos_nr_aluno` ASC) VISIBLE,
  INDEX `fk_Cursos_has_Alunos_Cursos1_idx` (`Cursos_id_curso` ASC) VISIBLE,
  CONSTRAINT `fk_Cursos_has_Alunos_Cursos1`
    FOREIGN KEY (`Cursos_id_curso`)
    REFERENCES `Ficha_3`.`Cursos` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_has_Alunos_Alunos1`
    FOREIGN KEY (`Alunos_nr_aluno`)
    REFERENCES `Ficha_3`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Matrícula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Matrícula` (
  `UCs_id_uc` INT NOT NULL,
  `Alunos_nr_aluno` INT NOT NULL,
  PRIMARY KEY (`UCs_id_uc`, `Alunos_nr_aluno`),
  INDEX `fk_UCs_has_Alunos_Alunos1_idx` (`Alunos_nr_aluno` ASC) VISIBLE,
  INDEX `fk_UCs_has_Alunos_UCs1_idx` (`UCs_id_uc` ASC) VISIBLE,
  CONSTRAINT `fk_UCs_has_Alunos_UCs1`
    FOREIGN KEY (`UCs_id_uc`)
    REFERENCES `Ficha_3`.`UCs` (`id_uc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UCs_has_Alunos_Alunos1`
    FOREIGN KEY (`Alunos_nr_aluno`)
    REFERENCES `Ficha_3`.`Alunos` (`nr_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ficha_3`.`Leciona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ficha_3`.`Leciona` (
  `Docentes_nr_docente` INT NOT NULL,
  `UCs_id_uc` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `nr_horas` INT NOT NULL,
  INDEX `fk_Docentes_has_UCs_UCs1_idx` (`UCs_id_uc` ASC) VISIBLE,
  INDEX `fk_Docentes_has_UCs_Docentes1_idx` (`Docentes_nr_docente` ASC) VISIBLE,
  CONSTRAINT `fk_Docentes_has_UCs_Docentes1`
    FOREIGN KEY (`Docentes_nr_docente`)
    REFERENCES `Ficha_3`.`Docentes` (`nr_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Docentes_has_UCs_UCs1`
    FOREIGN KEY (`UCs_id_uc`)
    REFERENCES `Ficha_3`.`UCs` (`id_uc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
