--
-- Aqui vamos fazer a criacao das tabelas que vao armazenar os valores referentes aos ultimos 12 meses 
--
CREATE TABLE `tb_dashboard_mes` (
  `COD_EMPRESA` int(11) NOT NULL COMMENT 'Coluna que armazenas as informacoes da empresa',
  `COD_FILIAL` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que a filial 1 sempre seja a matriz ela tem que existem no cadastro',
  `MES` int(10) NOT NULL COMMENT 'Armazena o mes referente aos registros',
  `TOTAL_RECEBIDO` decimal(10,2) DEFAULT 0,
  `TOTAL_PAGO` decimal(10,2) DEFAULT 0,
  `TOTAL_LUCRO` decimal(10,2) DEFAULT 0,
  PRIMARY KEY (`COD_EMPRESA`,`COD_FILIAL`,`MES`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
CREATE TABLE `tb_dashboard_tech` (
  `COD_EMPRESA` int(11) NOT NULL COMMENT 'Coluna que armazenas as informacoes da empresa',
  `COD_FILIAL` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que a filial 1 sempre seja a matriz ela tem que existem no cadastro',
  `COD_USUARIO` int(11) NOT NULL,
  `NOM_USUARIO` varchar(100) NOT NULL,
  `MES` int(10) NOT NULL COMMENT 'Armazena o mes referente aos registros',
  `TOTAL_RECEBIDO` decimal(10,2) DEFAULT 0,
  `TOTAL_PAGO` decimal(10,2) DEFAULT 0,
  `TOTAL_LUCRO` decimal(10,2) DEFAULT 0,
  PRIMARY KEY (`COD_EMPRESA`,`COD_FILIAL`,`MES`,`COD_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
CREATE TABLE `tb_dashboard_job` (
  `COD_EMPRESA` int(11) NOT NULL COMMENT 'Coluna que armazenas as informacoes da empresa',
  `COD_FILIAL` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que a filial 1 sempre seja a matriz ela tem que existem no cadastro',
  `COD_JOB` int(11) NOT NULL,
  `MES` int(10) NOT NULL COMMENT 'Armazena o mes referente aos registros',
  `NOM_JOB` varchar(100) NOT NULL,
  `QTD` int(10) NOT NULL,
  `TOTAL_RECEBIDO` decimal(10,2) DEFAULT 0,
  `TOTAL_PAGO` decimal(10,2) DEFAULT 0,
  `TOTAL_LUCRO` decimal(10,2) DEFAULT 0,
  PRIMARY KEY (`COD_EMPRESA`,`COD_FILIAL`,`MES`,`COD_JOB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
CREATE TABLE `tb_dashboard_filial` (
  `COD_EMPRESA` int(11) NOT NULL COMMENT 'Coluna que armazenas as informacoes da empresa',
  `COD_FILIAL` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que a filial 1 sempre seja a matriz ela tem que existem no cadastro',
  `NOM_FILIAL` varchar(100) NOT NULL,
  `TOTAL_RECEBIDO` decimal(10,2) DEFAULT 0,
  `TOTAL_PAGO` decimal(10,2) DEFAULT 0,
  `TOTAL_LUCRO` decimal(10,2) DEFAULT 0,
  PRIMARY KEY (`COD_EMPRESA`,`COD_FILIAL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;