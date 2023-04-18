-- 29/10/2020 - Foi realizado um ajuste para que de permisão de cesso para o usuário para todas as paginas com exceção das telas que são apenas para o master. 
-- CADASTRO DE USUARIO 
DROP TRIGGER IF EXISTS NOVO_USUARIO;
CREATE TRIGGER NOVO_USUARIO
AFTER INSERT
ON TB_USUARIOS FOR EACH ROW
INSERT INTO TB_USUARIOS_PAGINAS (COD_PAGINA, COD_EMPRESA, COD_USUARIO, COD_TIPO_ACESSO)
SELECT 
   PG.COD_PAGINA, NEW.COD_EMPRESA, NEW.COD_USUARIO, IF(PG.FLG_TIPO_PAGINA != 'M', 1, 3) AS COD_TIPO_ACESSO
FROM 
   TB_PAGINAS AS PG;
-- 
-- DISPARA QUANDO UMA PAGINA FOR CADASTRADA
--
DROP TRIGGER IF EXISTS NOVA_PAGINA;
CREATE TRIGGER NOVA_PAGINA
AFTER INSERT
ON TB_PAGINAS FOR EACH ROW
INSERT INTO TB_USUARIOS_PAGINAS (COD_PAGINA, COD_EMPRESA, COD_USUARIO, COD_TIPO_ACESSO)
SELECT 
   NEW.COD_PAGINA, US.COD_EMPRESA, US.COD_USUARIO, 3 AS COD_TIPO_ACESSO
FROM 
   TB_USUARIOS AS US;
--
-- TRIGGER QUE QUANDO O CADASTRO DE UMA PAGINA É APAGADO REMOVE TODOS OS RELACIONAMENTOS
-- DE USUARIOS PAGINAS.
-- 
DROP TRIGGER IF EXISTS DELETE_PAGINA;
CREATE TRIGGER DELETE_PAGINA
BEFORE DELETE
ON TB_PAGINAS FOR EACH ROW
DELETE FROM TB_USUARIOS_PAGINAS WHERE COD_PAGINA = OLD.COD_PAGINA;
--
-- TRIGGER QUE QUANDO O CADASTRO DE UM USUARIO É APAGADO REMOVE TODOS OS RELACIONAMENTOS
-- DE USUARIOS PAGINAS.
-- 
DROP TRIGGER IF EXISTS DELETE_USUARIO;
CREATE TRIGGER DELETE_USUARIO
BEFORE DELETE
ON TB_USUARIOS FOR EACH ROW
DELETE FROM TB_USUARIOS_PAGINAS WHERE COD_USUARIO = OLD.COD_USUARIO AND COD_EMPRESA = OLD.COD_EMPRESA;