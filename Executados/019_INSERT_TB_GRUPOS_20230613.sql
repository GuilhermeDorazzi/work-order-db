--
INSERT INTO tb_grupo (GRUTECH, NIVEL_ACESSO) VALUES ('Quality Control', '5');
--
--
-- Validar se é a tela de ordem em produção
UPDATE tb_paginas SET NIVEL_ACESSO = '5' WHERE (`COD_PAGINA` = '2002');
--
