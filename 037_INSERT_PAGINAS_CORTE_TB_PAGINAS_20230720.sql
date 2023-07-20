--
INSERT INTO tb_tipos_paginas (COD_TIPO, CLASSE_CSS_ICON, DESCRICAO, ORDEM_MENU) 
VALUES ('600', ' fa-layer-group ', 'Splitting the data to create a new group', '6');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('6001', 'Splitting the data to create a new group', 'CD_Corte', 'S', '600', 'C', '98');
--