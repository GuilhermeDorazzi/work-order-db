--
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3002', 'Admin Master Report City Job', 'CD_ReportsAdminMasterReportCityJob', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3003', 'Admin Master Report Job', 'CD_ReportsAdminMasterReportJob', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3004', 'Admin Master Report Tech Job', 'CD_ReportsAdminMasterReportTechJob', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3005', 'Admin Review Report', 'CD_ReportsAdminReviewReport', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3006', 'Breakdown Tech Report (Admin)', 'CD_ReportsBreakdownTechReport', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3007', 'Report Dispatcher Closing (Admin)', 'CD_ReportsDispatcherClosing', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3008', 'Manager Review Report (Super)', 'CD_ReportsAdminReviewReportSuper', 'S', '300', 'C', '10');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3009', 'Report Simple (QC)', 'CD_ReportsSimple', 'S', '300', 'C', '5');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3010', 'Analitico Tech', 'CD_ReportsAnaliticoTech', 'S', '300', 'C', '1');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3011', 'Tech Report', 'CD_ReportsTechReport', 'S', '300', 'C', '1');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3012', 'Report Dispatcher Closing Group Qty (Admin)', 'CD_ReportsDispatcherClosingGroupQty', 'S', '300', 'C', '98');
--
INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
VALUES ('3013', 'Report Dispatcher Closing Simple (Admin)', 'CD_ReportsDispatcherClosingSimple', 'S', '300', 'C', '98');
--
--
DELETE FROM tb_paginas WHERE (COD_PAGINA = '3001');
--
-- usar somente se precisar voltar a tela antiga
-- INSERT INTO tb_paginas (COD_PAGINA, NOME_PAGINA, NOME_CONTROLADOR, FLG_ATIVO, COD_TIPO, FLG_TIPO_PAGINA, NIVEL_ACESSO) 
-- VALUES ('3001', 'Reports', 'CD_Reports', 'S', '300', 'C', '1');