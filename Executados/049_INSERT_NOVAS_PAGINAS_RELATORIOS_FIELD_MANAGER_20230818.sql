INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3018', 'Field Manager Report', 'CD_ReportsFieldManagerReport', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3019', 'Analitico Field Manager', 'CD_ReportsAnaliticoFieldManager', 'S', '300', 'C', '98');
--
UPDATE `tb_paginas` SET `NOME_PAGINA` = 'Admin Review Report (Field Manager)' WHERE (`COD_PAGINA` = '3016');
UPDATE `tb_paginas` SET `NOME_PAGINA` = 'Admin Master Report Tech Job  (Field Manager)' WHERE (`COD_PAGINA` = '3017');
UPDATE `tb_paginas` SET `NOME_PAGINA` = 'Field Manager X Tech' WHERE (`COD_PAGINA` = '3015');
