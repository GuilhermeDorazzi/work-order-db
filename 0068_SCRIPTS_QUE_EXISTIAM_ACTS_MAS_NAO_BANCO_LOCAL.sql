CREATE TABLE `tb_ordem_deletado` (
  `ID_LOG` int(20) NOT NULL AUTO_INCREMENT,
  `ID_ORDEM` int(20) NOT NULL,
  `JOB_NUM` varchar(30) NOT NULL,
  `COD_EMPRESA` int(11) NOT NULL,
  `COD_USUARIO` int(11) NOT NULL,
  `COD_TIPO_ORDEM` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que as ordem existentes no banco de dados são do tipo de credito',
  `ID_CORTE` int(11) NOT NULL DEFAULT '1',
  `DATA_AGEND` datetime NOT NULL,
  `STATUS` varchar(20) NOT NULL,
  `COMENTARIO` text,
  `DATA_BAIXA` datetime DEFAULT NULL,
  `COD_CIDADE` int(11) NOT NULL,
  `ZIP_CODE` varchar(20) DEFAULT NULL,
  `NUM_CASA` varchar(20) DEFAULT NULL,
  `NOME_RUA` varchar(100) DEFAULT NULL,
  `ORDEM_COM` text,
  `TIME_SLO` varchar(10) DEFAULT NULL,
  `TEL_CLIENTE` varchar(25) DEFAULT NULL,
  `TEL_CLIENTE2` varchar(25) DEFAULT NULL,
  `DATA_ATUALIZACAO` datetime DEFAULT NULL,
  `DATA_CADASTRO` datetime DEFAULT NULL,
  `COD_FILIAL` int(11) NOT NULL DEFAULT '1' COMMENT 'Por padrão vamos sumir que a filial 1 sempre seja a matriz ela tem que existem no cadastro',
  `TEM_IMAGEM` varchar(1) DEFAULT 'N' COMMENT 'Coluna que vai gravar se uma ordem de serviço tem ou não imagem relacionada (Valores vão varia de S e N)',
  `ID_MOTIVO` int(11) DEFAULT NULL COMMENT 'Quando uma ordem de serviço for reagendada o usuario precisa incluir o motivo aqui',
  PRIMARY KEY (`ID_LOG`),
  KEY `FK_TB_ORDEM_DEL_01_IDX` (`COD_EMPRESA`),
  KEY `FK_TB_ORDEM_DEL_02_IDX` (`COD_EMPRESA`,`COD_USUARIO`),
  KEY `FK_TB_ORDEM_DEL_03_IDX` (`COD_EMPRESA`,`COD_CIDADE`),
  KEY `FK_TB_ORDEM_DEL_04_IDX` (`COD_EMPRESA`,`STATUS`,`DATA_BAIXA`),
  KEY `FK_TB_ORDEM_DEL_05_IDX` (`COD_EMPRESA`,`COD_FILIAL`),
  KEY `FK_TB_ORDEM_DEL_06_IDX` (`COD_EMPRESA`,`COD_TIPO_ORDEM`),
  KEY `FK_TB_ORDEM_DEL_07_IDX` (`COD_EMPRESA`,`ID_MOTIVO`),
  KEY `FK_TB_ORDEM_DEL_03` (`ID_MOTIVO`),
  KEY `FK_TB_ORDEM_DEL_04` (`COD_CIDADE`),
  KEY `FK_TB_ORDEM_DEL_06` (`COD_USUARIO`,`COD_EMPRESA`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
--
DELIMITER $$
CREATE TRIGGER ANTES_DELETAR_ORDEM
 BEFORE DELETE ON tb_ordem
 FOR EACH ROW
 BEGIN
     -- Inserir o registro na tabela B
     INSERT INTO tb_ordem_deletado(
 		ID_ORDEM,
         JOB_NUM,
         COD_EMPRESA,
         COD_USUARIO,
         COD_TIPO_ORDEM,
         ID_CORTE,
         DATA_AGEND,
         STATUS,
         COMENTARIO,
         DATA_BAIXA,
         COD_CIDADE,
         ZIP_CODE,
         NUM_CASA,
         NOME_RUA,
         ORDEM_COM,
         TIME_SLO,
         TEL_CLIENTE,
         TEL_CLIENTE2,
         DATA_ATUALIZACAO,
         DATA_CADASTRO,
         COD_FILIAL,
         TEM_IMAGEM,
         ID_MOTIVO
     )
     VALUES (
         OLD.ID_ORDEM,
         OLD.JOB_NUM,
         OLD.COD_EMPRESA,
         OLD.COD_USUARIO,
         OLD.COD_TIPO_ORDEM,
         OLD.ID_CORTE,
         OLD.DATA_AGEND,
         OLD.STATUS,
         OLD.COMENTARIO,
         OLD.DATA_BAIXA,
         OLD.COD_CIDADE,
         OLD.ZIP_CODE,
         OLD.NUM_CASA,
         OLD.NOME_RUA,
         OLD.ORDEM_COM,
         OLD.TIME_SLO,
         OLD.TEL_CLIENTE,
         OLD.TEL_CLIENTE2,
         OLD.DATA_ATUALIZACAO,
         OLD.DATA_CADASTRO,
         OLD.COD_FILIAL,
         OLD.TEM_IMAGEM,
         OLD.ID_MOTIVO
     );
 END $$
 DELIMITER ;
 --
 