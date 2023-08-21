--
-- Como aplicar os valores retroativos para os usuarios.
--
-- create table temp_tb_jobs_usuario select * from tb_jobs_usuario where cod_empresa = 3 and cod_usuario = 138; -- 17,32,33,16
--
--
update tb_jobs_ordem as jo
  join tb_jobs_usuario as ju
    on ju.COD_EMPRESA = jo.COD_EMPRESA
   and ju.COD_USUARIO = jo.COD_USUARIO
   and ju.COD_FILIAL = jo.COD_FILIAL
   and ju.COD_JOB = jo.COD_JOB
set jo.VALOR_REP = ju.VALOR_REP,
    jo.VALOR_REC = ju.VALOR_REC,
    jo.VALOR_PAG = ju.VALOR_PAG
where jo.COD_EMPRESA = 3 
-- and jo.COD_FILIAL = 4
and ju.COD_USUARIO in (17,32,33,16);