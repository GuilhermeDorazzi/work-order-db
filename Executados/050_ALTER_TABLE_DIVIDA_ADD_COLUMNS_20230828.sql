--
-- ALTERAÇÃO TABELA DIVIDA
--
ALTER TABLE TB_DIVIDA ADD COLUMN TIPO VARCHAR(1) NOT NULL DEFAULT 'E' COMMENT '[E]mprestimo, [B]onificação';
--  
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('1009', 'Credit', 'CD_Bonus', 'S', '400', 'C', '98');
--