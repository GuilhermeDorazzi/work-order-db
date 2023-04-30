-- MySQL Script generated by MySQL Workbench
-- Mon Apr 24 19:36:33 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema painel-clgas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `TB_EMPRESA`
-- -----------------------------------------------------

ALTER TABLE TB_EMPRESA
ADD VALOR_IMP DECIMAL(10,2) NOT NULL DEFAULT 0;

ALTER TABLE TB_EMPRESA
ADD VALOR_EXP DECIMAL(10,2) NOT NULL DEFAULT 0;

-- -----------------------------------------------------
-- Table `TB_USUARIOS`
-- -----------------------------------------------------
ALTER TABLE TB_USUARIOS
ADD COD_TECH VARCHAR(20) NOT NULL COMMENT 'TECH NUMBER';

ALTER TABLE TB_USUARIOS
ADD FHO_TECH VARCHAR(15) NOT NULL;

ALTER TABLE TB_USUARIOS
ADD SSN_TECH VARCHAR(60) NOT NULL;

ALTER TABLE TB_USUARIOS
ADD GRUTECH VARCHAR(50) NOT NULL;

ALTER TABLE TB_USUARIOS
ADD DATA_CADASTRO DATETIME NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE TB_USUARIOS
ADD DATA_ATUALIZACAO DATETIME NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE TB_USUARIOS
ADD CONSTRAINT CODTECH_UNIQUE UNIQUE (`COD_TECH`, `COD_EMPRESA`);

-- -----------------------------------------------------
-- Table `TB_JOB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_JOB` (
  `COD_JOB` INT NOT NULL AUTO_INCREMENT,
  `COD_EMPRESA` INT NOT NULL,
  `COD_DEPARA_COMP` VARCHAR(100) NOT NULL COMMENT 'Esse código representa o deparado do job do nosso lado em relação a outra empresa',
  `NOME_JOB` VARCHAR(100) NOT NULL,
  `VALOR_PAG` DECIMAL(10,2) NOT NULL,
  `VALOR_REC` DECIMAL(10,2) NOT NULL,
  `QTD_MAX` DECIMAL(10,2) NOT NULL,
  `QTD_MIN` DECIMAL(10,2) NOT NULL,
  `FLG_ATIVO` VARCHAR(1) NOT NULL DEFAULT 'S',
  `DATA_CADASTRO` DATETIME NULL,
  `DATA_ATUALIZACAO` DATETIME NULL,
  PRIMARY KEY (`COD_JOB`),
  INDEX `fk_TB_JOBS_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  CONSTRAINT `fk_TB_JOBS_TB_EMPRESA1`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TB_CIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_CIDADE` (
  `COD_CIDADE` INT NOT NULL AUTO_INCREMENT,
  `COD_EMPRESA` INT NOT NULL,
  `NOME_CIDADE` VARCHAR(100) NOT NULL,
  `FLG_ATIVO` VARCHAR(1) NOT NULL DEFAULT 'S',
  `DATA_CADASTRO` DATETIME NULL,
  `DATA_ATUALIZACAO` DATETIME NULL,
  PRIMARY KEY (`COD_CIDADE`),
  INDEX `fk_TB_CIDADE_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  CONSTRAINT `fk_TB_CIDADE_TB_EMPRESA1`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TB_ORDEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_ORDEM` (
  `JOB_NUM` INT NOT NULL,
  `COD_EMPRESA` INT NOT NULL,
  `COD_USUARIO` INT NOT NULL,
  `DATA_AGEND` DATETIME NOT NULL,
  `STATUS` VARCHAR(20) NOT NULL,
  `COMENTARIO` TEXT NULL,
  `DATA_BAIXA` DATETIME NULL,
  `COD_CIDADE` INT NOT NULL,
  `ZAIP_CODE` VARCHAR(20) NULL,
  `NUM_CASA` VARCHAR(20) NULL,
  `NOME_RUA` VARCHAR(100) NULL,
  `ORDEM_COM` TEXT NULL,
  `TIME_SLO` VARCHAR(10) NULL,
  `TEL_CLIENTE` VARCHAR(25) NULL,
  `TEL_CLIENTE2` VARCHAR(25) NULL,
  `DATA_ATUALIZACAO` DATETIME NULL,
  `DATA_CADASTRO` DATETIME NULL,
  PRIMARY KEY (`JOB_NUM`, `COD_EMPRESA`),
  INDEX `fk_TB_ORDEM_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  INDEX `fk_TB_ORDEM_TB_USUARIOS1_idx` (`COD_USUARIO` ASC, `COD_EMPRESA` ASC),
  INDEX `fk_TB_ORDEM_TB_CIDADE1_idx` (`COD_CIDADE` ASC),
  CONSTRAINT `fk_TB_ORDEM_TB_EMPRESA1`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_ORDEM_TB_USUARIOS1`
    FOREIGN KEY (`COD_USUARIO` , `COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_USUARIO` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_ORDEM_TB_CIDADE1`
    FOREIGN KEY (`COD_CIDADE`)
    REFERENCES `TB_CIDADE` (`COD_CIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TB_JOBS_ORDEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TB_JOBS_ORDEM` (
  `COD_EMPRESA` INT NOT NULL,
  `JOB_NUM` INT NOT NULL,
  `COD_JOB` INT NOT NULL,
  `QTD` DECIMAL(10,2) NOT NULL,
  `DATA_CADASTRO` DATETIME NULL,
  `DATA_ATUALIZACAO` DATETIME NULL,
  INDEX `fk_TB_JOBS_ORDEM_TB_ORDEM1_idx` (`JOB_NUM` ASC),
  INDEX `fk_TB_JOBS_ORDEM_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  PRIMARY KEY (`COD_EMPRESA`, `JOB_NUM`, `COD_JOB`),
  CONSTRAINT `fk_TB_JOBS_ORDEM_TB_ORDEM1`
    FOREIGN KEY (`JOB_NUM`)
    REFERENCES `TB_ORDEM` (`JOB_NUM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_JOBS_ORDEM_TB_JOB1`
    FOREIGN KEY (`COD_JOB`)
    REFERENCES `TB_JOB` (`COD_JOB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_JOBS_ORDEM_TB_EMPRESA1`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;