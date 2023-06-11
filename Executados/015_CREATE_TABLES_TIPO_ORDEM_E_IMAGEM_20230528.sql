-- MySQL Script generated by MySQL Workbench
-- Sun May 28 11:49:34 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema painel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `TB_TIPO_ORDEM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_TIPO_ORDEM` ;

CREATE TABLE IF NOT EXISTS `TB_TIPO_ORDEM` (
  `COD_EMPRESA` INT NOT NULL,
  `COD_TIPO_ORDEM` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NOT NULL,
  `TIPO` VARCHAR(45) NOT NULL COMMENT 'CREDITO (POSITO), DEBITO(NEGATIVO)',
  PRIMARY KEY (`COD_EMPRESA`, `COD_TIPO_ORDEM`),
  INDEX `fk_TB_TIPO_ORDEM_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  CONSTRAINT `fk_TB_TIPO_ORDEM_TB_EMPRESA1`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--
-- CADASTRA O TIPO DE ORDEM PADRÃO
--
INSERT INTO TB_TIPO_ORDEM (COD_EMPRESA, COD_TIPO_ORDEM, DESCRICAO, TIPO) 
SELECT COD_EMPRESA, 1, 'Credit', 'Credit' FROM TB_EMPRESA; 
--
INSERT INTO TB_TIPO_ORDEM (COD_EMPRESA, COD_TIPO_ORDEM, DESCRICAO, TIPO) 
SELECT COD_EMPRESA, 2, 'Debit', 'Debit' FROM TB_EMPRESA; 
--
-- REALIZAR O PROCESSO DAS CHAVES EM SEGUIDA CRIAR O CADASTRO INICIAL
--
ALTER TABLE TB_ORDEM ADD COLUMN COD_TIPO_ORDEM INT NOT NULL DEFAULT 1 COMMENT 'Por padrão vamos sumir que as ordem existentes no banco de dados são do tipo de credito' AFTER COD_USUARIO;
ALTER TABLE TB_JOBS_ORDEM ADD COLUMN COD_TIPO_ORDEM INT NOT NULL DEFAULT 1 COMMENT 'Por padrão vamos sumir que as ordem existentes no banco de dados são do tipo de credito' AFTER COD_JOB;
--
ALTER TABLE TB_ORDEM ADD CONSTRAINT FK_TB_ORDEM_03 FOREIGN KEY(COD_EMPRESA, COD_TIPO_ORDEM) REFERENCES TB_TIPO_ORDEM(COD_EMPRESA, COD_TIPO_ORDEM);
--
ALTER TABLE TB_JOBS_ORDEM DROP FOREIGN KEY fk_TB_JOBS_ORDEM_TB_ORDEM1;
--
-- DROP PRIMARY
ALTER TABLE TB_ORDEM DROP PRIMARY KEY;
--
ALTER TABLE TB_ORDEM ADD CONSTRAINT PRIMARY KEY(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM);
--
ALTER TABLE TB_JOBS_ORDEM ADD CONSTRAINT fk_TB_JOBS_ORDEM_TB_ORDEM1 FOREIGN KEY(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM) REFERENCES TB_ORDEM(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM);
--
-- DROP PRIMARY
--
ALTER TABLE TB_JOBS_ORDEM DROP PRIMARY KEY; -- Se der erro em produção usar apenas o de baixo
--
ALTER TABLE TB_JOBS_ORDEM ADD CONSTRAINT PRIMARY KEY(COD_EMPRESA,JOB_NUM,COD_FILIAL,COD_JOB,COD_TIPO_ORDEM);

-- -----------------------------------------------------
-- Table `TB_IMAGENS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_IMAGENS` ;

CREATE TABLE IF NOT EXISTS `TB_IMAGENS` (
  `ID_IMAGEM` INT NOT NULL AUTO_INCREMENT,
  `COD_EMPRESA` INT NOT NULL,
  `JOB_NUM` INT NOT NULL,
  `COD_FILIAL` INT NOT NULL,
  `COD_TIPO_ORDEM` INT NOT NULL,
  `NOME_ARQUIVO` VARCHAR(200) NOT NULL,
  `URL_ARQUIVO` VARCHAR(1000) NOT NULL,
  `ID_STORAGE` VARCHAR(500) NOT NULL,
  `DATA_CADASTRO` DATETIME NULL,
  PRIMARY KEY (`ID_IMAGEM`, `COD_EMPRESA`),
  INDEX `fk_TB_IMAGENS_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  INDEX `fk_TB_IMAGENS_TB_ORDEM1_idx` (`JOB_NUM` ASC, `COD_FILIAL` ASC, `COD_TIPO_ORDEM` ASC, `COD_EMPRESA` ASC))
ENGINE = InnoDB;
--
ALTER TABLE TB_IMAGENS ADD CONSTRAINT FK_TB_IMAGENS_01 FOREIGN KEY(COD_EMPRESA) 
	REFERENCES TB_EMPRESA(COD_EMPRESA);
ALTER TABLE TB_IMAGENS ADD CONSTRAINT FK_TB_IMAGENS_02 FOREIGN KEY(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM) 
	REFERENCES TB_ORDEM(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM);
--
--
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
--
--
DROP TRIGGER IF EXISTS NOVA_EMPRESA;
CREATE TRIGGER NOVA_EMPRESA
AFTER INSERT
ON TB_EMPRESA FOR EACH ROW
    INSERT INTO TB_TIPO_ORDEM (COD_EMPRESA, COD_TIPO_ORDEM, DESCRICAO, TIPO) 
    VALUES (NEW.COD_EMPRESA, 1, 'Credit', 'Credit'), (NEW.COD_EMPRESA, 2, 'Debit', 'Debit');
--
INSERT INTO `tb_paginas` (`COD_PAGINA`, `NOME_PAGINA`, `NOME_CONTROLADOR`, `FLG_ATIVO`, `COD_TIPO`, `FLG_TIPO_PAGINA`, `NIVEL_ACESSO`) 
VALUES ('4006', 'Order Type', 'CD_TipoOrdem', 'S', '400', 'C', '98');