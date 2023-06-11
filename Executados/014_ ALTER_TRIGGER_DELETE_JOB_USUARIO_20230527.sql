-- TRIGGER QUE QUANDO O CADASTRO DE UM JOB É APAGADO REMOVE TODOS OS RELACIONAMENTOS
-- DE USUARIOS.
-- 
DROP TRIGGER IF EXISTS DELETE_JOB_USUARIO;
CREATE TRIGGER DELETE_JOB_USUARIO
BEFORE DELETE
ON TB_JOB FOR EACH ROW
DELETE FROM TB_JOBS_USUARIO WHERE COD_JOB = OLD.COD_JOB AND COD_EMPRESA = OLD.COD_EMPRESA AND COD_FILIAL = OLD.COD_FILIAL;