--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3020', 'Tech Invoice', 'CD_ReportsTechInvoice', 'S', '300', 'C', '98');
--
ALTER TABLE TB_EMPRESA ADD COLUMN `LOCAL_INVOICE` VARCHAR(150) NULL COMMENT 'Coluna que armazena o nome do local que será impresso na invoice';
--
ALTER TABLE TB_EMPRESA ADD COLUMN `PHONE_INVOICE` VARCHAR(50) NULL COMMENT 'Telefone que será exibido na invoice';
--
ALTER TABLE TB_EMPRESA ADD COLUMN `EMAIL_INVOICE` VARCHAR(150) NULL COMMENT 'E-mail que será exibido na invoice';
--