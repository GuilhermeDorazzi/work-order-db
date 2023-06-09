--
-- Faz a copia das informações basicas que não tem relacionamento;
SET @copiarEmp = 3; -- Codigo da empresa que vai ser copiada.
SET @recebeEmp = 4; -- Codigo da empresa que vai receber a copia.
SET @copiarFil = 1; -- Codigo da filial que vai ser copiada para a nova empresa.
--
--
-- tb_filial
--
INSERT INTO TB_FILIAL(COD_FILIAL,COD_EMPRESA,NOM_FILIAL,FLG_ATIVO, URL_LOGO, VALOR_EXP, VALOR_IMP)
SELECT COD_FILIAL, @recebeEmp, NOM_FILIAL, FLG_ATIVO, URL_LOGO, VALOR_EXP, VALOR_IMP FROM TB_FILIAL WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil;
--
SELECT * FROM TB_FILIAL WHERE COD_EMPRESA = @recebeEmp;
--
-- tb_tipo_ordem não precisa ser copiado, só tem os valores padrão.alter
--
-- tb_motivo
INSERT INTO TB_MOTIVO (COD_EMPRESA, NOME_MOTIVO, IMAGEM_OBRIGATORIA, FLG_ATIVO)
SELECT @recebeEmp, NOME_MOTIVO, IMAGEM_OBRIGATORIA, FLG_ATIVO FROM TB_MOTIVO WHERE COD_EMPRESA = @copiarEmp;
--
SELECT * FROM TB_MOTIVO where COD_EMPRESA = @recebeEmp;
--
--
-- tb_cidade 
-- 
INSERT INTO TB_CIDADE(COD_EMPRESA, NOME_CIDADE, FLG_ATIVO, DATA_CADASTRO, DATA_ATUALIZACAO)
SELECT @recebeEmp, NOME_CIDADE, FLG_ATIVO, DATA_CADASTRO, DATA_ATUALIZACAO FROM TB_CIDADE WHERE COD_EMPRESA = @copiarEmp;
--
SELECT * FROM TB_CIDADE WHERE COD_EMPRESA = @recebeEmp;
--
-- tb_job 
--
INSERT INTO TB_JOB(COD_EMPRESA, JOB_DESC, FUSE, CODE, VALOR_PAG, VALOR_REC, QTD_MAX, QTD_MIN, FLG_ATIVO, DATA_CADASTRO, DATA_ATUALIZACAO, COD_FILIAL)
SELECT @recebeEmp, JOB_DESC, FUSE, CODE, VALOR_PAG, VALOR_REC, QTD_MAX, QTD_MIN, FLG_ATIVO, DATA_CADASTRO, DATA_ATUALIZACAO, COD_FILIAL FROM TB_JOB 
WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil;
--
SELECT * FROM TB_JOB WHERE COD_EMPRESA = @recebeEmp;
--
-- tb_usuario
-- COPIA TODOS OS USUARIO QUE ESTÃO RELACIONADOS A FILIAL 1
SELECT * FROM tb_usuarios WHERE COD_EMPRESA = @copiarEmp;
--
SELECT * FROM tb_usuario_filial WHERE COD_EMPRESA = @copiarEmp and cod_filial = @copiarFil;
--
INSERT INTO TB_USUARIOS(COD_EMPRESA, NOM_USUARIO, LOGIN, SENHA, FLG_ATIVO, FLG_TIPO_USUARIO, FLG_TIPO_ACESSO_APP, COD_TECH, FHO_TECH, SSN_TECH, GRUTECH, DATA_CADASTRO, DATA_ATUALIZACAO)
SELECT @recebeEmp, NOM_USUARIO, concat('NEW_CODE_',LOGIN), SENHA, FLG_ATIVO, FLG_TIPO_USUARIO, FLG_TIPO_ACESSO_APP, COD_TECH, FHO_TECH, SSN_TECH, GRUTECH, DATA_CADASTRO, DATA_ATUALIZACAO 
FROM TB_USUARIOS WHERE COD_EMPRESA = @copiarEmp AND COD_USUARIO IN (
												SELECT COD_USUARIO FROM TB_USUARIO_FILIAL WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil 
											   );
