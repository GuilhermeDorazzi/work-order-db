INSERT INTO`tb_tipos_paginas` (`COD_TIPO`, `CLASSE_CSS_ICON`, `DESCRICAO`, `ORDEM_MENU`) 
	 VALUES ('900', ' fa-tachometer-alt', 'Dashboard', '0');
--
INSERT INTO `tb_paginas` (`COD_PAGINA`, `NOME_PAGINA`, `NOME_CONTROLADOR`, `FLG_ATIVO`, `COD_TIPO`, `FLG_TIPO_PAGINA`, `NIVEL_ACESSO`) 
	 VALUES ('9000', 'Dashboard', 'DS_Dashboard', 'S', '900', 'C', '98');
--