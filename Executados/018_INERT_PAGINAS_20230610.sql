--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('1005', 'Manage Users (Master)', 'AC_MasterUsuarios', 'S', '100', 'M', '99');
-- 
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('1006', 'User X Page (Master)', 'AC_MasterUsuariosPaginas', 'S', '100', 'M', '99');
--
-- Verificar se é a tela de empresas
UPDATE tb_paginas SET COD_TIPO = '100' WHERE (`COD_PAGINA` = '1003');