--
-- tb_job_usuarios
-- NÃO VOU FAZER PELA ROTINA DE COPIA TALVEZ MANUAL
-- 
/*SELECT * FROM tb_usuario_filial WHERE COD_USUARIO IN (
SELECT distinct JU.COD_USUARIO -- , JU.VALOR_PAG, JB.VALOR_PAG, JU.VALOR_REC, JB.VALOR_REC  
FROM tb_jobs_usuario AS JU 
LEFT JOIN tb_job AS JB ON JB.COD_EMPRESA = JU.COD_EMPRESA
AND JU.COD_JOB = JB.COD_JOB
WHERE JU.COD_EMPRESA = 3 AND JU.VALOR_PAG != JB.VALOR_PAG) AND COD_FILIAL = 1;*/
--
INSERT INTO TB_USUARIO_FILIAL(COD_USUARIO,COD_EMPRESA,COD_FILIAL, FLG_PRINCIPAL)
SELECT cod_usuario, @recebeEmp, @copiarFil, 'S' FROM tb_usuarios WHERE COD_EMPRESA = @recebeEmp AND GRUTECH != 'Admin';
--
--
--
--
INSERT INTO TB_ORDEM (JOB_NUM, COD_EMPRESA, COD_USUARIO, COD_TIPO_ORDEM, DATA_AGEND, STATUS, COMENTARIO, DATA_BAIXA, COD_CIDADE, ZIP_CODE, NUM_CASA, NOME_RUA, ORDEM_COM, TIME_SLO, TEL_CLIENTE, TEL_CLIENTE2, DATA_ATUALIZACAO, DATA_CADASTRO, COD_FILIAL, TEM_IMAGEM, ID_MOTIVO)
   SELECT JOB_NUM, COD_EMPRESA, COD_USUARIO, COD_TIPO_ORDEM, DATA_AGEND, STATUS, COMENTARIO, DATA_BAIXA, COD_CIDADE, ZIP_CODE, NUM_CASA, NOME_RUA, ORDEM_COM, TIME_SLO, TEL_CLIENTE, TEL_CLIENTE2, DATA_ATUALIZACAO, DATA_CADASTRO, COD_FILIAL, TEM_IMAGEM, ID_MOTIVO FROM (            
		 SELECT 
			   OD.JOB_NUM, 
			   @recebeEmp AS COD_EMPRESA, 
			   (SELECT COD_USUARIO FROM TB_USUARIOS WHERE COD_EMPRESA = @recebeEmp AND COD_TECH = US.COD_TECH) AS COD_USUARIO, 
               OD.COD_TIPO_ORDEM, 
               OD.DATA_AGEND, 
               OD.STATUS, 
               OD.COMENTARIO, 
               OD.DATA_BAIXA, 
               (SELECT COD_CIDADE FROM TB_CIDADE WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_CIDADE) = upper(CD.NOME_CIDADE)) AS COD_CIDADE, 
               OD.ZIP_CODE, 
               OD.NUM_CASA, 
               OD.NOME_RUA, 
               OD.ORDEM_COM, 
               OD.TIME_SLO, 
               OD.TEL_CLIENTE, 
               OD.TEL_CLIENTE2, 
               OD.DATA_ATUALIZACAO, 
               OD.DATA_CADASTRO, 
               OD.COD_FILIAL, 
               OD.TEM_IMAGEM, 
               (SELECT ID_MOTIVO FROM TB_MOTIVO WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_MOTIVO) = upper(MT.NOME_MOTIVO)) AS ID_MOTIVO
          FROM TB_ORDEM AS OD
     LEFT JOIN TB_CIDADE AS CD
            ON CD.COD_EMPRESA = OD.COD_EMPRESA
		   AND CD.COD_CIDADE = OD.COD_CIDADE
	 LEFT JOIN TB_MOTIVO AS MT
			ON MT.COD_EMPRESA = OD.COD_EMPRESA
		   AND MT.ID_MOTIVO = OD.ID_MOTIVO
	 LEFT JOIN TB_USUARIOS AS US
			ON US.COD_USUARIO = OD.COD_USUARIO
		   AND US.COD_EMPRESA = OD.COD_EMPRESA
            --
		 WHERE OD.COD_EMPRESA = @copiarEmp
           AND OD.COD_FILIAL = @copiarFil) AS X WHERE X.COD_USUARIO IS NOT NULL;
