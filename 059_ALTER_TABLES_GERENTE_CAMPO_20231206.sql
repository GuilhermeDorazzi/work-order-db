-- Cadastro da nova tela de relatório
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3021', 'General Market Report', 'CD_GeneralMarketReport', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3022', 'Field Director Analitico', 'CD_FieldDirectorReportAnalitico', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('4007', 'Salary', 'CD_Salary', 'S', '400', 'C', '98');
--
INSERT INTO tb_grupo (GRUTECH, NIVEL_ACESSO) 
VALUES ('Field Director', '2');
--
--
-- Alteração nas tabelas para contemplar as novas colunas
--
ALTER TABLE TB_JOB ADD COLUMN VALOR_FDR DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT 'Field Director Report, valor pago para o diretor de campo';
ALTER TABLE TB_JOB ADD COLUMN VALOR_FID DECIMAL(10,2) NOT NULL DEFAULT 0  COMMENT 'Field Director, valor de comissão';
--
ALTER TABLE TB_JOBS_USUARIO ADD COLUMN VALOR_FDR DECIMAL(10,2) NOT NULL DEFAULT 0  COMMENT 'Field Director Report, valor pago para o diretor de campo';
ALTER TABLE TB_JOBS_USUARIO ADD COLUMN VALOR_FID DECIMAL(10,2) NOT NULL DEFAULT 0  COMMENT 'Field Director, valor de comissão';
--
ALTER TABLE TB_JOBS_ORDEM ADD COLUMN VALOR_FDR DECIMAL(10,2) NOT NULL DEFAULT 0  COMMENT 'Field Director Report, valor pago para o diretor de campo';
ALTER TABLE TB_JOBS_ORDEM ADD COLUMN VALOR_FID DECIMAL(10,2) NOT NULL DEFAULT 0  COMMENT 'Field Director, valor de comissão';
ALTER TABLE TB_JOBS_ORDEM ADD COLUMN VALOR_FDR2 DECIMAL(10,2) NULL COMMENT 'Field Director Report, valor pago para o diretor de campo';
ALTER TABLE TB_JOBS_ORDEM ADD COLUMN VALOR_FID2 DECIMAL(10,2) NULL COMMENT 'Field Director, valor de comissão';
--
/*****************************************************************************************************/
/* 							ALTERAÇÃO DAS TRIGGERS RELACIONADAS AOS JOBS 					 		 */
/*****************************************************************************************************/
--
-- TRIGGER QUE DISPARA QUANDO UM NOVO JOB É CADASTRADO
--
DROP TRIGGER IF EXISTS NOVO_JOB;
-- 
CREATE TRIGGER NOVO_JOB
 AFTER INSERT
 ON TB_JOB FOR EACH ROW
 INSERT INTO TB_JOBS_USUARIO (COD_JOB, COD_EMPRESA, COD_USUARIO, VALOR_PAG, VALOR_REC, QTD_MAX, QTD_MIN, FLG_ATIVO, COD_FILIAL, VALOR_REP, VALOR_DESC, VALOR_FDR, VALOR_FID)
 SELECT 
    NEW.COD_JOB, US.COD_EMPRESA, US.COD_USUARIO, NEW.VALOR_PAG, NEW.VALOR_REC, NEW.QTD_MAX, NEW.QTD_MIN, NEW.FLG_ATIVO, NEW.COD_FILIAL, NEW.VALOR_REP, NEW.VALOR_DESC, NEW.VALOR_FDR, NEW.VALOR_FID
 FROM 
    TB_USUARIOS AS US WHERE US.COD_EMPRESA = NEW.COD_EMPRESA AND NEW.COD_FILIAL IN (SELECT COD_FILIAL FROM TB_USUARIO_FILIAL WHERE COD_USUARIO = US.COD_USUARIO AND US.COD_EMPRESA = NEW.COD_EMPRESA);
--
/*****************************************************************************************************/
