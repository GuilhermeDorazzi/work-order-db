-- MySQL Script generated by MySQL Workbench
-- Thu Jul 20 11:19:23 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema painel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `TB_CORTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TB_CORTE` ;

CREATE TABLE IF NOT EXISTS `TB_CORTE` (
  `ID_CORTE` INT NOT NULL,
  `COD_EMPRESA` INT NOT NULL,
  `DATA_CORTE` DATETIME NOT NULL DEFAULT current_timestamp,
  `COD_USUARIO` INT NOT NULL,
  PRIMARY KEY (`ID_CORTE`, `COD_EMPRESA`),
  INDEX `fk_TB_CORTE_TB_EMPRESA1_idx` (`COD_EMPRESA` ASC),
  INDEX `fk_TB_CORTE_TB_USUARIOS1_idx` (`COD_USUARIO` ASC, `COD_EMPRESA` ASC),
  CONSTRAINT `FK_TB_CORTE_01`
    FOREIGN KEY (`COD_EMPRESA`)
    REFERENCES `TB_EMPRESA` (`COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TB_CORTE_02`
    FOREIGN KEY (`COD_USUARIO` , `COD_EMPRESA`)
    REFERENCES `TB_USUARIOS` (`COD_USUARIO` , `COD_EMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--
--
INSERT INTO TB_CORTE(ID_CORTE, COD_EMPRESA, DATA_CORTE, COD_USUARIO)
VALUES (1, 1,'2023-06-01 00:00:01', 1);
--
INSERT INTO TB_CORTE(ID_CORTE, COD_EMPRESA, DATA_CORTE, COD_USUARIO)
VALUES (1, 2,'2023-06-01 00:00:01', 4);
--
INSERT INTO TB_CORTE(ID_CORTE, COD_EMPRESA, DATA_CORTE, COD_USUARIO)
VALUES (1, 3,'2023-06-01 00:00:01', 10);
--
INSERT INTO TB_CORTE(ID_CORTE, COD_EMPRESA, DATA_CORTE, COD_USUARIO)
VALUES (1, 4,'2023-06-01 00:00:01', 104);
--
--

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
