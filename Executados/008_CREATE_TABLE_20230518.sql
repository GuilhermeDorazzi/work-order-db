-- MySQL Script generated by MySQL Workbench
-- Thu May 18 21:06:06 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema painel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `TB_GRUPO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_GRUPO` ;

CREATE TABLE IF NOT EXISTS `TB_GRUPO` (
  `GRUTECH` VARCHAR(50) NOT NULL,
  `NIVEL_ACESSO` INT NOT NULL,
  PRIMARY KEY (`GRUTECH`))
ENGINE = InnoDB;
--
INSERT INTO TB_GRUPO (GRUTECH, NIVEL_ACESSO) VALUES ('Tech', 1);
INSERT INTO TB_GRUPO (GRUTECH, NIVEL_ACESSO) VALUES ('Admin', 98);
INSERT INTO TB_GRUPO (GRUTECH, NIVEL_ACESSO) VALUES ('Master', 99);

--
ALTER TABLE TB_PAGINAS ADD COLUMN NIVEL_ACESSO INT NOT NULL DEFAULT 1;
--
ALTER TABLE TB_USUARIOS ADD CONSTRAINT FK_TB_USUARIOS_01
FOREIGN KEY(GRUTECH) REFERENCES TB_GRUPO(GRUTECH);
--
ALTER TABLE TB_JOBS_ORDEM DROP FOREIGN KEY fk_TB_JOBS_ORDEM_TB_JOB1;
--
-- -----------------------------------------------------
-- Table `TB_JOBS_USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_JOBS_USUARIO` ;

CREATE TABLE IF NOT EXISTS `TB_JOBS_USUARIO` (
  `COD_JOB` INT NOT NULL AUTO_INCREMENT,
  `COD_USUARIO` INT NOT NULL,
  `COD_EMPRESA` INT NOT NULL,
  `VALOR_PAG` DECIMAL(10,2) NOT NULL,
  `VALOR_REC` DECIMAL(10,2) NOT NULL,
  `QTD_MAX` DECIMAL(10,2) NOT NULL,
  `QTD_MIN` DECIMAL(10,2) NOT NULL,
  `FLG_ATIVO` VARCHAR(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`COD_EMPRESA`, `COD_JOB`, `COD_USUARIO`),
  INDEX `IDX_TB_JOB_USUARIO_01` (`COD_EMPRESA` ASC),
  INDEX `IDX_TB_JOB_USUARIO_02` (`COD_USUARIO` ASC, `COD_EMPRESA` ASC),
  CONSTRAINT `FK_JOB_USUARIO_02`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_JOB_USUARIO_01`
    FOREIGN KEY (`COD_JOB`)
    REFERENCES `TB_JOB` (`COD_JOB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_JOB_USUARIO_03`
    FOREIGN KEY (`COD_USUARIO` , `COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_USUARIO` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
--
INSERT INTO TB_PAGINAS (`COD_PAGINA`, `NOME_PAGINA`, `NOME_CONTROLADOR`, `FLG_ATIVO`, `COD_TIPO`, `FLG_TIPO_PAGINA`, `NIVEL_ACESSO`) 
VALUES ('4003', 'Tech X Jobs', 'CD_JobUsuario', 'S', '400', 'C', '98');
--
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
