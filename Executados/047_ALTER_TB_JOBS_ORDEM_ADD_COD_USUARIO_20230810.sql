--
ALTER TABLE tb_jobs_ordem ADD COLUMN COD_USUARIO INT(11) DEFAULT NULL;
--
ALTER TABLE TB_JOBS_ORDEM ADD CONSTRAINT FK_TB_JOBS_ORDEM_NEW_04 FOREIGN KEY (COD_USUARIO,COD_EMPRESA) REFERENCES TB_USUARIOS (COD_USUARIO,COD_EMPRESA);
--
