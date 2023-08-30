--
-- Como aplicar os valores retroativos para os usuarios.
--
-- create table temp_tb_jobs_usuario select * from tb_jobs_usuario where cod_empresa = 3 and cod_usuario = 138; -- 17,32,33,16
--
--
-- create table tb_jobs_ordem_bk_1908 select * from tb_jobs_ordem;
-- 
-- Filiais - 8,3,4
-- Fields  - 105,119,138,146,164,176
-- Empresa - 3
--
/*update tb_jobs_usuario as ju
  join tb_job as jo
    on jo.cod_empresa = ju.cod_empresa
   and jo.cod_filial = ju.cod_filial
   and jo.cod_job = ju.cod_job
   set ju.valor_rep = jo.valor_rep
 where ju.cod_empresa = 3
   and ju.cod_filial = 6
   and (ju.cod_usuario in (select COD_USUARIO from tb_usuarios where cod_empresa = 3 and FLG_FILD_MANAGER = 'S')
   or ju.cod_usuario in (select COD_USUARIO from tb_usuarios where cod_empresa = 3 and COD_FILD_MANAGER IN (105, 119, 138, 146, 164))
   );*/
--
-- Filiais - 8,3,4
-- Fields  - 105,119,138,146,164,176
-- Empresa - 3
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
 and jo.COD_FILIAL = 6
  and (jo.cod_usuario in (select COD_USUARIO from tb_usuarios where cod_empresa = 3 and FLG_FILD_MANAGER = 'S')
   or jo.cod_usuario in (select COD_USUARIO from tb_usuarios where cod_empresa = 3 and COD_FILD_MANAGER IN (105, 119, 138, 146, 164))
   );


-- select * from tb_usuarios where COD_USUARIO in (17,32,33,16);