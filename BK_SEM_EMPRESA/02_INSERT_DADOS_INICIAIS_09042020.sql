INSERT INTO 
TB_TIPOS_PAGINAS 
(COD_TIPO, CLASSE_CSS_ICON, DESCRICAO) VALUES 
(300, ' fa-cogs ', 'Cadastros'),
(100, ' fa-users-cog ', 'Controle de Acesso');
--
INSERT INTO 
TB_TIPOS_ACESSOS 
(COD_TIPO_ACESSO,FLG_TIPO_ACESSO,DES_TIPO_ACESSO) VALUES
(1,'A','Alteração'), 
(2,'V','Visualização'),
(3,'N','Sem acesso');