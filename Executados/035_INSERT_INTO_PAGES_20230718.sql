--
INSERT INTO tb_tipos_paginas (COD_TIPO, CLASSE_CSS_ICON, DESCRICAO, ORDEM_MENU) 
VALUES ('500', ' fa-comment ', 'Notice', '5');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('5001', 'Notice', 'CD_Aviso', 'S', '500', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('5002', 'Accepted Terms', 'CD_AvisoUsuario', 'S', '500', 'C', '1');
--
