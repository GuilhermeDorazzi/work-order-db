--
ALTER TABLE TB_ORDEM ADD COLUMN ID_MOTIVO INT NULL COMMENT 'Quando uma ordem de serviço for reagendada o usuario precisa incluir o motivo aqui';
--
ALTER TABLE TB_ORDEM ADD CONSTRAINT FK_TB_ORDEM_04 FOREIGN KEY (ID_MOTIVO) REFERENCES TB_MOTIVO(ID_MOTIVO);
--