--
SELECT * FROM TB_ORDEM WHERE COD_EMPRESA = @recebeEmp;
--
--
-- tb_jobs_ordem
--
INSERT INTO TB_JOBS_ORDEM(COD_EMPRESA, JOB_NUM, COD_JOB, COD_TIPO_ORDEM, QTD, VALOR_PAG, VALOR_REC, DATA_CADASTRO, DATA_ATUALIZACAO, COD_FILIAL) 
SELECT @recebeEmp, JOB_NUM, COD_JOB, COD_TIPO_ORDEM, QTD, VALOR_PAG, VALOR_REC, DATA_CADASTRO, DATA_ATUALIZACAO, COD_FILIAL 
	FROM tb_jobs_ordem WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil AND JOB_NUM IN(
    SELECT JOB_NUM FROM (            
		 SELECT 
			   OD.JOB_NUM, 
			   @recebeEmp AS COD_EMPRESA, 
			   (SELECT COD_USUARIO FROM TB_USUARIOS WHERE COD_EMPRESA = @recebeEmp AND COD_TECH = US.COD_TECH) AS COD_USUARIO, 
               OD.COD_TIPO_ORDEM, 
               OD.DATA_AGEND, 
               OD.STATUS, 
               OD.COMENTARIO, 
               OD.DATA_BAIXA, 
               (SELECT COD_CIDADE FROM TB_CIDADE WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_CIDADE) = upper(CD.NOME_CIDADE)) AS COD_CIDADE, 
               OD.ZIP_CODE, 
               OD.NUM_CASA, 
               OD.NOME_RUA, 
               OD.ORDEM_COM, 
               OD.TIME_SLO, 
               OD.TEL_CLIENTE, 
               OD.TEL_CLIENTE2, 
               OD.DATA_ATUALIZACAO, 
               OD.DATA_CADASTRO, 
               OD.COD_FILIAL, 
               OD.TEM_IMAGEM, 
               (SELECT ID_MOTIVO FROM TB_MOTIVO WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_MOTIVO) = upper(MT.NOME_MOTIVO)) AS ID_MOTIVO
          FROM TB_ORDEM AS OD
     LEFT JOIN TB_CIDADE AS CD
            ON CD.COD_EMPRESA = OD.COD_EMPRESA
		   AND CD.COD_CIDADE = OD.COD_CIDADE
	 LEFT JOIN TB_MOTIVO AS MT
			ON MT.COD_EMPRESA = OD.COD_EMPRESA
		   AND MT.ID_MOTIVO = OD.ID_MOTIVO
	 LEFT JOIN TB_USUARIOS AS US
			ON US.COD_USUARIO = OD.COD_USUARIO
		   AND US.COD_EMPRESA = OD.COD_EMPRESA
            --
		 WHERE OD.COD_EMPRESA = @copiarEmp
           AND OD.COD_FILIAL = @copiarFil) AS X WHERE X.COD_USUARIO IS NOT NULL);
