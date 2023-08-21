-- Como a regra do bd08 entrou após o processo de criação da aplicação aconteceu que muitas ordens ficaram com os valores errados
-- o objetivo deste cara é voltar esse caras para o fluxo para que possamos corrigir e a aplicação recalcular os valores de forma correta.
--
-- Vamos criar a tabela de backup
create table tb_ordem_bk_bd08
select id_ordem, cod_empresa, data_baixa from tb_ordem 
        where cod_empresa = 3 
          and ID_ORDEM in (select distinct id_ordem from tb_jobs_ordem where COD_EMPRESA = 3 and COD_JOB in (198,199) and qtd2 is null) 
          and STATUS = 'Finished';
--
-- Vamos fazer o processo de alterar os status das ordens
--
update tb_ordem 
set STATUS = 'Pending'
where id_ordem in (select distinct id_ordem from tb_jobs_ordem where COD_EMPRESA = 3 and COD_JOB in (198,199) and qtd2 is null);
--
-- Fazer o processo manual de fechamento das ordens
--
update tb_ordem as od
join tb_ordem_bk_bd08 as bk
on od.id_ordem = bk.id_ordem
and od.cod_empresa = bk.cod_empresa
set os.data_baixa = bk.data_baixa
where od.cod_empresa = 3;
--
-- Vamos apagar a tabela com os backups
-- drop table tb_ordem_bk_bd08;