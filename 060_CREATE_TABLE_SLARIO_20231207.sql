-- MySQL Script generated by MySQL Workbench
-- Mon Dec 11 20:42:41 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `TB_SALARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_SALARIO` ;

CREATE TABLE IF NOT EXISTS `TB_SALARIO` (
  `ID_SALARIO` INT NOT NULL AUTO_INCREMENT,
  `COD_EMPRESA` INT NOT NULL,
  `COD_USUARIO` INT NOT NULL,
  `COD_FILIAL` INT NOT NULL,
  `TITULO` VARCHAR(100) NULL,
  `TIPO_SALARIO` VARCHAR(20) NOT NULL,
  `DATA_VENCIMENTO` DATE NOT NULL,
  `VALOR_SALARIO` DECIMAL(10,2) NOT NULL,
  `FLG_ATIVO` VARCHAR(1) NOT NULL DEFAULT 'S',
  PRIMARY KEY (`ID_SALARIO`),
  INDEX `TB_SALARIO_IDX01` (`COD_EMPRESA` ASC),
  INDEX `TB_SALARIO_IDX02` (`COD_USUARIO` ASC, `COD_EMPRESA` ASC),
  INDEX `TB_SALARIO_IDX03` (`COD_EMPRESA` ASC),
  INDEX `TB_SALARIO_IDX04` (`COD_FILIAL` ASC, `COD_EMPRESA` ASC),
  CONSTRAINT `FK_TB_SALARIO_01`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_02`
    FOREIGN KEY (`COD_USUARIO` , `COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_USUARIO` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_03`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_04`
    FOREIGN KEY (`COD_FILIAL` , `COD_EMPRESA`)
    REFERENCES `TB_FILIAL` (`COD_FILIAL` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `TB_SALARIO_LANCADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_SALARIO_LANCADO` ;

CREATE TABLE IF NOT EXISTS `TB_SALARIO_LANCADO` (
  `ID_SALARIO_LANCADO` INT NOT NULL AUTO_INCREMENT,
  `COD_EMPRESA` INT NOT NULL,
  `COD_USUARIO` INT NOT NULL,
  `COD_FILIAL` INT NOT NULL,
  `ID_SALARIO` INT NOT NULL,
  `TITULO` VARCHAR(100) NULL,
  `TIPO_SALARIO` VARCHAR(20) NOT NULL,
  `DATA_LANCAMENTO` DATE NOT NULL,
  `VALOR_SALARIO` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_SALARIO_LANCADO`),
  INDEX `FK_TB_SALARIO_LANCADO_IDX01` (`COD_EMPRESA` ASC),
  INDEX `FK_TB_SALARIO_LANCADO_IDX02` (`COD_USUARIO` ASC, `COD_EMPRESA` ASC),
  INDEX `FK_TB_SALARIO_LANCADO_IDX03` (`COD_FILIAL` ASC, `COD_EMPRESA` ASC),
  INDEX `FK_TB_SALARIO_LANCADO_IDX04` (`ID_SALARIO` ASC),
  CONSTRAINT `FK_TB_SALARIO_LANCADO_01`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_LANCADO_02`
    FOREIGN KEY (`COD_USUARIO` , `COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_USUARIO` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_LANCADO_03`
    FOREIGN KEY (`COD_FILIAL` , `COD_EMPRESA`)
    REFERENCES `TB_FILIAL` (`COD_FILIAL` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_SALARIO_LANCADO_04`
    FOREIGN KEY (`ID_SALARIO`)
    REFERENCES `TB_SALARIO` (`ID_SALARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