--
--
-- TB_IMAGENS
--
--
-- SCRIPT 21 TEM A CRIAÇÃO DAS TRIGGERS DE IMAGEM
DROP TRIGGER IF EXISTS ADD_IMAGEM;
DROP TRIGGER IF EXISTS DELETE_IMAGEM;
--
INSERT INTO TB_IMAGENS(COD_EMPRESA, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM, NOME_ARQUIVO, URL_ARQUIVO, ID_STORAGE, DATA_CADASTRO) 
SELECT @recebeEmp, JOB_NUM, COD_FILIAL, COD_TIPO_ORDEM, NOME_ARQUIVO, URL_ARQUIVO, ID_STORAGE, DATA_CADASTRO
	FROM TB_IMAGENS WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil AND JOB_NUM IN(
    SELECT JOB_NUM FROM (            
		 SELECT 
			   OD.JOB_NUM, 
			   @recebeEmp AS COD_EMPRESA, 
			   (SELECT COD_USUARIO FROM TB_USUARIOS WHERE COD_EMPRESA = @recebeEmp AND COD_TECH = US.COD_TECH) AS COD_USUARIO, 
               OD.COD_TIPO_ORDEM, 
               OD.DATA_AGEND, 
               OD.STATUS, 
               OD.COMENTARIO, 
               OD.DATA_BAIXA, 
               (SELECT COD_CIDADE FROM TB_CIDADE WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_CIDADE) = upper(CD.NOME_CIDADE)) AS COD_CIDADE, 
               OD.ZIP_CODE, 
               OD.NUM_CASA, 
               OD.NOME_RUA, 
               OD.ORDEM_COM, 
               OD.TIME_SLO, 
               OD.TEL_CLIENTE, 
               OD.TEL_CLIENTE2, 
               OD.DATA_ATUALIZACAO, 
               OD.DATA_CADASTRO, 
               OD.COD_FILIAL, 
               OD.TEM_IMAGEM, 
               (SELECT ID_MOTIVO FROM TB_MOTIVO WHERE COD_EMPRESA = @recebeEmp AND upper(NOME_MOTIVO) = upper(MT.NOME_MOTIVO)) AS ID_MOTIVO
          FROM TB_ORDEM AS OD
     LEFT JOIN TB_CIDADE AS CD
            ON CD.COD_EMPRESA = OD.COD_EMPRESA
		   AND CD.COD_CIDADE = OD.COD_CIDADE
	 LEFT JOIN TB_MOTIVO AS MT
			ON MT.COD_EMPRESA = OD.COD_EMPRESA
		   AND MT.ID_MOTIVO = OD.ID_MOTIVO
	 LEFT JOIN TB_USUARIOS AS US
			ON US.COD_USUARIO = OD.COD_USUARIO
		   AND US.COD_EMPRESA = OD.COD_EMPRESA
            --
		 WHERE OD.COD_EMPRESA = @copiarEmp
           AND OD.COD_FILIAL = @copiarFil) AS X WHERE X.COD_USUARIO IS NOT NULL);
--
CREATE TRIGGER ADD_IMAGEM
AFTER INSERT
ON TB_IMAGENS FOR EACH ROW
UPDATE TB_ORDEM SET TEM_IMAGEM = 'S' 
 WHERE COD_EMPRESA = NEW.COD_EMPRESA 
   AND COD_FILIAL = NEW.COD_FILIAL 
   AND JOB_NUM = NEW.JOB_NUM 
   AND COD_TIPO_ORDEM = NEW.COD_TIPO_ORDEM;
--
CREATE TRIGGER DELETE_IMAGEM
AFTER DELETE
ON TB_IMAGENS FOR EACH ROW
UPDATE TB_ORDEM SET TEM_IMAGEM = 'N' 
 WHERE COD_EMPRESA = OLD.COD_EMPRESA 
   AND COD_FILIAL = OLD.COD_FILIAL 
   AND JOB_NUM = OLD.JOB_NUM 
   AND COD_TIPO_ORDEM = OLD.COD_TIPO_ORDEM
   AND (SELECT COUNT(0) 
           FROM TB_IMAGENS 
		  WHERE COD_EMPRESA = OLD.COD_EMPRESA 
            AND COD_FILIAL = OLD.COD_FILIAL 
			AND JOB_NUM = OLD.JOB_NUM 
			AND COD_TIPO_ORDEM = OLD.COD_TIPO_ORDEM) = 0;
--
--
-- TENHO QUE RODAR O SCRIPT PARA VER QUAIS ORDEM NÃO TEM USUARIO RELACIONADO
-- RENOMEAR FAZER UM UPDATE NOS USUARIO DA FILIAL 1 PARA QUE SEJA CONCACATENADO OLD_ NOS EMAIL DOS USUARIO.

SELECT * 
FROM TB_USUARIOS WHERE COD_EMPRESA = @copiarEmp AND COD_USUARIO IN (
												SELECT COD_USUARIO FROM TB_USUARIO_FILIAL WHERE COD_EMPRESA = @copiarEmp AND COD_FILIAL = @copiarFil 
											   );
--                                               
SELECT * FROM tb_usuarios WHERE LOGIN LIKE 'OLD_%';                                  
--
SELECT * FROM tb_usuarios WHERE LOGIN LIKE 'NEW_CODE_%';
--
SELECT * FROM tb_filial WHERE COD_EMPRESA = @copiarEmp;                             
--

SELECT * FROM TB_USUARIO_FILIAL



                                               
                                               
                                               